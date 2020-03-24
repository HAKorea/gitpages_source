---
title: 에디맥스(Edimax)
description: Instructions on how to integrate Edimax switches into Home Assistant.
logo: edimax.png
ha_category:
  - Switch
ha_release: pre 0.7
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/pWA_luALGi8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 `edimax` 스위치 플랫폼을 사용하면 [Edimax](https://www.edimax.com/edimax/merchandise/merchandise_list/data/edimax/global/home_automation_smart_plug/) 스위치의 상태를 제어할 수 있습니다.

설치시 Edimax 스위치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: edimax
    host: 192.168.1.32
```

{% configuration %}
host:
  description: "The IP address of your Edimax switch, e.g., `192.168.1.32`."
  required: true
  type: string
username:
  description: Your username for the Edimax switch.
  required: false
  default: admin
  type: string
password:
  description: Your password for the Edimax switch.
  required: false
  default: 1234
  type: string
name:
  description: The name to use when displaying this switch.
  required: false
  default: Edimax Smart Plug
  type: string
{% endconfiguration %}

## 소비 전력 센서

[version 2 of the firmware](https://www.edimax.com/edimax/download/download/data/edimax/global/download/)부터 Edimax 스위치는 상태 개체에서 현재 및 누적 일일 전력 소비량을 보고할 수도 있습니다. [template sensor](/integrations/template)를 사용하여 값을 추출하십시오. 

{% raw %}
```yaml
  - platform: template
    sensors:
      edimax_current_power:
        friendly_name: Edimax Current power consumption
        unit_of_measurement: 'W'
        value_template: "{{ state_attr('switch.edimax_smart_plug',  'current_power_w') | replace('None', 0) }}"

      edimax_total_power:
        friendly_name: Edimax Accumulated daily power consumption
        unit_of_measurement: 'kWh'
        value_template: "{{ state_attr('switch.edimax_smart_plug',  'today_energy_kwh') | replace('None', 0) }}"
```
{% endraw %}

스마트 플러그가 꺼져 있으면 이 상태는 문자열 `None`을 보고합니다. 템플릿에서 `replace ()`를 사용하여 이 센서는 순수한 숫자 값을 보고합니다.