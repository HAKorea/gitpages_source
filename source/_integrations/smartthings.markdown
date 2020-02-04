---
title: Smartthings
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

삼성 SmartThings는 SmartThings Cloud API를 통해 Home Assistant에 연동됩니다. SmartThings 연동은 모든 SmartThings 관련 플랫폼들의 통합이 가능한 연동방법입니다. 통합연동의 기본 기능은 다음과 같습니다.:

1. SmartThings의 푸시 상태 업데이트로 SmartThings 장치 제어.
2. SmartThings에서 변경 될 때 entity가 자동으로 추가, 제거 또는 업데이트됩니다 (Home Assistant 다시 시작시).
3. 프런트 엔드 구성에서 각각 고유 한 연동방식으로 표시되는 여러 SmartThings 계정 및 위치 지원.
4. 브로커, 브릿지 또는 추가 종속성이 없습니다.

다음 단계별 가이드로 실제로 설정하는 방법을 확인하십시오! (v0.87에서 작업 ) :

<div class='videoWrapper'>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/QZHlhQ7fqrA" frameborder="0" allowfullscreen></iframe>
</div>

## 기본 요구 사항

SmartThings 연동은 Webhook을 사용하거나 Home Assistant Cloud를 구독하여 사용할 수 있습니다. 

### Cloudhook 통한 Nabu Casa

Home Assistant Cloud (Nabu Casa)를 사용하는 경우 통합시 Cloud Hook가 자동으로 생성됩니다. 이렇게하면 기본 요구 사항이 크게 단순화되고 홈 어시스턴트가 인터넷에 노출 될 필요가 없습니다.
**Cloudhook 요구 사항을 충족하기 전에 또는 v0.90.0 이전에 연동을 이전에 설정 한 경우 이전의 모든 연동을 제거하고 을 다시 실행해야합니다.**

1. A [personal access token](https://account.smartthings.com/tokens) 삼성이나 SmartThings에 등록한 기존 계정 (자세한 내용은 아래 참조).
2. Home Assistant Cloud가 구동중이어야 하며 로그인 되어있여야 합니다. 

### Webhook

1. A [personal access token](https://account.smartthings.com/tokens) 삼성이나 SmartThings에 등록한 기존 계정 (자세한 내용은 아래 참조).
2. SSL로 보안 된 도메인 이름을 통한 [remote access](/docs/configuration/remote/) 를 위한 홈 어시스턴트 설정 . *자체 서명 된 SSL 인증서는 SmartThings Cloud API에서 지원되지 않습니다.*
3. [`base_url` of the http integration](/integrations/http#base_url) 에서 홈 어시스턴트가 인터넷연결이 사용 가능한 URL을 설정하십시오. SmartThings에는 `base_url` 표준 HTTPS 포트 (443)를 사용 하려면 및 홈 지원이 필요합니다 .

## 설치 순서

### 개인용 액세스 토큰 생성

1. [personal access tokens page](https://account.smartthings.com/tokens)에 로그인하여 '[Generate new token](https://account.smartthings.com/tokens/new)'을 클릭
2. 토큰 이름을 입력하고 (예 : 'Home Assistant') 다음과 같이 인증 된 범위를 선택하십시오.:
    - Devices (all)
    - Installed Apps (all)
    - Locations (all)
    - Apps (all)
    - Schedules (all)
    - Scenes (all)
3. '토큰 생성'을 클릭하십시오. 토큰이 표시되면 다시 검색 할 수 없으므로 안전한 위치 (예 : 키 저장소)에 복사하여 저장하십시오.

### 홈 어시스턴트 설정

<div class='note info'>

SmartThings 통합은 프런트 엔드를 통해서만 설정됩니다. 현재 수동 설정 `configuration.yaml` 에서는 사용 불가합니다.

</div>

1. 홈 어시스턴트 프론트 엔드에서 '설정'과 '통합 구성요소'으로 이동하십시오. '새로운 통합 구성요소 설정'에서 'SmartThings'를 찾아 '확인'을 클릭하십시오.
2. 위에서 만든 개인 액세스 토큰을 입력하고 '제출'을 클릭하십시오
3. 프롬프트가 표시되면 SmartApp을 설치하십시오.:
    1. SmartThings Classic 모바일 앱을 엽니다. '자동화'로 이동하여 'SmartApps'탭을 선택하십시오.
    2. 'SmartApp 추가'를 클릭하고 맨 아래로 스크롤하여 '내 앱'을 선택한 다음 '홈 어시스턴트'를 선택하십시오.
    3. 원한다면 표시 이름을 변경하고 '완료'를 누르십시오
    4. '허용'을 눌러 앱을 승인하십시오.
4. 홈 어시스턴트로 돌아가서 '제출'을 클릭하십시오.

<div class='note info'>

고급 : SmartThings가 여러 위치가있는 경우 각 위치를 Home Assistant에 통합 할 수 있습니다. 위의 단계를 수행 한 후 이후의 각 위치에 SmartApp을 설치하면 Home Assistant에 자동으로 추가됩니다. 위의 3 단계 (SmartApp 설치) 를 반복할 경우에 완료 할 수 있습니다.

</div>

연동 설정에서 문제가 있는 경우 [troubleshooting](#troubleshooting)를 참조하세요.  

## Events

SmartThings 연동은 일부 장치 기능에 대한 이벤트를 트리거합니다.

### smartthings.button

연동은 [button](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Button) 기능이 있는 장치가 작동 될 때 이벤트를 트리거하며 Home Assistant 내에서 자동화를 트리거하는 데 사용 할 수 있습니다. 아래는 데이터 페이로드의 예입니다.:

```json
{
  "component_id": "main",
  "device_id": "42a16cf2-fef7-4ee8-b4a6-d32cb65474b7",
  "location_id": "2a54b9fa-f66c-42d9-8488-d8f036b980c8",
  "value": "pushed",
  "name": "Scene Button"
}
```

| 속성                       | 내용
|---------------------------|------------------------------------------------------------------|
`component_id`              | 이벤트를 트리거 한 기기와의 연동에 대해 설명합니다. `main`은 부모 장치를 나타냅니다.  자식장치가있는 기기의 경우이 특성은 이벤트를 발생시킨 자식장치를 구분합니다.
`device_id`                 | SmartThings에서 기기의 고유 ID입니다. 이것은 홈 어시스턴트 기기 레지스트리 혹은 [SmartThings Developer Workspace](https://smartthings.developer.samsung.com/workspace/)에 있습니다.
`location_id`               | 기기가 속한 위치의 고유 ID입니다. 구성 항목 레지스트리 또는 [SmartThings Developer Workspace](https://smartthings.developer.samsung.com/workspace/)에서 찾을 수 있습니다.
`value`                     | 버튼에서 수행 된 작업을 설명합니다. 가능한 값 목록에 대해서는 [button](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Button) 기능을 참조하십시오 (일부 장치에서 모두 지원되는 것은 아님).
`name`                      | SmartThings에서 기기에 지정된 이름입니다.

이벤트 데이터 페이로드는 디버그 레벨에서 Log를 확일 할 수 있습니다, 자세한 정보는 [debugging](#debugging) 을 참조하십시오.

## 플랫폼

SmartThings는 장치를 일련의 [capabilities](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html) 으로 나타내고 SmartThings 연동은 기기를 Home Assistant의 entitiy 플랫폼에 매핑합니다.  단일 장치는 하나 이상의 플랫폼으로 표현 될 수 있습니다.

- [Binary Sensor](#binary-sensor)
- [Climate](#climate)
- [Cover](#cover)
- [Fan](#fan)
- [Light](#light)
- [Lock](#lock)
- [Sensor](#sensor)
- [Scene](#scene)
- [Switch](#switch)

향후 추가 플랫폼 지원이 추가 될 예정입니다.

### Binary Sensor

SmartThings Binary Sensor 플랫폼을 사용하면 Binary Sensor 관련 기능이 있는 장치를 볼 수 있습니다. 장치에서 지원하는 각 속성 (아래)에 대해 이진 센서 엔터티가 생성됩니다.

| Capability        |Attribute     |On-Value
|-------------------|--------------|----------------|
| [`accelerationSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Acceleration-Sensor) | `acceleration` | `active`
| [`contactSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Contact-Sensor)           | `contact`      | `open`
| [`filterStatus`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Filter-Status)             | `filterStatus` | `replace`
| [`motionSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Motion-Sensor)             | `motion`       | `active`
| [`presenceSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Presence-Sensor)         | `presence`     | `present`
| [`tamperAlert`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Tamper-Alert)               | `tamper`       | `detected`
| [`valve`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Valve)                            | `valve`        | `open`
| [`waterSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Water-Sensor)               | `water`        | `wet`

### CLIMATE

SmartThings Climate 플랫폼을 사용하면 에어컨 또는 온도 조절기 관련 장치를 제어 할 수 있습니다.

#### Air Conditioners

SmartThings Air Conditioner가 냉난방 장치 플랫폼으로 표시 되려면 다음과 같은 필수 기능이 모두 있어야합니다.:

| Capability                          |Climate Features
|-------------------------------------|--------------------------------------------|
| [`airConditionerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Air-Conditioner-Mode) (required)            | `hvac mode`, `hvac action`
| `airConditionerFanMode` (required) | `fan mode`
| [`temperatureMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Temperature-Measurement) (required)    | `temperature`
| [`thermostatCoolingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Cooling-Setpoint) (required) | `target temp`
| [`demandResponseLoadControl`](https://docs.smartthings.com/en/latest/capabilities-reference.html#demand-response-load-control) | `drlc_status_duration` (state attribute), `drlc_status_level` (state attribute), `drlc_status_override` (state attribute), `drlc_status_start` (state attribute)
| [`powerConsumptionReport`](https://docs.smartthings.com/en/latest/capabilities-reference.html#power-consumption-report) | `power_consumption_end` (state attribute), `power_consumption_energy` (state attribute), `power_consumption_power` (state attribute), `power_consumption_start` (state attribute)

#### Thermostats

SmartThings 온도 조절 장치를 기후 플랫폼으로 나타내려면 "set a" 또는 "set b"의 모든 기능이 있어야합니다 .:

| Capability                          |Climate Features
|-------------------------------------|--------------------------------------------|
| [`thermostat`](https://docs.smartthings.com/en/latest/capabilities-reference.html#thermostat) (set a)                | `hvac mode`, `hvac action`, `target temp high`, `target temp low` and `fan mode`
| [`thermostatMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Mode) (set b)            | `hvac mode`
| [`thermostatCoolingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Cooling-Setpoint) (seb b) | `target temp low`
| [`thermostatHeatingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Heating-Setpoint) (set b) | `target temp high`
| [`temperatureMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Temperature-Measurement) (set b)    |
| [`thermostatOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Operating-State)          | `hvac action`
| [`thermostatFanMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Fan-Mode)                 | `fan mode`
| [`relativeHumidityMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Relative-Humidity-Measurement)       | `humidity` (state attribute)

### Cover

SmartThings Cover 플랫폼을 사용하면 관련 기능이있는 개폐장치(커튼 혹은 창고 도어)를 제어 할 수 있습니다. 커버 플랫폼으로 장치를 나타내려면 아래 "a 설정"의 기능 중 하나가 있어야합니다.

| Capability                          |Cover Features
|-------------------------------------|--------------------------------------------|
| [`doorControl`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Door-Control) (set a)            | `open` and `close`
| [`garageDoorControl`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Garage-Door-Control) (seb a) | `open` and `close`
| [`windowShade`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Window-Shade) (set a) | `open` and `close`
| [`switchLevel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch-Level)    |  `position`
| [`battery`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Battery)          | `battery_level` (state attribute)

### Fan

SmartThings Fan 플랫폼을 사용하면 Fan 관련 기능이있는 장치를 제어 할 수 있습니다. SmartThings 장치가 Fan 플랫폼으로 표시 되려면 해당 기능 외에 아래 기능 중 하나 이상이 있어야합니다 [`switch`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch).

| Capability        |Fan Features
|-------------------|------------------------------------------------------------|
| [`fanSpeed`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Fan-Speed)            | `speed` (`off`, `low`, `medium`, and `high`)

### Light

SmartThings Light 플랫폼을 사용하면 조명 관련 기능이있는 장치를 제어 할 수 있습니다.   SmartThings 장치를 라이트 플랫폼으로 표시하려면 기능 외에 아래 기능 중 하나 이상이 있어야합니다 [`switch`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch).

| Capability        |Light Features
|-------------------|------------------------------------------------------------|
| [`switchLevel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch-Level)            | `brightness` and `transition`
| [`colorControl`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Color-Control)            | `color`
| [`colorTemperature`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Color-Temperature)            | `color_temp`

### Lock

SmartThings Lock 플랫폼을 사용하면 [`lock`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Lock) 현재 잠금 상태를 표시하고 잠금 및 잠금 해제 명령을 지원하는 기능이 있는 장치를 제어 할 수 있습니다 .

### Sensor

SmartThings Sensor 플랫폼을 사용하면 센서 관련 기능이있는 장치를 볼 수 있습니다. 장치가 지원하는 각 속성 (아래)에 대해 센서 entitiy가 생성됩니다.

| Capability        |Attributes     |
|-------------------|---------------|
| [`activityLightingMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Activity-Lighting-Mode)            | `lightingMode`
| [`airConditionerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Air-Conditioner-Mode)                | `airConditionerMode`
| [`airQualitySensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Air-Quality-Sensory)                   | `airQuality`
| [`alarm`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Alarm)                                            | `alarm`
| [`audioVolume`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Audio-Volume)                               | `volume`
| [`battery`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Battery)                                        | `battery`
| [`bodyMassIndexMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Body-Mass-Index-Measurement)   | `bmiMeasurement`
| [`bodyWeightMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Body-Weight-Measurement)          | `bodyWeightMeasurement`
| [`carbonDioxideMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Carbon-Dioxide-Measurement)    | `carbonDioxide`
| [`carbonMonoxideDetector`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Carbon-Monoxide-Detector)        | `carbonMonoxide`
| [`carbonMonoxideMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Carbon-Monoxide-Measurement)  | `carbonMonoxideLevel`
| [`dishwasherOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dishwasher-Operating-State)    | `machineState`, `dishwasherJobState` and `completionTime`
| [`dryerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dryer-Mode)                                   | `dryerMode`
| [`dryerOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dryer-Operating-State)              | `machineState`, `dryerJobState` and `completionTime`
| [`dustSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Dust-Sensor)                                 | `fineDustLevel` and `dustLevel`
| [`energyMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Energy-Meter)                               | `energy`
| [`equivalentCarbonDioxideMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Equivalent-Carbon-Dioxide-Measurement) | `equivalentCarbonDioxideMeasurement`
| [`formaldehydeMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Formaldehyde-Measurement)       | `formaldehydeLevel`
| [`illuminanceMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Illuminance-Measurement)         | `illuminance`
| [`infraredLevel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Infrared-Level)                           | `infraredLevel`
| [`lock`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Lock)                                              | `lock`
| [`mediaInputSource`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Input-Source)                    | `inputSource`
| [`mediaPlaybackRepeat`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Playback-Repeat)              | `playbackRepeatMode`
| [`mediaPlaybackShuffle`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Playback-Shuffle)            | `playbackShuffle`
| [`mediaPlayback`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Media-Playback)                           | `playbackStatus`
| [`odorSensor`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Odor-Sensor)                                 | `odorLevel`
| [`ovenMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Oven-Mode)                                     | `ovenMode`
| [`ovenOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Oven-Operating-State)                | `machineState`, `ovenJobState` and `completionTime`
| [`ovenSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Oven-Setpoint)                             | `ovenSetpoint`
| [`powerMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Power-Meter)                                 | `power`
| [`powerSource`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Power-Source)                               | `powerSource`
| [`refrigerationSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Refrigeration-Setpoint)           | `refrigerationSetpoint`
| [`relativeHumidityMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Relative-Humidity-Measurement) | `humidity`
| [`robotCleanerCleaningMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Robot-Cleaner-CleaningMode)    | `robotCleanerCleaningMode`
| [`robotCleanerMovement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Robot-Cleaner-Movement)            | `robotCleanerMovement`
| [`robotCleanerTurboMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Robot-Cleaner-Turbo-Mode)         | `robotCleanerTurboMode`
| [`signalStrength`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Signal-Strength)                         | `lqi` and `rssi`
| [`smokeDetector`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Smoke-Detector)                           | `smoke`
| [`temperatureMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Temperature-Measurement)         | `temperature`
| [`thermostatCoolingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Cooling-Setpoint)  | `coolingSetpoint`
| [`thermostatFanMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Fan-Mode)                  | `thermostatFanMode`
| [`thermostatHeatingSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Heating-Setpoint)  | `heatingSetpoint`
| [`thermostatMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Mode)                         | `thermostatMode`
| [`thermostatOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Operating-State)    | `thermostatOperatingState`
| [`thermostatSetpoint`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Thermostat-Setpoint)                 | `thermostatSetpoint`
| [`threeAxis`](https://docs.smartthings.com/en/latest/capabilities-reference.html#three-axis)                                            | `threeAxis` (as discrete sensors `X`, `Y` and `Z`)
| [`tvChannel`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Tv-Channel)                                   | `tvChannel`
| [`tvocMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Tvoc-Measurement)                       | `tvocLevel`
| [`ultravioletIndex`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Ultraviolet-Index)                     | `ultravioletIndex`
| [`voltageMeasurement`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Voltage-Measurement)                 | `voltage`
| [`washerMode`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Washer-Mode)                                 | `washerMode`
| [`washerOperatingState`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Washer-Operating-State)            | `machineState`, `washerJobState` and `completionTime`

### Scene

SmartThings Scene 플랫폼을 사용하면 위치 내의 각 SmartThings Scene을 나타내는 Scene entity를 사용하여 SmartThings에 정의 된 Scene을 활성화 할 수 있습니다.

### Switch

SmartThings Switch 플랫폼을 사용하면 [`switch`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Switch) 더 상세한 플랫폼 연계 방식으로 아직 연계되지 않은 기능을 추가 제어할 수 있습니다. 다음의 선택적 기능은 에너지 및 전력 사용 정보를 제공합니다.:

| Capability                          |Switch Features
|-------------------------------------|--------------------------------------------|
| [`energyMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Energy-Meter) | energy consumption (`today_energy_kwh` state attribute)
| [`powerMeter`](https://smartthings.developer.samsung.com/develop/api-ref/capabilities.html#Power-Meter) | power consumption (`current_power_w` state attribute)

## Troubleshooting

### Setup

통합을 설정하는 중에 다음 오류 메시지 중 하나가 표시되면 다음 단계를 수행하십시오 (Home Assistant 클라우드를 통해 통합 된 경우에는 적용되지 않음).:

- "SmartThings는 base_url에 구성된 엔드 포인트를 검증 할 수 없습니다. 통합 요구 사항을 검토하십시오."
- "SmartApp을 설정할 수 없습니다. 다시 시도하십시오."

#### Checklist

1. 홈 어시스턴트가 인터넷에서 사용 가능한 외부 주소 `base_url` 로 올바르게 설정되어 있는지 확인하십시오.  SmartThings가 이 주소와 통신이 가능해야 합니다.
1. [https://www.digicert.com/help/](https://www.digicert.com/help/)와 같은 온라인 검사기를 사용하여 인증서 또는 SSL 구성에 문제가 없는지 확인 하십시오 .
1. 일부 리버스 프록시 구성 설정은 SmartThings의 통신을 방해 할 수 있습니다. 예를 들어, TLSv1.3은 지원되지 않습니다. 지원되는 암호 제품군을 너무 제한적으로 설정하면 핸드 쉐이킹이 지원되지 않습니다. 다음과 같은 NGINX SSL 구성이 작동하는 것으로 알려져 있습니다.:
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
1. 위의 오류 메시지가 표시되는 동안 로컬 네트워크 외부에서 다음 명령을 실행하여 ping으로 응답하는지 확인하십시오.:
    ```bash
    curl -X POST https://{BASE_URL}/api/webhook/{WEBHOOK_ID} -H "Content-Type: application/json; charset=utf-8" -d $'{"lifecycle": "PING", "executionId": "00000000-0000-0000-0000-000000000000", "locale": "en", "version": "1.0.0", "pingData": { "challenge": "00000000-0000-0000-0000-000000000000"}}'
    ```
    Where `{BASE_URL}` is your external address and `{WEBHOOK_ID}` is the value of `webhook_id` from `.storage/smartthings` in your Home Assistant configuration directory.

    The expected response is:
    ```bash
    {"pingData": {"challenge": "00000000-0000-0000-0000-000000000000"}}
    ```

위의 점검 목록을 완료했지만 여전히 플랫폼을 설정할 수없는 경우 SmartThings 통합을위한 , [activate debug logging](#debugging) 을 활성화 하고 [a new issue](https://github.com/home-assistant/home-assistant/issues)의 실패 시점까지 로그 메시지를 포함 시키십시오 . [a new issue](https://github.com/home-assistant/home-assistant/issues).

### Debugging

SmartThings 연동은 log 레벨을 `debug`로 설정할 경우 수신 된 푸시 업데이트, 발생한 이벤트 및 기타 메시지에 대한 추가 정보를 기록합니다  .  `configuration.yaml` 아래에 다음을 추가하십시오:

```yaml
logger:
  default: info
  logs:
    homeassistant.components.smartthings: debug
```
