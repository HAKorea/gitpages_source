---
title: Mythic Beasts DNS
description: Keep your mythic beasts DNS updated
ha_category:
  - Network
ha_release: 0.85
ha_iot_class: Cloud Push
logo: mythic_beasts.png
---

`mythicbeastsdns` 통합구성요소를 통해 [Mythic Beasts](https://www.mythic-beasts.com/)에서 동적 DNS 항목을 자동으로 업데이트 할 수 있습니다.

## 설정

설치시 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
mythicbeastsdns:
  host: YOUR_HOST
  domain: YOUR_DOMAIN
  password: YOUR_API_KEY
```

{% configuration %}
  host:
    description: The first part, or subdomain that you want to be dynamic.
    required: true
    type: string
  domain:
    description: Your domain, e.g., `example.com`.
    required: true
    type: string
  password:
    description: The password for your domain. You can set this by clicking "DNS API" on the domain page.
    required: true
    type: string
{% endconfiguration %}
