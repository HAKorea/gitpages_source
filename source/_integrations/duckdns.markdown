---
title: 원격접속설정(Duck DNS)
description: Keep your computer registered with the DuckDNS dynamic DNS.
logo: duckdns.png
ha_category:
  - Network
ha_release: 0.55
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/A5CMD0FDOOM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

DuckDNS 통합구성요소로 DuckDNS 기록을 최신 상태로 유지할 수 있습니다. DuckDNS는 무료 동적 DNS 서비스로 `duckdns.org`의 하위 도메인으로 당산의 컴퓨터(홈어시스턴트)를 지정할 수 있습니다.

## 설정

설정하기 위해선 `configuration.yaml`에 다음을 추가하십시오. :

```yaml
# Example configuration.yaml entry
duckdns:
  domain: YOUR_SUBDOMAIN
  access_token: YOUR_ACCESS_TOKEN
```

{% configuration duckdns %}
  domain:
    description: duckdns 하위 도메인 (`.duckdns.org` 접미사 제외).
    required: true
    type: string
  access_token:
    description: DuckDNS 액세스 토큰을 얻기위해 duckdns 사이트에서 할당받아오십시오. 
    required: true
    type: string
{% endconfiguration %}

## Service `set_txt`

DuckDNS 하위 도메인의 TXT 레코드를 설정하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `txt` | no | Payload for the TXT record. |


<div class='note'>

[DuckDNS add-on](/addons/duckdns/)를 Hass.io에서 사용할 경우 연동이 필요하지 않습니다. Duckdns add-on이 해당 기능을 수행합니다. 
</div>
