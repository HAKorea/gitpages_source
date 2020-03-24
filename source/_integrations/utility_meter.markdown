---
title: 사용자정의 청구서만들기(Utility Meter)
description: Instructions on how to integrate the Utility Meter into Home Assistant.
ha_category:
  - Sensor
ha_release: 0.87
ha_iot_class: Local Push
logo: energy_meter.png
ha_quality_scale: internal
ha_codeowners:
  - '@dgomes'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/qw0bk4wZCZY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`utility meter` 통합구성요소는 다양한 유틸리티 (예: 에너지, 가스, 물, 난방)의 소비를 추적하는 기능을 제공합니다.

사용자 관점에서 유틸리티 미터는 청구 목적으로 주기적(일반적으로 월 단위)으로 작동합니다. 이 센서는 소스 센서값을 추적하여 설정된 주기에 따라 측정값을 자동으로 재설정합니다. 재설정시 속성은 이전 측정값을 저장하여 비교 작업을 위한 운영 비교(예를 들어 "이 달에 더 많거나 적게 썼는가?") 또는 청구 추정(예를 들어, 과금된 단위량당 계량된 값을 곱하는 센서 템플릿을 통해) 방법을 제공합니다. 

일부 유틸리티 제공 업체는 시간/자원 가용성 등에 따라 요금이 다릅니다. 유틸리티 측정기를 사용하면 유틸리티 공급자가 지원하는 다양한 요금 및 규정에 따른 소비량을 정의할 수 있습니다. 세금이 정의되면 새로운 엔티티가 나타나 현재 세금을 나타냅니다. 세금을 변경하려면 사용자는 일반적으로 시간 또는 기타 외부 소스를 기반으로하는 자동화를 통해 서비스를 호출해야합니다. (예: a REST sensor )

<div class='note'>
이 통합구성요소로 생성된 센서는 지속적이므로 Home Assistant 다시 시작시 값이 유지됩니다. 각 센서의 첫 번째 주기는 불완전합니다. 연동이 활성화 된 후 다음날에는 매일 사용량을 추적하는 센서가 정확하게 시작됩니다. 월별 사용량을 추적하는 센서는 홈어시스턴트에 추가된 후 다음 달 1 일부터 정확한 데이터를 제공합니다.
</div>

## 설정

설비에서 Utility Meter Sensor를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
utility_meter:
  energy:
    source: sensor.energy_in_kwh
    cycle: monthly
```

{% configuration %}
source:
  description: The entity ID of the sensor providing utility readings (energy, water, gas, heating).
  required: true
  type: string
cycle:
  description: How often to reset the counter. Valid values are `hourly`, `daily`, `weekly`, `monthly`, `quarterly` and `yearly`.
  required: true
  type: string
offset:
  description: "Cycle reset occur at the beginning of the period (0 minutes, 0h00 hours, Monday, day 1, January). This option enables the offsetting of these beginnings. Supported formats: `offset: 'HH:MM:SS'`, `offset: 'HH:MM'` and Time period dictionary (see example below)."
  required: false
  default: 0
  type: time 
  type: integer
net_consumption:
  description: Set this to True if you would like to treat the source as a net meter. This will allow your counter to go both positive and negative.
  required: false
  default: false
  type: boolean
tariffs:
  description: List of tariffs supported by the utility meter.
  required: false
  default: []
  type: list
{% endconfiguration %}

### Time period dictionary example

```yaml
offset:
  # At least one of these must be specified:
  days: 1
  hours: 0
  minutes: 0 
```

## 서비스

### `utility_meter.reset` 서비스

유틸리티 측정기를 재설정하십시오. 모든 센서 추적 세금는 0으로 재설정됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of strings that point at `entity_id`s of utility_meters.

### `utility_meter.next_tariff` 서비스

현재 세금을 목록에서 다음으로 변경하십시오.
이 서비스는 세금 전환 로직이 발생하도록 사용자에 의해 호출되어야합니다 (예 : 자동화 사용)

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of strings that point at `entity_id`s of utility_meters.

### `utility_meter.select_tariff` 서비스

현재 세금을 지정된 세금으로 변경합니다.
이 서비스는 세금 전환 로직이 발생하도록 사용자에 의해 호출되어야합니다 (예 : 자동화 사용)

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of strings that point at `entity_id`s of utility_meters.
| `tariff` | no | String that is equal to one of the defined tariffs.

# 고급 설정

다음 설정은 2 개의 utility_meters (`daily_energy` 및 `monthly_energy`)가 일일 및 월간 에너지 소비를 추적하는 예를 보여줍니다.

둘 다 동일한 센서 (`sensor.energy`)를 추적하여 소비되는 에너지를 지속적으로 모니터링합니다.

유틸리티 미터당 2 개, 각 요금표에 해당하는 4 개의 서로 다른 센서가 생성됩니다. 
센서 `sensor.daily_energy_peak`, `sensor.daily_energy_offpeak`, `sensor.monthly_energy_peak` 및 `sensor.monthly_energy_offpeak`는 주어진 주기동안 각 요금표의 소비를 추적하기 위해 자동으로 생성됩니다.

`utility_meter.daily_energy` 및`utility_meter.monthly_energy` 엔티티는 현재 세금을 추적하고 세금을 변경하는 서비스를 제공합니다.

```yaml
utility_meter:
  daily_energy:
    source: sensor.energy
    cycle: daily
    tariffs:
      - peak
      - offpeak
  monthly_energy:
    source: sensor.energy
    cycle: monthly
    tariffs:
      - peak
      - offpeak
```

에너지 공급자 요금이 시간에 따라 다음과 같다고 가정합니다.

- *peak*: 9시부터 21시까지 
- *offpeak*: 21시부터 다음날 9시까지

다음과 같이 시간 기반 자동화를 사용할 수 있습니다.

```yaml
automation:
  trigger:
    - platform: time
      at: '09:00:00'
    - platform: time
      at: '21:00:00'
  action:
    - service: utility_meter.next_tariff
      entity_id: utility_meter.daily_energy
    - service: utility_meter.next_tariff
      entity_id: utility_meter.monthly_energy
```

## Advanced Configuration for DSMR users 

When using the [DSMR component](/integrations/dsmr) to get data from the utility meter, each tariff (peak and off-peak) has a separate sensor. Additionally, there is a separate sensor for gas consumption. The meter switches automatically between tariffs, so an automation is not necessary in this case. But, you do have to setup a few more instances of the `utility_meter` component.

If you want to create a daily and monthly sensor for each tariff, you have to track separate sensors:

- `sensor.power_consumption_low` for off-peak power
- `sensor.power_consumption_normal` for peak power
- `sensor.gas_consumption` for gas consumption

So, tracking daily and monthly consumption for each sensor, will require setting up 6 entries under the `utility_meter` component.

```yaml
utility_meter:
  daily_power_offpeak:
    source: sensor.power_consumption_low
    cycle: daily
  daily_power_peak:
    source: sensor.power_consumption_normal
    cycle: daily
  daily_gas:
    source: sensor.gas_consumption
    cycle: daily
  monthly_power_offpeak:
    source: sensor.power_consumption_low
    cycle: monthly
  monthly_power_peak:
    source: sensor.power_consumption_normal
    cycle: monthly
  monthly_gas:
    source: sensor.gas_consumption
    cycle: monthly
```

Additionally, you can add template sensors to compute daily and monthly total usage. 

{% raw %}
```yaml
sensor:
  - platform: template
    sensors:
      daily_power:
        friendly_name: Daily Power
        unit_of_measurement: kWh
        value_template: "{{ states('sensor.daily_power_offpeak')|float + states('sensor.daily_power_peak')|float }}"
      monthly_power:
        friendly_name: Monthly Power
        unit_of_measurement: kWh
        value_template: "{{ states('sensor.monthly_power_offpeak')|float + states('sensor.monthly_power_peak')|float }}"
```
{% endraw %}
