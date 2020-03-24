---
title: 대화(Conversation)
description: Instructions on how to have conversations with your Home Assistant.
logo: home-assistant.png
ha_category:
  - Voice
ha_release: 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

대화 통합구성요소를 통해 Home Assistant와 대화할 수 있습니다. 프론트 엔드에서 마이크를 누르거나 (지원되는 브라우저만 (iOS는 아님)), 텍스트를 번역하여 `conversation/process` 서비스를 호출하여 대화할 수 있습니다.

<p class='img'>
  <img src="/images/screenshots/voice-commands.png" />
  홈어시스턴트의 대화 인터페이스 스크린 샷.
</p>

```yaml
# Example base configuration.yaml entry
conversation:
```

{% configuration %}
intents:
  description: Intents that the conversation integration should understand.
  required: false
  type: map
  keys:
    '`<INTENT NAME>`':
      description: Sentences that should trigger this intent.
      required: true
      type: list
{% endconfiguration %}

## 사용자정의 문장 추가

기본적으로 장치 켜기 및 끄기를 지원합니다. "turn on kitchen lights" 또는 "turn the living room lights off"와 같은 것을 말할 수 있습니다. 자신만의 문장을 처리하도록 설정할 수도 있습니다. 이것은 문장을 의도(intents)에 매핑한 다음 이러한 의도(intents)를 처리하도록 [intent script integration](/integrations/intent_script/)을 설정하여 작동합니다.

다음은 거실의 온도가 얼마인지 묻는 간단한 예입니다.

```yaml
# Example configuration.yaml entry
conversation:
  intents:
    LivingRoomTemperature:
     - What is the temperature in the living room

intent_script:
  LivingRoomTemperature:
    speech:
      text: It is currently {% raw %}{{ states.sensor.temperature }}{% endraw %} degrees in the living room.
```

## 고급사용자정의 문장 추가

문장에는 슬롯 (중괄호: `{name}`)과 선택적 단어 (대괄호: `[the]`)가 포함될 수 있습니다. 슬롯값은 의도(intents)로 전달되며 템플릿 내에서 사용할 수 있습니다.

다음 설정은 다음 문장을 처리 할 수 ​​있습니다.

 - Change the lights to red
 - Change the lights to green
 - Change the lights to blue
 - Change the lights to the color red
 - Change the lights to the color green
 - Change the lights to the color blue

```yaml
# Example configuration.yaml entry
conversation:
  intents:
    ColorLight:
     - Change the lights to [the color] {color}
{% raw %}
intent_script:
  ColorLight:
    speech:
      text: Changed the lights to {{ color }}.
    action:
      service: light.turn_on
      data_template:
        rgb_color:
          - "{% if color == 'red' %}255{% else %}0{% endif %}"
          - "{% if color == 'green' %}255{% else %}0{% endif %}"
          - "{% if color == 'blue' %}255{% else %}0{% endif %}"
{% endraw %}
```

#### `conversation.process` 서비스

| Service data attribute | Optional | Description                                      |
|------------------------|----------|--------------------------------------------------|
| `text`                 |      yes | Transcribed text                                 |
