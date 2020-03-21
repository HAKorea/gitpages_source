---
title: 블링크트(Blinkt!)
description: Instructions on how to setup Blinkt! RGB LED lights within Home Assistant.
logo: raspberry-pi.png
ha_category:
  - DIY
ha_iot_class: Local Push
ha_release: 0.44
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/QvDe3___604" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`blinkt` 라이트 플랫폼을 사용하면 8 개의 초고휘도 RGB LED가 있는 [Blinkt!](https://shop.pimoroni.com/products/blinkt) 보드를 제어 할 수 있습니다.

## 설정

설치에서 `blinkt`를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
light:
  - platform: blinkt
```
