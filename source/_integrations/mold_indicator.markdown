---
title: 곰팡이 표시기(Mold Indicator)
description: How to use the mold growth indication integration in Home Assistant
logo: home-assistant.png
ha_category:
  - Environment
ha_release: '0.20'
ha_iot_class: Local Polling
ha_quality_scale: internal
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/8KwRPF5NoI8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

곰팡이 표시기(Mold Indicator) 센서 통합구성요소는 2 개의 온도 센서와 습도 센서의 정보를 조합하여 가정에서 곰팡이가 생길 수 있음을 나타냅니다. 환기 및 단열이 불량한 경우 실내 습도로 인해 창문이나 벽처럼 차가운 표면에 응결이 발생할 수 있습니다. 차가운 표면 근처의 응축 또는 상대 습도가 높으면 곰팡이가 생길 위험이 높아집니다. 이 센서 통합구성요소는 실내에서 사전 교정 된 임계점 (가장 추운 표면)의 온도를 추정하고 해당 지점에서 공기의 상대 습도를 계산합니다. 센서 값이 약 70 % 이상 상승하면 곰팡이가 생길 수 있으며 실내를 환기시켜야합니다. 100 %에서는 공기 습도가 임계점에서 응축됩니다.

센서 데이터는 예를 들어, 나쁜 공기 질 (너무 높은 습도)을 알리거나 실내 공기 가습기의 작동을 자동화하여 실내 습도를 최적으로 유지하기 위해 사용될 수 있습니다.

## 설정

설치시 곰팡이 표시기 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: mold_indicator
    indoor_temp_sensor: sensor.temp
    indoor_humidity_sensor: sensor.humidity
    outdoor_temp_sensor: sensor.weather_temperature
    calibration_factor: 2.0
```

{% configuration %}
name:
  description: 센서의 이름.
  required: false
  type: string
indoor_temp_sensor:
  description: 실내 온도 센서의 엔티티 ID.
  required: true
  type: string
indoor_humidity_sensor:
  description: 실내 습도 센서의 엔티티 ID.
  required: true
  type: string
outdoor_temp_sensor:
  description: 실외 온도 센서의 엔티티 ID.
  required: true
  type: string
calibration_factor:
  description: 실내의 임계점까지 교정필요시 사용.
  required: true
  type: float
{% endconfiguration %}

이 경우 일기 예보 온도 센서가 외부 온도에 사용됩니다.

## Calibration

실외 및 실내 온도에서 임계점의 온도를 추정하려면 곰팡이 표시기 센서 연동값을 교정해야합니다. 먼저 방에서 가장 차가운 표면 (임계점)을 찾으십시오.이 지점은 일반적으로 창틀 근처에 있지만 집의 단열재에 따라 다릅니다. 교정을하려면이 임계점에서 온도를 측정하고 금형 표시기에 사용 된 실내 및 실외 온도 센서의 값을 동시에 기록해야합니다. 최상의 교정 결과를 얻으려면 실내와 실외의 온도 차이가 유의해야합니다. 세 가지 측정 온도 (섭씨 또는 화씨)로 구성 파일의 calibration_factor는 다음과 같습니다.

```text
calibration_factor = (temp_indoor - temp_outdoor) / (temp_criticalpoint - temp_outdoor)
```
