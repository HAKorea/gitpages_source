---
title: 스마트홈플랫폼(TP-Link Casa Smart)
description: Instructions on integrating TP-Link Smart Home Devices to Home Assistant.
logo: tp-link.png
ha_category:
  - Hub
  - Switch
  - Light
ha_release: 0.89
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@rytilahti'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/9ViLqLne7-4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`tplink` 통합구성요소를 통해 스마트 플러그 및 스마트 전구와 같은 [TP-Link Smart Home Devices](https://www.tp-link.com/kasa-smart/)를 제어할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- **Light**
- **Switch**

지원을 활성화하려면 설정 패널 내부의 통합구성요소를 활성화해야합니다.
네트워크에서 지원되는 장치는 자동으로 검색되지만 다른 네트워크에 상주하는 장치를 제어하려면 아래와 같이 수동으로 설정해야합니다.

## 지원 장치

이 통합구성요소는 [KASA app](https://www.tp-link.com/us/kasa-smart/kasa.html)으로 제어 가능한 장치를 지원합니다.
다음 장치가 이 구성 요소와 동작하는 것으로 알려져 있습니다.

### Plugs

- HS100
- HS103
- HS105
- HS110 (The only device capable or reporting energy usage data to template sensors)

### Strip (Multi-Plug)

- HS107 (indoor 2-outlet)
- HS300 (powerstrip 6-outlet)
- KP303 (powerstrip 3-outlet)
- KP400 (outdoor 2-outlet)
- KP200 (indoor 2-outlet)

### Wall Switches

- HS200
- HS210
- HS220 (acts as a light)

### Bulbs

- LB100
- LB110
- LB120
- LB130
- LB230
- KL110
- KL120
- KL130

## 설정

```yaml
# Example configuration.yaml
tplink:
```

{% configuration %}
discovery:
  description: Whether to do automatic discovery of devices.
  required: false
  type: boolean
  default: true
light:
  description: List of light devices.
  required: false
  type: list
  keys:
    host:
      description: Hostname or IP address of the device.
      required: true
      type: string
strip:
  description: List of multi-outlet on/off switch devices.
  required: false
  type: list
  keys:
    host:
      description: Hostname or IP address of the device.
      required: true
      type: string
switch:
  description: List of on/off switch devices.
  required: false
  type: list
  keys:
    host:
      description: Hostname or IP address of the device.
      required: true
      type: string
dimmer:
  description: List of dimmable switch devices.
  required: false
  type: list
  keys:
    host:
      description: Hostname or IP address of the device.
      required: true
      type: string
{% endconfiguration %}

## 수동 설정 사례

```yaml
# Example configuration.yaml entry with manually specified addresses
tplink:
  discovery: false
  light:
    - host: 192.168.200.1
    - host: 192.168.200.2
  switch:
    - host: 192.168.200.3
    - host: 192.168.200.4
  dimmer:
    - host: 192.168.200.5
    - host: 192.168.200.6
  strip:
    - host: 192.168.200.7
    - host: 192.168.200.8
```

## 에너지 센서 데이터 추출

TP-Link HS110 장치에서 전력 소비량 판독값을 얻으려면 [템플릿 센서](/integrations/switch.template/)를 만들어야합니다.
아래 예에서 모든 `my_tp_switch`를 장치의 엔티티 ID와 일치하도록 변경하십시오.

{% raw %}
```yaml
sensor:
  - platform: template
    sensors:
      my_tp_switch_amps:
        friendly_name_template: "{{ states.switch.my_tp_switch.name}} Current"
        value_template: '{{ states.switch.my_tp_switch.attributes["current_a"] | float }}'
        unit_of_measurement: 'A'
      my_tp_switch_watts:
        friendly_name_template: "{{ states.switch.my_tp_switch.name}} Current Consumption"
        value_template: '{{ states.switch.my_tp_switch.attributes["current_power_w"] | float }}'
        unit_of_measurement: 'W'
      my_tp_switch_total_kwh:
        friendly_name_template: "{{ states.switch.my_tp_switch.name}} Total Consumption"
        value_template: '{{ states.switch.my_tp_switch.attributes["total_energy_kwh"] | float }}'
        unit_of_measurement: 'kWh'
      my_tp_switch_volts:
        friendly_name_template: "{{ states.switch.my_tp_switch.name}} Voltage"
        value_template: '{{ states.switch.my_tp_switch.attributes["voltage"] | float }}'
        unit_of_measurement: 'V'
      my_tp_switch_today_kwh:
        friendly_name_template: "{{ states.switch.my_tp_switch.name}} Today's Consumption"
        value_template: '{{ states.switch.my_tp_switch.attributes["today_energy_kwh"] | float }}'
        unit_of_measurement: 'kWh'
```
{% endraw %}
