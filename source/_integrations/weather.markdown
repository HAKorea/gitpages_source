---
title: 날씨(Weather)
description: Instructions on how to setup your Weather platforms with Home Assistant.
logo: home-assistant.png
ha_category:
  - Weather
ha_release: 0.32
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`weather` 플랫폼은 웹 서비스에서 기상 정보를 수집하고 주어진 위치에서 날씨에 대한 조건 및 기타 세부 사항을 표시합니다. 특정 날씨 제공 업체의 통합 문서를 읽고 설정 방법을 알아보십시오.

홈어시스턴트는 현재 무료 웹 서비스를 지원하며 일부는 등록이 필요합니다.

## Condition mapping

`weather` 플랫폼은 아래에 나열된 조건만 알고 있습니다. 그 이유는 이러한 조건에서 [frontend](https://github.com/home-assistant/home-assistant-polymer/blob/master/src/cards/ha-weather-card.js#L170)에서 사용 가능하고 매핑된 [Material Design Icons](https://materialdesignicons.com/)의 아이콘이기 때문입니다.

- 'clear-night'
- 'cloudy'
- 'fog'
- 'hail'
- 'lightning'
- 'lightning-rainy'
- 'partlycloudy'
- 'pouring'
- 'rainy'
- 'snowy'
- 'snowy-rainy'
- 'sunny'
- 'windy'
- 'windy-variant'
- 'exceptional'
