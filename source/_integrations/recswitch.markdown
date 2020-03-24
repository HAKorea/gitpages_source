---
title: 스마트홈플랫폼(Ankuoo REC Switch)
description: Instructions on how to integrate Ankuoo Rec Switch into Home Assistant.
logo: ankuoo_recswitch.png
ha_release: 0.81
ha_category:
  - Switch
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/kgf8a2oFrHk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`recswitch` 스위치 플랫폼을 사용하면 Ankuoo Rec Switch 장치를 제어할 수 있습니다.

지원되는 장치 (테스트) :

- Ankuoo RecSwitch MS6126
- Lumitek CSW201 NEO WiFi
- MALMBERGS CSW201

## 설정

이 스위치를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: recswitch
    host: 'IP_ADDRESS'
    mac: 'MAC_ADDRESS'
```

{% configuration %}
host:
  description: IP address or hostname of the device.
  required: true
  type: string
mac:
  description: MAC address of the device.
  required: true
  type: string
name:
  description: Name to use in the frontend.
  required: false
  type: string
{% endconfiguration %}
