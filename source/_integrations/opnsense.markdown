---
title: OPNSense(오픈소스방화벽)
description: Instructions on how to configure OPNsense integration
logo: opnsense.png
ha_category:
  - Hub
  - Presence Detection
ha_release: 0.105
ha_codeowners:
  - '@mtreinish'
---

[OPNsense] (https://opnsense.org/)는 오픈 소스 HardenedBSD 기반 방화벽 및 라우팅 플랫폼입니다. 현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Presence Detection](#presence-detection)

## 설정

Home Assistant에 OPNsense 통합구성요소를 설정하려면 configuration.yaml에 다음 섹션을 추가하십시오.

```yaml
opnsense:
  url: http://router/api
  api_secret: API_SECRET
  api_key: API_KEY
```

여기서 api_key 및 api_secret 값은 웹 인터페이스를 사용하여 OPNsense 라우터에서 가져옵니다. 이 절차에 대한 자세한 내용은 OPNsense [documentation](https://docs.opnsense.org/development/how-tos/api.html#creating-keys)을 참조하십시오.

{% configuration %}
url:
  description: The URL for the OPNsense API endpoint of your router.
  type: string
  required: true
api_key:
  description: The API key used to authenticate with your OPNsense API endpoint.
  type: string
  required: true
api_secret:
  description: The API secret used to authenticate with your OPNsense API endpoint.
  type: string
  required: true
verify_ssl:
  description: Set to true to enable the validation of the OPNsense API SSL.
  type: boolean
  required: false
  default: false
tracker_interfaces:
  description: List of the OPNsense router's interfaces to use for tracking devices.
  type: list
  required: false
  default: []
{% endconfiguration %}


## 재실 감지

이 플랫폼을 사용하면 OPNsense 라우터에 연결된 장치를 보고 현재 상태를 감지 할 수 있습니다.