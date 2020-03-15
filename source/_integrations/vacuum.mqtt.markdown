---
title: MQTT 로봇청소기(MQTT Vacuum)
description: "Instructions on how to integrate your MQTT enabled Vacuum within Home Assistant."
logo: mqtt.png
ha_category:
  - Vacuum
ha_release: 0.54
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/t2NgA8qYcFI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`mqtt` vacuum 통합구성요소로 MQTT를 쓸 수 있는 로봇청소기를 제어할 수 있습니다.
`legacy` 및 `state`라는 두 가지 가능한 메시지 스키마가 있습니다. 
`legacy`는 더 이상 사용되지 않으며 향후 언젠가 제거될 수 있으므로 새로 설치시에는 `state` 스키마를 사용해야합니다.
로봇청소기 state는 추천하는 상위 vacuum 엔티티인 `StateVacuumDevice`로 표시되므로 `state` 스키마를 추천합니다.

이 문서에는 3 개의 섹션이 있습니다. 예제가 있는 `legacy` vacuum에 대한 설정, 예제에 대한 `state` vacuum에 대한 설정 및 두 스키마에 대해 동일한 예가 있는 합쳐진 섹션입니다.

## 설정

MQTT vacuum을 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
vacuum:
  - platform: mqtt
```

## Legacy 설정

Legacy MQTT vacuum 설정 섹션.

{% configuration %}
name:
  description: The name of the vacuum.
  required: false
  type: string
  default: MQTT Vacuum
schema:
  description: The schema to use.
  required: false
  type: string
  default: legacy
supported_features:
  description: List of features that the vacuum supports (possible values are `turn_on`, `turn_off`, `pause`, `stop`, `return_home`, `battery`, `status`, `locate`, `clean_spot`, `fan_speed`, `send_command`)."
  required: false
  type: [string, list]
  default: "`turn_on`, `turn_off`, `stop`, `return_home`, `status`, `battery`, `clean_spot`"
command_topic:
  description: The MQTT topic to publish commands to control the vacuum.
  required: false
  type: string
qos:
  description: The maximum QoS level of the state topic.
  required: false
  type: integer
  default: 0
retain:
  description: If the published message should have the retain flag on or not.
  required: false
  type: boolean
  default: false
payload_turn_on:
  description: The payload to send to the `command_topic` to begin the cleaning cycle.
  required: false
  type: string
  default: turn_on
payload_turn_off:
  description: The payload to send to the `command_topic` to turn the vacuum off.
  required: false
  type: string
  default: turn_off
payload_return_to_base:
  description: The payload to send to the `command_topic` to tell the vacuum to return to base.
  required: false
  type: string
  default: return_to_base
payload_stop:
  description: The payload to send to the `command_topic` to stop the vacuum.
  required: false
  type: string
  default: stop
payload_clean_spot:
  description: The payload to send to the `command_topic` to begin a spot cleaning cycle.
  required: false
  type: string
  default: clean_spot
payload_locate:
  description: The payload to send to the `command_topic` to locate the vacuum (typically plays a song).
  required: false
  type: string
  default: locate
payload_start_pause:
  description: The payload to send to the `command_topic` to start or pause the vacuum.
  required: false
  type: string
  default: start_pause
battery_level_topic:
  description: The MQTT topic subscribed to receive battery level values from the vacuum.
  required: false
  type: string
battery_level_template:
  description: Defines a [template](/topics/templating/) to define the battery level of the vacuum. This is required if `battery_level_topic` is set.
  required: false
  type: string
charging_topic:
  description: The MQTT topic subscribed to receive charging state values from the vacuum.
  required: false
  type: string
charging_template:
  description: Defines a [template](/topics/templating/) to define the charging state of the vacuum. This is required if `charging_topic` is set.
  required: false
  type: string
cleaning_topic:
  description: The MQTT topic subscribed to receive cleaning state values from the vacuum.
  required: false
  type: string
cleaning_template:
  description: Defines a [template](/topics/templating/) to define the cleaning state of the vacuum. This is required if `cleaning_topic` is set.
  required: false
  type: string
docked_topic:
  description: The MQTT topic subscribed to receive docked state values from the vacuum.
  required: false
  type: string
docked_template:
  description: Defines a [template](/topics/templating/) to define the docked state of the vacuum. This is required if `docked_topic` is set.
  required: false
  type: string
error_topic:
  description: The MQTT topic subscribed to receive error messages from the vacuum.
  required: false
  type: string
error_template:
  description: Defines a [template](/topics/templating/) to define potential error messages emitted by the vacuum. This is required if `error_topic` is set.
  required: false
  type: string
fan_speed_topic:
  description: The MQTT topic subscribed to receive fan speed values from the vacuum.
  required: false
  type: string
fan_speed_template:
  description: Defines a [template](/topics/templating/) to define the fan speed of the vacuum. This is required if `fan_speed_topic` is set.
  required: false
  type: string
set_fan_speed_topic:
  description: The MQTT topic to publish commands to control the vacuum's fan speed.
  required: false
  type: string
fan_speed_list:
  description: List of possible fan speeds for the vacuum.
  required: false
  type: [string, list]
send_command_topic:
  description: The MQTT topic to publish custom commands to the vacuum.
  required: false
  type: string
availability_topic:
  description: The MQTT topic subscribed to receive availability (online/offline) updates.
  required: false
  type: string
payload_available:
  description: The payload that represents the available state.
  required: false
  type: string
  default: online
payload_not_available:
  description: The payload that represents the unavailable state.
  required: false
  type: string
  default: offline
json_attributes_topic:
  description: The MQTT topic subscribed to receive a JSON dictionary payload and then set as sensor attributes. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-topic-configuration) documentation.
  required: false
  type: string
json_attributes_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the JSON dictionary from messages received on the `json_attributes_topic`. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-template-configuration) documentation."
  required: false
  type: template
{% endconfiguration %}

### Legacy 설정 사례

{% raw %}
```yaml
# Example configuration.yaml entry
vacuum:
  - platform: mqtt
    name: "MQTT Vacuum"
    supported_features:
      - turn_on
      - turn_off
      - pause
      - stop
      - return_home
      - battery
      - status
      - locate
      - clean_spot
      - fan_speed
      - send_command
    command_topic: "vacuum/command"
    battery_level_topic: "vacuum/state"
    battery_level_template: "{{ value_json.battery_level }}"
    charging_topic: "vacuum/state"
    charging_template: "{{ value_json.charging }}"
    cleaning_topic: "vacuum/state"
    cleaning_template: "{{ value_json.cleaning }}"
    docked_topic: "vacuum/state"
    docked_template: "{{ value_json.docked }}"
    error_topic: "vacuum/state"
    error_template: "{{ value_json.error }}"
    fan_speed_topic: "vacuum/state"
    fan_speed_template: "{{ value_json.fan_speed }}"
    set_fan_speed_topic: "vacuum/set_fan_speed"
    fan_speed_list:
      - min
      - medium
      - high
      - max
    send_command_topic: 'vacuum/send_command'
```
{% endraw %}

## Legacy MQTT Protocol

이 통합구성요소에 대한 위의 설정에는 다음과 같은 MQTT 프로토콜이 필요합니다.

### Legacy Basic Commands

MQTT topic: `vacuum/command`

Possible MQTT payloads:

- `turn_on` - Begin cleaning
- `turn_off` - Turn the Vacuum off
- `return_to_base` - Return to base/dock
- `stop` - Stop the Vacuum
- `clean_spot` - Initialize a spot cleaning cycle
- `locate` - Locate the vacuum (typically by playing a song)
- `start_pause` - Toggle the vacuum between cleaning and stopping

### Status/Sensor Updates

MQTT topic: `vacuum/state`

MQTT payload:

```json
{
    "battery_level": 61,
    "docked": true,
    "cleaning": false,
    "charging": true,
    "fan_speed": "off",
    "error": "Error message"
}
```

## State 설정

State MQTT vacuum 설정 섹션.

{% configuration %}
name:
  description: The name of the vacuum.
  required: false
  type: string
  default: MQTT Vacuum
schema:
  description: The schema to use.
  required: false
  type: string
  default: legacy
supported_features:
  description: "List of features that the vacuum supports (possible values are `start`, `stop`, `pause`, `return_home`, `battery`, `status`, `locate`, `clean_spot`, `fan_speed`, `send_command`)."
  required: false
  type: [string, list]
  default: "`start`, `stop`, `return_home`, `status`, `battery`, `clean_spot`"
command_topic:
  description: The MQTT topic to publish commands to control the vacuum.
  required: false
  type: string
qos:
  description: The maximum QoS level of the state topic.
  required: false
  type: integer
  default: 0
retain:
  description: If the published message should have the retain flag on or not.
  required: false
  type: boolean
  default: false
payload_start:
  description: "The payload to send to the `command_topic` to begin the cleaning cycle."
  required: false
  type: string
  default: start
payload_stop:
  description: "The payload to send to the `command_topic` to stop cleaning."
  required: false
  type: string
  default: stop
payload_return_to_base:
  description: The payload to send to the `command_topic` to tell the vacuum to return to base.
  required: false
  type: string
  default: return_to_base
payload_clean_spot:
  description: The payload to send to the `command_topic` to begin a spot cleaning cycle.
  required: false
  type: string
  default: clean_spot
payload_locate:
  description: The payload to send to the `command_topic` to locate the vacuum (typically plays a song).
  required: false
  type: string
  default: locate
payload_pause:
  description: The payload to send to the `command_topic` to pause the vacuum.
  required: false
  type: string
  default: pause
state_topic:
  description: The MQTT topic subscribed to receive state messages from the vacuum. State topic is extracting json if no `value_template` is defined.
  required: false
  type: string
value_template:
  description: "Defines a [template](/topics/templating/) to extract possible states from the vacuum."
  required: false
  type: string
set_fan_speed_topic:
  description: The MQTT topic to publish commands to control the vacuum's fan speed.
  required: false
  type: string
fan_speed_list:
  description: List of possible fan speeds for the vacuum.
  required: false
  type: [string, list]
send_command_topic:
  description: The MQTT topic to publish custom commands to the vacuum.
  required: false
  type: string
availability_topic:
  description: The MQTT topic subscribed to receive availability (online/offline) updates.
  required: false
  type: string
payload_available:
  description: The payload that represents the available state.
  required: false
  type: string
  default: online
payload_not_available:
  description: The payload that represents the unavailable state.
  required: false
  type: string
  default: offline
json_attributes_topic:
  description: The MQTT topic subscribed to receive a JSON dictionary payload and then set as sensor attributes. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-topic-configuration) documentation.
  required: false
  type: string
{% endconfiguration %}

### State 설정 사례

{% raw %}
```yaml
# Example configuration.yaml entry
vacuum:
  - platform: mqtt
    name: "MQTT Vacuum"
    schema: state
    supported_features:
      - start
      - pause
      - stop
      - return_home
      - battery
      - status
      - locate
      - clean_spot
      - fan_speed
      - send_command
    command_topic: "vacuum/command"
    state_topic: "vacuum/state"
    set_fan_speed_topic: "vacuum/set_fan_speed"
    fan_speed_list:
      - min
      - medium
      - high
      - max
    send_command_topic: 'vacuum/send_command'
```
{% endraw %}

## State MQTT Protocol

이 통합구성요소에 대한 위의 설정은 다음과 같은 MQTT 프로토콜이 필요합니다.

### State Basic Commands

MQTT topic: `vacuum/command`

Possible MQTT payloads:

- `start` - Start cleaning
- `pause` - Pause cleaning
- `return_to_base` - Return to base/dock
- `stop` - Stop the vacuum.
- `clean_spot` - Initialize a spot cleaning cycle
- `locate` - Locate the vacuum (typically by playing a song)

### Send Custom Command

Vacuum send_command는 세 가지 매개 변수를 허용합니다.

- entity_id
- command
- params - optional

매개 변수가 제공되지 않으면 명령을 페이로드로 MQTT send_command topic에 보냅니다.
매개 변수가 제공되면 서비스는 다음과 같은 구조로 json을 페이로드로 보냅니다.

```json
{
  'command': 'command',
  'param1-key': 'param1-value'
}
```

서비스 트리거 예 : 

```yaml
- alias: Push command based on sensor
    trigger:
      - platform: state
        entity_id: sensor.sensor
    action:
      service: vacuum.send_command
      data:
        entity_id: 'vacuum.vacuum_entity'
        command: 'custom_command'
        params:
          - key: value
```

MQTT topic: `vacuum/send_command`

### Status/Sensor 업데이트

MQTT topic: `vacuum/state`

MQTT payload:

```json
{
    "battery_level": 61,
    "state": "docked",
    "fan_speed": "off"
}
```

state는 홈어시스턴트가 지원하는 vacuum state중 하나여야합니다.

- cleaning,
- docked,
- paused,
- idle,
- returning,
- error.

## Shared MQTT Protocol

이 연동의 설정에는 다음과 같은 MQTT 프로토콜이 필요합니다.
이러한 서비스는 legacy 및 state vacuum 모두에서 동일합니다.

### Set Fan Speed

MQTT topic: `vacuum/set_fan_speed`

Possible MQTT payloads:

- `min` - Minimum fan speed
- `medium` - Medium fan speed
- `high` - High fan speed
- `max` - Max fan speed

### Send Custom Command

Vacuum send_command는 세 가지 매개 변수를 허용합니다 :

- entity_id
- command
- params - optional

매개 변수가 제공되지 않으면 명령을 페이로드로 MQTT send_command topic에 보냅니다.
매개 변수가 제공되면 서비스는 다음과 같은 구조로 json을 페이로드로 보냅니다.

```json
{
  'command': 'command',
  'param1-key': 'param1-value'
}
```

서비스 트리거 사례:

```yaml
- alias: Push command based on sensor
    trigger:
      - platform: state
        entity_id: sensor.sensor
    action:
      service: vacuum.send_command
      data:
        entity_id: 'vacuum.vacuum_entity'
        command: 'custom_command'
        params:
          - key: value
```

MQTT topic: `vacuum/send_command`

### cloudless Xiaomi vacuums 사용하기

이 연동은 클라우드가 없는 Xiaomi Vacuum Webinterface [Valetudo](https://github.com/Hypfer/Valetudo)에서 지원합니다.

### 비와이 파이 vacumm 장치 개조

- ESP8266으로 기존 Roomba를 개조하십시오. [This repo](https://github.com/johnboiles/esp-roomba-mqtt)는 MQTT 클라이언트 펌웨어를 제공합니다.

- Wi-Fi가 아닌 Neato를 소유한 경우 Raspberry Pi를 사용하여 오래된 Neato를 개조하는 [this repo](https://github.com/jeroenterheerdt/neato-serial)를 참조할 수 있습니다.
