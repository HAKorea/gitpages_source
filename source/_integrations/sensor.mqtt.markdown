---
title: "MQTT Sensor"
description: "Instructions on how to integrate MQTT sensors within Home Assistant."
logo: mqtt.png
ha_category:
  - Sensor
ha_release: 0.7
ha_iot_class: Configurable
---

이 mqtt 센서 플랫폼은 MQTT 메시지 payload를 센서값으로 사용합니다. 이 'state_topic'의 메시지가 *RETAIN* 플래그와 함께 게시되면 센서는 마지막으로 알려진 값으로 즉시 업데이트를 받습니다. 그렇지 않으면 초기 상태가 정의되지 않습니다.

## 설정

MQTT 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: mqtt
    state_topic: "home/bedroom/temperature"
```

{% configuration %}
state_topic:
  description: The MQTT topic subscribed to receive sensor values.
  required: true
  type: string
name:
  description: The name of the MQTT sensor.
  required: false
  type: string
  default: MQTT Sensor
qos:
  description: The maximum QoS level of the state topic.
  required: false
  type: integer
  default: 0
unit_of_measurement:
  description: Defines the units of measurement of the sensor, if any.
  required: false
  type: string
icon:
  description: The icon for the sensor.
  required: false
  type: icon
expire_after:
  description: Defines the number of seconds after the value expires if it's not updated.
  required: false
  type: integer
  default: 0
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the value."
  required: false
  type: template
force_update:
  description: Sends update events even if the value hasn't changed. Useful if you want to have meaningful value graphs in history.
  reqired: false
  type: boolean
  default: false
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
  description: The MQTT topic subscribed to receive a JSON dictionary payload and then set as sensor attributes. Implies `force_update` of the current sensor state when a message is received on this topic.
  required: false
  type: string
json_attributes_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the JSON dictionary from messages received on the `json_attributes_topic`."
  required: false
  type: template
json_attributes:
  description: (Deprecated, replaced by json_attributes_topic) A list of keys to extract values from a JSON dictionary payload and then set as sensor attributes.
  required: false
  type: [string, list]
unique_id:
  description: "An ID that uniquely identifies this sensor. If two sensors have the same unique ID, Home Assistant will raise an exception."
  required: false
  type: string
device_class:
  description: The [type/class](/integrations/sensor/#device-class) of the sensor to set the icon in the frontend.
  required: false
  type: device_class
  default: None
device:
  description: "Information about the device this sensor is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set."
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

## 사례

본 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### JSON 속성 topic 설정

The example sensor below shows a configuration example which uses a JSON dict: `{"ClientName": <string>, "IP": <string>, "MAC": <string>, "RSSI": <string>, "HostName": <string>, "ConnectedSSID": <string>}` in a separate topic `home/sensor1/attributes` to add extra attributes. It also makes use of the `availability` topic. Extra attributes will be displayed in the frontend and can also be extracted in [Templates](/docs/configuration/templating/#attributes). For example, to extract the `ClientName` attribute from the sensor below, use a template similar to: {% raw %}`{{ state_attr('sensor.bs_rssi', 'ClientName') }}`{% endraw %}.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: mqtt
    name: "RSSI"
    state_topic: "home/sensor1/infojson"
    unit_of_measurement: 'dBm'
    value_template: "{{ value_json.RSSI }}"
    availability_topic: "home/sensor1/status"
    payload_available: "online"
    payload_not_available: "offline"
    json_attributes_topic: "home/sensor1/attributes"
```
{% endraw %}

### JSON 속성 템플릿 설정

The example sensor below shows a configuration example which uses a JSON dict: `{"Timer1":{"Arm": <status>, "Time": <time>}, "Timer2":{"Arm": <status>, "Time": <time>}}` on topic `tele/sonoff/sensor` with a template to add `Timer1.Arm` and `Timer1.Time` as extra attributes.  Extra attributes will be displayed in the frontend and can also be extracted in [Templates](/docs/configuration/templating/#attributes). For example, to extract the `Arm` attribute from the sensor below, use a template similar to: {% raw %}`{{ state_attr('sensor.timer1', 'Arm') }}`{% endraw %}.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: mqtt
    name: "Timer 1"
    state_topic: "tele/sonoff/sensor"
    value_template: "{{ value_json.Timer1.Arm }}"
    json_attributes_topic: "tele/sonoff/sensor"
    json_attributes_template: "{{ value_json.Timer1 | tojson }}"
  - platform: mqtt
    name: "Timer 2"
    state_topic: "tele/sonoff/sensor"
    value_template: "{{ value_json.Timer2.Arm }}"
    json_attributes_topic: "tele/sonoff/sensor"
    json_attributes_template: "{{ value_json.Timer2 | tojson }}"
```
{% endraw %}

설계상 센서의 상태 및 속성은 동일한 MQTT topic을 공유하는 경우 동기 방식으로 업데이트되지 않습니다. 상태와 속성이 동일한 MQTT 메시지에 의해 동시에 변경되면 상태와 속성 데이터 사이의 시간 불일치가 발생할 수 있습니다. 센서의 상태 변경시 트리거되는 자동화는 상태 변경 또는 속성 변경시 모두 트리거됩니다. 상태와 속성이 모두 변경되면 이러한 자동화가 두 번 트리거됩니다.
[MQTT trigger](/docs/automation/trigger/#mqtt-trigger)를 사용하고 동일한 MQTT 메시지 내에서 여러 JSON 값을 동기적으로 처리해야하는 자동화를 위해 {% raw %}`{{ trigger.payload_json }}`{% endraw %}[trigger data](/docs/automation/templating/#mqtt)를 통해 자동화에서 JSON을 직접 처리하십시오.

### 밧데리 레벨 받기

[OwnTracks](/integrations/owntracks)를 사용하고 배터리 잔량보고를 활성화 한 경우 MQTT 센서를 사용하여 배터리를 추적할 수 있습니다. OwnTracks의 일반 MQTT 메시지는 다음과 같습니다.

```bash
owntracks/tablet/tablet {"_type":"location","lon":7.21,"t":"u","batt":92,"tst":144995643,"tid":"ta","acc":27,"lat":46.12}
```

따라서 트릭(trick)은 payload에서 배터리 레벨을 추출하는 것입니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: mqtt
    name: "Battery Tablet"
    state_topic: "owntracks/tablet/tablet"
    unit_of_measurement: '%'
    value_template: "{{ value_json.batt }}"
```
{% endraw %}

### 온습도 받기

DHT 센서와 NodeMCU 보드 (esp8266)를 사용하는 경우 MQTT 센서로 온도 및 습도를 검색 할 수 있습니다. [here](https://github.com/mertenats/open-home-automation/tree/master/ha_mqtt_sensor_dht22)에서 코드 예제를 찾을 수 있습니다. 이 예제의 일반 MQTT 메시지는 다음과 같습니다.

```json
office/sensor1
  {
    "temperature": 23.20,
    "humidity": 43.70
  }
```

그런 다음이 설정 예제를 사용하여 payload에서 데이터를 추출하십시오.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: mqtt
    name: "Temperature"
    state_topic: "office/sensor1"
    unit_of_measurement: '°C'
    value_template: "{{ value_json.temperature }}"
  - platform: mqtt
    name: "Humidity"
    state_topic: "office/sensor1"
    unit_of_measurement: '%'
    value_template: "{{ value_json.humidity }}"
```
{% endraw %}

### ESPEasy를 사용하여 장치에서 센서값 받기

[ESPEasy](https://github.com/letscontrolit/ESPEasy)를 사용하여 ESP8266 장치를 플래시했다고 가정합니다. "Config"에서 장치의 이름 ("Unit Name:")을 설정하십시오 (여기서는 "bathroom"). "OpenHAB MQTT" 프로토콜을 사용하는 MQTT 용 "Controller"가 있으며 항목("Controller Subscribe:" 및 "Controller Publish:")이 상황에 맞게 조정됩니다. 이 예에서 topic은 "home"으로 시작합니다. ESPEasy 기본 topic은 `/`로 시작하고 `configuration.yaml` 파일에 대한 항목을 작성할 때만 이름을 포함합니다.

- **Controller Subscribe**: `home/%sysname%/#` (instead of `/%sysname%/#`)
- **Controller Publish**: `home/%sysname%/%tskname%/%valname%` (instead of `/%sysname%/%tskname%/%valname%`)

또한 "Devices"탭에서 이름이 "analog" 및 "brightness"인 값으로 센서를 추가하십시오.

장치가 온라인 상태가 되면 센서 상태를 얻게됩니다.

```bash
home/bathroom/status Connected
...
home/bathroom/analog/brightness 290.00
```

설정은 아래 예와 같습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: mqtt
    name: "Brightness"
    state_topic: "home/bathroom/analog/brightness"
```
{% endraw %}
