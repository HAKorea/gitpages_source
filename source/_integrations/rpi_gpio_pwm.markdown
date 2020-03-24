---
title: pigpio Daemon PWM LED
description: Instructions on how to setup PWM LEDs within Home Assistant.
ha_category:
  - DIY
ha_iot_class: Local Push
ha_release: 0.43
logo: raspberry-pi.png
---

`rpi_gpio_pwm` 플랫폼은 pulse-width 변조 (예: LED 스트립)를 사용하여 여러 조명을 제어할 수 있습니다. Raspberry Pi의 GPIO 또는 PCA9685 컨트롤러로 구동되는 단색, RGB 및 RGBW LED를 지원합니다.

GPIO를 제어하기 위해 플랫폼은 실행중인 [pigpio-daemon](http://abyz.me.uk/rpi/pigpio/pigpiod.html)에 연결됩니다. Raspbian Jessie 2016-05-10 이상에는 `pigpio` 라이브러리가 이미 포함되어 있습니다. 다른 운영 체제에서는 먼저 설치해야합니다 ([installation instructions](https://github.com/soldag/python-pwmled#installation) 참조).

## 설정

이 플랫폼을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
light:
  - platform: rpi_gpio_pwm
    leds:
      - name: Lightstrip Cupboard
        driver: gpio
        pins: [17]
        type: simple
```

{% configuration %}
leds:
  description: Can contain multiple LEDs.
  required: true
  type: list
  keys:
    name:
      description: The name of the LED.
      required: true
      type: string
    driver:
      description: The driver which controls the LED. Choose either `gpio` or `pca9685`.
      required: true
      type: string
    pins:
      description: The pins connected to the LED as a list. The order of pins is determined by the specified type.
      required: true
      type: [list, integer]
    type:
      description: The type of LED. Choose either `rgb`, `rgbw` or `simple`.
      required: true
      type: string
    freq:
      description: The PWM frequency.
      required: false
      default: 200
      type: integer
    address:
      description: The address of the PCA9685 driver.
      required: false
      default: 0x40
      type: string
{% endconfiguration %}

## 사례

이 섹션에는이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### PCA9685 컨트롤러에 연결된 RGB LED 

This example uses a [PCA9685 controller](https://www.nxp.com/products/interfaces/ic-bus-portfolio/ic-led-display-control/16-channel-12-bit-pwm-fm-plus-ic-bus-led-controller:PCA9685) to control a RGB LED.
이 예에서는 [PCA9685 controller](https://www.nxp.com/products/interfaces/ic-bus-portfolio/ic-led-display-control/16-channel-12-bit-pwm-fm-plus-ic-bus-led-controller:PCA9685)를 사용하여 RGB LED를 제어합니다.

```yaml
# Example configuration.yaml entry
light:
  - platform: rpi_gpio_pwm
    leds:
      - name: TV Backlight
        driver: pca9685
        pins: [0, 1, 2] # [R, G, B]
        type: rgb
```

### PCA9685 컨트롤러에 연결된 RGBW LED

이 예는 [PCA9685 controller](https://www.nxp.com/products/interfaces/ic-bus-portfolio/ic-led-display-control/16-channel-12-bit-pwm-fm-plus-ic-bus-led-controller:PCA9685)를 사용하여 RGBW LED와 상호 작용합니다.

```yaml
# Example configuration.yaml entry
light:
  - platform: rpi_gpio_pwm
    leds:
      - name: Lightstrip Desk
        driver: pca9685
        pins: [3, 4, 5, 6] # [R, G, B, W]
        type: rgbw
```
