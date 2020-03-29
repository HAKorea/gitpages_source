---
title: 라즈베리파이 GPIO
description: Instructions on how to integrate the GPIO capability of a Raspberry Pi into Home Assistant.
logo: raspberry-pi.png
ha_category:
  - DIY
  - Binary Sensor
  - Cover
  - Switch
ha_release: pre 0.7
ha_iot_class: Local Push
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/wikJla6AilQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`rpi_gpio` 통합구성요소는 Home Assistant의 모든 관련 GPIO 플랫폼의 기본입니다. 연동 자체에 필요한 설정이 없습니다. 플랫폼의 경우 해당 페이지를 확인하십시오.

## Binary Sensor

`rpi_gpio` 바이너리 센서 플랫폼을 사용하면 [Raspberry Pi](https://www.raspberrypi.org/)의 GPIO 센서 값을 읽을 수 있습니다.

## 설정

설치시 Raspberry Pi의 GPIO를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: rpi_gpio
    ports:
      11: PIR Office
      12: PIR Bedroom
```

{% configuration %}
ports:
  description: List of used ports.
  required: true
  type: map
  keys:
    "port: name":
      description: The port numbers ([BCM mode pin numbers](https://pinout.xyz/resources/raspberry-pi-pinout.png)) and corresponding names.
      required: true
      type: string
bouncetime:
  description: The time in milliseconds for port debouncing.
  required: false
  type: integer
  default: 50
invert_logic:
  description: If `true`, inverts the output logic to ACTIVE LOW.
  required: false
  type: boolean
  default: "`false` (ACTIVE HIGH)"
pull_mode:
  description: >
    Type of internal pull resistor to use.
    Options are `UP` - pull-up resistor and `DOWN` - pull-down resistor.
  required: false
  type: string
  default: "`UP`"
{% endconfiguration %}

GPIO 레이아웃에 대한 자세한 내용은 Raspberry Pi에 대한 Wikipedia [article](https://en.wikipedia.org/wiki/Raspberry_Pi#GPIO_connector)를 방문하십시오.

## Cover

`rpi_gpio` 커버 플랫폼을 사용하면 Raspberry Pi를 사용하여 차고문과 같은 커버를 제어할 수 있습니다.

라즈베리파이에 2 개의 핀을 사용합니다.

- `state_pin`은 커버가 닫혀 있는지 감지합니다. 
- `relay_pin`은 덮개가 열리거나 닫히도록 트리거합니다.

홈어시스턴트를 실행할 때 Andrews Hilliday의 소프트웨어 컨트롤러는 필요하지 않지만 차고문과 센서를 Raspberry Pi에 연결하는 방법에 대한 명확한 지침을 [here](https://github.com/andrewshilliday/garage-door-controller#hardware-setup)에 작성했습니다. 

## 설정

설치에서 Raspberry Pi Covers를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
cover:
  - platform: rpi_gpio
    covers:
      - relay_pin: 10
        state_pin: 11
```

{% configuration %}
relay_time:
  description: The time that the relay will be on for in seconds.
  required: false
  default: 0.2
  type: float
invert_relay:
  description: Invert the relay pin output so that it is active-high (True).
  required: false
  default: false
  type: boolean
state_pull_mode:
  description: The direction the State pin is pulling. It can be UP or DOWN.
  required: false
  default: UP
  type: string
invert_state:
  description: Invert the value of the State pin so that 0 means closed.
  required: false
  default: false
  type: boolean
covers:
  description: List of your doors.
  required: true
  type: list
  keys:
    relay_pin:
      description: The pin of your Raspberry Pi where the relay is connected.
      required: true
      type: integer
    state_pin:
      description: The pin of your Raspberry Pi to retrieve the state.
      required: true
      type: integer
    name:
      description: The name to use in the frontend.
      required: false
      type: string
{% endconfiguration %}

## 전체 사례

```yaml
# Example configuration.yaml entry
cover:
  - platform: rpi_gpio
    relay_time: 0.2
    invert_relay: false
    state_pull_mode: 'UP'
    invert_state: true
    covers:
      - relay_pin: 10
        state_pin: 11
      - relay_pin: 12
        state_pin: 13
        name: 'Right door'
```

## 라즈베리파이 커버 리모콘

Raspberry Pi에서 Home Assistant를 실행하지 않고 대신 리모콘 커버로 사용하려는 경우 [MQTT Cover Component](/integrations/cover.mqtt/)와 원격으로 작동하는 [GarageQTPi](https://github.com/Jerrkawz/GarageQTPi)라는 프로젝트가 있습니다. Github 지침에 따라 GarageQTPi를 설치 및 세팅하고 일단 설정되면 홈어시스턴트 지침에 따라 MQTT Cover를 설정하십시오.

## Switch

`rpi_gpio` 스위치 플랫폼을 사용하면 [Raspberry Pi](https://www.raspberrypi.org/)의 GPIO를 제어할 수 있습니다.

## 설정

설치시 Raspberry Pi의 GPIO를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: rpi_gpio
    ports:
      11: Fan Office
      12: Light Desk
```

{% configuration %}
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

GPIO 레이아웃에 대한 자세한 내용은 Raspberry Pi에 관한 Wikipedia [article](https://en.wikipedia.org/wiki/Raspberry_Pi#General_purpose_input-output_(GPIO)_connector)를 참조하십시오.

<div class='note warning'>
홈어시스턴트가 관리하는 핀은 홈어시스턴트 전용입니다.
</div>

일반적인 질문은 포트가 무엇을 참조하는지입니다. 이 숫자는 핀 번호가 아닌 실제 GPIO # 입니다. 
예를 들어, 핀 11에 연결된 릴레이가있는 경우 GPIO 번호는 17입니다.

```yaml
# Example configuration.yaml entry
switch:
  - platform: rpi_gpio
    ports:
      17: Speaker Relay
```
