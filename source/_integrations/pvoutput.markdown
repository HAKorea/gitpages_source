---
title: 태양광클라우드비교(PVOutput)
description: Instructions on how to use PVOutput within Home Assistant.
logo: pvoutput.png
ha_category:
  - Energy
ha_release: 0.33
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/DCOrwp_48TA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`pvoutput` 센서 플랫폼은 태양광 발전(PV) 시스템에 의해 업로드된 [PVOutput](https://pvoutput.org/)의 정보를 소비합니다.

설치에 PVOutput 세부 사항을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: pvoutput
    system_id: YOUR_SYSTEM_ID
    api_key: YOUR_API_KEY
    scan_interval: 120
```

{% configuration %}
api_key:
  description: Your API key. A read-only key is fine.
  required: true
  type: string
system_id:
  description: The ID of your station.
  required: true
  type: string
name:
  description: Name of the sensor.
  required: false
  default: PVOutput
  type: string
{% endconfiguration %}

<div class='note warning'>

`scan_interval:`을 60 초보다 큰 값에 따라 설정하는 것이 좋습니다. 이 서비스는 시간당 60 개의 요청만 허용하지만 센서의 기본값은 30 초입니다.

</div>

PV 출력 센서를 포맷하려면 [template component](/topics/templating/)를 사용하는 것이 좋습니다. 예를 들면 다음과 같습니다.

```yaml
sensor:
  - platform: pvoutput
    system_id: YOUR_SYSTEM_ID
    api_key: YOUR_API_KEY
    scan_interval: 150
  - platform: template
    sensors:
      power_consumption:
        value_template: {% raw %}'{% if is_state_attr("sensor.pvoutput", "power_consumption", "NaN") %}0{% else %}{{ state_attr('sensor.pvoutput', 'power_consumption') }}{% endif %}'{% endraw %}
        friendly_name: 'Using'
        unit_of_measurement: 'Watt'
      energy_consumption:
        value_template: {% raw %}'{{ "%0.1f"|format(state_attr('sensor.pvoutput', 'energy_consumption')|float/1000) }}'{% endraw %}
        friendly_name: 'Used'
        unit_of_measurement: 'kWh'
      power_generation:
        value_template: {% raw %}'{% if is_state_attr("sensor.pvoutput", "power_generation", "NaN") %}0{% else %}{{ state_attr('sensor.pvoutput', 'power_generation') }}{% endif %}'{% endraw %}
        friendly_name: 'Generating'
        unit_of_measurement: 'Watt'
      energy_generation:
        value_template: {% raw %}'{% if is_state_attr("sensor.pvoutput", "energy_generation", "NaN") %}0{% else %}{{ "%0.2f"|format(state_attr('sensor.pvoutput', 'energy_generation')|float/1000) }}{% endif %}'{% endraw %}
        friendly_name: 'Generated'
        unit_of_measurement: 'kWh'
```
