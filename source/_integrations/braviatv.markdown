---
title: 소니 TV(Sony Bravia TV)
description: Instructions on how to integrate a Sony Bravia TV into Home Assistant.
logo: bravia.png
ha_category:
  - Media Player
ha_release: 0.23
ha_iot_class: Local Polling
ha_codeowners:
  - '@robbiet480'
---

`braviatv` 플랫폼을 사용하면 [Sony Bravia TV](https://www.sony.com/)를 제어 할 수 있습니다.

거의 모든 [Sony Bravia TV 2013 이상](https://info.tvsideview.sony.net/en_ww/home_device.html#bravia)이 지원됩니다. HDMI-CEC를 사용하여 Raspberry Pi에 연결된 구형 TV의 일반적인 방법은 아래에 자세히 설명되어 있습니다.

원격 사용을 위해 홈어시스턴트를 허용하도록 TV를 설정해야합니다. 그러려면 TV가 켜져 있는지 확인하십시오. 홈어시스턴트에서 설정 팝업을 열고 임의의 PIN (예: 0000)을 입력하십시오. 그런 다음 TV에 PIN이 표시되고 홈어시스턴트에서 해당 PIN을 다시 입력 할 수 있습니다. TV에 표시된 PIN을 입력하면 홈어시스턴트가 Sony Bravia TV를 제어할 수 있습니다.

TV를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: braviatv
    host: 192.168.0.10
```

{% configuration %}
host:
  description: The IP of the Sony Bravia TV, e.g., 192.168.0.10
  required: true
  type: string
name:
  description: The name to use on the frontend.
  required: false
  default: Sony Bravia TV
  type: string
{% endconfiguration %}

다음 정보와 함께 [configuration directory](/docs/configuration/)에 `bravia.conf` 파일을 넣어 TV를 수동으로 설정할 수도 있습니다. 설정에 맞게 세부 정보를 업데이트하십시오.

```json
{"192.168.0.10": {"pin": "7745", "mac": "ac:1e:0a:e1:0c:01"}}
```

## 2013년 이전 모델

2013보다 오래된 TV 사용자는 홈어시스턴트를 통해 TV를 제어할 수있는 다른 옵션이 있습니다.

### HDMI-CEC 사용하기

Raspberry Pi가 TV에 연결된 경우 :

```yaml
switch:
  - platform: command_line
    switches:
      tv_rpi:
        command_on: ssh root@[IP] "echo 'on 0' | cec-client -s"
        command_off: ssh root@[IP] "echo 'standby 0' | cec-client -s"
        command_state: ssh root@[IP] "echo 'pow 0' | cec-client -s |grep 'power status:'"
        value_template: {% raw %}'{{ value == "power status: on" }}{% endraw %}'
```

`cec-client`를 사용하면 TV를 켜고 끌 수 있는 좋은 방법이지만 Kodi를 사용하는 경우 더이상 TV 리모컨을 사용하여 TV를 제어할 수 없습니다.

이는 한 번에 하나의 프로세스 만 Raspberry Pi 내에서 CEC 기능을 제어할 수 있고 위 명령을 실행하면 Kodi 내의 libCEC 내 기능이 종료되기 때문입니다. TV 제거 기능이 다시 작동하려면 Kodi를 다시 시작해야합니다.

**해결방법:**

TV를 켜려는 것만 원하는 경우 다음 "해결 방법"이 바람직 할 수 있습니다.

'on' 명령을 Kodi의 재시작으로 변경하십시오. 이것은 Kodi 장치를 재부팅하지 않습니다.

Kodi를 다시 시작하면 HDMI-CEC 이벤트가 발생하여 TV가 대기 모드에서 벗어날 수 있습니다. 다음은 TV 'on' 명령을 대체할 수 있습니다.

```yaml
command_on: ssh root@[IP] "systemctl restart kodi"
```
