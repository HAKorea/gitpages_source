---
title: 원격 라즈베리파이 GPIO(remote_rpi_gpio)
description: Instructions on how to integrate the GPIO capability of a Remote Raspberry Pi into Home Assistant.
logo: raspberry-pi.png
ha_category:
  - DIY
  - Binary Sensor
  - Switch
ha_release: 0.94
ha_iot_class: Local Push
---

`rpi_gpio` 통합구성요소는 Home Assistant의 모든 관련 GPIO 플랫폼의 기본입니다. 플랫폼 설정에 대해서는 해당 섹션을 확인하십시오.

원격 RPi 및 Home Assistant가 실행중인 제어 컴퓨터는 remote_rpi_gpio를 실행할 수 있도록 준비해야합니다. 자세한 내용은 [here](https://gpiozero.readthedocs.io/en/stable/remote_gpio.html)를 참조하십시오.

가상 환경의 경우 핀 팩토리(pin factory)를 설정하기 위해 환경을 시작할 때 환경 변수를 설정해야 할 수 있습니다. 예를 들면 다음과 같습니다. 

`Environment =  GPIOZERO_PIN_FACTORY=pigpio PIGPIO_ADDR=YOUR_RPi_IP_ADDRESS`

## Binary Sensor

`remote_rpi_gpio` 바이너리 센서 플랫폼은 [Remote Raspberry Pi](https://www.raspberrypi.org/)의 GPIO 센서 값을 읽을 수 있게합니다.

설치에서 Remote Raspberry Pi의 GPIO를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: remote_rpi_gpio
    host: IP_ADDRESS_OF_REMOTE_PI
    ports:
      11: PIR Office
      12: PIR Bedroom
```

{% configuration %}
host:
  description: IP Address of remote Raspberry Pi.
  required: true
  type: string
ports:
  description: List of used ports.
  required: true
  type: map
  keys:
    "port: name":
      description: The port numbers (BCM mode pin numbers) and corresponding names.
      required: true
      type: string
invert_logic:
  description: If `true`, inverts the output logic
  required: false
  type: boolean
  default: "`false` (ACTIVE HIGH)"
pull_mode:
  description: >
    Type of internal pull resistor to use.
    Options are `UP` - pull-up resistor and `DOWN` - pull-down resistor.
    Pull-Up defaults to active LOW and Pull-down defaults to active HIGH.  This can be adjusted with invert_logic
  required: false
  type: string
  default: "`UP`"
{% endconfiguration %}

GPIO 레이아웃에 대한 자세한 내용은 Raspberry Pi에 대한 Wikipedia [article](https://en.wikipedia.org/wiki/Raspberry_Pi#GPIO_connector)를 방문하십시오.

## Switch

`remote_rpi_gpio` 스위치 플랫폼을 사용하면 [Remote Raspberry Pi](https://www.raspberrypi.org/)의 GPIO를 제어 할 수 있습니다.

설치에서 Remote Raspberry Pi의 GPIO를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: remote_rpi_gpio
    host: IP_ADDRESS_OF_REMOTE_PI
    ports:
      11: Fan Office
      12: Light Desk
```

{% configuration %}
host:
  description: IP Address of remote Raspberry Pi.
  required: true
  type: string
ports:
  description: Array of used ports.
  required: true
  type: list
  keys:
    port:
      description:  Port numbers and corresponding names (GPIO #).
      required: true
      type: [integer, string]
invert_logic:
  description: If true, inverts the output logic to ACTIVE LOW.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

GPIO 레이아웃에 대한 자세한 내용은 Raspberry Pi에 대한 Wikipedia [article](https://en.wikipedia.org/wiki/Raspberry_Pi#GPIO_connector)를 방문하십시오.

<div class='note warning'>
홈어시스턴트가 관리하는 핀은 홈어시스턴트 전용입니다.
</div>

일반적인 질문은 포트가 무엇을 참조하는지 입니다. 이 숫자는 핀 번호가 아닌 실제 GPIO #입니다.
예를 들어, 핀 11에 연결된 릴레이가 있는 경우 GPIO 번호는 17입니다.

```yaml
# Example configuration.yaml entry
switch:
  - platform: remote_rpi_gpio
    host: 192.168.0.123
    ports:
      17: Speaker Relay
```

### 문제 해결

`gpiozero.exc.BadPinFactory: Unable to load any default pin factory!` 와 같은 오류가 발생하면 pinfactory를 `pigpio`에서 `mock`으로 변경하십시오, 이는 [known issue](https://www.raspberrypi.org/forums/viewtopic.php?p=1417922)를 해결합니다.