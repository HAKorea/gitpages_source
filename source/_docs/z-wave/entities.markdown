---
title: "Z-Wave Entity Naming"
description: "A summary of common entity names."
---

<div class='note'>

이것은 포럼의 보고서, 저자 자신의 장치와 다양한 문서 읽기를 기반으로 진행중인 작업입니다. 불완전하므로 여기에 보고되지 않은 장치가 있거나 다른 값을 보고하는 장치가 있는 경우 포럼의 [Z-Wave 섹션](https://community.home-assistant.io/c/configuration/zwave) 혹은 [Discord](https://discord.gg/RkajcgS)의 #zwave 채널에 보고서를 제공하십시오.

</div>

## Binary Sensor

이진 센서 명령 클래스를 지원하는 장치는 `binary_sensor`로 시작하는 하나 이상의 엔티티를 만듭니다. 예를 들어 노드가 `door_sensor`인 경우 이진 센서 엔터티는 `binary_sensor.door_sensor`입니다.

센서가 활성화되면 일반적으로 `on`이 되고 그렇지 않으면 `off`이 됩니다. 일부 장치는 닫힘에 `on`을 사용하고 일부 장치는 열림에 `on`을 사용하고 일부 장치에서는 보고 방식을 변경할 수 있습니다.

## Alarm

이는 단일 목적 센서용이며 다중 센서는 다중 센서 아래에 설명되어 있습니다.

Alarm 명령 클래스를 지원하는 장치 (일반적으로 센서)는 `sensor`로 시작하고 일부 일반 접미사와 지원되는 알람 클래스와 관련된 접미사로 엔터티를 만듭니다. 예를 들어, 연기 감지기 `lounge`에는 엔티티 `sensor.lounge_smoke`와 `sensor.lounge_alarm_type`, `sensor.lounge_alarm_level` 엔티티가 있습니다. 장치가 `binary_sensor` 엔티티를 생성하는 경우 `sensor` 엔티티 대신 해당 엔티티를 사용하는 것이 좋습니다.

이전 Z-Wave 알람 명령 클래스 버전 1에는 표준화된 유형이 없으므로 각 제조업체는 고유한 버전과 유형 정보를 지정했습니다. 버전 2에서는 경보 유형이 아래 목록으로 표준화되었습니다. 자세한 내용은 [openzwave 알람 명령 클래스 문서](https://github.com/OpenZWave/open-zwave/wiki/Alarm-Command-Class)를 참조하십시오. zwcfg_0x\*.xml 파일을 통해 센서가 지원하는 버전을 확인할 수 있습니다. 버전 2를 지원하는 예 :

```xml
<CommandClass id="113" name="COMMAND_CLASS_ALARM" version="2" request_flags="2" innif="true">
```

### Alarm 유형 엔티티

[//]: # (from the openzwave source found here: https://github.com/OpenZWave/open-zwave/blob/master/cpp/src/command_classes/Alarm.cpp#L56)

- Version 2 **alarm_type**:
  - **0**: General purpose
  - **1**: Smoke sensor
  - **2**: Carbon Monoxide (CO) sensor
  - **3**: Carbon Dioxide (CO2) sensor
  - **4**: Heat sensor
  - **5**: Water leak (flood) sensor
  - **6**: Access control
  - **7**: Burglar
  - **8**: Power management
  - **9**: System
  - **10**: Emergency
  - **11**: Clock
  - **12**: Appliance
  - **13**: Home Health

- Version 1 (manufacturer-specific) **alarm_type**:
  - **9**: Lock jammed
  - **18**: Lock locked with user code
  - **19**: Lock unlocked with user code
  - **21**: Manual lock
  - **22**: Manual unlock
  - **24**: Locked by RF
  - **25**: Unlocked by RF
  - **27**: Auto lock
  - **33**: User deleted
  - **112**: Master code changed, or user added
  - **113**: Duplicate PIN code error
  - **130**: RF Module power cycled
  - **161**: Tamper alarm
  - **167**: Low battery
  - **168**: Critical battery level
  - **169**: Battery too low to operate

### Alarm 레벨 엔티티

`alarm_level` 엔티티의 의미는 알람 센서의 특성에 따라 다릅니다.

#### Smoke, CO, and CO2

  - **1**: Detection - will include a Node Location Report
  - **2**: Detection (unknown location)
  - **254**: Unknown event

#### Heat

  - **1**: Overheat detected - will include a Node Location Report
  - **2**: Overheat detected (unknown location)
  - **3**: Rapid temperature rise - will include a Node Location Report
  - **4**: Rapid temperature rise (unknown location)
  - **5**: Underheat detection - will include a Node Location Report
  - **6**: Underheat detection (unknown location)
  - **254**: Unknown event

#### Water leak

  - **1**: Water leak detected - will include a Node Location Report
  - **2**: Water leak detected (unknown location)
  - **3**: Water level dropped - will include a Node Location Report
  - **4**: Water level dropped (unknown location)
  - **254**: Unknown event

#### Access control

  - **1**: Manual lock
  - **2**: Manual unlock
  - **3**: RF lock
  - **4**: RF unlock
  - **5**: Keypad lock - will include the User Identifier of the User Code Report
  - **6**: Keypad unlock - will include the User Identifier of the User Code Report
  - **254**: Unknown event

#### Burglar

  - **1**: Intrusion - will include a Node Location Report
  - **2**: Intrusion (unknown location)
  - **3**: Tampering (case opened)
  - **4**: Tampering (invalid code)
  - **5**: Glass break - will include a Node Location Report
  - **6**: Glass break (invalid code)
  - **254**: Unknown event

#### Power Management

  - **1**: Power applied
  - **2**: AC disconnected
  - **3**: AC re-connected
  - **4**: Surge detection
  - **5**: Voltage drop or drift
  - **254**: Unknown event

#### System Alarm

  - **1**: System hardware failure
  - **2**: System software failure
  - **254**: Unknown event

#### Emergency Alarm

  - **1**: Contact Police
  - **2**: Contact Fire Service
  - **3**: Contact Medical Service
  - **254**: Unknown event

#### Alarm Clock

  - **1**: Wake up
  - **254**: Unknown event

### Access Control Entity

- **access_control**: These *may* vary between brands
  - **22**: Open
  - **23**: Closed
  - **254**: Deep sleep
  - **255**: Case open

장치에 `access_control` 엔티티가 있지만 `binary_sensor`에 해당하지 않는 경우 [template binary sensor](/integrations/binary_sensor.template/)를 사용하여 하나를 작성할 수 있습니다. (여기서 문으로 정의했지만 [모든 관련 기기 클래스](/integrations/binary_sensor/#device-class)를 사용할 수 있습니다.) :

{% raw %}
```yaml
binary_sensor:
  - platform: template
    sensors: 
      YOUR_SENSOR:
        friendly_name: "Friendly name here"
        device_class: door
        value_template: "{{ is_state('sensor.YOUR_ORIGINAL_SENSOR_access_control', '22') }}"
```
{% endraw %}

### Burglar Entity

- **burglar**: These *may* vary between brands
   - **0**: Not active
   - **2**: Smoke (?)
   - **3**: Tamper
   - **8**: Motion
   - **22**: Open
   - **23**: Closed
   - **254**: Deep sleep
   - **255**: Case open

장치에 `access_control` 엔티티가 있지만 `binary_sensor`에 해당하지 않는 경우 [template binary sensor](/integrations/binary_sensor.template/)를 사용하여 하나를 작성할 수 있습니다. (여기서 모션 센서로 정의했지만 [모든 관련 기기 클래스](/integrations/binary_sensor/#device-class)를 사용할 수 있습니다.) :

{% raw %}
```yaml
binary_sensor:
  - platform: template
    sensors: 
      YOUR_SENSOR:
        friendly_name: "Friendly name here"
        device_class: motion
        value_template: "{{ is_state('sensor.YOUR_SENSOR_burglar', '8') }}"
```
{% endraw %}

### Source Node ID Entity

- **sourcenodeid**: alarm을 생성한 센서를 보고합니다. - 이는 Zensor Net 기반 장치에만 유효합니다.

## Multisensor

다중센서 장치는 각 센서마다 하나씩, 잠재적으로 `binary_sensor` 엔티티와 아마도 `alarm_type`과 `alarm_level` 엔티티를 여러 엔티티로 작성합니다.

이들은 일반적으로 설명할게 없는 내용이지만, 주목할 가치가 있습니다. 

- **ultraviolet** UVB가 유리에 의해 차단되므로 센서는 일반적으로 실내에 0을 보고합니다
- **luminance** 센서는 [Lux](https://en.wikipedia.org/wiki/Lux)로 보고해야합니다
