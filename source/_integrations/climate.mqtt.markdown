---
title: "MQTT 온습도조절기(MQTT HVAC)"
description: "Instructions on how to integrate MQTT HVAC into Home Assistant."
logo: mqtt.png
ha_category:
  - Climate
ha_release: 0.55
ha_iot_class: Local Polling
---

`mqtt` climate 플랫폼을 사용하면 MQTT 지원 HVAC 장치를 제어 할 수 있습니다.

## 설정

설치시 이 climate 플랫폼을 활성화하려면 먼저 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
climate:
  - platform: mqtt
```

{% configuration %}
name:
  description: The name of the HVAC.
  required: false
  type: string
  default: MQTT HVAC
unique_id:
   description: An ID that uniquely identifies this HVAC device. If two HVAC devices have the same unique ID, Home Assistant will raise an exception.
   required: false
   type: string
qos:
  description: The maximum QoS level to be used when receiving and publishing messages.
  required: false
  type: integer
  default: 0
retain:
  description: Defines if published messages should have the retain flag set.
  required: false
  type: boolean
  default: false
send_if_off:
  description: "Set to `false` to suppress sending of all MQTT messages when the current mode is `Off`."
  required: false
  type: boolean
  default: true
initial:
  description: Set the initial target temperature.
  required: false
  type: integer
  default: 21
payload_on:
  description: The payload that represents enabled state.
  required: false
  type: string
  default: "ON"
payload_off:
  description: The payload that represents disabled state.
  required: false
  type: string
  default: "OFF"
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
value_template:
  description: Default template to render the payloads on *all* `*_state_topic`s with.
  type: template
  required: false
current_temperature_topic:
  description: The MQTT topic on which to listen for the current temperature.
  required: false
  type: string
current_temperature_template:
  description: A template with which the value received on `current_temperature_topic` will be rendered.
  required: false
  type: template
power_command_topic:
  description: The MQTT topic to publish commands to change the power state. This is useful if your device has a separate power toggle in addition to mode.
  required: false
  type: string
action_topic:
  description: >-
    The MQTT topic to subscribe for changes of the current action. If this is set, the climate graph uses the value received as data source.
    Valid values: `off`, `heating`, `cooling`, `drying`, `idle`, `fan`.
  required: false
  type: string
action_template:
  description: A template to render the value received on the `action_topic` with.
  required: false
  type: template
mode_command_topic:
  description: The MQTT topic to publish commands to change the HVAC operation mode.
  required: false
  type: string
mode_state_topic:
  description: The MQTT topic to subscribe for changes of the HVAC operation mode. If this is not set, the operation mode works in optimistic mode (see below).
  required: false
  type: string
mode_state_template:
  description: A template to render the value received on the `mode_state_topic` with.
  required: false
  type: template
modes:
  description: A list of supported modes. Needs to be a subset of the default values.
  required: false
  default: ['auto', 'off', 'cool', 'heat', 'dry', 'fan_only']
  type: list
action_topic:
  description: The MQTT topic on which to listen for the current action state of the HVAC. Expects `idle`, `cooling`, `heating`, `drying`, or `off`.
  required: false
  type: string
action_template:
  description: A template to render the value received on the `action_topic` with.
  required: false
  type: template
temperature_command_topic:
  description: The MQTT topic to publish commands to change the target temperature.
  required: false
  type: string
temperature_state_topic:
  description: The MQTT topic to subscribe for changes in the target temperature. If this is not set, the target temperature works in optimistic mode (see below).
  required: false
  type: string
temperature_state_template:
  description: A template to render the value received on the `temperature_state_topic` with.
  required: false
  type: template
temperature_low_command_topic:
  description: The MQTT topic to publish commands to change the target low temperature.
  required: false
  type: string
temperature_low_state_topic:
  description: The MQTT topic to subscribe for changes in the target low temperature. If this is not set, the target low temperature works in optimistic mode (see below).
  required: false
  type: string
temperature_low_state_template:
  description: A template to render the value received on the `temperature_low_state_topic` with.
  required: false
  type: template
temperature_high_command_topic:
  description: The MQTT topic to publish commands to change the high target temperature.
  required: false
  type: string
temperature_high_state_topic:
  description: The MQTT topic to subscribe for changes in the target high temperature. If this is not set, the target high temperature works in optimistic mode (see below).
  required: false
  type: string
temperature_high_state_template:
  description: A template to render the value received on the `temperature_high_state_topic` with.
  required: false
  type: template
precision:
  description: The desired precision for this device. Can be used to match your actual thermostat's precision. Supported values are `0.1`, `0.5` and `1.0`.
  required: false
  type: float
  default: 0.1 for Celsius and 1.0 for Fahrenheit.
fan_mode_command_topic:
  description: The MQTT topic to publish commands to change the fan mode.
  required: false
  type: string
fan_mode_state_topic:
  description: The MQTT topic to subscribe for changes of the HVAC fan mode. If this is not set, the fan mode works in optimistic mode (see below).
  required: false
  type: string
fan_mode_state_template:
  description: A template to render the value received on the `fan_mode_state_topic` with.
  required: false
  type: template
fan_modes:
  description: A list of supported fan modes.
  required: false
  default: ['auto', 'low', 'medium', 'high']
  type: list
swing_mode_command_topic:
  description: The MQTT topic to publish commands to change the swing mode.
  required: false
  type: string
swing_mode_state_topic:
  description: The MQTT topic to subscribe for changes of the HVAC swing mode. If this is not set, the swing mode works in optimistic mode (see below).
  required: false
  type: string
swing_mode_state_template:
  description: A template to render the value received on the `swing_mode_state_topic` with.
  required: false
  type: template
swing_modes:
  description: A list of supported swing modes.
  required: false
  default: ['on', 'off']
  type: list
away_mode_command_topic:
  description: The MQTT topic to publish commands to change the away mode.
  required: false
  type: string
away_mode_state_topic:
  description: The MQTT topic to subscribe for changes of the HVAC away mode. If this is not set, the away mode works in optimistic mode (see below).
  required: false
  type: string
away_mode_state_template:
  description: A template to render the value received on the `away_mode_state_topic` with.
  required: false
  type: template
hold_command_topic:
  description: The MQTT topic to publish commands to change the hold mode.
  required: false
  type: string
hold_state_topic:
  description: The MQTT topic to subscribe for changes of the HVAC hold mode. If this is not set, the hold mode works in optimistic mode (see below).
  required: false
  type: string
hold_state_template:
  description: A template to render the value received on the `hold_state_topic` with.
  required: false
  type: template
hold_modes:
  description: A list of available hold modes.
  required: false
  type: list
aux_command_topic:
  description: The MQTT topic to publish commands to switch auxiliary heat.
  required: false
  type: string
aux_state_topic:
  description: The MQTT topic to subscribe for changes of the auxiliary heat mode. If this is not set, the auxiliary heat mode works in optimistic mode (see below).
  required: false
  type: string
aux_state_template:
  description: A template to render the value received on the `aux_state_topic` with.
  required: false
  type: template
min_temp:
  description: Minimum set point available.
  type: float
  required: false
max_temp:
  description: Maximum set point available.
  type: float
  required: false
temp_step:
  description: Step size for temperature set point.
  type: float
  required: false
  default: 1
json_attributes_topic:
  description: The MQTT topic subscribed to receive a JSON dictionary payload and then set as sensor attributes. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-topic-configuration) documentation.
  required: false
  type: string
json_attributes_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the JSON dictionary from messages received on the `json_attributes_topic`. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-template-configuration) documentation."
  required: false
  type: template
device:
  description: 'Information about the device this HVAC device is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set.'
  required: false
  type: map
  keys:
    identifiers:
      description: 'A list of IDs that uniquely identify the device. For example a serial number.'
      required: false
      type: [list, string]
    connections:
      description: 'A list of connections of the device to the outside world as a list of tuples `[connection_type, connection_identifier]`. For example the MAC address of a network interface: `"connections": [["mac", "02:5b:26:a8:dc:12"]]`.'
      required: false
      type: list
    manufacturer:
      description: 'The manufacturer of the device.'
      required: false
      type: string
    model:
      description: 'The model of the device.'
      required: false
      type: string
    name:
      description: 'The name of the device.'
      required: false
      type: string
    sw_version:
      description: 'The firmware version of the device.'
      required: false
      type: string
{% endconfiguration %}

#### Optimistic mode

속성이 *optimistic mode*에서 작동하는 경우 (해당 state topic이 설정되지 않은 경우) 홈어시스턴트는 command topic에 게시된 모든 상태 변경이 작동한 것으로 가정하고 command topic에 게시한 직후 엔티티의 내부 상태를 변경합니다. optimistic mode에서 작동하지 않으면 요청된 업데이트가 state topic를 통해 장치에 의해 확인된 경우에만 엔티티의 내부 상태가 업데이트됩니다.

#### 템플릿 사용하기

모든 `*_state_topic`의 경우, 이 topic에서 들어오는 페이로드를 렌더링하는데 사용될 템플릿을 지정할 수 있습니다. 또한 모든 state topic에 적용되는 기본 템플릿은 `value_template`으로 지정할 수 있습니다. 페이로드를 받은 경우 (예: JSON 형식)에 유용합니다. JSON에서 따옴표 붙은 문자열 (예: `"foo"`)은 문자열 일 뿐이므로 따옴표를 없에도 사용할 수 있습니다. 

`mode_state_topic`을 통해 operation 모드 `"auto"`를 받았지만 실제로 모드는 그냥 auto라고합니다. 여기서 수행할 수 있는 작업은 다음과 같습니다.

{% raw %}
```yaml
climate:
  - platform: mqtt
    name: Study
    modes:
      - "off"
      - "heat"
      - "auto"
    mode_command_topic: "study/ac/mode/set"
    mode_state_topic: "study/ac/mode/state"
    mode_state_template: "{{ value_json }}"
```
{% endraw %}

들어오는 `"auto"`를 JSON으로 파싱하여 `auto`가 됩니다. 분명히 이 경우  `value_template: {% raw %}"{{ value_json }}"{% endraw %}`를 설정할 수도 있습니다.

### 사례

전체 설정 예는 다음과 같습니다.

```yaml
# Full example configuration.yaml entry
climate:
  - platform: mqtt
    name: Study
    modes:
      - "off"
      - "cool"
      - "fan_only"
    swing_modes:
      - "on"
      - "off"
    fan_modes:
      - "high"
      - "medium"
      - "low"
    power_command_topic: "study/ac/power/set"
    mode_command_topic: "study/ac/mode/set"
    temperature_command_topic: "study/ac/temperature/set"
    fan_mode_command_topic: "study/ac/fan/set"
    swing_mode_command_topic: "study/ac/swing/set"
    precision: 1.0
```
