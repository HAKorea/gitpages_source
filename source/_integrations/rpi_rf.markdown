---
title: 라즈베리파이 RF
description: Instructions on how to integrate devices controlled via codes sent with low-cost GPIO RF modules on a Raspberry Pi into Home Assistant as a switch.
logo: raspberry-pi.png
ha_category:
  - DIY
ha_release: 0.19
ha_iot_class: Assumed State
---

`rpi_rf` 스위치 플랫폼을 사용하면 [Raspberry Pi](https://www.raspberrypi.org/)의 일반 저가형 GPIO RF 모듈로 433/315MHz LPD/SRD 신호를 통해 장치를 제어할 수 있습니다.

[rpi-rf 모듈](https://pypi.python.org/pypi/rpi-rf) 또는 [rc-switch](https://github.com/sui77/rc-switch)를 통해 스니핑된 코드와 상호 운용 가능.
자세한 내용은 PyPi 모듈 설명을 참조하십시오 : [rpi-rf](https://pypi.python.org/pypi/rpi-rf)

## 설정

활성화하려면 `configuration.yaml`에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: rpi_rf
    gpio: 17
    switches:
      bedroom_light:
        code_on: 1234567
        code_off: 1234568
      ambilight:
        pulselength: 200
        code_on: 987654
        code_off: 133742
      living_room_light:
        protocol: 5
        code_on: 654321,565874,233555,149874
        code_off: 654320,565873,233554,149873
        signal_repetitions: 15
```

{% configuration %}
gpio:
  description: GPIO to which the data line of the TX module is connected.
  required: true
  type: integer
switches:
  description: The array that contains all switches.
  required: true
  type: list
  keys:
    entry:
      description: Name of the switch. Multiple entries are possible.
      required: true
      type: list
      keys:
        code_on:
          description: Decimal code(s) to switch the device on. To run multiple codes in a sequence, separate the individual codes with commas ','.
          required: true
          type: list
        code_off:
          description: Decimal code(s) to switch the device off. To run multiple codes in a sequence, separate the individual codes with commas ','.
          required: true
          type: list
        protocol:
          description: RF Protocol.
          required: false
          default: 1
          type: integer
        pulselength:
          description: Pulselength.
          required: false
          type: integer
        signal_repetitions:
          description: Number of times to repeat transmission.
          required: false
          default: 10
          type: integer
{% endconfiguration %}
