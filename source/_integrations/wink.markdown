---
title: 윙크(Wink)
description: Instructions on how to set up the Wink hub within Home Assistant.
logo: wink.png
ha_category:
  - Hub
  - Alarm
  - Binary Sensor
  - Climate
  - Cover
  - Fan
  - Light
  - Lock
  - Scene
  - Sensor
  - Switch
  - Water Heater
featured: true
ha_iot_class: Cloud Polling
ha_release: pre 0.7
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/9ax5ml0YC2s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Wink](https://www.wink.com/)는 시중에서 판매되는 광범위한 장치를 제어할 수 있는 홈오토메이션 허브입니다. 또는 제조사가 자신들에 대해 말하는 것처럼 :

<blockquote>
  윙크는 집에서 항상 도움을 주는 IOT기기와 사람들을 연결하는 빠르고 쉬운 방법을 제공합니다. !!
</blockquote>

Home Assistant는 Wink API와 연동되어 switches, lights, locks, fans, climate devices (thermostats, air conditioners, water heaters), covers, sensors, alarms, and sirens을 자동으로 설정합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Alarm](#alarm-control-panel)
- [Binary Sensor](#binary-sensor)
- [Climate](#climate)
- [Cover](#cover)
- [Fan](#fan)
- [Light](#light)
- [Lock](#lock)
- Scene
- [Sensor](#sensor)
- [Switch](#switch)
- [Water heater](#water-heater)

## [developer.wink.com](https://developer.wink.com)를 사용한 인증

Wink를 사용하여 개발자 계정을 설정해야합니다. 이 프로세스는 승인을 받는데 며칠이 걸릴 수 있습니다.

윙크는 개발자 계정에 가입할 때 사용자에게 세 가지 정보를 요청합니다.

1. `Name:` 원하는 이름을 넣어도 되지만, 예를 들어 "Home Assistant"라고 써도 됩니다.
2. `Website:` Home Assistant 인스턴스의 외부 주소입니다. 외부에서 액세스할 수 없는 경우 이메일 주소를 사용할 수 있습니다.
3. `Redirect URI:` IP를 홈어시스턴트 박스의 내부 IP로 바꾸는 `http://192.168.1.5:8123/auth/wink/callback` 이어야합니다.

`wink` 이외의 `configuration.yaml`에는 설정이 필요하지 않습니다 :

`wink:`를 `configuration.yaml`에 추가하고 홈어시스턴트를 다시 시작하면 프론트 엔드 Configurator를 통해 설정을 안내하는 `CONFIGURE` 버튼이 있는 프론트 엔드에 지속적인 알림이 표시됩니다.

<div class='note'>
configurator를 사용하는 경우 홈어시스턴트가 실행중인 동일한 box가 아닌 경우 홈어시스턴트 서버와 동일한 로컬 네트워크에서 초기 설정을 수행해야합니다. 이를 통해 인증 리디렉션이 올바르게 수행될 수 있습니다.
</div>

```yaml
wink:
```

## Full oauth authentication (legacy)

이는 [developer.wink.com's](https://developer.wink.com)의 Wink Support 이메일을 통해 client_id 및 client_secret을 얻은 사용자들이 사용할 수 있습니다. 

```yaml
wink:
  email: YOUR_WINK_EMAIL_ADDRESS
  password: YOUR_WINK_PASSWORD
  client_id: YOUR_WINK_CLIENT_ID
  client_secret: YOUR_WINK_CLIENT_SECRET
```

필수 항목은 legacy OAuth access에만 필요합니다.

{% configuration %}
email:
  description: Your Wink login email address.
  required: true
  type: string
password:
  description: Your Wink login password.
  required: true
  type: string
client_id:
  description: Your provided Wink `client_id`.
  required: true
  type: string
client_secret:
  description: Your provided Wink `client_secret`.
  required: true
  type: string
local_control:
  description: If set to `true` state changes for lights, locks and switches will be issued to the local hub.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

로컬 제어:

- Wink의 로컬 제어 API는 공식적으로 문서화되어있지 않으므로 허브 업데이트로 인해 손상될 수 있습니다. 이러한 이유로 `local_control`의 기본값은 `false`입니다.
- 로컬 제어를 사용하면 명령이 더 빨라지지는 않지만 Wink가 인터넷과 상관없이 작동합니다.
- 로컬 제어는 Wink 릴레이가 아닌 Wink 허브 v1 및 v2에서만 사용할 수 있습니다.
- 홈어시스턴트 시작시에는 로컬 제어가 사용되지 않습니다. 즉, 초기 설정에는 인터넷 연결이 필요합니다.
- 로컬 제어 요청은 먼저 제어 허브로 전송됩니다. 요청이 실패하면 해당 요청은 온라인 상태가됩니다.

<div class='note'>

허브가 로컬 제어 요청 수락을 중지하는 잘못된 상태가 될 수 있습니다. 이 경우 온라인으로 리디렉션될 때 요청이 훨씬 오래 걸린다는 것을 알 수 있습니다. 자주 발생하지는 않지만 허브를 재부팅하면 문제가 해결 된 것으로 보입니다.

허브가 로컬 요청을 거부하면 다음 오류가 기록됩니다.

```txt
Error sending local control request. Sending request online
```

</div>

## `refresh_state_from_wink` 서비스

Wink 통합구성요소는 시작하는 동안 Wink API에서 한 번만 장치 상태를 가져옵니다. 그 이후의 모든 업데이트는 PubNub라는 타사(third party)를 통해 푸시됩니다. 드물지만 업데이트가 푸시되지 않는 경우 장치 상태가 동기화되지 않을 수 있습니다.

wink/refresh_state_from_wink 서비스를 사용하여 모든 장치의 Wink API에서 최신 상태를 가져올 수 있습니다. `local_control`이 `true`로 설정되면 온라인 API가 아닌 장치 제어 허브에서 상태를 가져옵니다.

## `pull_newly_added_devices_from_wink` 서비스

wink/add_new_devices 서비스를 사용하여 새로 페어링된 Wink 장치를 이미 실행중인 Home-Assistant 인스턴스로 가져올 수 있습니다. 홈어시스턴트를 다시 시작하면 새 장치도 추가됩니다.

## `delete_wink_device` 서비스

wink/delete_wink_device 서비스를 사용하여 Wink에서 장치를 remove/unpair 할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String that points at the `entity_id` of device to delete.

## `pair_new_device` 서비스

wink/pair_new_device 서비스를 사용하여 새 장치를 Wink hub/relay에 페어링할 수 있습니다

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `hub_name` | no | The name of the hub to pair a new device to.
| `pairing_mode` | no | One of the following [zigbee, zwave, zwave_exclusion, zwave_network_rediscovery, lutron, bluetooth, kidde]
| `kidde_radio_code` | conditional | A string of 8 1s and 0s one for each dip switch on the kidde device left --> right = 1 --> 8 (Required if pairing_mode = kidde)

<div class='note'>
장치가 페어링된 후 서비스 wink/pull_newly_added_wink_devices를 호출하면 새 장치가 홈어시스턴트에 추가됩니다. 다음에 홈어시스턴트를 다시 시작할 때 장치가 나타납니다.
</div>

## `rename_wink_device` 서비스

wink/rename_wink_device 서비스를 사용하여 장치 이름을 변경할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String that points at the `entity_id` of device to rename.
| `name` | no | The name to change it to.

<div class='note'>
Wink 장치의 홈어시스턴트 entity_id는 Wink 장치의 이름을 기반으로합니다. 이 서비스를 호출해도 Home Assistant가 다시 시작될 때까지 장치의 entity_id가 변경되지 않습니다.
</div>

<div class='note'>
Wink 허브는 기본적으로 클라우드를 통해서만 액세스 할 수 있습니다. 즉, 인터넷에 연결되어 있어야하며 장치를 제어하고 업데이트 할 때 지연이 발생합니다 (~ 3 초).
</div>

## 커스텀 Wink 장치 및 서비스

- GoControl siren and strobe
- Dome siren/chime/strobe
- Quirky Nimbus (Legacy device) These can no longer be officially added to your Wink account

### `set_siren_auto_shutoff` 서비스

wink/set_siren_auto_shutoff 서비스를 사용하여 종료전에 사이렌이 울리는 시간을 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `auto_shutoff` | no | Int. One of [None, -1, 30, 60, 120] (None and -1 are forever. Use None for gocontrol, and -1 for Dome)
| `entity_id` | yes | String or list of strings that point at `entity_id`s of siren.

예시:

```yaml
script:
  set_all_sirens_to_one_minute_auto_shutoff:
    sequence:
      - service: wink.set_siren_auto_shutoff
        data:
          auto_shutoff: 60
```

<div class='note'>
다음 서비스는 Dome siren/chime에서만 작동합니다.
</div>

### `set_chime_volume` 서비스

wink/set_chime_volume 서비스를 사용하여 Dome siren/chime에서 chime의 볼륨을 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `volume` | no | String. One of ["low", "medium", "high"]
| `entity_id` | yes | String or list of strings that point at `entity_id`s of the siren/chime.

예시:

```yaml
script:
  set_chime_volume_to_low_for_all_chimes
    sequence:
      - service: wink.set_chime_volume
        data:
          volume: "low"
```

### `set_siren_volume` 서비스

wink/set_chime_volume 서비스를 사용하여 Dome Dome siren/chime에서 chime의 볼륨을 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `volume` | no | String. One of ["low", "medium", "high"]
| `entity_id` | yes | String or list of strings that point at `entity_id`s of siren/chime.

예시:

```yaml
script:
  set_siren_volume_to_low_for_all_sirens
    sequence:
      - service: wink.set_siren_volume
        data:
          volume: "low"
```

### `enable_chime` 서비스

wink/enable_chime 서비스를 사용하여 tone을 설정하고 Dome siren/chime에서 chime을 활성화할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `tone` | no | String. One of ["doorbell", "fur_elise", "doorbell_extended", "alert", "william_tell", "rondo_alla_turca", "police_siren", "evacuation", "beep_beep", "beep", "inactive"]
| `entity_id` | yes | String or list of strings that point at `entity_id`s of siren/chime.

예시:

```yaml
script:
  execute_doorbell
    sequence:
      - service: wink.enable_chime
        data:
          tone: "doorbell"
```

### `set_siren_tone` 서비스

wink/set_siren_tone 서비스를 사용하여 Dome siren의 tone을 설정할 수 있습니다. 이 tone은 다음에 siren이 실행될 때 사용됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `tone` | no | String. One of ["doorbell", "fur_elise", "doorbell_extended", "alert", "william_tell", "rondo_alla_turca", "police_siren", "evacuation", "beep_beep", "beep"]
| `entity_id` | yes | String or list of strings that point at `entity_id`s of siren/chime.

예시:

```yaml
script:
  set_siren_to_alert:
    sequence:
      - service: wink.set_siren_tone
        data:
          tone: "alert"
```

### `set_siren_strobe_enabled` 서비스

wink/set_siren_strobe_enabled 서비스를 사용하여 siren이 실행될 때 strobe를 활성화 또는 비활성화 할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `enabled` | no | Boolean. True or False.
| `entity_id` | yes | String or list of strings that point at `entity_id`s of siren/chime.

예시:

```yaml
script:
  disable_siren_strobe:
    sequence:
      - service: wink.set_siren_strobe_enabled
        data:
          enabled: false
```

### `set_chime_strobe_enabled` 서비스

wink/set_chime_strobe_enabled 서비스를 사용하여 chime이 실행될 때 strobe를 활성화 또는 비활성화 할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `enabled` | no | Boolean. True or False.
| `entity_id` | yes | String or list of strings that point at `entity_id`s of chime/chime.

예시:

```yaml
script:
  disable_chime_strobe:
    sequence:
      - service: wink.set_chime_strobe_enabled
        data:
          enabled: false
```

### `set_nimbus_dial_state` 서비스

wink/set_nimbus_dial_state 서비스를 사용하여 개별 dial의 value/position 및 label을 업데이트 할 수 있습니다

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of strings that point at `entity_id`s of chime/chime.
| `value` | no | A number, should be between the dials min and max value (See set_nimbus_dial_configuration below)
| `labels` | yes | A list of strings the first being the value set on the dial's face and the second being the value on the dial face when the Nimbus is pressed

예시:

```yaml
script:
  set_dial_1_value:
    sequence:
      - service: wink.set_nimbus_dial_state
        data:
          entity_id: wink.nimbus_dial_1
          value: 150
          labels:
            - "Dial 1"
            - "150"
```

### `set_nimbus_dial_configuration` 서비스

wink/set_nimbus_dial_configuration 서비스를 사용하여 개별 dial의 설정을 업데이트 할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of strings that point at `entity_id`s of chime/chime.
| `rotation` | yes | One of "cw" or "ccw" the direction the dial hand should rotate.
| `ticks` | yes | A positive number, the number of times the hand should move.
| `scale` | yes | One of "linear" or "log" How the dial should move in response to higher values.
| `min_value` | yes | A number, the minimum value that the dial can have.
| `max_value` | yes | A number, the maximum value that the dial can have.
| `min_position` | yes | A number generally [0-360], the minimum position for the dial's hand.
| `max_value` | yes | A number generally [0-360], the maximum position for the dial's hand.

예시:

```yaml
script:
  set_dial_1_value:
    sequence:
      - service: wink.set_nimbus_dial_state
        data:
          entity_id: wink.nimbus_dial_1
          rotation: 'ccw'
```

## 경보 제어판 

Wink 경보 플랫폼을 사용하면 [Wink](https://www.wink.com/) Canary all-in-one security camera를 제어 할 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 장치

- Canary all-in-one security camera

<div class='note'>
위의 장치는 작동하는 것으로 확인되었지만 다른 장치도 작동 할 수 있습니다.
</div>

## Binary Sensor

Wink Binary Sensor 플랫폼을 사용하면 [Wink](https://www.wink.com/) Binary Sensor에서 데이터를 가져올 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 Binary sensor 장치

- Smoke and CO detectors (No Wink hub required for Nest)
- Window/Door sensors
- Motion sensors
- Ring Door bells (No hub required)
- Liquid presence sensors
- Z-wave lock key codes
- Lutron connected bulb remote buttons
- Wink Relay buttons and presence detection
- Wink spotter loudness and vibration (No Wink hub required)
- Wink hub devices connection status. This includes any paired hubs like Hue, Wink v1, Wink v2, Wink Relay...
- Dropcam sensors

<div class='note'>
위의 장치는 작동하는 것으로 확인되었지만 다른 장치도 작동할 수 있습니다.
</div>

## Climate

Wink Climate 플랫폼을 사용하면 [Wink](https://www.wink.com/) thermostats 및 air conditioners에서 데이터를 얻을 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 climate 장치

- Nest (No Wink hub required)
- Ecobee (No Wink hub required)
- Sensi (No Wink hub required)
- Carrier (Unconfirmed)
- Honeywell (No Wink hub required)
- Generic Z-Wave
- Quirky Aros window AC unit

<div class='note'>
위의 장치는 작동하는 것으로 확인되었지만 다른 장치도 작동 할 수 있습니다.
</div>

## Cover

Wink Cover garage door 기능은 제품에 따라 다릅니다. 홈어시스턴트는 GoControl/Linear opener의 상태를 열고 닫고 볼 수 있습니다. Chamberlain MyQ-enabled openers의 경우 홈어시스턴트는이 Wink Cover를 사용하는 경우에만 현재 상태 (open 혹은 closed)를 표시하도록 제한됩니다. 이 제한은 Chamberlain에 의해 제3자 통제로 맡겨져 있습니다. 윙크는 MyQ 고객이 권한 추가에 대해 Chamberlain에 직접 문의하고 제안해야 합니다. 

[MyQ Cover](/integrations/myq)는 MyQ-enabled garage doors을 열고 닫을 수 있는 모든 기능을 제공합니다. Wink Component와 함께 설치하면 garage doors 엔터티가 중복될 수 있습니다. 이 경우 semi-functional Wink garage doors 엔터티는 customize.yaml을 통해 숨길 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 cover 장치

- Bali window treatments
- Lutron shades
- Pella motorized blinds and shades
- GoControl garage door opener
- Chamberlain MyQ (Limited functionality) (No Wink hub required)

<div class='note'>
위의 장치는 작동하는 것으로 확인되었지만 다른 장치도 작동 할 수 있습니다.
</div>

## Fan

Wink Fan 플랫폼을 사용하면 [Wink](https://www.wink.com/) Fan을 제어 할 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 fan 장치

- Home Decorator Wink-enabled Gardinier ceiling fan
- Hampton Bay ceiling fan module

<div class='note'>
위의 장치는 작동하는 것으로 확인되었지만 다른 장치도 작동 할 수 있습니다.
</div>

## Light

`wink` Light 플랫폼을 사용하면 [Wink](https://www.wink.com/) Light를 사용할 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 light 장치

- Z-wave switches with dimming
- Hue
- Lightify
- GE link
- Wink light groups (User created groups of lights)

<div class='note'>
위의 장치는 작동하는 것으로 확인되었지만 다른 장치도 작동할 수 있습니다.
</div>

## Lock

Wink Lock 플랫폼을 사용하면 [Wink](https://www.wink.com/) Lock을 제어 할 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 lock 장치

- Kwikset
- Schlage
- August (No Wink hub required) (August Connect required)
- Generic Z-wave

<div class='note'>
다음 서비스는 Schlage lock에서만 확인되었습니다.
</div>

### `set_lock_alarm_mode` 서비스

wink/set_lock_alarm_mode 서비스를 사용하여 lock alarm mode를 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `mode` | no | String one of tamper, activity, or forced_entry
| `entity_id` | yes | String or list of strings that point at `entity_id`s of locks.

예시:

```yaml
script:
  set_locks_to_tamper:
    sequence:
      - service: wink.set_lock_alarm_mode
        data:
          mode: "tamper"
```

### `set_lock_alarm_sensitivity` 서비스

wink/set_lock_alarm_sensitivity 서비스를 사용하여 lock의 alarm sensitivity를 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `sensitivity` | no | String one of low, medium_low, medium, medium_high, high.
| `entity_id` | yes | String or list of strings that point at `entity_id`s of locks.

예시:

```yaml
script:
  set_locks_to_high_sensitivity:
    sequence:
      - service: wink.set_lock_alarm_sensitivity
        data:
          sensitivity: "high"
```

### `set_lock_alarm_state` 서비스

wink/set_lock_alarm_state 서비스를 사용하여 lock alarm state를 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `enabled` | no | Boolean enabled or disabled, true or false
| `entity_id` | yes | String or list of strings that point at `entity_id`s of locks.

예시:

```yaml
script:
  disable_all_locks_alarm:
    sequence:
      - service: wink.set_lock_alarm_state
        data:
          enabled: false
```

### `set_lock_beeper_state` 서비스

wink/set_lock_beeper_state 서비스를 사용하여 lock 신호음 상태를 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `enabled` | no | Boolean enabled or disabled, true or false
| `entity_id` | yes | String or list of strings that point at `entity_id`s of locks.

예시:

```yaml
script:
  disable_all_locks_beepers:
    sequence:
      - service: wink.set_lock_beeper_state
        data:
          enabled: false
```

### `set_lock_vacation_mode` 서비스

wink/set_lock_vacation_mode 서비스를 사용하여 lock의 vacation mode를 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `enabled` | no | Boolean enabled or disabled, true or false
| `entity_id` | yes | String or list of strings that point at `entity_id`s of locks.

예시:

```yaml
script:
  enabled_vacation_mode_on_all_locks:
    sequence:
      - service: wink.set_lock_vacation_mode
        data:
          enabled: false
```

### `add_new_lock_key_code` 서비스

wink/add_new_lock_key_code 서비스를 사용하여 Wink lock에 new user code를 추가할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of strings that point at `entity_id`s of locks.
| `name` | no | the name of the new key code
| `code` | no | The new code. Must match length of existing codes.

<div class='note'>
wink/pull_newly_added_wink_devices 서비스를 호출하면 new key code가 홈어시스턴트에 추가됩니다. 다음에 홈어시스턴트를 다시 시작할 때 장치가 나타납니다.
</div>

<div class='note'>
lock 장치가 지원하는 경우 정의한 각 user key code마다 binary sensor가 생성됩니다. 이 key code는 해당 code를 입력하면 켜지고 몇 초 후에 자동으로 꺼집니다.
</div>

## Sensor

Wink Sensor 플랫폼을 사용하면 [Wink](https://www.wink.com/) Sensor에서 데이터를 얻을 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야합니다.

### 지원 sensor 장치

- Wink Relay temperature, proximity, and humidity
- Wink Spotter temperature, humidity, and brightness (No Wink hub required)
- Wink Porkfolio balance (No Wink hub required)
- Wink eggminder (No Wink hub required)
- Nest protect Smoke and CO severity (No confirmation that this is actually reported) (No Wink hub required)
- Motion sensor temperature
- Quirky refuel propane tank monitor (No Wink hub required)

<div class='note'>
위의 장치는 작동하는 것으로 확인되었지만 다른 장치도 작동 할 수 있습니다.
</div>

## Switch

Wink Switch 플랫폼을 사용하면 [Wink](https://www.wink.com/) Switch를 제어할 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야한다는 것입니다.

## 지원 switch 장치

- Wink Pivot power genius (No Wink hub required)
- non-dimming Z-wave in-wall switches (dimming switches show up as lights)
- Wink Relay load controlling switches
- Rachio sprinkler controller (No Wink hub required)
- iHome smart plug (No Wink hub required)
- Wink switch groups (User created groups of switches)

## Water heater

Wink water heater 플랫폼을 사용하면 [Wink](https://www.wink.com/) water heater에서 데이터를 얻을 수 있습니다.

요구 사항은 위에서 [Wink](/integrations/wink/)를 설정해야한다는 것입니다.

## 지원하는 water heaters

- Rheem Econet water heaters (No Wink hub required)

<div class='note'>

Wink water heaters는 홈어시스턴트 0.81을 이전 버전은 `climate` 플랫폼으로 사용합니다.
</div>
