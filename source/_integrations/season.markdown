---
title: 계절(Season)
description: Instructions on how to add season sensors into Home Assistant.
ha_category:
  - Utility
logo: home-assistant.png
ha_iot_class: Local Polling
ha_release: 0.53
ha_quality_scale: internalㄴ
---

`season` 센서는 설정 파일의 사용자 설정에 따라 현재 천문학적 혹은 기상학적 계절 (봄, 여름, 가을, 겨울)을 표시합니다.

천문학적 계절과 기상학적 계절의 차이에 대한 정보는 아래 링크를 참조하십시오.

- [https://www.ncei.noaa.gov/news/meteorological-versus-astronomical-seasons](https://www.ncei.noaa.gov/news/meteorological-versus-astronomical-seasons)

계절이 어떻게 작동하는지에 대한 모든 정보는 Wikipedia에서 가져왔습니다. : 

- [https://en.wikipedia.org/wiki/Season#Astronomical](https://en.wikipedia.org/wiki/Season#Astronomical)
- [https://en.wikipedia.org/wiki/Equinox](https://en.wikipedia.org/wiki/Equinox)
- [https://en.wikipedia.org/wiki/Solstice](https://en.wikipedia.org/wiki/Solstice)

## 설정

센서를 활성화하려면 `configuration.yaml` 파일에 다음 라인을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: season
```

{% configuration %}
type:
  description: "계절 정의의 유형. 옵션은 `meteorological` 혹은 `astronomical`."
  required: false
  type: string
  default: astronomical
name:
  description: "프런트 엔드의 센서 식별자"
  required: false
  type: string
  default: Season
{% endconfiguration %}
