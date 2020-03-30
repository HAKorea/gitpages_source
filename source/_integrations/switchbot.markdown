---
title: 스위치봇(Switchbot)
description: Instructions on how to set up Switchbot switches.
logo: switchbot.png
ha_category:
  - Switch
ha_release: 0.78
ha_iot_class: Local Polling
ha_codeowners:
  - '@danielhiversen'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/jYYVih2uNmM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`switchbot` 스위치 플랫폼을 사용하면 Switchbot [devices](https://www.switch-bot.com/)를 제어할 수 있습니다.

## 수동 설정

이를 활성화하려면`configuration.yaml`에 다음 줄을 추가하십시오

```yaml
switch:
  - platform: switchbot
    mac: 'MAC_ADDRESS'
```

{% configuration %}
mac:
  description: 소문자로된 장치 MAC 주소.
  required: true
  type: string
name:
  description: 프런트 엔드에 스위치를 표시하는데 사용되는 이름.
  required: false
  type: string
password:
  description: 설정된 경우 스위치의 비밀번호
  required: false
  type: string  
{% endconfiguration %}

## Switchbot Entity

Switchbot 엔터티에는 장치에 대한 추가 정보를 제공하는 두 가지 특성이 있습니다.

- `last_run_success` : 스위치봇에 마지막으로 전송된 액션이 성공한 경우 true. 이 속성은 Bluetooth 연결이 간헐적인 경우 오류 트래핑에 유용합니다. `false`인 경우 특정 오류 메시지는 home-assistant.log를 참조하십시오.
- `assumed_state`: 항상 `true`. Switchbot 엔티티의 상태를 판별할 수 없는 경우 'on'인 것으로 가정합니다.
