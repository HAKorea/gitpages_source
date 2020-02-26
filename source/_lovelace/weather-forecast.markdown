---
title: "Weather Forecast 카드"
sidebar_label: Weather Forecast
description: "The Weather card allows you a visual card to display the weather."
---

Weather Forecast는 날씨를 표시하는 카드입니다. 월패드에 표시하는 인터페이스로 활용시에 매우 유용합니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_weather.png' alt='Screenshot of the weather card'>
날씨 카드의 스크린 샷.
</p>

{% configuration %}
type:
  required: true
  description: weather-forecast
  type: string
entity:
  required: true
  description: "`weather` 플랫폼의 `entity_id`를 사용"
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어 씁니다.
  type: string
  default: Entity Name
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
{% endconfiguration %}

Example

```yaml
type: weather-forecast
entity: weather.dark_sky
```

<div class="note">

  이 카드는 `weather` 엔티티 를 정의하는 플랫폼에서만 작동합니다 . 
  예를 들어, [Dark Sky](/integrations/weather.darksky/) 에서는 작동 하지만 [Dark Sky Sensor](/integrations/darksky) 에서는 작동 하지 않습니다.

</div>
