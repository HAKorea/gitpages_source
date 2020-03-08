---
title: (PDU 랙스위치)ATEN Rack PDU
description: Instructions on how to integrate ATEN Rack PDUs into Home Assistant.
logo: aten.png
ha_category:
  - Switch
ha_release: 0.103
ha_codeowners:
  - '@mtdcr'
---

`aten_pe` 통합구성요소를 통해 Home Assistant에서 [ATEN Rack PDUs](https://www.aten.com/eu/en/products/energy-intelligence-pduupsracks/rack-pdu/)를 제어 할 수 있습니다.

이를 사용하려면 PDU에서 SNMP를 활성화해야합니다. 자격 증명(credentials)을 도청하지 못하도록 SNMPv3을 사용하는 것이 좋습니다.

테스트된 장치 :
  * [PE8324G](https://www.aten.com/eu/en/products/energy-intelligence-pduupsracks/rack-pdu/pe8324/)

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
switch:
  - platform: aten_pe
    host: 192.168.0.60
```

{% configuration %}
host:
  description: The IP/host which to control.
  required: true
  type: string
port:
  description: The port on which to communicate.
  required: false
  type: string
  default: 161
community:
  description: community string to use for authentication (SNMP v1 and v2c).
  required: false
  type: string
  default: private
username:
  description: Username to use for authentication.
  required: false
  type: string
  default: administrator
auth_key:
  description: Authentication key to use for SNMP v3.
  required: false
  type: string
priv_key:
  description: Privacy key to use for SNMP v3.
  required: false
  type: string
{% endconfiguration %}
