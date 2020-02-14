---
title: "MQTT Discovery (장치 찾기)"
description: "Instructions on how to setup MQTT Discovery within Home Assistant."
logo: mqtt.png
---

MQTT 장치를 발견하면 Home Assistant 측에서 최소한의 설정으로 MQTT 장치를 사용할 수 있습니다.  설정은 장치 자체와 장치가 사용하는 topic에서 수행됩니다. [HTTP binary sensor](/integrations/http/#binary-sensor) 와 [HTTP sensor](/integrations/http/#sensor)가 비슷합니다. 장치가 다시 연결되는 경우 여러 개의 동일한 항목에 연결되는 것을 방지하려면, 고유 한 식별자가 필요합니다. 장치 측에는 두 부분이 필요합니다. : 필요한 장치 유형 및 고유 식별자가 포함 된 설정 topic 및 장치 유형이 없는 장치 설정. **의역 필요**

MQTT discovery 지원 장치 :

- [Alarm control panels](/integrations/alarm_control_panel.mqtt/)
- [Binary sensors](/integrations/binary_sensor.mqtt/)
- [Cameras](/integrations/camera.mqtt/)
- [Covers](/integrations/cover.mqtt/)
- [Fans](/integrations/fan.mqtt/)
- [HVACs](/integrations/climate.mqtt/)
- [Lights](/integrations/light.mqtt/)
- [Locks](/integrations/lock.mqtt/)
- [Sensors](/integrations/sensor.mqtt/)
- [Switches](/integrations/switch.mqtt/)
- [Vacuums](/integrations/vacuum.mqtt/)

MQTT dicovery를 사용하려면, `configuration.yaml` 파일에 다음을 추가 하십시오. :

```yaml
# Example configuration.yaml entry
mqtt:
  discovery: true
  discovery_prefix: homeassistant
```

{% configuration %}
discovery:
  description: MQTT 감지가 사용 가능한지 여부입니다.
  required: false
  default: false
  type: boolean
discovery_prefix:
  description: discovery topic을 위한 prefix.
  required: false
  default: homeassistant
  type: string
{% endconfiguration %}

<div class='note'>

[embedded MQTT broker](/docs/mqtt/broker#embedded-broker) 재시작 시에 어떤 메시지들도 저장하지 않습니다. 임베드 된 MQTT 브로커를 사용하는 경우 디바이스가 표시되도록 모든 홈어시스턴트가 재시작 된 후 MQTT 감지 메시지를 보내야합니다.

</div>

discovery topic은 특정 형식을 따라야합니다. :

```text
<discovery_prefix>/<component>/[<node_id>/]<object_id>/config
```

- `<component>`: 지원되는 MQTT 구성 요소 중 하나입니다. (예 `binary_sensor`).
- `<node_id>` (*선택사항*):  topic를 제공하는 노드의 ID이며, 이는 홈어시스턴트에서 사용되지 않지만 MQTT topic를 설정하는 데 사용될 수 있습니다.
- `<object_id>`: 장치의 ID입니다. 이것은 각 장치에 대해 별도의 topic을 허용하기위한 것이며 `entity_id`에는 사용될 수 없습니다.

페이로드는 JSON dictionay이어야하며 새 장치가 추가되면 `configuration.yaml`에서 특정 항목처럼 체크됩니다. 이는 누락된 변수가 플랫폼의 기본값으로 채워짐을 의미합니다. *요구된* 모든 설정 변수들은 초기 payload에 나타나야하며, `/config`로 보냅니다. 

연동시 payload에 `alarm_control_panel`, `binary_sensor`, 혹은 `sensor` 등 필수적인 `state_topic`이 없는 경우, `state_topic`은 자동으로 다음과 같이 설정됩니다. :

```text
<discovery_prefix>/<component>/[<node_id>/]<object_id>/state
```

자동 설정 `state_topic` 은 더 이상 사용되지 않으며 이후 버전의 홈어시스턴트에서 제거 될 수 있습니다.

비어있는 payload는 이전에 검색된 장치를 삭제합니다.

`<discovery_prefix>/+/<node_id>/+/set`와 같은 하나의 wildcard topic을 사용함으로서 클라이언트 자체 (명령) topic을 subscribe 하기위해 클라이언트에서 `<node_id>` 레벨을 사용할 수 있습니다.   

동일한 topic이 여러 번 사용될 때 메모리를 보존하기 위해 페이로드에 기본topic `~`로 정의할 수 있습니다. 
만일 `~`가 값의 시작 혹은 끝에서 나타날 경우, `_topic`으로 끝나는 설정 변수 값에서, `~`는 기본topic으로 교체됩니다.  

디스커버리 페이로드의 설정 변수 이름은 메모리가 제한된 장치에서 디스커버리 메시지를 보낼 때 메모리를 절약하기 위해 줄여서 쓸 수 있습니다.

지원되는 약어(줄임말):
```txt
    'aux_cmd_t':           'aux_command_topic',
    'aux_stat_tpl':        'aux_state_template',
    'aux_stat_t':          'aux_state_topic',
    'avty_t':              'availability_topic',
    'away_mode_cmd_t':     'away_mode_command_topic',
    'away_mode_stat_tpl':  'away_mode_state_template',
    'away_mode_stat_t':    'away_mode_state_topic',
    'b_tpl':               'blue_template',
    'bri_cmd_t':           'brightness_command_topic',
    'bri_scl':             'brightness_scale',
    'bri_stat_t':          'brightness_state_topic',
    'bri_tpl':             'brightness_template',
    'bri_val_tpl':         'brightness_value_template',
    'bat_lev_t':           'battery_level_topic',
    'bat_lev_tpl':         'battery_level_template',
    'chrg_t':              'charging_topic',
    'chrg_tpl':            'charging_template',
    'clr_temp_cmd_t':      'color_temp_command_topic',
    'clr_temp_stat_t':     'color_temp_state_topic',
    'clr_temp_val_tpl':    'color_temp_value_template',
    'cln_t':               'cleaning_topic',
    'cln_tpl':             'cleaning_template',
    'cmd_off_tpl':         'command_off_template',
    'cmd_on_tpl':          'command_on_template',
    'cmd_t':               'command_topic',
    'curr_temp_t':         'current_temperature_topic',
    'curr_temp_tpl':       'current_temperature_template',
    'dev':                 'device',
    'dev_cla':             'device_class',
    'dock_t':              'docked_topic',
    'dock_tpl':            'docked_template',
    'err_t':               'error_topic',
    'err_tpl':             'error_template',
    'fanspd_t':            'fan_speed_topic',
    'fanspd_tpl':          'fan_speed_template',
    'fanspd_lst':          'fan_speed_list',
    'fx_cmd_t':            'effect_command_topic',
    'fx_list':             'effect_list',
    'fx_stat_t':           'effect_state_topic',
    'fx_tpl':              'effect_template',
    'fx_val_tpl':          'effect_value_template',
    'exp_aft':             'expire_after',
    'fan_mode_cmd_t':      'fan_mode_command_topic',
    'fan_mode_stat_tpl':   'fan_mode_state_template',
    'fan_mode_stat_t':     'fan_mode_state_topic',
    'frc_upd':             'force_update',
    'g_tpl':               'green_template',
    'hold_cmd_t':          'hold_command_topic',
    'hold_stat_tpl':       'hold_state_template',
    'hold_stat_t':         'hold_state_topic',
    'ic':                  'icon',
    'init':                'initial',
    'json_attr':           'json_attributes',
    'json_attr_t':         'json_attributes_topic',
    'max_temp':            'max_temp',
    'min_temp':            'min_temp',
    'mode_cmd_t':          'mode_command_topic',
    'mode_stat_tpl':       'mode_state_template',
    'mode_stat_t':         'mode_state_topic',
    'name':                'name',
    'on_cmd_type':         'on_command_type',
    'opt':                 'optimistic',
    'osc_cmd_t':           'oscillation_command_topic',
    'osc_stat_t':          'oscillation_state_topic',
    'osc_val_tpl':         'oscillation_value_template',
    'pl_arm_away':         'payload_arm_away',
    'pl_arm_home':         'payload_arm_home',
    'pl_avail':            'payload_available',
    'pl_cls':              'payload_close',
    'pl_disarm':           'payload_disarm',
    'pl_hi_spd':           'payload_high_speed',
    'pl_lock':             'payload_lock',
    'pl_lo_spd':           'payload_low_speed',
    'pl_med_spd':          'payload_medium_speed',
    'pl_not_avail':        'payload_not_available',
    'pl_off':              'payload_off',
    'pl_on':               'payload_on',
    'pl_open':             'payload_open',
    'pl_osc_off':          'payload_oscillation_off',
    'pl_osc_on':           'payload_oscillation_on',
    'pl_stop':             'payload_stop',
    'pl_unlk':             'payload_unlock',
    'pow_cmd_t':           'power_command_topic',
    'r_tpl':               'red_template',
    'ret':                 'retain',
    'rgb_cmd_tpl':         'rgb_command_template',
    'rgb_cmd_t':           'rgb_command_topic',
    'rgb_stat_t':          'rgb_state_topic',
    'rgb_val_tpl':         'rgb_value_template',
    'send_cmd_t':          'send_command_topic',
    'send_if_off':         'send_if_off',
    'set_pos_tpl':         'set_position_template',
    'set_pos_t':           'set_position_topic',
    'pos_t':               'position_topic',
    'spd_cmd_t':           'speed_command_topic',
    'spd_stat_t':          'speed_state_topic',
    'spd_val_tpl':         'speed_value_template',
    'spds':                'speeds',
    'stat_clsd':           'state_closed',
    'stat_off':            'state_off',
    'stat_on':             'state_on',
    'stat_open':           'state_open',
    'stat_t':              'state_topic',
    'stat_tpl':            'state_template',
    'stat_val_tpl':        'state_value_template',
    'sup_feat':            'supported_features',
    'swing_mode_cmd_t':    'swing_mode_command_topic',
    'swing_mode_stat_tpl': 'swing_mode_state_template',
    'swing_mode_stat_t':   'swing_mode_state_topic',
    'temp_cmd_t':          'temperature_command_topic',
    'temp_stat_tpl':       'temperature_state_template',
    'temp_stat_t':         'temperature_state_topic',
    'tilt_clsd_val':       'tilt_closed_value',
    'tilt_cmd_t':          'tilt_command_topic',
    'tilt_inv_stat':       'tilt_invert_state',
    'tilt_max':            'tilt_max',
    'tilt_min':            'tilt_min',
    'tilt_opnd_val':       'tilt_opened_value',
    'tilt_status_opt':     'tilt_status_optimistic',
    'tilt_status_t':       'tilt_status_topic',
    't':                   'topic',
    'uniq_id':             'unique_id',
    'unit_of_meas':        'unit_of_measurement',
    'val_tpl':             'value_template',
    'whit_val_cmd_t':      'white_value_command_topic',
    'whit_val_scl':        'white_value_scale',
    'whit_val_stat_t':     'white_value_state_topic',
    'whit_val_tpl':        'white_value_template',
    'xy_cmd_t':            'xy_command_topic',
    'xy_stat_t':           'xy_state_topic',
    'xy_val_tpl':          'xy_value_template',
```

장치 레지스트리 설정에 지원되는 줄임말(약어):
```txt
    'cns':                 'connections',
    'ids':                 'identifiers',
    'name':                'name',
    'mf':                  'manufacturer',
    'mdl':                 'model',
    'sw':                  'sw_version',
```

### 지원되는 다른 것들 (Support by third-party tools)

다음 소프트웨어는 MQTT Discovery을 기본적으로 지원합니다.:

- [Sonoff-Tasmota](https://github.com/arendst/Sonoff-Tasmota) (starting with 5.11.1e)
- [ESPHome](https://esphome.io)
- [ESPurna](https://github.com/xoseperez/espurna)
- [Arilux AL-LC0X LED controllers](https://github.com/mertenats/Arilux_AL-LC0X)
- [room-assistant](https://github.com/mKeRix/room-assistant) (starting with 1.1.0)
- [Zigbee2mqtt](https://github.com/koenkk/zigbee2mqtt)
- [Zwave2Mqtt](https://github.com/OpenZWave/Zwave2Mqtt) (starting with 2.0.1)
- [IOTLink](https://iotlink.gitlab.io) (starting with 2.0.0)

### 사례 

#### Motion 감지 (binary sensor)

정원에서 binary 센서로 나타낼 수 있는 Motion 감지 장치는 설정값을 JSON 페이로드로 topic설정에 보냅니다. `config`에 대한 첫번째 message 이후, state topic으로 전송된 MQTT 메시지는 홈어시스턴트에서 상태를 업데이트합니다. 

- Configuration topic: `homeassistant/binary_sensor/garden/config`
- State topic: `homeassistant/binary_sensor/garden/state`
- Payload:  `{"name": "garden", "device_class": "motion", "state_topic": "homeassistant/binary_sensor/garden/state"}`

새 센서를 수동으로 작성합니다. 자세한 내용은 [MQTT testing section](/docs/mqtt/testing/)을 참조하십시오 

```bash
$ mosquitto_pub -h 127.0.0.1 -p 1883 -t "homeassistant/binary_sensor/garden/config" -m '{"name": "garden", "device_class": "motion", "state_topic": "homeassistant/binary_sensor/garden/state"}'
```
상태를 업데이트.

```bash
$ mosquitto_pub -h 127.0.0.1 -p 1883 -t "homeassistant/binary_sensor/garden/state" -m ON
```

빈 메시지를 보내 센서를 삭제.

 ```bash
$ mosquitto_pub -h 127.0.0.1 -p 1883 -t "homeassistant/binary_sensor/garden/config" -m ''
```

#### 여러 값을 가진 센서

여러 측정 값으로 센서를 설정하려면 여러 개의 연속설정 topic값의 제출이 필요합니다

- Configuration topic no1: `homeassistant/sensor/sensorBedroomT/config`
- Configuration payload no1: `{"device_class": "temperature", "name": "Temperature", "state_topic": "homeassistant/sensor/sensorBedroom/state", "unit_of_measurement": "°C", "value_template": "{% raw %}{{ value_json.temperature}}{% endraw %}" }`
- Configuration topic no2: `homeassistant/sensor/sensorBedroomH/config`
- Configuration payload no2: `{"device_class": "humidity", "name": "Humidity", "state_topic": "homeassistant/sensor/sensorBedroom/state", "unit_of_measurement": "%", "value_template": "{% raw %}{{ value_json.humidity}}{% endraw %}" }`
- Common state payload: `{ "temperature": 23.20, "humidity": 43.70 }`

#### 스위치 (Switches)

스위치 설정은 비슷하지만 [MQTT switch documentation](/integrations/switch.mqtt/)에 언급 된대로 `command_topic`이 필요합니다. 

- Configuration topic: `homeassistant/switch/irrigation/config`
- State topic: `homeassistant/switch/irrigation/state`
- Command topic: `homeassistant/switch/irrigation/set`
- Payload:  `{"name": "garden", "command_topic": "homeassistant/switch/irrigation/set", "state_topic": "homeassistant/switch/irrigation/state"}`

```bash
$ mosquitto_pub -h 127.0.0.1 -p 1883 -t "homeassistant/switch/irrigation/config" \
  -m '{"name": "garden", "command_topic": "homeassistant/switch/irrigation/set", "state_topic": "homeassistant/switch/irrigation/state"}'
```
상태를 설정하십시오.

```bash
$ mosquitto_pub -h 127.0.0.1 -p 1883 -t "homeassistant/switch/irrigation/set" -m ON
```

#### topic 이름 줄임말(약어)

페이로드 길이를 줄이기 위해 topic prefix 및 축약된 설정 변수 이름을 사용하여 스위치 설정.

- Configuration topic: `homeassistant/switch/irrigation/config`
- Command topic: `homeassistant/switch/irrigation/set`
- State topic: `homeassistant/switch/irrigation/state`
- Configuration payload: `{"~": "homeassistant/switch/irrigation", "name": "garden", "cmd_t": "~/set", "stat_t": "~/state"}`

#### 조명 (Lighting)

축약된 설정 변수 이름으로 [light that takes JSON payloads](/integrations/light.mqtt/#json-schema) 설정 :

- Configuration topic: `homeassistant/light/kitchen/config`
- Command topic: `homeassistant/light/kitchen/set`
- State topic: `homeassistant/light/kitchen/state`
- Example state payload: `{"state": "ON", "brightness": 255}`
- Configuration payload:

  ```json
  {
    "~": "homeassistant/light/kitchen",
    "name": "Kitchen",
    "unique_id": "kitchen_light",
    "cmd_t": "~/set",
    "stat_t": "~/state",
    "schema": "json",
    "brightness": true
  }
  ```

#### 냉난방기 컨트롤 (Climate control)

냉난방기 연동 설정 (heat only):

- Configuration topic: `homeassistant/climate/livingroom/config`
- Configuration payload:

```json
{
  "name":"Livingroom",
  "mode_cmd_t":"homeassistant/climate/livingroom/thermostatModeCmd",
  "mode_stat_t":"homeassistant/climate/livingroom/state",
  "mode_stat_tpl":"{{value_json.mode}}",
  "avty_t":"homeassistant/climate/livingroom/available",
  "pl_avail":"online",
  "pl_not_avail":"offline",
  "temp_cmd_t":"homeassistant/climate/livingroom/targetTempCmd",
  "temp_stat_t":"homeassistant/climate/livingroom/state",
  "temp_stat_tpl":"{{value_json.target_temp}}",
  "curr_temp_t":"homeassistant/climate/livingroom/state",
  "curr_temp_tpl":"{{value_json.current_temp}}",
  "min_temp":"15",
  "max_temp":"25",
  "temp_step":"0.5",
  "modes":["off", "heat"]
}
```

- State topic: `homeassistant/climate/livingroom/state`
- State payload:

```json
{
  "mode":"off",
  "target_temp":"21.50",
  "current_temp":"23.60",
}
```
