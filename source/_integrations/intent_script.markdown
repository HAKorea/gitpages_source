---
title: 의도 스크립트(Intent Script)
description: Instructions on how to setup scripts to run on intents.
logo: home-assistant.png
ha_category:
  - Intent
ha_release: '0.50'
ha_quality_scale: internal
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/5hDEwnqQqT0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`intent_script` 통합구성요소를 통해 사용자는 의도(intents)에 대한 액션 및 응답을 설정 할 수 있습니다. 의도(intents)는 이를 지원하는 모든 통합구성요소로 시작될 수 있습니다. 
예로서 [Alexa](/integrations/alexa/) (Amazon Echo), [Dialogflow](/integrations/dialogflow/) (Google Assistant), [Snips](/integrations/snips/)가 있습니다.

```yaml
# Example configuration.yaml entry
intent_script:
  GetTemperature:  # Intent type
    speech:
      text: We have {% raw %}{{ states.sensor.temperature }}{% endraw %} degrees
    action:
      service: notify.notify
      data_template:
        message: Hello from an intent!
```

의도(intents) 내에서 다음 변수를 정의 할 수 있습니다.:

{% configuration %}
intent:
  description: 의도의 이름. 여러 항목이 가능.
  required: true
  type: map
  keys:
    action:
      description: 의도에 따라 실행할 액션을 정의.
      required: false
      type: action
    async_action:
      description: 홈어시스턴트가 의도 응답을 리턴하기 전에 스크립트가 완료되기를 기다리지 않도록하려면 True로 설정하십시오.
      required: false
      default: false
      type: boolean
    card:
      description: 표시 할 카드.
      required: false
      type: map
      keys:
        type:
          description: 표시 할 카드의 유형.
          required: false
          default: simple
          type: string
        title:
          description: 표시 할 카드의 제목.
          required: true
          type: template
        content:
          description: 표시 할 카드의 내용.
          required: true
          type: template
    speech:
      description: 반환 할 텍스트 또는 템플릿.
      required: false
      type: map
      keys:
        type:
          description: speech 유형.
          required: false
          default: plain
          type: string
        text:
          description: Text to speech.
          required: true
          type: template
{% endconfiguration %}
