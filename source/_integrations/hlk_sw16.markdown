---
title: 하이링크(Hi-Link HLK-SW16)
description: Instructions on how to integrate HLK-SW16 relay into Home Assistant.
logo: hlktech.jpg
ha_category:
  - DIY
  - Switch
ha_release: 0.84
ha_iot_class: Local Push
---

The [HLK-SW16](http://www.hlktech.net/product_detail.php?ProId=48) by [Hi-Link](http://www.hlktech.net/) is a simple networkable 16 port relay device.
[Hi-Link](http://www.hlktech.net/)의 [HLK-SW16](http://www.hlktech.net/product_detail.php?ProId=48)은 심플한 네트워크 가능 16 포트 릴레이입니다.

To enable it, add the following lines to your `configuration.yaml`:
이를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
hlk_sw16:
  relay1:
    host: 10.225.225.53
    switches:
      0:
        name: relay1-0
      1:
        name: relay1-1
      2:
        name: relay1-2
      3:
        name: relay1-3
      4:
        name: relay1-4
      5:
        name: relay1-5
      6:
        name: relay1-6
      7:
        name: relay1-7
      8:
        name: relay1-8
      9:
        name: relay1-9
      a:
        name: relay1-a
      b:
        name: relay1-b
      c:
        name: relay1-c
      d:
        name: relay1-d
      e:
        name: relay1-e
      f:
        name: relay1-f
```

{% configuration %}
deviceid:
  description: HLK-SW16 장치가 포함 된 어레이.
  required: true
  type: map
  keys:
    host:
      description: HLK-SW16의 IP 주소 또는 호스트 이름.
      required: true
      type: string
    port:
      description: 릴레이의 제어 포트.
      required: false
      type: integer
      default: 8080
    switches:
      description: 릴레이가 포함 된 배열
      required: true
      type: map
      keys:
        relayid:
          description: HLK-SW16 릴레이를 포함하는 어레이는 각각 0 과 9 사이의 숫자이거나 a 와 f 사이의 문자 여야하며, 각각 HLK-SW16의 레이블이 있는 릴레이 스위치에 해당합니다.
          required: false
          type: map
          keys:
            name:
              description: 프런트 엔드에 스위치를 표시하는 데 사용되는 이름.
              required: false
              type: string
              default: relayid
{% endconfiguration %}
