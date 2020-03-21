---
title: 네트워크회사(MikroTik)
description: Instructions on how to integrate MikroTik/RouterOS based devices into Home Assistant.
logo: mikrotik.png
ha_category:
  - Hub
  - Presence Detection
ha_release: 0.44
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/4qP0gO8mi6k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`mikrotik` 플랫폼은 연결된 장치를 [MikroTik RouterOS](https://mikrotik.com) 기반 라우터로 보고 재실 감지 기능을 제공합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Presence Detection

## `mikrotik` 허브 설정

이 플랫폼을 사용하려면 라우터에서 RouterOS API에 액세스 할 수 있어야합니다.

터미널 :

```bash
/ip service
set api disabled=no port=8728
```

웹프론트엔드:

Go to **IP** -> **Services** -> **api** and enable it.

네트워크에서 포트 8728 또는 선택한 포트에 액세스 할 수 있는지 확인하십시오.

설비에서 MikroTik 라우터를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
mikrotik:
  - host: IP_ADDRESS
    username: ROUTEROS_USERNAME
    password: ROUTEROS_PASSWORD
```

{% configuration %}
host:
  description: The IP address of your MikroTik device.
  required: true
  type: string
username:
  description: The username of a user on the MikroTik device.
  required: true
  type: string
password:
  description: The password of the given user account on the MikroTik device.
  required: true
  type: string
login_method:
  description: The login method to use on the MikroTik device. The `plain` method is used by default, if you have an older RouterOS Version than 6.43, use `token` as the login method.
  required: false
  type: string
  options: plain, token
  default: plain
port:
  description: RouterOS API port.
  required: false
  default: 8728 (or 8729 if SSL is enabled)
  type: integer
ssl:
  description: Use SSL to connect to the API.
  required: false
  default: false
  type: boolean
method:
  description: Override autodetection of device scanning method. Can be `wireless` to use local wireless registration, `capsman` for capsman wireless registration, or `dhcp` for DHCP leases.
  required: false
  type: string
arp_ping:
  description: Use ARP ping with DHCP method for device scanning.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

<div class='note info'>

  RouterOS의 버전 6.43부터 Mikrotik은 이전 로그인 방법 (`token`) 외에 새로운 로그인 방법 (`plain`)을 도입했습니다. 버전 6.45.1에서는 이전 `token` 로그인 방법이 더 이상 사용되지 않습니다.
  두 로그인 메커니즘을 모두 지원하기 위해 새로운 설정 옵션인 `login_method`가 도입되었습니다.

</div>

## 인증서 사용

SSL을 사용하여 API에 연결하려면 (`api` 서비스 대신 `api-ssl` 을 통해) RouterOS 측에서 추가 설정이 필요합니다. 인증서를 업로드하거나 생성하고 이를 사용하려면 `api-ssl` 서비스를 설정해야합니다. 다음은 자체 서명 인증서의 예입니다.

```bash
/certificate add common-name="Self signed demo certificate for API" days-valid=3650 name="Self signed demo certificate for API" key-usage=digital-signature,key-encipherment,tls-server,key-cert-sign,crl-sign
/certificate sign "Self signed demo certificate for API"
/ip service set api-ssl certificate="Self signed demo certificate for API"
/ip service enable api-ssl
```

그런 다음 `configuration.yaml` 파일의 `mikrotik` 장치 추적기 항목에 `ssl: true`를 추가하십시오.

모든 것이 제대로 작동하면 RouterOS에서 순수한 `api` 서비스를 비활성화 할 수 있습니다 :

```bash
/ip service disable api
```

## RouterOS의 사용자 권한

이 장치 추적기를 사용하려면 제한된 권한만 필요합니다. MikroTik 장치의 보안을 강화하려면 API에 연결하고 ping 테스트만 수행 할 수 있는 "read only"사용자를 작성하십시오.

```bash
/user group add name=homeassistant policy=read,api,!local,!telnet,!ssh,!ftp,!reboot,!write,!policy,test,!winbox,!password,!web,!sniff,!sensitive,!romon,!dude,!tikapp
/user add group=homeassistant name=homeassistant
/user set password="YOUR_PASSWORD" homeassistant
```

## `configuration.yaml` 파일의 `mikrotik` 항목에 추가 설정 사용 :

```yaml
mikrotik:
  - host: 192.168.88.1
    username: homeassistant
    password: YOUR_PASSWORD
    ssl: true
    arp_ping: true
    method: dhcp
    track_devices: true

  - host: 192.168.88.2
    username: homeassistant
    password: YOUR_PASSWORD
    ssl: true
    port: 8729
    method: capsman
    track_devices: true
```

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.