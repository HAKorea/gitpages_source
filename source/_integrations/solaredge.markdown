---
title: 솔라엣지(SolarEdge)
description: Instructions on how to integrate SolarEdge sensor within Home Assistant.
logo: solaredge.png
ha_category:
  - Sensor
ha_release: 0.85
ha_iot_class: Cloud Polling
ha_config_flow: true
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/BjtL_vIkyNg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`solaredge` 플랫폼은 [SolarEdge Monitoring API](https://www.solaredge.com/sites/default/files/se_monitoring_api.pdf)를 사용하여 SolarEdge 태양광 전력 설정에서 세부 정보를 가져와 Home Assistant 설치시 연동할 수 있습니다.

<div class='note'>

SolarEdge Monitoring API의 일일 요청 속도는 300 회입니다. 이 한계를 지키고 일부 추가 요청을 줄이기 위해 `solaredge` 플랫폼은 10 분마다 사이트 Overview를 업데이트합니다.

</div>

## 설정

SolarEdge 통합구성요소 설정에는 두 가지 옵션이 있습니다.

- 홈어시스턴트 사용자 인터페이스를 통해 포트 문자열을 입력하여 Velbus 버스에 연결할 수 있습니다. 
- 홈어시스턴트 `configuration.yaml` 파일을 통해.

{% raw %}
```yaml
# Example configuration.yaml entry
solaredge:
  api_key: API_KEY
  site_id: SITE_ID
```
{% endraw %}

{% configuration %}
api_key:
  description: Your SolarEdge Site API key.
  required: true
  type: string
site_id:
  description: The id of your SolarEdge Site.
  required: true
  type: string
name:
  description: Let you overwrite the name of the device in the frontend.
  required: false
  default: SolarEdge
  type: string
{% endconfiguration %}

## 전체 설정 사례

예를 들어 기본값 Wh 대신 kWh로 값을 변환하려는 경우 [template platform](/integrations/template)을 사용할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry for template platform
sensors:
  platform: template
  sensors:
    solaredge_energy_this_year_template:
      value_template: "{{ (states('sensor.solaredge_energy_this_year') | float / 1000) | round(2) }}"
```
{% endraw %}
