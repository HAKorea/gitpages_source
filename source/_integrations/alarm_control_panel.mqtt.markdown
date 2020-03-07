---
title: "MQTT 경보 제어판"
description: "Instructions on how to integrate MQTT capable Alarm Panels into Home Assistant."
logo: mqtt.png
ha_category:
  - Alarm
ha_release: 0.7.4
ha_iot_class: Configurable
---

`mqtt` 경보 패널 플랫폼을 사용하면 MQTT를 사용할 수 있는 경보 패널을 제어 할 수 있습니다. 경보 아이콘은 `state_topic`에서 새로운 상태를 받은 후 해당 상태를 변경합니다. 이러한 메시지가 *RETAIN* 플래그와 함께 공개되면 MQTT 경보 패널은 등록후 즉시 상태 업데이트를 수신하고 변경된 상태로 시작합니다. 그렇지 않으면 초기 상태는 `unknown`이 됩니다.

통합구성요소는 경보 패널에서 다음 상태를 수락합니다 (소문자).

- `disarmed`
- `armed_home`
- `armed_away`
- `armed_night`
- `pending`
- `triggered`

이 통합구성요소는 사용자가 홈어시스턴트 프론트 엔드와 상호 작용할 때 `command_topic`에 공개하여 경보 패널을 제어할 수 있습니다.

## 설정

이 플랫폼을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
alarm_control_panel:
  - platform: mqtt
    state_topic: "home/alarm"
    command_topic: "home/alarm/set"
```

{% configuration %}
name:
  description: The name of the alarm.
  required: false
  type: string
  default: MQTT Alarm
unique_id:
   description: An ID that uniquely identifies this alarm panel. If two alarm panels have the same unique ID, Home Assistant will raise an exception.
   required: false
   type: string
state_topic:
  description: The MQTT topic subscribed to receive state updates.
  required: true
  type: string
command_topic:
  description: The MQTT topic to publish commands to change the alarm state.
  required: true
  type: string
command_template:
  description: "The [template](/docs/configuration/templating/#processing-incoming-data) used for the command payload. Available variables: `action` and `code`."
  required: false
  type: string
  default: action
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the value."
  required: false
  type: template
qos:
  description: The maximum QoS level of the state topic.
  required: false
  type: integer
  default: 0
payload_disarm:
  description: The payload to disarm your Alarm Panel.
  required: false
  type: string
  default: DISARM
payload_arm_home:
  description: The payload to set armed-home mode on your Alarm Panel.
  required: false
  type: string
  default: ARM_HOME
payload_arm_away:
  description: The payload to set armed-away mode on your Alarm Panel.
  required: false
  type: string
  default: ARM_AWAY
payload_arm_night:
  description: The payload to set armed-night mode on your Alarm Panel.
  required: false
  type: string
  default: ARM_NIGHT
code:
  description: If defined, specifies a code to enable or disable the alarm in the frontend.
  required: false
  type: string
code_arm_required:
  description: If true the code is required to arm the alarm. If false the code is not validated.
  required: false
  type: boolean
  default: true
code_disarm_required:
  description: If true the code is required to disarm the alarm. If false the code is not validated.
  required: false
  type: boolean
  default: true
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
device:
  description: 'Information about the device this alarm panel is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set.'
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
