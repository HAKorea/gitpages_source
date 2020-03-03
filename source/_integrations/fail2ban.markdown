---
title: Fail2Ban(로그인감시)
description: Instructions on how to integrate a fail2ban sensor into Home Assistant.
ha_category:
  - Network
ha_iot_class: Local Polling
logo: fail2ban.png
ha_release: 0.57
---

`fail2ban` 센서는 [fail2ban](https://www.fail2ban.org/wiki/index.php/Main_Page)에 의해 금지된 IP가 홈 어시스턴트 프론트 엔드에 표시되도록합니다.

<div class='note'>

이 센서가 작동하려면 시스템에 `fail2ban`이 설치되어 있고 올바르게 설정되어 있어야합니다. 또한 홈어시스턴트는 `fail2ban` 로그 파일을 읽을 수 있어야합니다.

</div>

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오

```yaml
# Example configuration.yaml entry
sensor:
  - platform: fail2ban
    jails:
      - ssh
      - hass-iptables
```

{% configuration %}
jails:
  description: 표시하려는 설정된 감옥(jail) 목록.
  required: true
  type: list
name:
  description: 센서 이름.
  required: false
  type: string
  default: fail2ban
file_path:
  description: fail2ban 로그의 경로
  required: false
  type: string
  default: /var/log/fail2ban.log
{% endconfiguration %}

### Fail2Ban 셋업

대부분의 설정에서 [this tutorial](/cookbook/fail2ban/)에 따라 시스템에서 `fail2ban`을 설정할 수 있습니다. 너무 많은 SSH 로그인 시도와 금지된 홈어시스턴트 로그인 시도에 대해 금지된 IP 주소를 모니터 할 수 있도록 감옥(jail)과 필터를 작성하는 과정을 안내합니다.

### Docker에서의 Fail2Ban

<div class='note'>

이 단계에서는 Home Assistant 도커가 이미 NGINX 뒤에서 실행 중이고 외부에서 액세스 할 수 있다고 가정합니다. 또한 도커가 `--net='host'` 플래그로 실행되고 있다고 가정합니다.

</div>

Docker를 사용하는 사람들에게는 위의 자습서로 충분하지 않을 수 있습니다. 다음 단계는 NGINX 뒤의 Docker 내에서 홈 어시스턴트를 실행할 때 `fail2ban` 및 홈어시스턴트를 설정하는 방법을 구체적으로 설명합니다. 이 테스트는 linuxserver.io의 [let's encrypt docker](https://github.com/linuxserver/docker-letsencrypt)를 사용한 unRAID 서버입니다.

#### http 로거 셋업 (Set http logger)

`configuration.yaml` 파일에서 다음 `logger` 통합구성요소에 추가하여 홈어시스턴트가 실패한 로그인 시도를 로그에 보이도록하십시오.

```yaml
logger:
  logs:
    homeassistant.components.http.ban: warning
```

#### `jail.local` 편집하기 

다음으로, 위의 Let's Encrypt 도커에 포함된 `jail.local` 파일을 편집해야합니다. 이 튜토리얼에서는 [previously linked tutorial](/cookbook/fail2ban/)에서만 `[hass-iptables]` 감옥(jail)을 구현할 것입니다.

`/mnt/user/appdata/letsencrypt/fail2ban/jail.local`을 편집하고 파일의 끝에 다음을 추가하십시오 :

```txt
[hass-iptables]
enabled = true
filter = hass
action = iptables-allports[name=HASS]
logpath = /hass/home-assistant.log
maxretry = 5
```

#### 홈어시스턴트 감옥(jail)에 대한 필터 만들기 

이제 로그를 제대로 파싱 할 수 있도록 `fail2ban`에 대한 필터를 만들어야합니다. 이것은 `failregex`로 이루어집니다. `/mnt/user/appdata/letsencrypt/fail2ban`의 `filter.d` 디렉토리 내에 `hass.local`이라는 파일을 작성하고 다음을 추가하십시오.

```txt
[INCLUDES]
before = common.conf

[Definition]
failregex = ^%(__prefix_line)s.*Login attempt or request with invalid authentication from <HOST>.*$

ignoreregex =

[Init]
datepattern = ^%%Y-%%m-%%d %%H:%%M:%%S
```

#### Map log file directories

먼저 fail2ban 로그를 홈어시스턴트로 전달하고 홈어시스턴트 로그를 fail2ban로 전달할 수 있는지 확인해야합니다. Let's Encrypt 도커를 시작할 때 다음 인수를 추가해야합니다 (설정에 따라 경로 조정)

```txt
/mnt/user/appdata/home-assistant:/hass
```

그러면 홈어시스턴트 설정 디렉토리가 Let's Encrypt 도커에 매핑되어 실패한 로그인 시도에 대해 `fail2ban`이 로그를 구문 분석 할 수 있습니다.

이제 홈어시스턴트 도커에 대해 동일한 작업을 수행하지만, 이번에는 fail2ban 센서가 해당 로그를 읽을 수 있도록 `fail2ban` 로그 디렉토리를 홈어시스턴트에 맵핑합니다.

```txt
/mnt/user/appdata/letsencrypt/log/fail2ban:/fail2ban
```


#### 홈어시스턴트로 클라이언트 IP 보내기

기본적으로, 홈어시스턴트가 보는 IP 주소는 컨테이너의 주소입니다 (`172.17.0.16`와 같은 것). 이는 실패한 로그인 시도에 대해 `fail2ban`을 올바르게 설정했다고 가정하면 Docker IP는 차단된 것으로 기록되지만 원래 IP는 여전히 시도를 할 수 있습니다. IP를 올바르게 차단하기 위해 원래 IP를 인식하는 `fail2ban` 이 필요합니다.

먼저 `/mnt/user/appdata/letsencrypt/nginx/site-confs/default`에 있는 nginx 설정 파일에 다음을 추가해야합니다.

```bash
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```

이 스니펫은 홈어시스턴트 서버 설정 내에 추가되어야합니다. 따라서 내용은 다음과 같습니다.

```bash
server {
    ...
    location / {
        proxy_pass http://192.168.0.100:8123;
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /api/websocket {
        proxy_pass http://192.168.0.100:8123/api/websocket;
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    ...
}
```

일단 nginx 설정에 추가되면, `X-Forwarded-For` 헤더를 파싱 할 수 있도록 Home Assistant `configuration.yaml`을 수정해야합니다. `http` 컴포넌트에 다음을 추가하면됩니다 :

```yaml
http:
  use_x_forwarded_for: true
```

이 시점에서 Let's Encrypt 및 Home Assistant 도커가 다시 시작되면 홈어시스턴트는 실패한 로그인 시도의 원래 IP를 올바르게 기록해야합니다. 완료되고 확인되면 마지막 단계로 넘어갈 수 있습니다.

#### fail2ban sensor 추가하기

Docker에 대한 모든 것을 올바르게 설정 했으므로 다음과 같이 센서를 `configuration.yaml` 에 추가 할 수 있습니다.

```yaml
sensor:
  - platform: fail2ban
    jails:
      - hass-iptables
    file_path: /fail2ban/fail2ban.log
```

모든 단계를 수행했다고 가정하면 프런트 엔드 내에 하나의 fail2ban 센서 `sensor.fail2ban_hassiptables`가 있어야 합니다.

### 다른 디버그 팁들

이 단계를 수행 한 후에도 'fail2ban'센서가 작동하지 않는 경우 도움이 될 수있는 다른 단계는 다음과 같습니다.

- Add `logencoding = utf-8` to the `[hass-iptables]` entry
- Ensure the `failregex` you added to `filter.d/hass.local` matches the output within `home-assistant.log`
- Try changing the datepattern in `filter.d/hass/local` by adding the following entry (change the datepattern to fit your needs). [source](https://github.com/fail2ban/fail2ban/issues/174)
    ```txt
    [Init]
    datepattern = ^%%Y-%%m-%%d %%H:%%M:%%S
    ```
