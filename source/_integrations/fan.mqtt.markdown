---
title: "MQTT Fan"
description: "Instructions on how to integrate MQTT fans into Home Assistant."
logo: mqtt.png
ha_category:
  - Fan
ha_release: 0.27
ha_iot_class: Configurable
---

`mqtt` 팬(fan) 플랫폼을 사용하면 MQTT 지원 팬을 제어할 수 있습니다.

## 설정

이상적인 시나리오에서 MQTT 디바이스에는 상태 변경 사항을 publish하는 `state_topic`이 있습니다.  이러한 메시지가 `RETAIN` 플래그와 함께 공개되면 MQTT 팬은 subscription 후 즉시 상태 업데이트를 수신하고 변경된 상태로 시작합니다. 그렇지 않으면 팬의 초기 상태는 `false` / `off`입니다.

`state_topic`을 사용할 수 없으면 팬은 optimistic 모드에서 작동합니다. 이 모드에서 팬은 모든 명령 후 즉시 상태를 변경합니다. 그렇지 않으면 팬은 장치에서 상태 확인을 기다립니다 (`state_topic`의 메시지).

`state_topic`이 사용 가능하더라도 Optimistic 모드를 강제할 수 있습니다. 팬이 잘못 작동하면 활성화하십시오.

설치에서 MQTT 팬을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
fan:
  - platform: mqtt
    command_topic: "bedroom_fan/on/set"
```

{% configuration %}
command_topic:
  description: The MQTT topic to publish commands to change the fan state.
  required: true
  type: string
name:
  description: The name of the fan.
  required: false
  type: string
  default: MQTT Fan
state_topic:
  description: The MQTT topic subscribed to receive state updates.
  required: false
  type: string
payload_on:
  description: The payload that represents the running state.
  required: false
  type: string
  default: "ON"
payload_off:
  description: The payload that represents the stop state.
  required: false
  type: string
  default: "OFF"
state_value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the state."
  required: false
  type: string
qos:
  description: The maximum QoS level of the state topic.
  required: false
  type: integer
  default: 0
optimistic:
  description: Flag that defines if lock works in optimistic mode
  required: false
  type: boolean
  default: "`true` if no state topic defined, else `false`."
retain:
  description: If the published message should have the retain flag on or not.
  required: false
  type: boolean
  default: true
oscillation_state_topic:
  description: The MQTT topic subscribed to receive oscillation state updates.
  required: false
  type: string
oscillation_command_topic:
  description: The MQTT topic to publish commands to change the oscillation state.
  required: false
  type: string
payload_oscillation_on:
  description: The payload that represents the oscillation on state.
  required: false
  type: string
  default: oscillate_on
payload_oscillation_off:
  description: The payload that represents the oscillation off state.
  required: false
  type: string
  default: oscillate_off
oscillation_value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the oscillation."
  required: false
  type: string
speed_state_topic:
  description: The MQTT topic subscribed to receive speed state updates.
  required: false
  type: string
speed_command_topic:
  description: The MQTT topic to publish commands to change speed state.
  required: false
  type: string
payload_low_speed:
  description: The payload that represents the fan's low speed.
  required: false
  type: string
  default: low
payload_medium_speed:
  description: The payload that represents the fan's medium speed.
  required: false
  type: string
  default: medium
payload_high_speed:
  description: The payload that represents the fan's high speed.
  required: false
  type: string
  default: high
speed_value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the speed payload."
  required: false
  type: string
speeds:
  description: "List of speeds this fan is capable of running at. Valid entries are `off`, `low`, `medium` and `high`."
  required: false
  type: [string, list]
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
unique_id:
  description: An ID that uniquely identifies this fan. If two fans have the same unique ID, Home Assistant will raise an exception.
  required: false
  type: string
device:
  description: "Information about the device this fan is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set."
  required: false
  type: map
  keys:
    identifiers:
      description: A list of IDs that uniquely identify the device. For example a serial number.
      required: false
      type: [string, list]
    connections:
      description: 'A list of connections of the device to the outside world as a list of tuples `[connection_type, connection_identifier]`. For example the MAC address of a network interface: `"connections": [["mac", "02:5b:26:a8:dc:12"]]`.'
      required: false
      type: [list, map]
    manufacturer:
      description: The manufacturer of the device.
      required: false
      type: string
    model:
      description: The model of the device.
      required: false
      type: string
    name:
      description: The name of the device.
      required: false
      type: string
    sw_version:
      description: The firmware version of the device.
      required: false
      type: string
{% endconfiguration %}

<div class='note warning'>

topics가 정확히 일치하는지 확인하십시오. `some-topic/`과 `some-topic`은 다른 topic입니다.

</div>

## 사례

이 섹션에는 이 팬을 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 전체 설정

아래 예는 MQTT 팬의 전체 설정을 보여줍니다.

```yaml
# Example configuration.yaml entry
fan:
  - platform: mqtt
    name: "Bedroom Fan"
    state_topic: "bedroom_fan/on/state"
    command_topic: "bedroom_fan/on/set"
    oscillation_state_topic: "bedroom_fan/oscillation/state"
    oscillation_command_topic: "bedroom_fan/oscillation/set"
    speed_state_topic: "bedroom_fan/speed/state"
    speed_command_topic: "bedroom_fan/speed/set"
    qos: 0
    payload_on: "true"
    payload_off: "false"
    payload_oscillation_on: "true"
    payload_oscillation_off: "false"
    payload_low_speed: "low"
    payload_medium_speed: "medium"
    payload_high_speed: "high"
    speeds:
      - "off"
      - low
      - medium
      - high
```
