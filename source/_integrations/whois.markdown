---
title: 후이즈(Whois)
description: Instructions on how to integrate WHOIS lookup sensor within Home Assistant.
logo: icann.png
ha_category:
  - Network
ha_release: 0.57
ha_iot_class: Cloud Polling
---

`whois` 센서 플랫폼을 사용하면 소유한 도메인에 대해 매일 WHOIS 조회를 수행 할 수 있습니다. 이것은 만료 날짜, 이름 서버 및 등록자 세부 정보와 같은 정보를 제공합니다.

## 설정

설치시이 센서를 사용하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: whois
    domain: example.net
```

{% configuration %}
  domain:
    description: The domain you want to perform WHOIS lookups against.
    required: true
    type: string
  name:
    description: Name to use in the frontend.
    required: false
    default: Whois
    type: string
{% endconfiguration %}
