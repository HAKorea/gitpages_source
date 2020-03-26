---
title: 태양광인버터(SolaX Power)
description: Instructions on how to integrate Solax sensor within Home Assistant.
logo: solax-logo.png
ha_category:
  - Energy
  - Sensor
ha_release: 0.94
ha_iot_class: Local Polling
ha_codeowners:
  - '@squishykid'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/a9TY16j_Kk4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`solax` 통합구성요소는 홈어시스턴트를 Solax 태양광 인버터에 연결합니다. Solax 인버터는 홈 Wi-Fi 네트워크에 연결되어 REST API를 노출할 수 있습니다. 이 연동은 태양광 발전, 배터리 레벨, 전력, 그리드에 얼마나 많은 전력이 공급되는지와 같은 정보를 검색합니다.

## 설정

Solax 센서를 사용하려면 configuration.yaml 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: solax
    ip_address: IP_ADDRESS
```

{% configuration %}
ip_address:
  description: The IP address of your Solax system.
  required: true
  type: string
port:
  required: false
  type: integer
  default: 80
  description: The port number
{% endconfiguration %}

### 선택적 템플릿 센서 

여러 패널의 값을 변환하거나 집에서 사용중인 총전력을 보려면 [template platform](/integrations/template)을 사용할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry for template platform
sensors:
- platform: template
  sensors:
    total_pv_power:
      friendly_name: "Total PV Power"
      unit_of_measurement: 'W'
      value_template: "{{ (states('sensor.pv1_power') | float) + (states('sensor.pv2_power') | float) }}"
    load_power:
      friendly_name: "Load Power"
      unit_of_measurement: 'W'
      value_template: "{{ (states('sensor.power_now') | float) - (states('sensor.exported_power') | float) }}"
```
{% endraw %}

### Note

최신 펌웨어가 포함된 인버터 모델(PocketWifi와 같은 장치를 사용하는 인버터 모델)은 무선 네트워크에 연결할 때 더이상 API를 노출시키지 않지만 자체 브로드 캐스트 SSID에 계속 노출시킵니다. 이 경우이 센서를 사용하려면 Nginx와 같은 것으로 리버스 프록시를 설정하고 두 개의 네트워크 연결 (하나는 인버터 SSID에 연결되는 wifi)로 라즈베리파이(또는 유사한 호스트)를 사용해야합니다.

Nginx 설정 예

```text
location / {
  proxy_pass http://5.8.8.8;
}
```
