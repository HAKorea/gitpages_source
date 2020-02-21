---
title: "MQTT Binary Sensor"
description: "Instructions on how to integrate MQTT binary sensors within Home Assistant."
logo: mqtt.png
ha_category:
  - Binary Sensor
ha_release: 0.9
ha_iot_class: Configurable
---

The `mqtt` binary sensor platform uses an MQTT message payload to set the binary sensor to one of two states: `on` or `off`.
`mqtt` binary sensor 플랫폼은 MQTT 메시지 페이로드를 사용하여 binary sensor를 두 가지 상태 중 하나로 설정합니다 : `on` 또는 `off`.

The binary sensor state will be updated only after a new message is published on `state_topic` matching `payload_on` or `payload_off`. 
If these messages are published with the `retain` flag set,the binary sensor will receive an instant state update after subscription and Home Assistant will display the correct state on startup.
Otherwise, the initial state displayed in Home Assistant will be `unknown`.
바이너리 센서 상태는 '`state_topic`가 `payload_on` 또는 `payload_off`와 일치할 때 새 메시지가 게시(publish)된 후에 만 ​​업데이트됩니다. 
이러한 메시지가 'retain'플래그가 설정된 상태로 게시(publish) 된 경우 subscription후 바이너리 센서에 즉시 상태 업데이트가 수신되고 홈어시스턴트는 시작시 올바른 상태를 표시합니다. 그렇지 않으면 홈어시스턴트에 표시되는 초기 상태는 `unknown` 입니다.

## 설정 (Configuration)

The `mqtt` binary sensor platform optionally supports an `availability_topic` to receive online and offline messages (birth and LWT messages) from the MQTT device. During normal operation, if the MQTT sensor device goes offline (i.e., publishes `payload_not_available` to `availability_topic`), Home Assistant will display the binary sensor as `unavailable`. If these messages are published with the `retain` flag set, the binary sensor will receive an instant update after subscription and Home Assistant will display the correct availability state of the binary sensor when Home Assistant starts up. If the `retain` flag is not set, Home Assistant will display the binary sensor as `unavailable` when Home Assistant starts up. If no `availability_topic`
is defined, Home Assistant will consider the MQTT device to be available.
`mqtt` binary sensor 플랫폼은 선택적으로 MQTT 장치에서 온라인 및 오프라인 메시지 (birth 및 LWT 메시지)를 수신 할 수있는 `availability_topic`을 지원합니다. 정상 작동 중에 MQTT 센서 장치가 오프라인 상태가되면 (즉, `payload_not_available`을 `availability_topic`에 게시하는 경우) 홈어시스턴트는  binary sensor를 `unavailable`로 표시합니다. 이러한 메시지가 `retain` 플래그가 설정된 상태로 게시된 경우 subscription 후  binary sensor는 즉시 업데이트를 수신하고 Home Assistant는 Home Assistant가 시작될 때  binary sensor의 올바른 가용성 상태를 표시합니다. `retain` 플래그가 설정되지 않은 경우 Home Assistant는 Home Assistant가 시작될 때 binary sensor를 사용할 수 없는 것으로 표시합니다. 
`availability_topic`이 정의되지 않은 경우 홈 어시스턴트는 MQTT 디바이스를 사용 가능한 것으로 간주합니다.

To use an MQTT binary sensor in your installation,
add the following to your `configuration.yaml` file:
설치에서 MQTT 이진 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mqtt
    state_topic: "home-assistant/window/contact"
```

{% configuration %}
state_topic:
  description: MQTT topic은 센서 값을 수신하도록 구독(subscribe).
  required: true
  type: string
name:
  description: 이진 센서의 이름.
  required: false
  type: string
  default: MQTT Binary Sensor
payload_on:
  description: 켜짐 상태를 나타내는 페이로드.
  required: false
  type: string
  default: "ON"
payload_off:
  description: 오프 상태를 나타내는 페이로드.
  required: false
  type: string
  default: "OFF"
availability_topic:
  description: "MQTT topic은 MQTT 디바이스에서 birth 및 LWT 메시지를 수신하도록 subscribe. 
`availability_topic`이 정의되어 있지 않으면 이진 센서 가용성 상태는 항상 사용 가능. `availability_topic`이 정의되어 있으면 이진 센서 가용성 상태는 기본적으로 사용할 수 없습니다. If `availability_topic` is not defined, the binary sensor availability state will always be `available`. If `availability_topic` is defined, the binary sensor availability state will be `unavailable` by default."
  required: false
  type: string
payload_available:
  description: The payload that represents the online state.
  required: false
  type: string
  default: online
payload_not_available:
  description: The payload that represents the offline state.
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
qos:
  description: The maximum QoS level to be used when receiving messages.
  required: false
  type: integer
  default: 0
unique_id:
  description: An ID that uniquely identifies this sensor. If two sensors have the same unique ID, Home Assistant will raise an exception.
  required: false
  type: string
device_class:
  description: Sets the [class of the device](/integrations/binary_sensor/#device-class), changing the device state and icon that is displayed on the frontend.
  required: false
  type: string
expire_after:
  description: "Defines the number of seconds after the value expires if it's not updated. After expiry, the value is cleared, and the availability is set to false"
  required: false
  type: integer
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the payload. Available variables: `entity_id`. Remove this option when 'payload_on' and 'payload_off' are sufficient to match your payloads."
  required: false
  type: string
force_update:
  description: Sends update events even if the value hasn't changed. Useful if you want to have meaningful value graphs in history.
  required: false
  type: boolean
  default: false
off_delay:
  description: "For sensors that only sends `On` state updates, this variable sets a delay in seconds after which the sensor state will be updated back to `Off`."
  required: false
  type: integer
device:
  description: "Information about the device this binary sensor is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set."
  required: false
  type: map
  keys:
    identifiers:
      description: A list of IDs that uniquely identify the device. For example a serial number.
      required: false
      type: [list, string]
    connections:
      description: "A list of connections of the device to the outside world as a list of tuples `[connection_type, connection_identifier]`. For example the MAC address of a network interface: `'connections': ['mac', '02:5b:26:a8:dc:12']`."
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

## Examples

In this section, you will find some real-life examples of how to use this sensor.

### Full configuration

To test, you can use the command line tool `mosquitto_pub` shipped with `mosquitto` or the `mosquitto-clients` package to send MQTT messages.

To set the state of the binary sensor manually:

```bash
$  mosquitto_pub -h 127.0.0.1 -t home-assistant/window/contact -m "OFF"
```

The example below shows a full configuration for a binary sensor:

{% raw %}
```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mqtt
    name: "Window Contact Sensor"
    state_topic: "home-assistant/window/contact"
    payload_on: "ON"
    payload_off: "OFF"
    availability_topic: "home-assistant/window/availability"
    payload_available: "online"
    payload_not_available: "offline"
    qos: 0
    device_class: opening
    value_template: '{{ value.x }}'
```
{% endraw %}

### Toggle the binary sensor each time a message is received on state_topic
{% raw %}
```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mqtt
    state_topic: "lab_button/cmnd/POWER"
    value_template: "{%if is_state(entity_id,\"on\")-%}OFF{%-else-%}ON{%-endif%}"
```
{% endraw %}

### Get the state of a device with ESPEasy

Assuming that you have flashed your ESP8266 unit with [ESPEasy](https://github.com/letscontrolit/ESPEasy). Under "Config" is a name ("Unit Name:") set for your device (here it's "bathroom"). A configuration for a "Controller" for MQTT with the protocol "OpenHAB MQTT" is present and the entries ("Controller Subscribe:" and "Controller Publish:") are adjusted to match your needs. In this example, the topics are prefixed with "home". Also, add a "Switch Input" in the "Devices" tap with the name "switch" and "button" as value.

As soon as the unit is online, you will get the state of the attached button.

```txt
home/bathroom/status Connected
...
home/bathroom/switch/button 1
```

The configuration will look like the example below:

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mqtt
    name: Bathroom
    state_topic: "home/bathroom/switch/button"
    payload_on: "1"
    payload_off: "0"
```
