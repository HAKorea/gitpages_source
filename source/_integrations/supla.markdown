---
title: ESP오픈소스스마트홈(Supla)
description: Instructions for integration with Supla Cloud's Web API
logo: supla.png
ha_release: 0.92
ha_category:
  - Hub
  - Cover
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@mwegrzynek'
---

<div class='videoWrapper'>
<iframe width="690" height="440" src="https://www.youtube.com/embed/LrV9-Q2ha-o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Supla](https://supla.org/)는 ESP8266 기반 장치를 위한 오픈 소스 홈오토메이션 시스템입니다. 자체 프로토콜 세트, 자체 펌웨어 및 [Zamel](https://supla.zamel.pl/)과 같은 상용 장치를 가지고 있습니다.

현재 커버(Supla's lingo의 셔터), 게이트 및 스위치만 지원되지만 포괄적이고 보편적인 REST API 덕분에 더 쉽게 추가할 수 있습니다.

당장은 단일 장치를 추가할 수 없습니다. - Supla Cloud 서버 또는 당신의 서버에서 모두 발견됩니다. Supla Cloud에서 비활성화된 장치는 Home Assistant에 로드되지 않습니다.

## 설정

Supla 장치를 사용하려면 `configuration.yaml`에 다음을 추가하십시오.

```yaml
supla:
  servers:
    - server: svr1.supla.org
      access_token: your_really_long_access_token
```

{% configuration %}
servers:
  description: List of server configurations.
  requires: true
  type: list
server:
  description: Address of your Supla Cloud server (either IP or DNS name)
  required: true
  type: string
access_token:
  description:
    An access token for REST API configuration. Can be acquired from
    http[s]://your.server.org/integrations/tokens (please add at least Channel's Read and Action Execution permissions).
  required: true
  type: string
{% endconfiguration %}
