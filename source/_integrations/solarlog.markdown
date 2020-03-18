---
title: 태양광관리시스템(Solar-Log)
description: Instructions on how to integrate Solar-Log sensors within Home Assistant.
logo: solar-log.png
ha_category: Sensor
ha_release: 0.101
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@Ernst79'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/eMXbTN2X4Ek" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`solarlog` 통합구성요소는 [Solar-Log PV monitoring systems](https://www.solar-log.com/)의 개방형 JSON 인터페이스를 사용하여 Solar-Log 장치에서 세부 정보를 가져와 이를 Home Assistant에 연동할 수 있습니다.

통합구성요소를 사용하기 전에 Solar-Log 장치에서 열린 JSON 인터페이스를 활성화해야합니다. 이는 Solar-Log 장치의 Configuration | System | Access control menu 에서 활성화 할 수 있습니다. 인터페이스를 활성화하면 보안 정보 및 위험 요소가있는 빨간색 경고 삼각형이 표시됩니다.

`solarlog` 통합구성요소는 호스트를 지정하지 않으면 기본 호스트 주소 "http://solar-log"를 사용합니다. 이 주소에서 장치에 액세스 할 수 없으면 대신 IP주소를 사용하십시오.

<div class='note warning'>
open JSON 인터페이스는 기본적으로 비활성화되어 있습니다. open JSON 인터페이스를 활성화하려면 먼저 사용자 비밀번호를 설정해야합니다. open JSON 인터페이스에 액세스하는데 비밀번호가 필요하지 않습니다.
</div>

## 설정

`solarlog` 통합구성요소 설정에는 두 가지 옵션이 있습니다.

- 홈어시스턴트 사용자 인터페이스를 통해 이름과 호스트를 입력하여 Solar-Log 장치에 연결할 수 있습니다.
- 홈어시스턴트 `configuration.yaml` 파일을 통해.

```yaml
# Example configuration.yaml entry
sensor:
  platform: solarlog
```

{% configuration %}
host:
  description: The IP Address or host address of your Solar-Log device.
  required: false
  default: http://solar-log
  type: string
name:
  description: Let you overwrite the name of the device in the frontend.
  required: false
  default: solarlog
  type: string
{% endconfiguration %}

### 전체 설정 샘플

전체 설정 항목은 아래 샘플과 같습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: solarlog
    name: solarlog
    host: 192.168.1.123
```

예를 들어 기본 kWh 대신 Wh로 값을 변환하려는 경우 [template platform](/integrations/template/)을 사용할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry for sensor template platform
sensor:
  - platform: template
    sensors:
      solarlog_yield_day_template:
        value_template: "{{ (states('sensor.solarlog_yield_day') | float * 1000) | round(0) }}"
```
{% endraw %}

## Sensors

라이브러리에서 다음 센서를 사용할 수 있습니다.

| name                  | Unit   | Description   |
|-----------------------|--------|:-------------------------------------------|
| last_update           |        | Time of latest data update.                |
| power_ac              | W      | Total output PAC from all of the inverters and meters in inverter mode. |
| power_dc              | W      | Total output PAC from all of the inverters. |
| voltage_ac            | V      | Average voltage AC from the inverter. |
| voltage_dc            | V      | Average voltage DC from the inverter |
| yield_day             | kWh    | Total yield for the day from all of the inverters |
| yield_yesterday       | kWh    | Total yield for the previous day from all of the inverters. |
| yield_month           | kWh    | Total yield for the month from all of the inverters. |
| yield_year            | kWh    | Total yield for the year from all of the inverters. |
| yield_total           | kWh    | Total yield from all of the inverters. |
| consumption_ac        | kWh    | Current total consumption AC from all of the consumption meters. |
| consumption_day       | kWh    | Total consumption for the day from all of the consumption meters. |
| consumption_yesterday | kWh    | Total consumption for the previous day from all of the consumption meters. |
| consumption_month     | kWh    | Total consumption for the month from all of the consumption meters. |
| consumption_year      | kWh    | Total consumption for the year from all of the consumption meters. |
| consumption_total     | kWh    | Accumulated total consumption from all consumption meters. |
| total_power           | Wp     | Installed generator power. |
| alternator_loss       | W      | Altenator loss (equals to power_dc - power_ac) |
| capacity              | %      | Capacity (equals to power_dc / total power) |
| efficiency            | % W/Wp | Efficiency (equals to power_ac / power_dc |
| power_available       | W      | Available power (equals to power_ac - consumption_ac) | 
| usage                 |        | Usage (equals to consumption_ac / power_ac) |

<div class='note'>
solarlog 통합구성요소는 sunwatcher pypi 패키지를 사용하여 Solar-Log 장치에서 데이터를 가져옵니다. 마지막 5 개의 센서는 Solar-Log 장치에 의해 직접보고되지 않지만 sunwatcher 패키지에 의해 계산됩니다.
</div>
