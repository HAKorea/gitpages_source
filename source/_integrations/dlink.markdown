---
title: 디링크 Wi-Fi Smart Plugs
description: Instructions on how to integrate D-Link switches into Home Assistant.
logo: dlink.png
ha_category:
  - Switch
ha_iot_class: Local Polling
ha_release: 0.14
---

`dlink` 스위치 플랫폼을 사용하면 [D-Link Wi-Fi Smart Plugs](https://us.dlink.com/en/consumer/smart-plugs)의 상태를 제어할 수 있습니다

지원 장치들 :

- DSP-W215
- DSP-W110

D-Link 스마트 플러그를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  platform: dlink
  host: IP_ADRRESS
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
host:
  description: "D-Link 플러그의 IP 주소 (예 : 192.168.1.32)"
  required: true
  type: string
name:
  description: 이 스위치를 표시 할 때 사용할 이름.
  required: false
  default: D-link Smart Plug W215
  type: string
username:
  description: 플러그의 사용자 이름.
  required: true
  default: admin
  type: string
password:
  description: 플러그의 비밀번호.
  required: true
  default: The default password is the `PIN` included on the configuration card.
  type: string
use_legacy_protocol:
  description: 레거시 펌웨어 프로토콜에 대한 제한된 지원을 활성화합니다 (v1.24로 테스트).
  required: false
  default: false
  type: boolean
{% endconfiguration %}
