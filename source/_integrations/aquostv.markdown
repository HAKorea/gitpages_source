---
title: 샤프 Aquos TV
description: Instructions on how to integrate a Sharp Aquos TV into Home Assistant.
logo: sharp_aquos.png
ha_category:
  - Media Player
ha_release: 0.35
ha_iot_class: Local Polling
---

`aquostv` 플랫폼을 통해 [Sharp Aquos TV](http://www.sharp-world.com/aquos/en/index.html)를 제어할 수 있습니다.

TV가 처음 연결되면 TV에서 홈어시스턴트를 수락하여 통신을 허용해야합니다.

TV를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: aquostv
    host: 192.168.0.10
```

{% configuration %}
host:
  description: The IP/Hostname of the Sharp Aquos TV, e.g., `192.168.0.10`.
  required: true
  type: string
port:
  description: The port of the Sharp Aquos TV.
  required: false
  default: 10002
  type: integer
username:
  description: The username of the Sharp Aquos TV.
  required: false
  default: admin
  type: string
password:
  description: The password of the Sharp Aquos TV.
  required: false
  default: password
  type: string
name:
  description: The name you would like to give to the Sharp Aquos TV.
  required: false
  type: string
power_on_enabled:
  description: If you want to be able to turn on your TV.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

<div class='note warning'>

**power_on_enabled**를 True로 설정하면 반드시 리모컨으로 TV를 처음 켜야합니다.
그런 다음 홈어시스턴트으로 전원을 켤 수 있습니다.
또한 **power_on_enabled**를 True로 설정하고 TV를 끄면 TV의 Aquos 로고가 계속 켜져 있고 TV에서 더 많은 전력을 소비 할 수 있습니다.

</div>

현재 알려진 지원 모델 :

- LC-40LE830U
- LC-46LE830U
- LC-52LE830U
- LC-60LE830U
- LC-60LE635 (no volume control)
- LC-52LE925UN
- LC-60LE925UN
- LC-60LE857U
- LC-60EQ10U
- LC-60SQ15U
- LC-50US40 (no volume control, not fully tested)

모델이 목록에 없으면 테스트를 해보고 모든 것이 올바르게 작동하면 [GitHub](https://github.com/home-assistant/home-assistant.io/blob/current/source/_integrations/aquostv.markdown)의 목록에 추가하십시오.