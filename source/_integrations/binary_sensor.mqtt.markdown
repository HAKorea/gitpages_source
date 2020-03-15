---
title: "MQTT 이진 센서(MQTT Binary Sensor)"
description: "Instructions on how to integrate MQTT binary sensors within Home Assistant."
logo: mqtt.png
ha_category:
  - Binary Sensor
ha_release: 0.9
ha_iot_class: Configurable
---

`mqtt` binary sensor 플랫폼은 MQTT 메시지 페이로드를 사용하여 binary sensor를 두 가지 상태 중 하나로 설정합니다 : `on` 또는 `off`.

바이너리 센서 상태는 `state_topic`가 `payload_on` 또는 `payload_off`와 일치할 때 새 메시지가 게시(publish)된 후에 만 ​​업데이트됩니다. 
이러한 메시지가 `retain` 플래그가 설정된 상태로 게시(publish) 된 경우 subscription후 바이너리 센서에 즉시 상태 업데이트가 수신되고 홈어시스턴트는 시작시 수정된 상태를 표시합니다. 그렇지 않으면 홈어시스턴트에 표시되는 초기 상태는 `unknown` 입니다.

## 설정 (Configuration)

`mqtt` binary sensor 플랫폼은 선택적으로 MQTT 장치에서 온라인 및 오프라인 메시지 (birth 및 LWT 메시지)를 수신 할 수있는 `availability_topic`을 지원합니다. 정상 작동 중에 MQTT 센서 장치가 오프라인 상태가되면 (즉, `payload_not_available`을 `availability_topic`에 게시하는 경우) 홈어시스턴트는  binary sensor를 `unavailable`로 표시합니다. 이러한 메시지가 `retain` 플래그가 설정된 상태로 게시된 경우 subscription 후  binary sensor는 즉시 업데이트를 수신하고 Home Assistant는 Home Assistant가 시작될 때  binary sensor의 수정된 가용성 상태를 표시합니다. `retain` 플래그가 설정되지 않은 경우 Home Assistant는 Home Assistant가 시작될 때 binary sensor를 사용할 수 없는 것으로 표시합니다. 
`availability_topic`이 정의되지 않은 경우 홈 어시스턴트는 MQTT 디바이스를 사용 가능한 것으로 간주합니다.

설치에서 MQTT 이진 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mqtt
    state_topic: "home-assistant/window/contact"
```

{% configuration %}
availability_topic:
  description: "The MQTT topic subscribed to receive birth and LWT messages from the MQTT device. If `availability_topic` is not defined, the binary sensor availability state will always be `available`. If `availability_topic` is defined, the binary sensor availability state will be `unavailable` by default."
  required: false
  type: string
device:
  description: "Information about the device this binary sensor is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set."
  required: false
  type: map
  keys:
    connections:
      description: "A list of connections of the device to the outside world as a list of tuples `[connection_type, connection_identifier]`. For example the MAC address of a network interface: `'connections': ['mac', '02:5b:26:a8:dc:12']`."
      required: false
      type: [list, map]
    identifiers:
      description: A list of IDs that uniquely identify the device. For example a serial number.
      required: false
      type: [list, string]
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
device_class:
  description: Sets the [class of the device](/integrations/binary_sensor/#device-class), changing the device state and icon that is displayed on the frontend.
  required: false
  type: string
expire_after:
  description: "Defines the number of seconds after the value expires if it's not updated. After expiry, the value is cleared, and the availability is set to false"
  required: false
  type: integer
force_update:
  description: Sends update events even if the value hasn't changed. Useful if you want to have meaningful value graphs in history.
  required: false
  type: boolean
  default: false
json_attributes_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the JSON dictionary from messages received on the `json_attributes_topic`. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-template-configuration) documentation."
  required: false
  type: template
json_attributes_topic:
  description: The MQTT topic subscribed to receive a JSON dictionary payload and then set as sensor attributes. Usage example can be found in [MQTT sensor](/integrations/sensor.mqtt/#json-attributes-topic-configuration) documentation.
  required: false
  type: string
name:
  description: The name of the binary sensor.
  required: false
  type: string
  default: MQTT Binary Sensor
off_delay:
  description: "For sensors that only sends `On` state updates, this variable sets a delay in seconds after which the sensor state will be updated back to `Off`."
  required: false
  type: integer
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
payload_off:
  description: The payload that represents the off state.
  required: false
  type: string
  default: "OFF"
payload_on:
  description: The payload that represents the on state.
  required: false
  type: string
  default: "ON"
qos:
  description: The maximum QoS level to be used when receiving messages.
  required: false
  type: integer
  default: 0
state_topic:
  description: The MQTT topic subscribed to receive sensor values.
  required: true
  type: string
unique_id:
  description: An ID that uniquely identifies this sensor. If two sensors have the same unique ID, Home Assistant will raise an exception.
  required: false
  type: string
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the payload. Available variables: `entity_id`. Remove this option when 'payload_on' and 'payload_off' are sufficient to match your payloads."
  required: false
  type: string
{% endconfiguration %}


## 사례

이 섹션에서는이 센서를 사용하는 방법에 대한 실제 예를 제공합니다.

### 전체 설정

테스트하려면 `moquitto` 또는 `mosquitto-clients` 패키지와 함께 제공된 command line tool `mosquitto_pub`을 사용하여 MQTT 메시지를 보낼 수 있습니다.

이진 센서의 상태를 수동으로 설정하려면 : 

```bash
$  mosquitto_pub -h 127.0.0.1 -t home-assistant/window/contact -m "OFF"
```

아래 예는 이진 센서의 전체 구성을 보여줍니다.

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

### state_topic에서 메시지가 수신될 때마다 이진 센서 Toggle
{% raw %}
```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mqtt
    state_topic: "lab_button/cmnd/POWER"
    value_template: "{%if is_state(entity_id,\"on\")-%}OFF{%-else-%}ON{%-endif%}"
```
{% endraw %}

### ESPEasy를 사용하여 장치 상태 확인

[ESPEasy](https://github.com/letscontrolit/ESPEasy)를 사용하여 ESP8266 장치를 만들었다고 가정합니다. "Config" 아래에 장치에 설정된 이름 ("Unit Name:")이 있습니다 (여기서는 "bathroom"). "OpenHAB MQTT" 프로토콜을 사용하는 MQTT에 대한 "Controller" 설정이 있으며 항목 ("Controller Subscribe:" 및 "Controller Publish:")이 필요에 맞게 조정합니다. 이 예에서 topic는 "home"으로 시작합니다. 또한 "Devices"탭에서 "switch" 및 "button"이라는 이름을 가진 "Switch Input"을 값으로 추가하십시오.

장치가 온라인 상태가 되면 바로 연결된 버튼의 상태가 됩니다.

```txt
home/bathroom/status Connected
...
home/bathroom/switch/button 1
```

설정은 아래 예와 같습니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mqtt
    name: Bathroom
    state_topic: "home/bathroom/switch/button"
    payload_on: "1"
    payload_off: "0"
```
