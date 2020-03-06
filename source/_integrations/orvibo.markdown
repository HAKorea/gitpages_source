---
title: 오르비보(orvibo)
description: Instructions on how to integrate Orvibo sockets within Home Assistant.
logo: orvibo.png
ha_category:
  - Switch
ha_release: 0.8
---

<div class='note warning'>

안전 문제로 인해 유럽 당국은 ORVIBO WIFI SMART SOCKET S20 (LGS-20) 제품을 리콜했습니다. 자세한 내용은 [RAPEX 정보](https://ec.europa.eu/consumers/consumers_safety/safety_products/rapex/alerts/?event=viewProduct&reference=A12/1577/15&lng=en)를 방문하십시오.

</div>

`orvibo` 스위치 플랫폼을 사용하면 Orvibo S20 Wifi 스마트 소켓을 토글 할 수 있습니다.

네트워크에서 Orvibo 소켓을 자동으로 감지하려면 다음을 수행하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: orvibo
```

Orvibo 소켓을 지정하고 discovery를 건너 뛰려면 다음을 수행하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: orvibo
    discovery: false
    switches:
      - host: IP_ADDRESS
        mac: MA:CA:DD:RE:SS:00
        name: "My Socket"
```

{% configuration %}
discovery:
  description: Whether to discover sockets.
  required: false
  default: true
  type: boolean
switches:
  description: A list of Orvibo switches.
  required: false
  type: list
  keys:
    host:
      description: "IP address of your socket, e.g., 192.168.1.10."
      required: true
      type: string
    mac:
      description: "MAC address of the socket, e.g., `AA:BB:CC:DD:EE:FF`. This is required if the socket is connected to a different subnet to the machine running Home Assistant."
      required: false
      type: string
    name:
      description: Your name for the socket.
      required: false
      default: Orvibo S20 Switch
      type: string
{% endconfiguration %}
