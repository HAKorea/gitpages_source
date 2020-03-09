---
title: "MQTT Switch"
description: "Instructions on how to integrate MQTT switches into Home Assistant."
logo: mqtt.png
ha_category:
  - Switch
ha_release: 0.7
ha_iot_class: Configurable
---

`mqtt` 스위치 플랫폼을 사용하면 MQTT가 가능한 스위치를 제어할 수 있습니다.

## 설정

이상적인 시나리오에서 MQTT 디바이스에는 상태 변경 사항을 공개하기 위한 `state_topic`이 있습니다. 이러한 메시지가 `RETAIN` 플래그와 함께 공개되면 MQTT 스위치는 구독(subscription) 후 즉시 상태 업데이트를 수신하고 변경된 상태로 시작합니다. 그렇지 않으면 스위치의 초기 상태는 `false`/`off`입니다.

`state_topic`을 사용할 수 없으면 스위치는 optimistic 모드에서 작동합니다. 이 모드에서 스위치는 모든 명령 후에 즉시 상태를 변경합니다. 그렇지 않으면 스위치는 장치의 상태 확인을 기다립니다 (`state_topic`의 메시지).

`state_topic`이 사용 가능하더라도 Optimistic 모드를 강제할 수 있습니다. 잘못된 스위치 작동이 발생하면 활성화하십시오.

설치에서이 스위치를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: mqtt
    command_topic: "home/bedroom/switch1/set"
```

{% configuration %}
command_topic:
  description: The MQTT topic to publish commands to change the switch state.
  required: false
  type: string
name:
  description: The name to use when displaying this switch.
  required: false
  type: string
  default: MQTT Switch
icon:
  description: Icon for the switch.
  required: false
  type: icon
state_topic:
  description: The MQTT topic subscribed to receive state updates.
  required: false
  type: string
state_on:
  description: The payload that represents the on state.
  required: false
  type: string
  default: "`payload_on` if defined, else ON"
state_off:
  description: The payload that represents the off state.
  required: false
  type: string
  default: "`payload_off` if defined, else OFF"
availability_topic:
  description: The MQTT topic subscribed to receive availability (online/offline) updates.
  required: false
  type: string
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
optimistic:
  description: Flag that defines if switch works in optimistic mode.
  required: false
  type: boolean
  default: "`true` if no `state_topic` defined, else `false`."
qos:
  description: The maximum QoS level of the state topic. Default is 0 and will also be used to publishing messages.
  required: false
  type: integer
  default: 0
retain:
  description: If the published message should have the retain flag on or not.
  required: false
  type: boolean
  default: false
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the payload."
  required: false
  type: string
json_attributes_topic:
  description: The MQTT topic subscribed to receive a JSON dictionary payload and then set as sensor attributes. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-topic-configuration) documentation.
  required: false
  type: string
json_attributes_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the JSON dictionary from messages received on the `json_attributes_topic`. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-template-configuration) documentation."
  required: false
  type: template
device:
  description: "Information about the device this switch is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set."
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
      type: list
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

topic이 정확히 일치하는지 확인하십시오. `some-topic/` 과 `some-topic`은 다른 topic입니다.

</div>

## 사례

이 섹션에서는 이 센서를 사용하는 방법에 대한 실제 예를 제공합니다.

### 전체 설정

아래 예는 스위치의 전체 설정을 보여줍니다.

```yaml
# Example configuration.yaml entry
switch:
  - platform: mqtt
    name: "Bedroom Switch"
    state_topic: "home/bedroom/switch1"
    command_topic: "home/bedroom/switch1/set"
    availability_topic: "home/bedroom/switch1/available"
    payload_on: "ON"
    payload_off: "OFF"
    state_on: "ON"
    state_off: "OFF"
    optimistic: false
    qos: 0
    retain: true
```

확인을 위해 `mosquitto`와 함께 제공된 `mosquitto_pub`를 command line tools로 사용하여 MQTT 메시지를 보낼 수 있습니다. 이를 통해 스위치를 수동으로 조작할 수 있습니다.

```bash
mosquitto_pub -h 127.0.0.1 -t home/bedroom/switch1 -m "ON"
```

### ESPEasy를 사용하여 장치 상태 설정 

[ESPEasy](https://github.com/letscontrolit/ESPEasy)를 사용하여 ESP8266 장치를 플래시했다고 가정합니다. "Config"아래에 장치의 이름 ( "Unit Name:")이 있습니다 (여기서는 "bathroom"). "OpenHAB MQTT" 프로토콜을 사용하는 MQTT에 대한 "Controller"에 대한 설정이 있으며 항목 ( "Controller Subscribe:"및 "Controller Publish:")이 필요에 맞게 조정됩니다. 이 예에서 topic은 "home"으로 시작합니다. [GPIO](https://www.letscontrolit.com/wiki/index.php/GPIO)를 MQTT로 직접 제어할 수 있으므로 추가 설정이 필요하지 않습니다.

`mosquitto_pub` 또는 다른 MQTT 도구를 사용하여 pin 13을 수동으로 HIGH로 설정할 수 있습니다.

```bash
mosquitto_pub -h 127.0.0.1 -t home/bathroom/gpio/13 -m "1"
```

설정은 아래 예와 같습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
switch:
  - platform: mqtt
    name: bathroom
    state_topic: "home/bathroom/gpio/13"
    command_topic: "home/bathroom/gpio/13"
    payload_on: "1"
    payload_off: "0"
```
{% endraw %}
