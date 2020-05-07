---
title: 스마트씽즈(Smarthings)
description: Instructions on setting up Samsung SmartThings within Home Assistant.
featured: true
logo: samsung_smartthings.png
ha_category:
  - Hub
  - Binary Sensor
  - Climate
  - Cover
  - Fan
  - Light
  - Lock
  - Sensor
  - Scene
  - Switch
ha_release: 0.87
ha_iot_class: Cloud Push
ha_config_flow: true
ha_codeowners:
  - '@andrewsayre'
---

SmartThings는 SmartThings Cloud API를 통해 Home Assistant에 연동됩니다. 이 통합구성요소의 기능은 다음과 같습니다.

1. SmartThings 디바이스를 Home Assistant 엔티티로 제어 ([지원되는 디바이스 및 기능에 대한 플랫폼 참조](#platforms)).
1. SmartThings에서 변경된 경우 Home Assistant를 다시 시작하면 엔티티가 자동으로 동기화됩니다. 
1. 홈어시스턴트에서 각각 통합구성요소 인스턴스로 표시되는 여러 SmartThings 계정과 위치를 지원합니다.
1. 브로커, 브릿지 또는 추가 종속성이 없습니다.

**최근 Smarthings의 연동방법이 쉽고 간편해졌습니다. ** 이를 연동한 HA카페의 [레이군님 게시물](https://cafe.naver.com/koreassistant/1476)을 참조하세요.  

## 전제 조건

1. SmartThings [개인용 액세스 토큰](https://account.smartthings.com/tokens). 
1. 인터넷에 접속할 수 있는 수신 웹후크 혹은 홈어시스턴트 클라우드 구독 활성화.

### 개인용 액세스 토큰 (PAT)

PAT는 통합구성요소 설정 중에 SmartThings 계정에서 Home Assistant SmartApp을 작성하는데 사용됩니다.

1. [개인 액세스 토큰 페이지](https://account.smartthings.com/tokens)에 로그인하여 '[새 토큰 생성](https://account.smartthings.com/tokens/new)'을 클릭하십시오.
1. 토큰 이름을 입력하고 (예: 'Home Assistant') 다음과 같이 인증된 범위(scopes)를 선택하십시오. :
    - Devices (all)
    - Installed Apps (all)
    - Locations (all)
    - Apps (all)
    - Schedules (all)
    - Scenes (all)
1. '토큰 생성'을 클릭하십시오. 토큰이 표시되면 다시 검색할 수 없으므로 안전한 곳에 저장하십시오 (예: 키 저장소).

### 웹후크 (Webhook)

이 통합구성요소에는 SmartThings에서 푸시 업데이트를 수신하려면 인터넷에 접속할 수 있는 수신 웹후크가 필요합니다. 추천하는 방법은 [Home Assistant Cloud (Nabu Casa)](https://www.nabucasa.com/)에 가입하는 것이며 통합구성요소는 클라우드 후크를 자동으로 설정하고 사용합니다. 또 다른 방법으로는 아래 설명과 같이 Home Assistant에서 인터넷 접속 가능한 웹 후크를 구성하고 설정해야합니다. : 

1. SSL로 보안된 도메인 이름을 통해 [remote access](/docs/configuration/remote/)를 설정하십시오. *자체 서명된 SSL 인증서는 SmartThings Cloud API에서 지원되지 않습니다.*
1. [HTTP 통합구성요소의 `base_url`](/integrations/http#base_url)을 홈어시스턴트가 인터넷에서 사용 가능한 URL로 설정하십시오. (`https://`로 시작해야합니다)

## 셋업 지침

위의 전제 조건 단계를 완료하면 연동을 설정할 준비가 되었습니다! 연동 설정에 문제가 있는 경우 [문제 해결](#troubleshooting)을 참조하십시오.

1. 홈어시스턴트에서 '설정'과 '통합구성요소'로 이동하십시오. 더하기 아이콘을 클릭하고 'SmartThings'를 입력/선택하십시오.
1. Home Assistant Cloud를 사용하는 경우 `https://hooks.nabuca.casa`로 시작합니다. URL이 올바르지 않으면 홈어시스턴트 설정을 업데이트하고 다시 시작한 후 다시 시도하십시오.
1. 개인 액세스 토큰을 입력하십시오.
1. SmartThings 위치를 선택하여 Home Assistant에 추가하십시오.
1. 열리는 창에서 :
   1. SmartThings 계정으로 로그인하십시오 (아직 로그인하지 않은 경우).
   1. 선택적으로 표시 이름을 변경하고 화면 오른쪽 상단의 '완료'를 클릭하십시오.
   1. 화면 오른쪽 하단의 '허용'을 클릭하여 통합을 승인하십시오.
   1. '창 닫기'를 클릭하거나 필요한 경우 수동으로 닫으십시오.
1. 홈어시스턴트로 돌아가 '마침'을 클릭하십시오.

<div class='note info'>

SmartThings 계정 혹은 위치를 추가 연동하려면 위 단계를 반복하십시오.

</div>

## 제거 지침

Home Assistant에서 통합구성요소를 제거하려면 Home Assistant 통합구성요소 페이지에서 인스턴스를 선택하고 오른쪽 상단 모서리에있는 휴지통 아이콘을 클릭하십시오. 또는 SmartThings 애플리케이션 내의 위치에서 SmartApp을 제거할 수 있습니다. 연동을 설정한 홈어시스턴트 인스턴스가 더 이상 실행되지 않거나 작동하지 않는 경우 이 [SmartThings 계정에서 갈길을 잃은 SmartApp 제거 유틸리티](https://pypi.org/project/hass-smartthings-remove/)를 사용해야합니다. 

## Events

SmartThings 통합구성요소는 일부 장치 기능에 대한 이벤트를 트리거합니다.

### smartthings.button

통합구성요소는 [버튼](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Button) 기능이 있는 장치가 작동될 때 이벤트를 트리거하고 Home Assistant 내에서 자동화를 트리거하는 데 사용될 수 있습니다. 아래는 데이터 페이로드의 예입니다. : 

```json
{
  "component_id": "main",
  "device_id": "42a16cf2-fef7-4ee8-b4a6-d32cb65474b7",
  "location_id": "2a54b9fa-f66c-42d9-8488-d8f036b980c8",
  "value": "pushed",
  "name": "Scene Button"
}
```

| Attribute      | Description                                                                                                                                                                                                                                |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `component_id` | Describes which integration of the device triggered the event. `main` represents the parent device. For devices with child-devices, this attribute identifies the child that raised the event.                                             |
| `device_id`    | The unique id of the device in SmartThings. This can be located in the Home Assistant device registry or in the [SmartThings Developer Workspace](https://smartthings.developer.samsung.com/workspace/).                                   |
| `location_id`  | The unique id of the location the device is part of. This can be found in the configuration entry registry or in the [SmartThings Developer Workspace](https://smartthings.developer.samsung.com/workspace/).                                     |
| `value`        | Describes the action taken on the button. See the [button](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Button) capability reference for a list of possible values (not all are supported by every device). |
| `name`         | The name given to the device in SmartThings.                                                                                                                                                                                               |

이벤트 데이터 페이로드는 debug level에서 기록됩니다. 자세한 내용은 [debugging](#debugging)을 참조하십시오.

## Platforms

SmartThings는 장치를 [capabilities](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html) 세트로 나타내고 SmartThings 통합구성요소는 Home Assistant에서 엔티티 플랫폼에 장치를 매핑합니다. 단일 장치는 하나 이상의 플랫폼으로 표현될 수 있습니다.

- [Binary Sensor](#binary-sensor)
- [Climate](#climate)
- [Cover](#cover)
- [Fan](#fan)
- [Light](#light)
- [Lock](#lock)
- [Sensor](#sensor)
- [Scene](#scene)
- [Switch](#switch)

향후 추가 플랫폼 지원이 추가될 예정입니다.

### Binary Sensor

SmartThings 이진 센서 플랫폼을 사용하면 이진 센서 관련 기능이 있는 장치를 볼 수 있습니다. 장치에서 지원하는 각 속성(아래)에 대해 이진 센서 엔터티가 생성됩니다.

| Capability                                                                                                              | Attribute      | On-Value   |
| ----------------------------------------------------------------------------------------------------------------------- | -------------- | ---------- |
| [`accelerationSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Acceleration-Sensor) | `acceleration` | `active`   |
| [`contactSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Contact-Sensor)           | `contact`      | `open`     |
| [`filterStatus`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Filter-Status)             | `filterStatus` | `replace`  |
| [`motionSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Motion-Sensor)             | `motion`       | `active`   |
| [`presenceSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Presence-Sensor)         | `presence`     | `present`  |
| [`tamperAlert`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Tamper-Alert)               | `tamper`       | `detected` |
| [`valve`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Valve)                            | `valve`        | `open`     |
| [`waterSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Water-Sensor)               | `water`        | `wet`      |

### Climate

SmartThings Climate 플랫폼을 사용하면 에어컨 또는 온도 조절기 관련 기능이 있는 장치를 제어할 수 있습니다.

#### Air Conditioners

SmartThings Air Conditioner가 climate 플랫폼으로 표시되려면 다음과 같은 필수 기능이 모두 있어야합니다.

| Capability                                                                                                                                        | Climate Features                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`airConditionerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Air-Conditioner-Mode) (required)               | `hvac mode`, `hvac action`                                                                                                                                                        |
| `airConditionerFanMode` (required)                                                                                                                | `fan mode`                                                                                                                                                                        |
| [`temperatureMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Temperature-Measurement) (required)        | `temperature`                                                                                                                                                                     |
| [`thermostatCoolingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Cooling-Setpoint) (required) | `target temp`                                                                                                                                                                     |
| [`demandResponseLoadControl`](https://docs.smartthings.com/en/latest/capabilities-reference.html#demand-response-load-control)                    | `drlc_status_duration` (state attribute), `drlc_status_level` (state attribute), `drlc_status_override` (state attribute), `drlc_status_start` (state attribute)                  |
| [`powerConsumptionReport`](https://docs.smartthings.com/en/latest/capabilities-reference.html#power-consumption-report)                           | `power_consumption_end` (state attribute), `power_consumption_energy` (state attribute), `power_consumption_power` (state attribute), `power_consumption_start` (state attribute) |

#### 온도조절장치 (Thermostats)

SmartThings 온도조절장치가 climate 플랫폼으로 표시되려면 "set a" 또는 "set b"의 모든 기능이 있어야합니다. : 

| Capability                                                                                                                                     | Climate Features                                                                 |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| [`thermostat`](https://docs.smartthings.com/en/latest/capabilities-reference.html#thermostat) (set a)                                          | `hvac mode`, `hvac action`, `target temp high`, `target temp low` and `fan mode` |
| [`thermostatMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Mode) (set b)                        | `hvac mode`                                                                      |
| [`thermostatCoolingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Cooling-Setpoint) (seb b) | `target temp low`                                                                |
| [`thermostatHeatingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Heating-Setpoint) (set b) | `target temp high`                                                               |
| [`temperatureMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Temperature-Measurement) (set b)        |
| [`thermostatOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Operating-State)           | `hvac action`                                                                    |
| [`thermostatFanMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Fan-Mode)                         | `fan mode`                                                                       |
| [`relativeHumidityMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Relative-Humidity-Measurement)     | `humidity` (state attribute)                                                     |

### Cover

SmartThings Cover 플랫폼을 사용하면 관련 기능이 있는 개폐 장치를 제어할 수 있습니다. Cover 플랫폼으로 장치를 나타내려면 아래 "a"의 기능 중 하나가 있어야합니다.

| Capability                                                                                                                     | Cover Features                    |
| ------------------------------------------------------------------------------------------------------------------------------ | --------------------------------- |
| [`doorControl`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Door-Control) (set a)              | `open` and `close`                |
| [`garageDoorControl`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Garage-Door-Control) (seb a) | `open` and `close`                |
| [`windowShade`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Window-Shade) (set a)              | `open` and `close`                |
| [`switchLevel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch-Level)                      | `position`                        |
| [`battery`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Battery)                               | `battery_level` (state attribute) |

### Fan

SmartThings Fan 플랫폼을 사용하면 팬 관련 기능이 있는 장치를 제어할 수 있습니다. SmartThings 장치를 Fan 플랫폼으로 나타내려면 [`switch`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch) 기능 외에 아래 기능 중 하나 이상이 있어야합니다.

| Capability                                                                                          | Fan Features                                 |
| --------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| [`fanSpeed`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Fan-Speed) | `speed` (`off`, `low`, `medium`, and `high`) |

### Light

SmartThings Light 플랫폼을 사용하면 조명 관련 기능이 있는 장치를 제어할 수 있습니다. SmartThings 장치가 Light 플랫폼으로 표시되려면 [`switch`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch) 기능 외에 아래 기능중 하나 이상이 있어야합니다.

| Capability                                                                                                          | Light Features                |
| ------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| [`switchLevel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch-Level)           | `brightness` and `transition` |
| [`colorControl`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Color-Control)         | `color`                       |
| [`colorTemperature`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Color-Temperature) | `color_temp`                  |

### Lock

SmartThings Lock 플랫폼을 사용하면 [`lock`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Lock) 기능이 있는 장치를 제어하여 현재 잠금 상태를 표시하고 잠금 및 잠금 해제 명령을 지원할 수 있습니다.

### Sensor

SmartThings Sensor 플랫폼을 사용하면 센서 관련 기능이 있는 장치를 볼 수 있습니다. 장치가 지원하는 각 속성 (아래)에 대해 센서 엔티티가 생성됩니다.

| Capability                                                                                                                                                | Attributes                                                |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| [`activityLightingMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Activity-Lighting-Mode)                              | `lightingMode`                                            |
| [`airConditionerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Air-Conditioner-Mode)                                  | `airConditionerMode`                                      |
| [`airQualitySensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Air-Quality-Sensory)                                     | `airQuality`                                              |
| [`alarm`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Alarm)                                                              | `alarm`                                                   |
| [`audioVolume`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Audio-Volume)                                                 | `volume`                                                  |
| [`battery`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Battery)                                                          | `battery`                                                 |
| [`bodyMassIndexMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Body-Mass-Index-Measurement)                     | `bmiMeasurement`                                          |
| [`bodyWeightMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Body-Weight-Measurement)                            | `bodyWeightMeasurement`                                   |
| [`carbonDioxideMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Carbon-Dioxide-Measurement)                      | `carbonDioxide`                                           |
| [`carbonMonoxideDetector`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Carbon-Monoxide-Detector)                          | `carbonMonoxide`                                          |
| [`carbonMonoxideMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Carbon-Monoxide-Measurement)                    | `carbonMonoxideLevel`                                     |
| [`dishwasherOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dishwasher-Operating-State)                      | `machineState`, `dishwasherJobState` and `completionTime` |
| [`dryerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dryer-Mode)                                                     | `dryerMode`                                               |
| [`dryerOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dryer-Operating-State)                                | `machineState`, `dryerJobState` and `completionTime`      |
| [`dustSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dust-Sensor)                                                   | `fineDustLevel` and `dustLevel`                           |
| [`energyMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Energy-Meter)                                                 | `energy`                                                  |
| [`equivalentCarbonDioxideMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Equivalent-Carbon-Dioxide-Measurement) | `equivalentCarbonDioxideMeasurement`                      |
| [`formaldehydeMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Formaldehyde-Measurement)                         | `formaldehydeLevel`                                       |
| [`illuminanceMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Illuminance-Measurement)                           | `illuminance`                                             |
| [`infraredLevel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Infrared-Level)                                             | `infraredLevel`                                           |
| [`lock`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Lock)                                                                | `lock`                                                    |
| [`mediaInputSource`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Input-Source)                                      | `inputSource`                                             |
| [`mediaPlaybackRepeat`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Playback-Repeat)                                | `playbackRepeatMode`                                      |
| [`mediaPlaybackShuffle`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Playback-Shuffle)                              | `playbackShuffle`                                         |
| [`mediaPlayback`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Playback)                                             | `playbackStatus`                                          |
| [`odorSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Odor-Sensor)                                                   | `odorLevel`                                               |
| [`ovenMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Oven-Mode)                                                       | `ovenMode`                                                |
| [`ovenOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Oven-Operating-State)                                  | `machineState`, `ovenJobState` and `completionTime`       |
| [`ovenSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Oven-Setpoint)                                               | `ovenSetpoint`                                            |
| [`powerMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Power-Meter)                                                   | `power`                                                   |
| [`powerSource`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Power-Source)                                                 | `powerSource`                                             |
| [`refrigerationSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Refrigeration-Setpoint)                             | `refrigerationSetpoint`                                   |
| [`relativeHumidityMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Relative-Humidity-Measurement)                | `humidity`                                                |
| [`robotCleanerCleaningMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Robot-Cleaner-CleaningMode)                      | `robotCleanerCleaningMode`                                |
| [`robotCleanerMovement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Robot-Cleaner-Movement)                              | `robotCleanerMovement`                                    |
| [`robotCleanerTurboMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Robot-Cleaner-Turbo-Mode)                           | `robotCleanerTurboMode`                                   |
| [`signalStrength`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Signal-Strength)                                           | `lqi` and `rssi`                                          |
| [`smokeDetector`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Smoke-Detector)                                             | `smoke`                                                   |
| [`temperatureMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Temperature-Measurement)                           | `temperature`                                             |
| [`thermostatCoolingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Cooling-Setpoint)                    | `coolingSetpoint`                                         |
| [`thermostatFanMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Fan-Mode)                                    | `thermostatFanMode`                                       |
| [`thermostatHeatingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Heating-Setpoint)                    | `heatingSetpoint`                                         |
| [`thermostatMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Mode)                                           | `thermostatMode`                                          |
| [`thermostatOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Operating-State)                      | `thermostatOperatingState`                                |
| [`thermostatSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Setpoint)                                   | `thermostatSetpoint`                                      |
| [`threeAxis`](https://docs.smartthings.com/en/latest/capabilities-reference.html#three-axis)                                                              | `threeAxis` (as discrete sensors `X`, `Y` and `Z`)        |
| [`tvChannel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Tv-Channel)                                                     | `tvChannel`                                               |
| [`tvocMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Tvoc-Measurement)                                         | `tvocLevel`                                               |
| [`ultravioletIndex`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Ultraviolet-Index)                                       | `ultravioletIndex`                                        |
| [`voltageMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Voltage-Measurement)                                   | `voltage`                                                 |
| [`washerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Washer-Mode)                                                   | `washerMode`                                              |
| [`washerOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Washer-Operating-State)                              | `machineState`, `washerJobState` and `completionTime`     |

### Scene(씬)

SmartThings Scene 플랫폼을 사용하면 위치 내의 각 SmartThings 씬(Scene)을 나타내는 Scene 엔티티를 사용하여 SmartThings에 정의된 Scene을 활성화 할 수 있습니다.

### Switch

SmartThings Switch 플랫폼을 사용하면 더 구체적인 플랫폼으로 표시되지 않은 [`switch`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch) 기능이 있는 장치를 제어 할 수 있습니다. 다음의 선택적 기능은 에너지 및 전력 사용 정보를 제공합니다.

| Capability                                                                                                | Switch Features                                         |
| --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [`energyMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Energy-Meter) | energy consumption (`today_energy_kwh` state attribute) |
| [`powerMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Power-Meter)   | power consumption (`current_power_w` state attribute)   |

## 문제 해결 (Troubleshooting)

### 셋업 (Setup)

#### Aborted: Home Assistant is not configured correctly to receive updates from SmartThings

이 오류 메시지는 활성화된 홈어시스턴트 클라우드(Nabu Casa) 구독이 없고 `base_url`이 올바르게 설정되지 않은 경우 발생합니다 (https로 시작해야 함). 위의 전제 조건에 따라 Home Assistant 설정을 업데이트하고 다시 시작한 후 다시 시도하십시오.

#### Error: The token must be in the UID/GUID format

개인용 액세스 토큰이 예상 형식과 일치하지 않습니다. 전체 토큰을 복사하고 외래 문자 (예: 후행 공백)가 없는지 확인한 후 다시 시도하십시오.

#### Error: The token is invalid or no longer authorized

입력한 개인 액세스 토큰이 유효하지 않거나 삭제되었습니다. 전제 조건의 지시 사항에 따라 새 토큰을 작성하고 다시 시도하십시오.

#### Error: The token does not have the required OAuth scopes

입력한 개인 액세스 토큰은 유효하지만 전제 조건에 요약된 필수 범위(scopes)가 없습니다. 전제 조건의 지시 사항에 따라 새 토큰을 작성하고 다시 시도하십시오.

#### Error: SmartThings could not validate the webhook URL

SmartThings가 webhook URL을 사용하여 Home Assistant 인스턴스에 도달할 수 없습니다. 디버그 로깅을 활성화하여 특정 문제를 확인하고 아래의 웹후크 문제 해결 점검표를 따르십시오.

#### Aborted: There are no available SmartThings Locations

이 오류 메시지는 개인 액세스 토큰에 연결된 계정의 모든 SmartThings 위치가 Home Assistant에 이미 설정되어있는 경우에 발생합니다. 올바른 개인 액세스 토큰을 사용하고 있는지 확인하거나 SmartThings에서 추가 위치를 작성하여 연동한 후 다시 시도하십시오.

#### Webhook Troubleshooting Checklist

1. `base_url`이 홈어시스턴트가 인터넷에서 사용 가능한 _external address_로 올바르게 설정되어 있는지 확인하십시오. SmartThings가 이 주소에 도달할 수 있어야합니다.
1. [https://www.digicert.com/help/](https://www.digicert.com/help/)와 같은 온라인 검사기를 사용하여 인증서 또는 SSL 설정에 문제가 없는지 확인하십시오.
1. 일부 리버스 프록시 설정 세팅은 SmartThings의 통신을 방해할 수 있습니다. 예를 들어, TLSv1.3은 지원되지 않습니다. 지원되는 암호 제품군을 너무 제한적으로 설정하면 핸드 쉐이킹이 방해받습니다. 다음과 같은 NGINX SSL 설정이 동작하는 것으로 알려져 있습니다. : 
   ```nginx
   # cert.crt also contains intermediate certificates
   ssl_certificate /path/to/cert.crt;
   ssl_certificate_key /path/to/cert.key;
   ssl_dhparam /path/to/dhparam.pem;
   ssl_protocols TLSv1.2;
   ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
   ssl_prefer_server_ciphers on;
   ssl_ecdh_curve secp384r1;
   ssl_session_timeout  10m;
   ssl_session_cache shared:SSL:10m;
   ssl_session_tickets off;
   ```
1. 위의 오류 메시지가 표시되는 동안 로컬 네트워크 외부에서 다음 명령을 실행하여 ping 이벤트에 응답하는지 확인하십시오. : 
    ```bash
    curl -X POST https://{BASE_URL}/api/webhook/{WEBHOOK_ID} -H "Content-Type: application/json; charset=utf-8" -d $'{"lifecycle": "PING", "executionId": "00000000-0000-0000-0000-000000000000", "locale": "en", "version": "1.0.0", "pingData": { "challenge": "00000000-0000-0000-0000-000000000000"}}'
    ```
    Where `{BASE_URL}` is your external address and `{WEBHOOK_ID}` is the value of `webhook_id` from `.storage/smartthings` in your Home Assistant configuration directory.

    The expected response is:
    ```bash
    {"pingData": {"challenge": "00000000-0000-0000-0000-000000000000"}}
    ```

위의 체크리스트를 완료했지만 여전히 플랫폼을 설정할 수 없는 경우 SmartThings 통합을 위한 [디버그 로깅 활성화](#debugging)과 [새로운 문제](https://github.com/home-assistant/home-assistant/issues)의 실패 시점까지 로그 메시지를 포함 시키십시오.

### Debugging

SmartThings 통합구성요소는 로그 레벨이 `debug`로 설정된 경우 수신된 푸시 업데이트, 발생한 이벤트 및 기타 메시지에 대한 추가 정보를 기록합니다. 아래의 관련 내용을 `configuration.yaml`에 추가하십시오 :

```yaml
logger:
  default: info
  logs:
    homeassistant.components.smartthings: debug
```