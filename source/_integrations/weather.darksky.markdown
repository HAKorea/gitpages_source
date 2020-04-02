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

 `darksky` 플랫폼은 [Dark Sky](https://darksky.net/) 웹서비스를 사용자 위치의 기상 데이터 소스로 사용합니다.

## 설정

<div class='note warning'>

2020 년 3 월 31 일 Dark Sky는 [Apple에서 인수](https://blog.darksky.net/dark-sky-has-a-new-home/)로 더이상 새로운 API 등록을 허용하지 않습니다. Dark Sky API는 2021 년 말까지 기존 사용자에게 계속 작동하지만 더이상 새로운 사용자를 위한 API 키를 얻을 수 없습니다.

</div>

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
  description: "단위 시스템을 수동으로 지정하십시오. 유효한 값은 다음과 같습니다: `auto`, `us`, `si`, `ca`, `uk`, `uk2`."
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
