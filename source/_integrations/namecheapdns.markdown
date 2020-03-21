---
title: Namecheap FreeDNS
description: Keep your namecheap dynamic DNS up to date
logo: namecheap.png
ha_category:
  - Network
ha_release: 0.56
---

`namecheapdns` 통합구성요소를 사용하면 [namecheapdns](https://www.namecheap.com/store/domains/freedns/)에서 동적 DNS 항목을 자동으로 업데이트 할 수 있습니다.

<div class='note warning'>
Namecheap only supports IPv4 addresses to update.
Namecheap은 업데이트 할 IPv4 주소만 지원합니다.
</div>

## 설정

설치시 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
namecheapdns:
  domain: example.com
  password: YOUR_PASSWORD
```

{% configuration %}
  host:
    description: The host part or "subdomain" part you want to update.
    required: false
    type: string
  domain:
    description: Your namecheap TLD (example.com).
    required: true
    type: string
  password:
    description: The namecheap "Dynamic DNS Password" you can find under the "Advanced DNS" tab.
    required: true
    type: string
{% endconfiguration %}

See the [How do I set up a Host for Dynamic DNS?](https://www.namecheap.com/support/knowledgebase/article.aspx/43/11/how-do-i-set-up-a-host-for-dynamic-dns) for further instructions
