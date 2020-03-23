---
title: "MQTT 커버(MQTT Cover)"
description: "Instructions on how to integrate MQTT covers into Home Assistant."
logo: mqtt.png
ha_category:
  - Cover
ha_iot_class: Configurable
ha_release: 0.18
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/bSrNEZpTOCk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`mqtt` 커버(Cover) 플랫폼을 사용하면 MQTT 커버(커튼, 블라인드, 롤러 셔터 또는 차고문)를 제어할 수 있습니다.

## 설정

장치 상태(`open` 또는 `closed`)는 `state_topic` 매칭에서 `state_open` 또는 `state_closed`의 새 메시지가 게시된 후에만 ​​업데이트됩니다. 이러한 메시지가 `retain` 플래그가 설정된 상태로 게시된 경우 subscription 후 커버에 즉시 상태 업데이트가 수신되고 홈어시스턴트는 시작시 변경된 상태를 표시합니다. 그렇지 않으면 홈어시스턴트에 표시되는 초기 상태는 `unknown`입니다.

이를 위해 커버의 상태와 위치를 설정할 수 있는 `position_topic`이 있습니다.
기본 설정은 0이며 장치가 `closed`를 의미하고 다른 모든 중간 위치는 장치가 `open`임을 의미합니다.
`position_topic`은 `position_open` 및 `position_closed`로 관리합니다.
반대 방식으로 설정할 수도 있습니다.
만일 position topic이 정의되면 state topic은 무시됩니다. 

state topic 및 state topic이 정의되지 않은 경우 cover는 optimistic mode에서 작동합니다. 이 모드에서 커버는 홈어시스턴트가 보낸 모든 명령 후에 즉시 state(`open` 혹은 `closed`)를 변경합니다. state topic/position topic이 정의된 경우, 커버는 `state_topic` 또는 `position_topic`에서 메시지를 기다립니다.

`state_topic`/`position_topic`이 정의되어 있어도 Optimistic mode를 강제할 수 있습니다. 잘못된 커버 작동이 발생하면 활성화하십시오 (Google Assistant Gauge는 set_cover_position을 보낸 후 즉시 홈어시스턴트로 요청을 보내므로 Optimistic mode가 필요할 수 있습니다. 이 경우 MQTT가 너무 느릴 수 있습니다.)

`mqtt` 커버 플랫폼은 선택적으로 MQTT 커버 장치로부터 online 및 offline messages (birth 및 LWT messages)를 수신할 수있는 `availability_topic`을 지원합니다. 정상적인 작동중에 MQTT 커버 장치가 offline state가 되면 (즉, `payload_not_available`을 `availability_topic`에 게시하는 경우) 홈어시스턴트는 커버를 "unavailable"으로 표시합니다. 이러한 massage가 `retain` flag가 설정된 상태로 publish된 경우 subscription후 커버가 즉시 업데이트를 수신하고 Home Assistant는 Home Assistant가 시작될 때 커버의 correct availability state를 표시합니다.

설치시 MQTT 커버를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
cover:
  - platform: mqtt
    command_topic: "home-assistant/cover/set"
```

{% configuration %}
command_topic:
  description: The MQTT topic to publish commands to control the cover.
  required: false
  type: string
name:
  description: The name of the cover.
  required: false
  type: string
  default: MQTT Cover
payload_open:
  description: The command payload that opens the cover.
  required: false
  type: string
  default: OPEN
payload_close:
  description: The command payload that closes the cover.
  required: false
  type: string
  default: CLOSE
payload_stop:
  description: The command payload that stops the cover.
  required: false
  type: string
  default: STOP
state_topic:
  description: The MQTT topic subscribed to receive cover state messages. Use only if not using `position_topic`. State topic can only read open/close state. Cannot read position state. If `position_topic` is set `state_topic` is ignored.
  required: false
  type: string
state_open:
  description: The payload that represents the open state.
  required: false
  type: string
  default: open
state_closed:
  description: The payload that represents the closed state.
  required: false
  type: string
  default: closed
position_topic:
  description: The MQTT topic subscribed to receive cover position messages. If `position_topic` is set `state_topic` is ignored.
  required: false
  type: string
position_open:
  description: Number which represents open position.
  required: false
  type: integer
  default: 100
position_closed:
  description: Number which represents closed position.
  required: false
  type: integer
  default: 0
availability_topic:
  description: "The MQTT topic subscribed to to receive birth and LWT messages from the MQTT cover device. If `availability_topic` is not defined, the cover availability state will always be `available`. If `availability_topic` is defined, the cover availability state will be `unavailable` by default."
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
optimistic:
  description: Flag that defines if switch works in optimistic mode.
  required: false
  type: string
  default: "`true` if no state topic defined, else `false`."
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
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the payload."
  required: false
  type: string
set_position_topic:
  description: "The MQTT topic to publish position commands to. You need to set position_topic as well if you want to use position topic. Use template if position topic wants different values than within range `position_closed` - `position_open`. If template is not defined and `position_closed != 100` and `position_open != 0` then proper position value is calculated from percentage position."
  required: false
  type: string
set_position_template:
  description: "Defines a [template](/topics/templating/) to define the position to be sent to the `set_position_topic` topic. Incoming position value is available for use in the template `{{position}}`. If no template is defined, the position (0-100) will be calculated according to `position_open` and `position_closed` values."
  required: false
  type: string
tilt_command_topic:
  description: The MQTT topic to publish commands to control the cover tilt.
  required: false
  type: string
tilt_status_topic:
  description: The MQTT topic subscribed to receive tilt status update values.
  required: false
  type: string
tilt_status_template:
  description: "Defines a [template](/topics/templating/) that can be used to extract the payload for the `tilt_status_topic` topic. "
  required: false
  type: string
tilt_min:
  description: The minimum tilt value.
  required: false
  type: integer
  default: 0
tilt_max:
  description: The maximum tilt value
  required: false
  type: integer
  default: 100
tilt_closed_value:
  description: The value that will be sent on a `close_cover_tilt` command.
  required: false
  type: integer
  default: 0
tilt_opened_value:
  description: The value that will be sent on an `open_cover_tilt` command.
  required: false
  type: integer
  default: 100
tilt_optimistic:
  description: Flag that determines if tilt works in optimistic mode.
  required: false
  type: boolean
  default: "`true` if `tilt_status_topic` is not defined, else `false`"
tilt_invert_state:
  description: Flag that determines if open/close are flipped; higher values toward closed and lower values toward open.
  required: false
  type: boolean
  default: false
device_class:
  description: Sets the [class of the device](/integrations/cover/), changing the device state and icon that is displayed on the frontend.
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
unique_id:
  description: An ID that uniquely identifies this cover. If two covers have the same unique ID, Home Assistant will raise an exception.
  required: false
  type: string
device:
  description: "Information about the device this cover is a part of to tie it into the [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html). Only works through [MQTT discovery](/docs/mqtt/discovery/) and when [`unique_id`](#unique_id) is set."
  required: false
  type: map
  keys:
    identifiers:
      description: 'A list of IDs that uniquely identify the device. For example a serial number.'
      required: false
      type: [list, string]
    connections:
      description: 'A list of connections of the device to the outside world as a list of tuples `[connection_type, connection_identifier]`. For example the MAC address of a network interface: `"connections": ["mac", "02:5b:26:a8:dc:12"]`.'
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

이 섹션에는 이 플랫폼을 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 틸트(TILT)가 없는 STATE TOPIC 전체 설정

아래 예는 state topic만 쓰고 tilt가 없는 커버의 전체 설정을 보여줍니다.

{% raw %}
```yaml
# Example configuration.yaml entry
cover:
  - platform: mqtt
    name: "MQTT Cover"
    command_topic: "home-assistant/cover/set"
    state_topic: "home-assistant/cover/state"
    availability_topic: "home-assistant/cover/availability"
    qos: 0
    retain: true
    payload_open: "OPEN"
    payload_close: "CLOSE"
    payload_stop: "STOP"
    state_open: "open"
    state_closed: "closed"
    payload_available: "online"
    payload_not_available: "offline"
    optimistic: false
    value_template: '{{ value.x }}'
```
{% endraw %}

### TILT가 없는 POSITION TOPIC 전체 설정

아래 예는 position topic으로 tilt가 없는 커버의 전체 설정을 보여줍니다.

{% raw %}
```yaml
# Example configuration.yaml entry
cover:
  - platform: mqtt
    name: "MQTT Cover"
    command_topic: "home-assistant/cover/set"
    position_topic: "home-assistant/cover/position"
    availability_topic: "home-assistant/cover/availability"
    set_position_topic: "home-assistant/cover/set_position"
    qos: 0
    retain: true
    payload_open: "OPEN"
    payload_close: "CLOSE"
    payload_stop: "STOP"
    position_open: 100
    position_closed: 0
    payload_available: "online"
    payload_not_available: "offline"
    optimistic: false
    value_template: '{{ value.x }}'
```
{% endraw %}

### 전체 설정

아래 예는 커버의 전체 설정을 보여줍니다.

{% raw %}
```yaml
# Example configuration.yaml entry
cover:
  - platform: mqtt
    name: "MQTT Cover"
    command_topic: "home-assistant/cover/set"
    state_topic: "home-assistant/cover/state"
    availability_topic: "home-assistant/cover/availability"
    qos: 0
    retain: true
    payload_open: "OPEN"
    payload_close: "CLOSE"
    payload_stop: "STOP"
    state_open: "open"
    state_closed: "closed"
    payload_available: "online"
    payload_not_available: "offline"
    optimistic: false
    value_template: '{{ value.x }}'
    tilt_command_topic: 'home-assistant/cover/tilt'
    tilt_status_topic: 'home-assistant/cover/tilt-state'
    tilt_status_template: '{{ value_json["PWM"]["PWM1"] }}'
    tilt_min: 0
    tilt_max: 180
    tilt_closed_value: 70
    tilt_opened_value: 180
```
{% endraw %}

테스트하려면 mosquitto와 함께 제공된 `mosquitto_pub` command line tool 또는 `mosquitto-clients` 패키지를 사용하여 MQTT 메시지를 보낼 수 있습니다. 이를 통해 커버를 수동으로 조작할 수 있습니다.

```bash
$  mosquitto_pub -h 127.0.0.1 -t home-assistant/cover/set -m "CLOSE"
```
