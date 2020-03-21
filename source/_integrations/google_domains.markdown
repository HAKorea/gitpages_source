---
title: 구글 도메인(Google Domains)
description: Keep your computer registered with the Google Domains dynamic DNS.
logo: google_domains.png
ha_category:
  - Network
ha_release: 0.57
---

Google Domains 통합구성요소를 사용하면 Google Domains 레코드를 최신 상태로 유지할 수 있습니다.

## 설정

설치시 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
google_domains:
  domain: subdomain.domain.com
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
  domain:
    description: Your FQDN.
    required: true
    type: string
  username:
    description: The generated username for this DDNS record.
    required: true
    type: string
  password:
    description: The generated password for this DDNS record.
    required: true
    type: string
  timeout:
    description: Timeout (in seconds) for the API calls.
    required: false
    type: integer
    default: 10
{% endconfiguration %}
