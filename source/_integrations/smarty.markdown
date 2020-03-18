---
title: 공조시스템(Salda Smarty)
description: Instructions on how to integrate Salda Smarty 2X/3X/4X P/V ventilation systems into Home Assistant.
logo: salda.png
ha_category:
  - Hub
  - Fan
  - Sensor
ha_release: 0.95
ha_codeowners:
  - '@z0mbieprocess'
---

<iframe width="692" height="388" src="https://www.youtube.com/embed/4Jzt1-vL5Wc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`smarty` 연동을 통해 Home Assistant에서 Salda [Smarty](http://www.salda.lt/en/products/category/compact-counter-flow-units) 환기 장치를 제어 할 수 있습니다. 로컬 네트워크에 연결하려면 [MB-GATEWAY](http://www.salda.lt/en/products/item/5637227077) 또는 이와 유사한 것이 필요합니다.

현재 홈어시스턴트에는 다음 장치 유형이 지원됩니다.

- Fan
- Sensor

통합구성요소에는 환기 속도를 보고 제어 할 수있는 팬 플랫폼과 다음을 읽을 수있는 센서 플랫폼이 있습니다.

- Outdoor air temperature
- Extract air temperature
- Supply air temperature
- Extract fan speed rpm
- Supply fan speed rpm
- Alarm
- Warning
- Filter Change Timer

## 설정

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
smarty:
  host: 192.168.0.10
```

{% configuration %}
host:
  description: The IP Address of the unit.
  required: true
  type: string
name:
  description: The name of this device as you want to see it in Home Assistant.
  required: false
  default: Smarty
  type: string
{% endconfiguration %}
