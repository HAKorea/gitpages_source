---
title: 공기측정기(Kaiterra)
description: Instructions on how to integrate your Kaiterra device into Home Assistant.
logo: kaiterra.svg
ha_iot_class: Cloud Polling
ha_category:
  - Health
ha_release: '0.100'
ha_codeowners:
  - '@Michsior14'
---

`kaiterra` 통합구성요소를 통해 [Kaiterra REST API](https://www.kaiterra.com/dev/)를 사용하여 Laser Egg 또는 Sensedge 장치의 판독값을 볼 수 있습니다.

통합을 사용하려면 [Kaiterra dashboard](https://dashboard.kaiterra.cn/)에 가입하여 API 키를 얻어야합니다. 장치를 등록하고 `Settings -> Profile -> Developer` 에서 키를 만듭니다.

## 설정

`kaiterra`를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
kaiterra:
  api_key: YOUR_API_KEY
  devices:
    - device_id: YOUR_DEVICE_ID
      type: YOUR_DEVICE_TYPE
```

{% configuration %}
api_key:
  description: Kaiterra Dashboard의 개인 API 키.
  required: true
  type: string
aqi_standard:
  description: 대기질 지수의 표준. 사용 가능한 값. `us`, `in`, `cn`.
  required: false
  type: string
  default: us
scan_interval:
  description: 센서 상태를 스캔하는 간격은 초 단위로 변경.
  required: false
  type: integer
  default: 30
preferred_units:
  description: 선호하는 단위의 목록입니다. 목록에서 사용 가능한 값 `x`, `%`, `C`, `F`, `mg/m³`, `µg/m³`, `ppm`, `ppb`.
  required: false
  type: list
devices:
  description: 읽어오고자하는 장치.
  required: true
  type: list
  keys:
    device_id:
      description: 모니터링하려는 장치의 UUID Kaiterra Dashboard에서 가져올 수 있습니다.
      required: true
      type: string
    type:
      description: 장치 유형. 사용 가능한 값 `laseregg`, `sensedge`.
      required: true
      type: string
    name:
      description: 기기의 사용자 정의 이름.
      required: false
      type: string
{% endconfiguration %}
