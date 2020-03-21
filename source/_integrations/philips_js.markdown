---
title: 필립스 TV(Philips TV)
description: Instructions on how to add Philips TVs to Home Assistant.
logo: philips.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.34
ha_codeowners:
  - '@elupus'
---

`philips_js` 플랫폼을 사용하면 [jointSPACE](http://jointspace.sourceforge.net/) JSON-API를 노출시키는 Philips TV를 제어할 수 있습니다. API 활성화 방법 및 모델 지원 여부에 대한 지침은 [여기](http://jointspace.sourceforge.net/download.html)를 참조하십시오. jointSPACE-enabled 디바이스가 모두 포트 1925에서 JSON 인터페이스를 실행하는 것은 아닙니다. 이것은 2011 년 이전의 일부 모델에는 해당됩니다.

TV를 설치시 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: philips_js
    host: 192.168.1.99
```

{% configuration %}
host:
  description: IP address of TV.
  required: true
  default: 127.0.0.1 (localhost).
  type: string
name:
  description: The name you would like to give to the Philips TV.
  required: false
  default: Philips TV
  type: string
turn_on_action:
  description: A script that will be executed to turn on the TV (can be used with wol).
  required: false
  type: list
api_version:
  description: The JointSpace API version of your Philips TV. This is an experimental option and not all the functionalities are guaranteed to work with API versions different from `1` and `5`.
  required: false
  default: 1
  type: integer
{% endconfiguration %}

<div class='note'>
api_version 사용시: 5 개의 입력 변경으로 TV 채널이 전환됩니다. 또한 볼륨 레벨을 설정할 수 있습니다.
</div>

```yaml
# Example configuration.yaml with turn_on_action
media_player:
  - platform: philips_js
    host: 192.168.1.99
    turn_on_action:
      service: wake_on_lan.send_magic_packet
      data:
        mac: aa:bb:cc:dd:ee:ff
```
