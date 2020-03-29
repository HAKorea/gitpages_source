---
title: 러스사운드 RNET(Russound RNET)
description: Instructions on how to integrate Russound RNET devices into Home Assistant.
logo: russound.png
ha_category:
  - Media Player
ha_release: 0.25
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/SR6IuN1wuDM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`russound_rnet` 플랫폼을 사용하면 RNET 프로토콜을 사용하는 Russound 장치를 제어할 수 있습니다.

이는 6 개의 구역(zone)과 6 개의 소스(source)가 있는 Russound CAV6.6 장치에 처음 테스트되었습니다. Russound CAA66에서도 작동하지만 null-modem 케이블을 사용해야합니다.

Russound 장치에 연결하는 것은 TCP를 통해서만 가능합니다. [tcp_serial_redirect](https://github.com/pyserial/pyserial/blob/master/examples/tcp_serial_redirect.py)와 같은 TCP to Serial 게이트웨이를 사용할 수 있습니다

설치시 장치를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
media_player:
  - platform: russound_rnet
    host: 192.168.1.10
    port: 1337
    name: Russound
    zones:
      1:
        name: Main Bedroom
      2:
        name: Living Room
      3:
        name: Kitchen
      4:
        name: Bathroom
      5:
        name: Dining Room
      6:
        name: Guest Bedroom
    sources:
      - name: Sonos
      - name: Sky+
```

{% configuration %}
host:
  description: The IP of the TCP gateway.
  required: true
  type: string
port:
  description: The port of the TCP gateway.
  required: true
  type: integer
name:
  description: The name of the device.
  required: true
  type: string
zones:
  description: This is the list of zones available.
  required: true
  type: integer
sources:
  description: The list of sources available, these must be in order as they are connected to the device.
  required: true
  type: list
{% endconfiguration %}
