---
title: 리만합(Integration - Riemann sum)
description: Instructions on how to integrate Integration Sensor into Home Assistant.
ha_category:
  - Utility
  - Energy
ha_release: 0.87
ha_iot_class: Local Push
logo: integral.png
ha_quality_scale: internal
ha_codeowners:
  - '@dgomes'
---

`integration` 플랫폼은 소스 센서가 제공한 값의 [Riemann sum](https://en.wikipedia.org/wiki/Riemann_sum)을 제공합니다. Riemann sum은 finite sum에 의한 **integral**의 근사치입니다. **source**가 변경되면 integration 센서가 업데이트됩니다. 빠른 샘플링 소스 센서로 더 나은 결과를 제공합니다. 이 구현에서 기본값은 사다리꼴(Trapezoidal) 방법이지만 왼쪽과 오른쪽(Left and Righ) 방법을 선택적으로 사용할 수 있습니다.

## 설정

설치시 Integration 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: integration
    source: sensor.current_power
```

{% configuration %}
source:
  description: The entity ID of the sensor providing numeric readings.
  required: true
  type: string
name:
  description: Name to use in the frontend.
  required: false
  default: source entity ID meter
  type: string
round:
  description: Round the calculated integration value to at most N decimal places.
  required: false
  default: 3
  type: integer
unit_prefix:
  description: "Metric unit to prefix the integration result. Available units are `k`, `M`, `G` and `T`."
  required: false
  default: None
  type: string
unit_time:
  description: "SI unit of time to integrate over. Available units are `s`, `min`, `h` and `d`."
  required: false
  default: h
  type: string
unit:
  description: Unit of measurement to be used for the integration.
  required: false
  type: string
method:
  description: Riemann sum method to be used. Available methods are `trapezoidal`, `left` and `right`."
  required: false
  type: string
  default: trapezoidal
{% endconfiguration %}

온/오프 전기 보일러와 같이 소비량이 많은 기기가 있는 경우 정확한 판독값을 얻으려면 `left` 방법을 선택해야합니다. `unit`이 설정되면 `unit_prefix`와 `unit_time`은 무시됩니다.

## Energy

`integration` 센서는 에너지가 일반적으로 kWh로 청구되고 많은 센서가 W(Watts)로 전력을 공급하기 때문에 에너지 청구 시나리오에서 매우 유용합니다.

Watts 단위의 전력 측정값을 제공하는 센서가 있는 경우 (W를 `unit_of_measurement`로 사용), `integration` 센서를 사용하여 소비되는 에너지량을 추적할 수 있습니다. 다음 설정을 예로 들어 보겠습니다.

```yaml
sensor:
  - platform: integration
    source: sensor.current_power
    name: energy_spent
    unit_prefix: k
    round: 2
```

이 설정은 에너지를 kWh 단위로 `sensor.energy_spent`를 제공합니다.