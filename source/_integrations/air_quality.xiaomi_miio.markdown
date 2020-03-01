---
title: "샤오미 Air Quality Monitor"
description: "Instructions how to integrate your Xiaomi Mi Air Quality Monitor within Home Assistant."
logo: xiaomi.png
ha_category:
  - Health
ha_iot_class: Local Polling
ha_release: 0.102
---

`xiaomi_miio` 센서 플랫폼은 샤오미 미 공기질 모니터를 관찰하고 공기 품질 값을 보고합니다. 

현재 지원되는 기능은 다음과 같습니다.

- PM 2.5 미세먼지 수치 
- 속성 
  - carbon_dioxide_equivalent : CO2 수치 
  - total_volatile_organic_compounds : TVOC 수치 

API 토큰을 얻으려면 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token)에 대한 지시 사항을 따르십시오 .

## 설정 

Xiaomi Mi Air Quality Monitor를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
air_quality:
  - platform: xiaomi_miio
    host: IP_ADDRESS
    token: YOUR_TOKEN
```

{% configuration %}
host:
  description: miio 장치의 IP 주소.
  required: true
  type: string
token:
  description: miio 장치의 API 토큰.
  required: true
  type: string
name:
  description: miio 장치의 이름
  required: false
  type: string
  default: Xiaomi Miio 대기 질 모니터
{% endconfiguration %}
