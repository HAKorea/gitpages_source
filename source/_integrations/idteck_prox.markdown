---
title: 대한민국 보안회사(IDTECK Proximity Reader)
description: How to use IDTECK proximity card readers.
logo: idteck.jpg
ha_category:
  - Other
ha_release: 0.85
ha_iot_class: Local Push
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/yz4RXf_ABVc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[IDTECK] (http://www.idteck.com)는 ID 시스템을 사용하여 액세스를 제어하고 사용자를 식별합니다. 이 통합구성요소는 [Proximity Readers](http://www.idteck.com/en/products/proximity-reader-__-card-%26-tag-__125khz)(RFID 카드 리더)와 함께 작동합니다. 이 장치는 serial to ethernet converter (NPort)를 통해 Home Assistant에 연결됩니다.

`idteck_prox_keycard` 이벤트는 카드나 키 시퀀스가 ​​입력될 때마다 발생합니다. 이벤트에는 'card' - card/key 순서 및 카드 판독기의 'name'이 포함됩니다. 알려진 카드 번호에 대해 'card'를 확인하는 것은 출입 통제 시스템의 기초 또는 check-in/check-out 시스템의 일부로 사용될 수 있습니다.

## Configuration

``` yaml
# Example configuration.yaml entry
idteck_prox:
  - host: host1.domain.com
    port: 4001
    name: "Lower Door"
  - host: host2.domain.com
    port: 4001
    name: "Upper Door"
```

{% configuration %}
host:
  description: The hostname or IP address of the ethernet to serial adapter that is connected to the proximity reader.  It is assumed that the adapter has been preconfigured.
  required: true
  type: string
port:
  description: The port of the ethernet to serial adapter
  required: true
  type: integer
name:
  description: The name of the prox card reader
  required: true
  type: string
{% endconfiguration %}
