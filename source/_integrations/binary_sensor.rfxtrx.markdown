---
title: "RFXtrx Binary Sensor"
description: "Instructions on how to integrate RFXtrx binary sensors into Home Assistant."
logo: rfxtrx.png
ha_category:
  - Binary Sensor
ha_release: 0.48
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/zcjNvSMG-hg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`rfxtrx` 플랫폼은 433.92 MHz의 주파수 범위에서 통신하는 이진 센서를 지원합니다.
rfxtrx 이진 센서 통합구성요소는 이를 지원합니다.

오늘날 웹에서 사용할 수 있는 많은 저렴한 센서는 *PT-2262* 라는 특정 RF 칩을 기반으로합니다. RFXcom box에서 실행중인 펌웨어에 따라 일부는 X10 프로토콜에서 인식될 수 있지만 대부분은 *Lighting4* 프로토콜에서 인식됩니다. rfxtrx 이진 센서 통합구성요소는 특별한 옵션을 제공하는 반면 다른 rfxtrx 프로토콜들도 작동해야합니다.

## 장치 셋업

[rfxtrx hub](/integrations/rfxtrx/)를 설정하면 바이너리 센서를 찾는 가장 쉬운 방법은 이것을 `configuration.yaml`에 추가하는 것입니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  platform: rfxtrx
  automatic_add: true
```

홈어시스턴트 프론트 엔드를 열고 "states" 페이지로 이동하십시오.
그런 다음 센서를 트리거하십시오. "binary_sensor"로 시작하여 *Current entities* 목록에 새 엔티티가 나타납니다. 16 진수입니다. 16 진수는 Device ID입니다.

예: "binary_sensor.0913000022670e013b70" 여기서  Device ID는 `0913000022670e013b70`입니다. 그런후 설정을 다음과 같이 업데이트해야합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  platform: rfxtrx
  devices:
    0913000022670e013b70:
      name: device_name
```

{% configuration %}
devices:
  description: A list of devices.
  required: false
  type: list
  keys:
    name:
      description: Override the name to use in the frontend.
      required: false
      type: string
    device_class:
      description: Sets the [class of the device](/integrations/binary_sensor/), changing the device state and icon that is displayed on the frontend.
      required: false
      type: device_class
    fire_event:
      description: Fires an event even if the state is the same as before. Can be used for automations.
      required: false
      type: boolean
      default: false
    off_delay:
      description: For sensors that only sends 'On' state updates, this variable sets a delay after which the sensor state will be updated back to 'Off'.
      required: false
      type: integer
    data_bits:
      description: Defines how many bits are used for commands inside the data packets sent by the device.
      required: false
      type: integer
    command_on:
      description: Defines the data bits value that is sent by the device upon an 'On' command.
      required: false
      type: string
    command_off:
      description: Defines the data bits value that is sent by the device upon an 'Off' command.
      required: false
      type: string
automatic_add:
  description: To enable the automatic addition of new binary sensors.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

<div class='note warning'>

이 통합구성요소 및 [rfxtrx 스위치](/integrations/switch.rfxtrx/)는 `automatic_add` 설정 매개 변수를 `true`로 설정할 때 서로의 장치를 가져가버릴 수 있습니다. 
설치시 추가할 장치가 있는 경우에만 `automatic_add`를 설정하고 그렇지 않으면 `false`로 두십시오.

</div>

<div class='note warning'>

device ID가 숫자로만 구성되어 있으면 따옴표로 묶어야합니다. 
device ID는 숫자로 해석되므로 YAML의 제한 사항입니다.

</div>

이진 센서는 "on"과 "off"의 두 가지 상태만 있습니다. 많은 문 또는 창 열기 센서는 문/창이 열리거나 닫힐 때마다 신호를 보냅니다. 
그러나 하드웨어 또는 목적에 따라 일부 센서는 "on" 상태만 신호를 보낼 수 있습니다.

- 대부분의 모션 센서는 모션을 감지할 때마다 신호를 보냅니다. 그들은 몇 초 동안 "on" 이고 다른 동작 이벤트를 알리기 위해 다시 잠들게됩니다. 일반적으로 그들은 다시 잠들 때 신호를 보내지 않습니다.
- 일부 초인종은 토글 스위치를 눌렀을 때 "on" 신호만 보낼 수 있지만 스위치를 놓을 때 "off" 신호는 나타나지 않습니다.

해당 장치의 경우 *off_delay* 매개 변수를 사용하십시오.
장치가 "off" 상태로 돌아가는 지연을 정의합니다.
"off" 상태는 마치 장치가 자체적으로 작동하는 것처럼 홈어시스턴트에 의해 내부적으로 실행됩니다. 모션 센서가 5 초마다 한 번만 신호를 보낼 수 있는 경우 *off_delay* 매개 변수를 *seconds: 5*로 설정하십시오.

설정 예시 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  platform: rfxtrx
  automatic_add: true
  devices:
    091300006ca2c6001080:
    name: motion_hall
    device_class: motion
    off_delay:
      seconds: 5
```

### Lighting4 프로토콜 하의 PT-2262 장치 옵션

Lighting4 프로토콜을 사용하여 PT-2262 장치에서 데이터 패킷을 전송하면 패킷에서 장치 식별자와 명령을 자동으로 추출할 방법이 없습니다.
각 장치에는 고유한 ID/command length 조합이 있으며 필드 길이는 데이터에 포함되지 않습니다. 2 개의 다른 명령을 보내는 하나의 장치는 Home Assistant에서 2 개의 장치로 표시됩니다.
이러한 경우 문제를 피하기 위해 다음 옵션을 사용할 수 있습니다.

- **data_bits** (*Optional*)
- **command_on** (*Optional*)
- **command_off** (*Optional*)

"automatic_add" 옵션을 사용하여 새 PT-2262 센서를 추가하고 Home Assistant 시스템 로그를 살펴 보겠습니다.

센서가 처음에 "on" 상태를 트리거하도록 하십시오.
일부 메시지가 나타납니다. : 

```text
INFO (Thread-6) [homeassistant.components.binary_sensor.rfxtrx] Added binary sensor 0913000022670e013970 (Device_id: 22670e Class: LightingDevice Sub: 0)
```

Here the sensor has the id *22670e*.
센서의 ID는 *22670e*입니다. 

이제 센서가 "Off" 상태를 트리거하고 홈어시스턴트 로그에서 다음 메시지를 찾으십시오. "Off" 상태를 트리거 할 때 장치가 *new* 장치로 감지된 것을 확인할 수 있습니다.

```text
INFO (Thread-6) [homeassistant.components.binary_sensor.rfxtrx] Added binary sensor 09130000226707013d70 (Device_id: 226707 Class: LightingDevice Sub: 0)
```

여기서 device ID는 *226707*이며 이는 몇 초 전에 "On" 이벤트에 있었던 *22670e*와 거의 비슷합니다.

이 두 값에서 장치의 실제 ID는 *22670*이고 *e* 및 *7*은 각각 "On", "Off" 상태에 대한 명령이라고 추측할 수 있습니다. 하나의 16 진수가 4 비트를 사용하므로 장치가 4 데이터 비트를 사용하고 있다고 결론 지을 수 있습니다.

바이너리 센서의 실제 설정 섹션은 다음과 같습니다. : 

```yaml
platform: rfxtrx
automatic_add: true
devices:
  0913000022670e013b70:
    name: window_room2
    device_class: opening
    data_bits: 4
    command_on: 0xe
    command_off: 0x7
```

*automatic_add* 옵션은 rfxtrx 이진 센서 통합구성요소가 홈어시스턴트 프로그램 로그에서 설정 옵션을 계산하고 표시하게합니다.

```text
INFO (Thread-6) [homeassistant.components.rfxtrx] rfxtrx: found possible device 226707 for 22670e with the following configuration:
data_bits=4
command_on=0xe
command_off=0x7
INFO (Thread-6) [homeassistant.components.binary_sensor.rfxtrx] Found possible matching deviceid 22670e.
```

이 자동 추측은 대부분 작동하지만 그에 대한 보장은 없습니다. 새 장치를 설정하려는 경우에만 활성화하고 그렇지 않으면 끄십시오.

### 알려진 작동 장치

다음 장치는 rfxtrx 이진 센서 구성 요소와 작동하는 것으로 알려져 있습니다.
나열할 다른 항목이 너무 많습니다.

- Motion detectors:
  - Kerui P817 and P829.
  - Chuango PIR-700.

- Door / window sensors:
  - Kerui D026 door / window sensor: can trigger on "open" and "close". Has a tamper switch.
  - Nexa LMST-606.
