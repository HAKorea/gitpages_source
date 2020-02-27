---
title: 홈킷
description: Instructions on how to set up the HomeKit integration in Home Assistant.
ha_category:
  - Voice
ha_release: 0.64
logo: apple-homekit.png
---

`homekit` 통합구성요소는 애플의 홈앱과 Siri에서 제어할 수 있도록 애플 HomeKit에 홈어시스턴트에서 entity들을 전달할 수 있습니다. 나중에 문제를 해결하기 위해 아래 나열된 [고려 사항](#consideration)을 읽었는지 확인하십시오. 그러나 문제가 발생하면 [문제해결](#troubleshooting) 섹션을 확인 하십시오. 

<div class="note">

  홈어시스턴트로 `HomeKit` 장치만 제어 하려면, [HomeKit controller](/integrations/homekit_controller/) 구성 요소를 확인하십시오.

</div>

<div class="note warning">

  추가 패키지를 설치해야 할 수도 있습니다. :
  `sudo apt-get install libavahi-compat-libdnssd-dev`

</div>

```yaml
# Example configuration.yaml entry configuring HomeKit
homekit:
  filter:
    include_domains:
      - alarm_control_panel
      - light
      - media_player
    include_entities:
      - binary_sensor.living_room_motion
  entity_config:
    alarm_control_panel.home:
      code: 1234
    binary_sensor.living_room_motion:
      linked_battery_sensor: sensor.living_room_motion_battery
      low_battery_threshold: 31
    light.kitchen_table:
      name: Kitchen Table Light
    lock.front_door:
      code: 1234
    media_player.living_room:
      feature_list:
        - feature: on_off
        - feature: play_pause
        - feature: play_stop
        - feature: toggle_mute
    switch.bedroom_outlet:
      type: outlet
```

{% configuration %}
  homekit:
    description: HomeKit configuration.
    required: true
    type: map
    keys:
      auto_start:
        description: Home Assistant Core 설정이 완료된 후 HomeKit 서버가 자동으로 시작되어야하는지 여부를 표시. ([Disable Auto Start](#disable-auto-start))
        required: false
        type: boolean
        default: true
      port:
        description: HomeKit 확장을 위한 포트입니다.
        required: false
        type: integer
        default: 51827
      name:
        description: 동일한 로컬 네트워크에서 연동을 사용하여 각 홈어시스턴트 인스턴스마다 개별적이어야합니다. `3` 에서 `25`의 문자열들. 문자, 영숫자와 공백이 허용됩니다.
        required: false
        type: string
        default: '`Home Assistant Bridge`'
      ip_address:
        description: 로컬 네트워크 IP 주소 홈어시스턴트의 기본값이 작동하지 않는 경우에만 필요합니다.
        required: false
        type: string
      safe_mode:
        description: 페어링 중에 문제가 발생하는 경우에만 이 매개 변수를 설정하십시오. ([Safe Mode](#safe-mode)).
        required: false
        type: boolean
        default: false
      advertise_ip:
        description: mDNS 알림에 사용된 IP 주소를 재정의해야하는 경우. (예를 들어, Docker에서 네트워크 격리하여 사용하고 `avahi-daemon` reflector 모드 처럼 mDNS Forwarder와 함께 사용하는 경우).
        required: false
        type: string
      filter:
        description: HomeKit에서 포함 / 제외할 entity를 필터링합니다. ([Configure Filter](#configure-filter)).
        required: false
        type: map
        keys:
          include_domains:
            description: 포함할 domain들.
            required: false
            type: list
          include_entities:
            description: 포함할 Entity들. 
            required: false
            type: list
          exclude_domains:
            description: 제외할 domain들.
            required: false
            type: list
          exclude_entities:
            description: 제외할 Entity들.
            required: false
            type: list
      entity_config:
        description: 특정 entity에 대한 설정. 모든 종속된 key들은 domain들에 해당하는 endtity id 입니다. 예:) `alarm_control_panel.alarm`.
        required: false
        type: map
        keys:
          '`<ENTITY_ID>`':
            description: 특정 entity에 대한 추가 옵션.
            required: false
            type: map
            keys:
              name:
                description: HomeKit에 표시할 entity의 이름입니다. HomeKit은 첫 실행시 액세서리의 기능 세트를 캐시하므로 변경 사항을 적용하려면 장치를 [reset](#resetting-accessories) 해야 합니다.
                required: false
                type: string
              linked_battery_sensor:
                description: entity `sensor` 의 `entity_id`는 액세서리의 배터리로 사용할 수 있습니다. HomeKit은 첫 실행시 액세서리 기능 세트를 캐시하므로 변경 사항을 적용하려면 장치를 [reset] (# resetting-accessories)해야합니다.
                required: false
                type: string
              low_battery_threshold:
                description: 액세서리가 배터리 부족을보고하기 전에 최소 배터리 수준.
                required: false
                type: integer
                default: 20
              code:
                description: 알람 (`arm / disarm`) 혹은 잠금장치 (`lock / unlock`)으로 code를 사용. `alarm_control_panel` 혹은 `lock` entity에만 해당.
                required: false
                type: string
                default: '`<No code>`'
              feature_list:
                description: entity(`media_player`)만 해당. 주어진 entity에 추가할 기능 확인 목록입니다. 플랫폼 스키마와 비교할 수 있습니다.
                required: false
                type: list
                keys:
                  feature:
                    description: entity 표시에 추가 할 기능의 이름입니다. 유효한 기능은 `on_off`, `play_pause`, `play_stop` 그리고 `toggle_mute` 입니다. media_player entity는 이 기능이 유효하도록 지원해야합니다.
                    required: true
                    type: string
              type:
                description: entity (`switch`)에만 해당.  HomeKit 내에서 생성 할 액세서리 유형. 유효한 유형으로는 `faucet`, `outlet`, `shower`, `sprinkler`, `switch` 그리고 `valve`. HomeKit은 첫 실행시 타입을 캐시하므로 변경 사항을 적용하려면 장치를 [reset](#resetting-accessories) 해야 합니다.
                required: false
                type: string
                default: '`switch`'
{% endconfiguration %}


## 설정

홈어시스턴트에서 HomeKit 통합구성요소를 사용하려면 configuration 파일에 다음을 추가하십시오.:

```yaml
# Example for HomeKit setup
homekit:
```

홈어시스턴트가 시작된 후, 필터로 특정한 entity들은 [supported](#supported-components)되기만 하면 나타납니다. 다음은 이들을 추가하는 방법입니다. :

1. 홈어시스턴트 프론트엔드를 여십시오. 새 카드에 `pin code` 가 표시됩니다 . 참고 : 핀 코드가 표시되지 않으면 홈어시스턴트 UI의 왼쪽 아래에서 "알림"(종 모양 아이콘)을 확인하십시오.
2. `Home` 앱을 엽니다.
3. `Add Accessory`를 클릭한 다음 `Don't Have a Code or Can't Scan?`을 선택, `Home Assistant Bridge`를 선택하십시오.
4. `Add Anyway`를 클릭해서 `Uncertified Accessory`를 추가하도록 하십시오. 
5. `PIN` 코드를 입력하십시오.
6. 화면에 따라 `Next` 를 클릭, 상단의 오른쪽 모서리에 `Done` 을 클릭하십시오. 
7. `홈어시스턴트` Bridge 와 액세서리는 `Home` 앱에 나오게 됩니다. 

설정이 완료되면 애플의 홈앱 및 Siri를 통해 홈어시스턴트 연동으로 제어 할 수 있게 됩니다.

## 홈어시스턴트 설치로 이동

새로운 홈어시스턴트 장치로 이동하거나 설치하여 HomeKit 페어링을 유지하려면 구성 파일을 복사하는 것 외에도 configuration 디렉토리 안에 `.homekit.state` 파일 을 복사해야합니다. 운영 체제에 따라 파일이 기본적으로 숨겨져 있음을 명심하십시오.

복사하기 전에 먼저 홈어시스턴트 인스턴스를 완전히 중지하십시오. 그렇지 않으면 작동하지 않습니다.

## 고려 사항

### 액세서리 ID

현재 이 통합구성요소는 고유한 `HomeKit`을 위한 `accessory id (aid)`를 생성해내기 위해서 `entity_id`를 사용합니다. `aid`는 모든 구성 장치를 식별하고 저장하는 데 사용됩니다. 하지만 만일 이 액세서리를 위한 모든 설정을 갖고 있는 `entity_id`가 변경될 경우 `home` 앱에서는 사라지게 됩니다. 

### 기기 제한

HomeKit 가이드 라인는 브리지 당 최대 100 개의 고유 한 액세서리만 허용합니다.  필터를 구성할 때 이 점에 유의하십시오.

### 지속적인 저장

불행하게도 `HomeKit` 지속적인 저장 역할은 지원하지 않습니다 - `Home Assistant Bridge`에 추가 된 액세서리의 구성 만 유지됩니다. 문제를 피하기 위해서, 적어도 entity 셋업이 되어있는 상태에서 `homekit`이 항상 시작되도록 자동화를 사용할 것을 권장합니다. 만일 어떤 이유로 일부 엔티티가 설정되지 않았다면 해당 설정이 삭제됩니다. (알 수없는 상태 또는 비슷한 상태는 문제를 일으키지는 않습니다.)

테스트를 위해 설정의 일부를 비활성화하기로 결정 할지 말지가, 일반적인 상황이 될 수 있습니다. `auto start`, `turn off`, `Start HomeKit` 자동화가 (하나라도 있을 경우) 비활성화시킬 것을 꼭 확인하십시오.


## 자동 시작 비활성화

설정에 따라, 사용할 수있는 모든 `HomeKit` 액세서리의 `Auto Start`를 비활성화해야 할 수도 있습니다. `HomeKit` 연동이 시작될 때 모든것이 설정된 entity만 추가 할 수 있습니다. `auto_start: false`일 경우 `HomeKit`을 시작하려면, `homekit.start` service를 호출하면 됩니다..

HomeKit에 노출하려는 Z-Wave entity가 있는 경우 자동 시작을 비활성화 한 다음 Z-Wave mesh가 준비된 후 시작해야합니다. Z-Wave entity는 그때까지 완전히 설정되지 않기 때문입니다. 이는 자동화를 사용하면 자동으로 실행시킬 수 있습니다. 
<div class='note'>

하나의 `automation` 항목만 가질 수 있습니다. 기존 자동화에 자동화를 추가하십시오.

</div>

{% raw %}
```yaml
# Example for Z-Wave
homekit:
  auto_start: false

automation:
  - alias: 'Start HomeKit'
    trigger:
      - platform: event
        event_type: zwave.network_ready
      - platform: event
        event_type: zwave.network_complete
      - platform: event
        event_type: zwave.network_complete_some_dead
    action:
      - service: homekit.start
```
{% endraw %}

연동시 이벤트를 생성하지 않는 일반적인 지연의 경우 다음을 수행 할 수 있습니다. :

{% raw %}
```yaml
# Example using a delay after the start of Home Assistant
homekit:
  auto_start: false

automation:
  - alias: 'Start HomeKit'
    trigger:
      - platform: homeassistant
        event: start
    action:
      - delay: 00:05  # Waits 5 minutes
      - service: homekit.start
```
{% endraw %}

경우에 따라 `HomeKit`을 시작하기 전에 모든 엔터티를 사용할 수 있는지 확인하는 것이 좋습니다. 다음과 같이 추가적인 `binary_sensor`를 추가 할 수 있습니다. :

{% raw %}
```yaml
# Example checking specific entities to be available before start
homekit:
  auto_start: false

automation:
  - alias: 'Start HomeKit'
    trigger:
      - platform: homeassistant
        event: start
    action:
      - wait_template: >-
          {% if not states.light.kitchen_lights %}
            false
          {% elif not states.sensor.outside_temperature %}
            false
          # Repeat for every entity
          {% else %}
            true
          {% endif %}
        timeout: 00:15  # Waits 15 minutes
        continue_on_timeout: false
      - service: homekit.start
```
{% endraw %}

## 필터 설정

기본적으로 entity는 제외되지 않습니다. `HomeKit`에 노출되는 엔터티를 제한하기 위해, `filter` 파라미터를 사용할 수 있습니다. [supported components](#supported-components) 만 추가할 수 있다는 것을 상기하십시오.

{% raw %}
```yaml
# Example filter to include specified domains and exclude specified entities
homekit:
  filter:
    include_domains:
      - alarm_control_panel
      - light
    exclude_entities:
      - light.kitchen_light
```
{% endraw %}

필터는 다음과 같이 적용됩니다. :

1. No includes or excludes - 모든 entity 전달
2. Includes, no excludes - 지정된 entity만 포함
3. Excludes, no includes - 지정된 entity만 제외
4. Both includes and excludes:
   * 지정된 domain 포함
      - domain이 포함되고 entity가 제외되지 않은 경우 전달
      - domain이 포함되지 않고 entity가 포함되지 않은 경우 실패
   * Exclude domain specified
      - domain이 제외되고 entity가 포함되지 않은 경우 실패
      - domain이 제외되지 않고 entity가 제외되지 않은 경우 전달
      - 포함 및 제외 domain이 모두 지정된 경우 제외 domain은 무시됩니다.
   * Neither include or exclude domain specified
      - entity가 포함되어 있으면 위의 # 2와 같이 전달하십시오
      - entity 포함 및 제외 인 경우 entity 제외가 무시됩니다.

## 안전 모드

페어링시 문제가 발생하는 경우 `safe_mode` 옵션만 사용되야 합니다(어짜피 이 옵션만 작동). ([Pairing hangs - zeroconf error](#pairing-hangs---zeroconf-error)).

`safe_mode`를 사용하려면, `homekit` 설정에 다음을 추가하십시오. :

```yaml
homekit:
  safe_mode: true
```

홈어시스턴트 인스턴스를 다시 시작하십시오. `pincode`가 보이지 않으면, 여기 [guide](#deleting-the-homekitstate-file)를 따르십시오. 이제 정상적으로 페어링 할 수 있습니다.

<div class="note warning">

오류를 방지하려면, 홈어시스턴트 Bridge를 성공적으로 페어링 한 후, 설정에서 `safe_mode` 옵션을 삭제하고 홈어시스턴트를 재시작 하십시오. 

</div>

## Docker 네트워크와의 격리

`advertise_ip` 옵션은 예를 들어 호스트 네트워크를 사용하지 않고도 네트워크 격리가 활성화 된 임시 Docker 컨테이너 내에서 조차도 이러한 연동을 실행하는 데 사용할 수 있습니다.

`advertise_ip` 사용하기 위해서, `homekit` 옵션을 다음과 같이 추가하십시오. :

```yaml
homekit:
  advertise_ip: "STATIC_IP_OF_YOUR_DOCKER_HOST"
```

홈어시스턴트 인스턴스를 다시 시작하십시오. 이 기능을 사용하려면 Docker 호스트에서 mDNS 전달자를 실행해야합니다, (예 : avahi-daemon 리플렉터 모드). 이러한 종류의 bridge 설정을 하는 동안, `safe_mode`를 가장 많이 필요로 합니다. 

## 지원되는 구성 요소

현재 다음 연동이 지원됩니다.:

| Component                                            | Type Name             | Description                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ---------------------------------------------------- | --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| alarm_control_panel                                  | SecuritySystem        | All security systems.                                                                                                                                                                                                                                                                                                                                                                                                                        |
| automation / input_boolean / remote / scene / script | Switch                | All represented as switches.                                                                                                                                                                                                                                                                                                                                                                                                                 |
| binary_sensor                                        | Sensor                | Support for `co2`, `door`, `garage_door`, `gas`, `moisture`, `motion`, `occupancy`, `opening`, `smoke` and `window` device classes. Defaults to the `occupancy` device class for everything else.                                                                                                                                                                                                                                            |
| climate                                              | Thermostat            | All climate devices.                                                                                                                                                                                                                                                                                                                                                                                                                         |
| cover                                                | GarageDoorOpener      | All covers that support `open` and `close` and have `garage` as their `device_class`.                                                                                                                                                                                                                                                                                                                                                        |
| cover                                                | WindowCovering        | All covers that support `set_cover_position`.                                                                                                                                                                                                                                                                                                                                                                                                |
| cover                                                | WindowCovering        | All covers that support `open_cover` and `close_cover` through value mapping. (`open` -> `>=50`; `close` -> `<50`)                                                                                                                                                                                                                                                                                                                           |
| cover                                                | WindowCovering        | All covers that support `open_cover`, `stop_cover` and `close_cover` through value mapping. (`open` -> `>70`; `close` -> `<30`; `stop` -> every value in between)                                                                                                                                                                                                                                                                            |
| device_tracker / person                              | Sensor                | Support for `occupancy` device class.                                                                                                                                                                                                                                                                                                                                                                                                        |
| fan                                                  | Fan                   | Support for `on / off`, `direction` and `oscillating`.                                                                                                                                                                                                                                                                                                                                                                                       |
| fan                                                  | Fan                   | All fans that support `speed` and `speed_list` through value mapping: `speed_list` is assumed to contain values in ascending order. The numeric ranges of HomeKit map to a corresponding entry of `speed_list`. The first entry of `speed_list` should be equivalent to `off` to match HomeKit's concept of fan speeds. (Example: `speed_list` = [`off`, `low`, `high`]; `off` -> `<= 33`; `low` -> between `33` and `66`; `high` -> `> 66`) |
| light                                                | Light                 | Support for `on / off`, `brightness` and `rgb_color`.                                                                                                                                                                                                                                                                                                                                                                                        |
| lock                                                 | DoorLock              | Support for `lock / unlock`.                                                                                                                                                                                                                                                                                                                                                                                                                 |
| media_player                                         | MediaPlayer           | Represented as a series of switches which control `on / off`, `play / pause`, `play / stop`, or `mute` depending on `supported_features` of entity and the `mode` list specified in `entity_config`.                                                                                                                                                                                                                                         |
| media_player                                         | TelevisionMediaPlayer | All media players that have `tv` as their `device_class`.  Represented as Television and Remote accessories in HomeKit to control `on / off`, `play / pause`, `select source`, or `volume increase / decrease`, depending on `supported_features` of entity. Requires iOS 12.2/macOS 10.14.4 or later.                                                                                                                                       |
| sensor                                               | TemperatureSensor     | All sensors that have `Celsius` or `Fahrenheit` as their `unit_of_measurement` or `temperature` as their `device_class`.                                                                                                                                                                                                                                                                                                                     |
| sensor                                               | HumiditySensor        | All sensors that have `%` as their `unit_of_measurement` and `humidity` as their `device_class`.                                                                                                                                                                                                                                                                                                                                             |
| sensor                                               | AirQualitySensor      | All sensors that have `pm25` as part of their `entity_id` or `pm25` as their `device_class`                                                                                                                                                                                                                                                                                                                                                  |
| sensor                                               | CarbonMonoxideSensor  | All sensors that have `co` as their `device_class`                                                                                                                                                                                                                                                                                                                                                                                           |
| sensor                                               | CarbonDioxideSensor   | All sensors that have `co2` as part of their `entity_id` or `co2` as their `device_class`                                                                                                                                                                                                                                                                                                                                                    |
| sensor                                               | LightSensor           | All sensors that have `lm` or `lx` as their `unit_of_measurement` or `illuminance` as their `device_class`                                                                                                                                                                                                                                                                                                                                   |
| switch                                               | Switch                | Represented as a switch by default but can be changed by using `type` within `entity_config`.                                                                                                                                                                                                                                                                                                                                                |
| water_heater                                         | WaterHeater           | All `water_heater` devices.                                                                                                                                                                                                                                                                                                                                                                                                                  |

## 문제 해결

### `.homekit.state` 파일 삭제

`.homekit.state` 파일은 구성 디렉토리에서 찾을 수 있습니다. 이를 보기 위해 `view hidden files` 를 활성화 시켜야 할 수 있습니다.

 1. 홈어시스턴트 **Stop** 
 2. `.homekit.state` 파일 삭제
 3. 홈어시스턴트 **Start** 

### 페어링 중 오류

페어링 중에 문제가 발생하면 다음을 확인하십시오 :

 1. 홈어시스턴트 **Stop**
 2. `.homekit.state` 파일 삭제
 3. configuaration 편집 (아래 참조)
 4. 홈어시스턴트 **Start** 

```yaml
logger:
  default: warning
  logs:
    homeassistant.components.homekit: debug
    pyhap: debug

homekit:
  filter:
    include_entities:
      - demo.demo
```

#### PIN이 지속적 상태로 표시되지 않습니다

`Home Assistant Bridge` 이미 페어링했을 수 있습니다. 그렇지 않은 경우, `.homekit.state` 파일을 삭제하십시오. ([guide](#deleting-the-homekitstate-file)).

#### 홈 어시스턴트 브리지가 홈 앱에 나타나지 않음 (페어링)

이것은 종종 설정 및 네트워크와 관련이 있습니다. 아래의 다른 외부 환경 문제도 확인해 볼 수 있습니다. :

- 라우터 설정 확인
- WiFi **와** LAN을 모두 사용해보십시오. 
- 기본 포트 변경 [port](#port)

iOS 기기는 페어링을 위해 홈 어시스턴트 기기와 동일한 로컬 네트워크에 있어야합니다.

#### `홈어시스턴트 브리지`가 홈 앱에 나타나지 않음 (페어링) - Docker

`network_mode: host`를 설정하십시오. 추가 문제가있는 경우 [issue](https://github.com/home-assistant/home-assistant/issues/15692) 가 도움이 될 것입니다.

`advertise_ip` 옵션과 함께 `avahi-daemon` 리플렉터 모드에서 사용을 시도해볼 수 있습니다 (위 참조).

#### `홈어시스턴트 브리지`가 홈 앱 (페어링)에 표시되지 않음 - VirtualBox

`networkbridge`로 네트워크 모드를 설정하십시오. 그렇지 않으면 홈어시스턴트 bridge가 네트워크에 노출되지 않습니다.

#### 페어링 중단 - zeroconf 오류

결국 페어링에 실패하면 `NonUniqueNameException` 오류 메시지가 표시 될 수 있습니다. `safe_mode` 옵션을 설정에 추가 하십시오, [safe_mode](#safe-mode) 참조.

#### 페어링 중단 - 디버그 설정에서만 작동

`demo.demo`를 포함하여 세팅 했을 때 페어링은 잘 동작합니다, 일반 설정에서는 동작하지 않습니다. [specific entity doesn't work](#specific-entity-doesnt-work) 참조.

#### 페어링 중단 - 에러 없음

1. 100 개가 넘는 액세서리를 추가하지 마십시오,  [device limit](#device-limit) 참조. 드물기는하지만 entity 중 하나가 HomeKit 통합구성요소와 작동하지 않습니다. [filter](#configure-filter)를 사용하여 어느것인지 찾을 수 있습니다. `home-assistant` 리포지토리에서 새로운 문제를 자유롭게 열어, 어떤 문제인지 해결할 수 있습니다. 
2.  `Starting accessory Home Assistant Bridge on address` 로그를 확인하고을 검색하십시오. 홈어시스턴트 브리지가 올바른 인터페이스에 연결되어 있는지 확인하십시오. 그렇지 않은 경우, `homekit.ip_address` 설정 변수를 명시하여 설정 하십시오.

#### 액세서리를 추가하려고 할 때 중복 된 AID가 발견

두 entity가 `entity_id`를 동일하게 공유합니다. 이를 해결하거나 제외하도록 [filter](#configure-filter) 를 설정하십시오.

### 정상적인 사용시 문제

#### 내 기기 중 일부가 표시되지 않음 - Z-Wave / Discovery

[disable auto start](#disable-auto-start) 참조

#### 내 entity가 표시되지 않습니다

entity의 도메인이 [supported](#supported-components)되는지 확인하십시오. 그렇다면, [filter](#configure-filter) 설정을 확인하십시오.  특히 `include_entities`를 사용하는 경우, 철자가 올바른지 확인하십시오.

#### HomeKit은 두 번째 홈어시스턴트 인스턴스에서 작동하지 않습니다

동일한 로컬 네트워크에서 다른 홈어시스턴트 인스턴스와 HomeKit 연동 사용하려면 하나 이상의 사용자 정의 이름을 설정해야합니다. [config/name](#name)

#### 특정 엔티티가 작동하지 않습니다

최선을 다하고 있지만, 일부 entity는 아직 HomeKit 통합에서 작동하지 않습니다. 그 결과 페어링이 완전히 실패하거나 모든 홈 어시스턴트 액세서리가 작동을 멈출 수 있습니다. 필터를 사용하여 문제를 일으키는 entity를 식별하십시오. 더 많은 entity를 포함하여 단계별로 페어링을 시도하는 것이 가장 좋습니다. 연결이 끊어지면 문제의 원인이 될 때까지 반복하십시오. 다른 사람과 개발자를 돕기 위해 여기에서 issue 를 여십시오.: [home-assistant/issues/new](https://github.com/home-assistant/home-assistant/issues/new?labels=component:%20homekit)

#### 액세서리가 모두 응답하지 않는 것으로 표시됨

참조 [specific entity doesn't work](#specific-entity-doesnt-work)

#### 액세서리가 응답하지 않음 - 재시작 또는 업데이트 후

참조 [device limit](#device-limit)

#### 액세서리가 응답하지 않음 - 임의로

불행히도, 이는 종종 발생합니다.  `Home` 앱 을 닫고 캐시에서 삭제하는 것이 도움이 될 수 있습니다. 일반적으로 액세서리는 최대 몇 분 후에 다시 응답합니다.

#### 액세서리가 응답하지 않거나 비정상적인 동작 - `0.65.x`에서 업그레이드

이 문제를 해결하려면의 `Home Assistant Bridge` 페어링을 해제, `.homekit.state` 파일을 삭제하고 ([guide](#deleting-the-homekitstate-file)) 다시 페어링 합니다. `0.65.x` 또는 이하에서 업그레이드하는 경우에만 문제가 됩니다.

#### 연결된 배터리 센서가 인식되지 않습니다

HomeKit에서 entity를 제거한 후 다시 추가하십시오. HomeKit의 기존 엔터티에이 구성 옵션을 추가하는 경우 액세서리를 HomeKit에서 제거한 다음 다시 추가 할 때까지이 엔터티의 구성 옵션에 대한 변경 내용이 표시되지 않습니다. [resetting accessories](#resetting-accessories)를 참조하십시오.

#### 미디어 플레이어가 TV 액세서리로 표시되지 않습니다

미디어 플레이어 `device_class: tv` entity는  iOS 12.2 / macOS 10.14.4 이상을 실행하는 기기에서 텔레비전 액세서리로 표시됩니다. 필요한 경우, 특히 이전에 `media_player`가 일련의 스위치로 노출 된 경우 HomeKit에서 entity를 제거한 다음 다시 추가하십시오. 지원되는 기능 변경을 포함하여 기존 액세서리에 대한 변경 사항은 HomeKit에서 액세서리를 제거한 다음 다시 추가 할 때까지 나타나지 않습니다.  [resetting accessories](#resetting-accessories) 참조.

#### TV 미디어 플레이어의 볼륨을 조절할 수 없습니까?

볼륨 및 재생 / 일시 정지 제어가 원격 앱 또는 제어 센터에 표시됩니다. TV가 홈어시스턴트를 통한 볼륨 조절을 지원하는 경우 화면에서 리모컨을 선택한 상태에서 장치의 측면 볼륨 버튼을 사용하여 볼륨을 조절할 수 있습니다.

#### 액세서리 재설정

홈어시스턴트 `0.97.x` 혹은 이후, 에서는 하나 이상의 entity_id와 함께 `homekit.reset_accessory` 서비스 를 사용하여 설정이 변경되었을 수있는 액세서리를 재설정 할 수 있습니다. media_player의 장치 클래스에서 `tv`로 변경했을 때 혹은 기존 entity에 새로운 HomeKit 기능에 대한 지원을 추가 할 때 유용합니다.

이전 버전의 홈어시스턴트에서는, (via [filter](#configure-filter))를 통해 HomeKit에서 entity를 제거한 다음 액세서리를 다시 추가하여 액세서리를 재설정 할 수 있습니다.

어느쪽이든, 액세서리를 처음 설치 한 것처럼 액세서리가 작동하므로, 이름, 그룹, 회의실, 장면 및 / 또는 자동화 설정을 복원해야합니다.