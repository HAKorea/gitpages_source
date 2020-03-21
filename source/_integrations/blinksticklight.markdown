---
title: 블링크스틱(BlinkStick)
description: Instructions on how to setup Blinkstick lights within Home Assistant.
logo: blinkstick.png
ha_category:
  - DIY
ha_release: 0.7.5
ha_iot_class: Local Polling
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/cjmDbKk3ajk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`blinkstick` 플랫폼을 사용하면 Home Assistant 내에서 [Blinkstick](https://www.blinkstick.com/) 조명을 제어 할 수 있습니다.

## 셋업

Blinkstick을 사용하려면 [non-root users](https://github.com/arvydas/blinkstick-python#permission-problems-in-linux-and-mac-os-x)의 장치에 대한 액세스를 허용해야합니다

```bash
$ sudo blinkstick --add-udev-rule
```

## 설정

Blinkstick을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: blinksticklight
    serial: BS000795-1.1
```

{% configuration %}
serial:
  description: The serial number of your stick.
  required: true
  default: 640
  type: string
name:
  description: Name of the stick.
  required: false
  type: string
  default: Blinkstick
{% endconfiguration %}
