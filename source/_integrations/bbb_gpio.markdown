---
title: 비글본 블랙(BeagleBone Black GPIO)
description: Instructions on how to integrate the GPIO capability of a BeagleBone Black into Home Assistant.
logo: beaglebone-black.png
ha_category:
  - DIY
  - Binary Sensor
  - Switch
ha_release: 0.36
ha_iot_class: Local Push
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/UIw14y82KIo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`bbb_gpio` 통합구성요소는 Home Assistant의 모든 [BeagleBone Black](https://beagleboard.org/black) 관련 GPIO 플랫폼을 사용할 수 있습니다.
연동 자체에 필요한 설정이 없습니다.

## Binary Sensor

`bbb_gpio` 이진 센서 플랫폼을 사용하면 [BeagleBone Black](https://beagleboard.org/black)의 GPIO 센서값을 읽을 수 있습니다.

## 설정

설치에서 BeagleBone Black의 GPIO를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: bbb_gpio
    pins:
      P8_12:
        name: Door
      GPIO0_26:
        name: Window
```

{% configuration %}
pins:
  description: List of used pins.
  required: true
  type: map
  keys:
    pin_name:
      description: Port numbers and corresponding names.
      required: true
      type: map
      keys:
        name:
          description: Friendly name to use for the frontend.
          required: true
          type: string
        bouncetime:
          description: Debounce time for reading input pin defined in milliseconds [ms].
          required: false
          type: integer
          default: 50
        invert_logic:
          description: If `true`, inverts the input logic to ACTIVE LOW
          required: false
          type: boolean
          default: false
        pull_mode:
          description: Type of internal pull resistor connected to input. Options are `UP` - pull-up resistor and `DOWN` - pull-down resistor.
          required: false
          type: string
          default: UP
{% endconfiguration %}

GPIO 레이아웃에 대한 자세한 내용은 BeagleBone Black에 관한 [article](https://elinux.org/Beagleboard:BeagleBoneBlack)을 방문하십시오.

## Switch

`bbb_gpio` 스위치 플랫폼을 사용하면 [BeagleBone Black](https://beagleboard.org/black)의 GPIO를 제어 할 수 있습니다.

## 설정

설치에서 BeagleBone Black의 GPIO를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: bbb_gpio
    pins:
      GPIO0_7:
        name: LED Red
      P9_12:
        name: LED Green
```

{% configuration %}
pins:
  description: List of used pins.
  required: true
  type: map
  keys:
    pin_name:
      description: Port numbers and corresponding names.
      required: true
      type: map
      keys:
        name:
          description: Friendly name to use for the frontend.
          required: false
          type: string
        initial:
          description: Initial state of the pin.
          required: false
          default: false
          type: boolean
        invert_logic:
          description: If `true`, inverts the input logic to ACTIVE LOW
          required: false
          default: false
          type: boolean
{% endconfiguration %}

GPIO 레이아웃에 대한 자세한 내용은 BeagleBone Black에 관한 [article](https://elinux.org/Beagleboard:BeagleBoneBlack)을 방문하십시오.