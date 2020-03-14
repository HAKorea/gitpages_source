---
title: "다크 스카이(Dark Sky)"
description: "Instructions on how to integrate Dark Sky within Home Assistant."
featured: true
logo: dark_sky.png
ha_category:
  - Weather
ha_release: 0.61
ha_iot_class: Cloud Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/rxqSG7o5N6Y" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

 `darksky` 플랫폼은 [Dark Sky](https://darksky.net/) 웹서비스를 사용자 위치의 기상 데이터 소스로 사용합니다.

## 설정

무료이긴 하지만 [가입](https://darksky.net/dev/register)을 한 이후 API키를 받아야 합니다. 무료서비스로는 하루에 최대 1000번의 데이터 사용을 허용하며 플랫폼은 최대 3 분마다 최대 480번을 사용하여 업데이트합니다. (보통은 그 이하로 사용하므로 개인사용자는 무료로 사용 가능)

<div class='note warning'>

[Dark Sky](https://darksky.net/dev/) 신용 카드 정보 입력시 하루에 1000 번 이상 사용시 Dark Sky 는 이후 API 사용 횟수당 $ 0.0001의 요금을 청구합니다. (입력 안해도 1000번은 사용 가능)

</div>

Dark Sky를 사용하시려면, `configuration.yaml` 파일에 다음을 추가하십시오:

```yaml
# Example configuration.yaml entry
weather:
  - platform: darksky
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: "가입 이후 받은 [Dark Sky](https://darksky.net/dev/) API 값."
  required: true
  type: string
latitude:
  description: 위도를 수동으로 지정 가능. 기본적으로 이 값은 홈어시스턴트 설정에서 가져옵니다.
  required: false
  type: float
  default: 홈어시스턴트 사용자의 초기 설정값 사용 
longitude:
  description: 경도를 수동으로 지정 가능. 기본적으로 이 값은 홈어시스턴트 설정에서 가져옵니다.
  required: false
  type: float
  default: 홈어시스턴트 사용자의 초기 설정값 사용 
units:
  description: "단위 시스템을 수동으로 지정하십시오. 유효한 값은 다음과 같습니다: `auto`, `us`, `si`, `ca`, `uk` and `uk2`."
  required: false
  type: string
  default: "`si` if Home Assistant unit system is metric, `us` if imperial."
name:
  description: 프론트 엔드에서 나타날 이름입니다.
  required: false
  type: string
  default: Dark Sky
mode:
  description: "예보 시간 단위. `hourly` 혹은 `daily`로 측정 가능합니다."
  required: false
  type: string
  default: hourly
{% endconfiguration %}

<div class='note'>

이 플랫폼은 [`darksky`](/integrations/darksky) 센서를 대신해서 쓸 수 있습니다.

</div>

자세한 설명은 [Dark Sky documentation](https://darksky.net/dev/docs) 문서를 참조해주세요.
