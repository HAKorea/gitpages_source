---
title: FortiOS 지원 장치 추적기
description: Instructions on how to use Fortinet FortiOS to track devices in Home Assistant.
logo: fortinet.jpg
ha_category:
  - Presence Detection
ha_release: 0.97
ha_iot_class: Local Polling
ha_codeowners:
  - '@kimfrellsen'
---

이 통합구성요소를 통해 Home Assistant는 [Fortinet](https://www.fortinet.com)에서 FortiGate에 연결된 MAC 주소를 가진 장치의 장치 추적을 수행 할 수 있습니다.

연동은 [fortiosapi] (https://pypi.org/project/fortiosapi/)에 의존합니다.
통합은 SW FortiOS v. 6.0.x 및 6.2.0을 실행하는 FortiGate 어플라이언스 및 FortiGate VM에서 모두 테스트되었습니다.

FortiGate에 의해 식별된 MAC 주소를 가진 모든 장치가 추적되며, 이는 LLDP에 의해 감지된 장치를 포함하여 이더넷 및 WiFi 장치를 모두 포함합니다.

통합구성요소는 Home Assistant`device_tracker` 플랫폼을 기반으로합니다.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: fortios
    host: YOUR_HOST
    token: YOUR_API_USER_KEY
```

{% configuration %}
host:
    description: Hostname or IP address of the FortiGate.
    required: true
    type: string
token:
    description: "See [Fortinet Developer Network](https://fndn.fortinet.net) for how to create an API token. Remember this integration only needs read access to a FortiGate, so configure the API user to only to have limited and read-only access."
    required: true
    type: string
verify_ssl:
    description: If the SSL certificate should be verified. In most home cases users do not have a verified certificate.
    required: false
    type: boolean
    default: false
{% endconfiguration %}
