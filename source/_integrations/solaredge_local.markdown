---
title: 솔라엣지 로컬(SolarEdge Local)
description: Instructions on how to integrate SolarEdge sensor within Home Assistant via Local API.
logo: solaredge.png
ha_category:
  - Sensor
  - Energy
ha_release: 0.95
ha_iot_class: Local Polling
ha_codeowners:
  - '@drobtravels'
  - '@scheric'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/BjtL_vIkyNg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`solaredge_local` 플랫폼은 일부 SolarEdge 인버터에서 사용 가능한 로컬 API를 사용하여 SolarEdge 태양광 설정에서 세부 정보를 가져와 Home Assistant에 연동할 수 있습니다.

특정 모델만 로컬 API를 지원합니다. 로컬 API는 LCD 문자 화면이 없는 인버터에서 사용할 수 있습니다. "Additional Features" 섹션에서 "Inverter Commissioning"하위 섹션에 "With the SetApp mobile application using built-in Wi-Fi access point for local connection" 섹션이 있는 경우 데이터 시트를 확인할 수 있습니다. 이 인버터에는 또한 4로 끝나는 부품 번호가 있습니다. (예: SEXXK-XXXXXBXX4 또는 SEXXXXH-XXXXXBXX4)

인버터의 IP 주소를 찾아 브라우저에서 로컬 API가 작동하는지 확인할 수 있습니다. 로컬 API를 지원하는 경우 SolarEdge 로고가 있는 HTML 페이지와 "Commissioning" 메뉴가 나타납니다.

<div class='note'>
  
인버터가 로컬 API를 지원하지 않는 경우 [cloud based version](/integrations/solaredge/)을 사용할 수 있습니다

</div>


## 설정

SolarEdge 센서를 사용하려면 configuration.yaml 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: solaredge_local
    ip_address: IP_ADDRESS
```

{% configuration %}
ip_address:
  description: The IP Address of your SolarEdge inverter.
  required: true
  type: string
name:
  description: Let you overwrite the name of the device in the frontend.
  required: false
  default: SolarEdge
  type: string
{% endconfiguration %}

### 전체 설정 샘플

전체 설정 항목은 아래 샘플과 같습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: solaredge_local
    name: SolarEdge
    ip_address: 192.168.1.123
```

예를 들어 기본값 Wh 대신 kWh로 값을 변환하려는 경우 [template platform](/integrations/template)을 사용할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry for sensor template platform
sensor:
  - platform: template
    sensors:
      solaredge_energy_this_year_template:
        value_template: "{{ (states('sensor.solaredge_energy_this_year') | float / 1000) | round(2) }}"
        unit_of_measurement: 'KWh'
        icon_template: "mdi:solar-power"
```
{% endraw %}
