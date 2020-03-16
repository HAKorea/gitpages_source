---
title: 인스테온(Insteon)
description: Instructions on how to set up an Insteon Modem (PLM or Hub) locally within Home Assistant.
logo: insteon.png
ha_category:
  - Hub
  - Binary Sensor
  - Cover
  - Fan
  - Light
  - Sensor
  - Switch
ha_iot_class: Local Push
ha_release: 0.39
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/W_BDn-BUaD4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

이 연동 기능으로 INSTEON 모뎀에 대한 "local push"지원이 추가되어 연결된 INSTEON 장치를 Home Assistant 내에서 사용할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Binary Sensor
- Cover
- Fan
- Light
- Sensor
- Switch

장치 지원은 기본 [insteonplm] 패키지에 의해 제공됩니다. PLM의 [2413U] USB 및 [2412S] RS242 플레이버 및 [2448A7] USB 스틱과 함께 작동하는 것으로 알려져 있습니다. 또한 [2242] 및 [2245] 허브와 함께 작동하도록 테스트되었습니다.

[insteonplm]: https://github.com/nugget/python-insteonplm
[2413U]: https://www.insteon.com/powerlinc-modem-usb
[2412S]: https://www.insteon.com/powerlinc-modem-serial
[2448A7]: https://www.smarthome.com/insteon-2448a7-portable-usb-adapter.html
[2245]: https://www.insteon.com/insteon-hub/
[2242]: https://www.insteon.com/support-knowledgebase/2014/9/26/insteon-hub-owners-manual

### INSTEON 모뎀 설정

[2413U]와 같은 INSTEON Powerline Modem (PLM) 장치를 설정하려면 다음 설정을 사용하십시오.

```yaml
# PLM configuration variables
insteon:
  port: SERIAL_PORT
```

INSTEON Hub 모델 [2245]를 설정하려면 다음 설정을 사용하십시오.

```yaml
# Hub 2245 configuration variables
insteon:
  host: HOST
  ip_port: IP_PORT
  username: USERNAME
  password: PASSWORD
  hub_version: 2
```

INSTEON Hub 모델 [2242]을 설정하려면 다음 설정을 사용하십시오.

```yaml
# Hub 2242 configuration variables
insteon:
  host: HOST
  hub_version: 1
```

추가 설정 아이템들을 사용할 수 있습니다.

```yaml
insteon:
  <PLM or Hub configuration>
  device_override:
     - address: ADDRESS
       cat: CATEGORY
       subcat: SUBCATEGORY
       firmware: FIRMWARE
       product_key: PRODUCT_KEY
  x10_devices:
     - housecode: HOUSECODE
       unitcode: UNITCODE
       platform: PLATFORM
       steps: STEPS
  x10_all_units_off: HOUSECODE
  x10_all_lights_on: HOUSECODE
  x10_all_lights_off: HOUSECODE
```

{% configuration %}
port:
  description: The serial or USB port for your device, e.g., `/dev/ttyUSB0` or `COM3`. Required for PLM setup.
  required: false
  type: string
host:
  description: The host name or IP address of the Hub. Required with Hub.
  required: false
  type: string
ip_port:
  description: The IP port number of the Hub. For Hub model [2245] (i.e. Hub version 2) the default port is 25105. For the Hub model [2242] (i.e. Hub version 1) the default port is 9761. Use the Insteon app to find the port number for your specific Hub. Optional with Hub.
  required: true
  type: integer
username:
  description: The username to login in to the local Hub. You can find your Hub username on the bottom of the Hub or you can use the Insteon app. Required for Hub version 2 setup.
  required: false
  type: string
password:
  description: The password to login in to the local Hub. You can find your Hub password on the bottom of the Hub or you can use the Insteon app. Required for Hub version 2 setup.
  required: false
  type: string
hub_version:
  description: The Hub version number where model [2242] is Hub version 1 and model [2245] is Hub version 2. Required for Hub version 1 setup.
  required: false
  default: 2
  type: integer
device_override:
  description: Override the default device definition.
  required: false
  type: list
  keys:
    address:
      description: is found on the device itself in the form 1A.2B.3C or 1a2b3c.
      required: true
      type: string
    cat:
      description: is found in the back of the device's User Guide in the form of 0x00 - 0xff.
      required: false
      type: integer
    subcat:
      description: is found in the back of the device's User Guide in the form of 0x00 - 0xff.
      required: false
      type: integer
    firmware:
      description: are more advanced options and will typically not be used.
      required: false
      type: string
    product_key:
      description: are more advanced options and will typically not be used.
      required: false
      type: integer
x10_devices:
  description: Define X10 devices to control or respond to.
  required: false
  type: list
  keys:
    housecode:
      description: is the X10 housecode values a - p
      required: true
      type: string
    unitcode:
      description: is the X10 unit code values 1 - 16
      required: true
      type: integer
    platform:
      description: "is the Home Assistant Platform to associate the device with. The following platforms are supported: binary_sensor: Used for on/off devices or keypad buttons that are read-only. light: Used for dimmable X10 devices. switch: Used for On/Off X10 devices."
      required: true
      type: string
    dim_steps:
      description: is the number of dim/bright steps the device supports. Used for dimmable X10 devices only.
      required: false
      default: 22
      type: integer
x10_all_units_off:
  description: Creates a binary_sensor that responds to the X10 standard command for All Units Off.
  required: false
  type: string
x10_all_lights_on:
  description: Creates a binary_sensor that responds to the X10 standard command for All Lights On
  required: false
  type: string
x10_all_lights_off:
  description: Creates a binary_sensor that responds to the X10 standard command for All Lights Off
  required: false
  type: string
{% endconfiguration %}

### 장치 자동검색

자동 검색이 처음 실행될 때 기간은 장치 당 최대 20 초가 필요할 수 있습니다. 캐시된 장치 정보를 사용하면 이후의 시작이 훨씬 빨라집니다. 자동 검색 중에 장치가 인식되지 않으면 장치를 **device_override** 설정에 추가 할 수 있습니다.

장치를 검색하려면 응답기(responder) 또는 컨트롤러로 INSTEON 모뎀에 연결되어 있어야합니다.

### 장치를 INSTEON 모뎀에 장치 연결

두 개의 Insteon 장치가 서로 통신하려면 장치가 연결되어 있어야합니다. 장치 연결에 대한 개요는 [understanding linking]의 Insteon 페이지를 참조하십시오. Insteon Modem 모듈은 [Development Tools] 서비스 호출을 통한 All-Linking을 지원합니다. 다음과 같은 서비스를 이용할 수 있습니다 :

- **insteon.add_all_link**: Puts the Insteon Modem (IM) into All-Linking mode. The IM can be set as a controller or a responder. If the IM is a controller, put the IM into linking mode then press the SET button on the device. If the IM is a responder, press the SET button on the device then put the IM into linking mode.
- **insteon.delete_all_link**: Tells the Insteon Modem (IM) to remove an All-Link record from the All-Link Database of the IM and a device. Once the IM is set to delete the link, press the SET button on the corresponding device to complete the process.
- **insteon.load_all_link_database**: Load the All-Link Database for a device. WARNING - Loading a device All-Link database may take a LONG time and may need to be repeated to obtain all records.
- **insteon.print_all_link_database**: Print the All-Link Database for a device. Requires that the All-Link Database is loaded first.
- **insteon.print_im_all_link_database**: Print the All-Link Database for the INSTEON Modem (IM).

고급 옵션을 찾고 있다면 [insteonplm] Python 모듈과 함께 배포된 [insteonplm_interactive] Command line tool을 사용할 수 있습니다. [insteonplm] GitHub 사이트의 설명서를 참조하십시오. 또는 모든 Windows PC에서 실행되는 [HouseLinc]를 다운로드하거나 오픈 소스이고 대부분의 플랫폼에서 실행되는 [Insteon Terminal]을 사용할 수 있습니다. SmartHome은 더 이상 HouseLinc을 지원하지 않지만 여전히 작동합니다. Insteon Terminal은 매우 유용한 도구이지만 면책 조항을 주의 깊게 읽으십시오. 중요합니다.

[understanding linking]: https://www.insteon.com/support-knowledgebase/2015/1/28/understanding-linking
[Development Tools]: /docs/tools/dev-tools/
[HouseLinc]: https://www.smarthome.com/houselinc.html
[Insteon Terminal]: https://github.com/pfrommerd/insteon-terminal
[insteonplm_interactive]: https://github.com/nugget/python-insteonplm#command-line-interface

### Customization

홈어시스턴트가 INSTEON 모뎀에 연결하려면 PLM 포트 또는 허브 IP 주소, 사용자 이름 및 비밀번호만 있으면됩니다. 모뎀의 ALL-Link 데이터베이스에 있는 지원되는 모든 INSTEON 장치가 노출됩니다. 그러나 장치는 INSTEON 16진 주소 (예 :“1A.2B.3C”)로만 표시되며 이는 다소 다루기 힘들 수 있습니다. ‘Set’ 버튼을 사용하여 기기를 연결 및 연결을 해제하면 기기가 홈어시스턴트에서 자동으로 추가 및 제거됩니다.

설정의 일반 홈어시스턴트 [device customization] 섹션을 사용하여 친숙한 이름과 특수 아이콘을 장치에 할당할 수 있습니다. binary_sensor INSTEON 장치에서 device_class를 설정하는 데 특히 유용합니다.

[device customization]: /getting-started/customizing-devices/

### 장치 재정의

INSTEON 장치는 하드웨어의 모델 및 기능에 따라 가장 적합한 플랫폼을 사용하여 Home Assistant에 추가됩니다. INSTEON 장치의 기능은 Home Assistant 플랫폼에 내장되어 있습니다. 플랫폼을 변경하지 않는 것이 좋습니다.

**device_override** 기능에는 두 가지 주요 용도가 있습니다.

- 자동 검색 중에 응답하지 않는 장치. 이는 배터리로 작동되는 장치에선 일반적입니다.
- 완전히 개발되지 않은 장치. 이를 통해 알 수 없는 장치를 다른 장치와 유사하게 작동하는 장치에 매핑 할 수 있습니다.

### 옵션 설정을 한 설정 예시

```yaml
# Full example of Insteon configuration with customizations and overrides

homeassistant:
  customize:
    light.a1b2c3:
      friendly_name: Bedside Lamp
    binary_sensor.a2b3c4:
      friendly_name: Garage Door
      device_class: opening

insteon:
  port: /dev/ttyUSB0
  device_override:
    - address: a1b2c3  # Hidden Door Sensor [2845-222]
      cat: 0x10
      subcat: 0x11
```

### 하지 말아야 할 것 

Insteon Modem은 최상위 통합구성요소이며 장치 검색은 장치가 속한 Home Assistant 플랫폼을 식별합니다. 따라서 다른 플랫폼에서 Insteon 장치를 선언하지 마십시오. 예를 들어 이 설정은 작동하지 않습니다.

```yaml
light:
  - platform: insteon
    address: 1a2b3c
```

### INSTEON 장면 (Scenes)

INSTEON 장면 트리거링은 자동화를 통해 수행됩니다. 이 기능을 지원하기 위해 두 가지 서비스가 제공됩니다.

- **insteon.scene_on**
  - **group**: (required) The INSTEON scene number to trigger.
- **insteon.scene_off**
  - **group**: (required) The INSTEON scene to turn off

```yaml
automation:
  # Trigger an INSTEON scene 25
  - id: trigger_scene_25_on
    alias: Turn on scene 25
    action:
      - service: insteon.scene_on
        group: 25
```

### Events 와 Mini-Remotes

Mini-Remote 장치는 홈어시스턴트 엔티티로 나타나지 않고 이벤트를 생성합니다. 다음과 같은 이벤트가 있습니다 :

- **insteon.button_on**
  - **address**: (required) The Insteon device address in lower case without dots (e.g., 1a2b3c)
  - **button**: (Optional) The button id in lower case. For a 4-button remote the values are `a` to `d`. For an 8 button remote the values are `a` to `h`. For a one-button remote this field is not used.
- **insteon.button_off**
  - **address**: (required) The Insteon device address in lower case without dots (e.g., 1a2b3c)
  - **button**: (Optional) The button id in lower case. For a 4-button remote the values are a to d. For an 8 button remote the values are `a` to `h`. For a one-button remote this field is not used.

이를 통해 mini-remotes를 자동화하기 위한 트리거로 설정 할 수 있습니다. 다음은 이러한 이벤트를 자동화에 사용하는 방법의 예입니다.

```yaml
automation:
  # 4 or 8 button remote with button c pressed
  - id: light_on
    alias: Turn a light on
    trigger:
      - platform: event
        event_type: insteon.button_on
    event_data:
      address: 1a2b3c
      button: c
    condition:
      - condition: state
        entity_id: light.some_light
        state: 'off'
    action:
      - service: light.turn_on
        entity_id: light.some_light

  # single button remote
  - id: light_off
    alias: Turn a light off
    trigger:
      - platform: event
        event_type: insteon.button_on
    event_data:
      address: 1a2b3c
    condition:
      - condition: state
        entity_id: light.some_light
        state: 'off'
    action:
      - service: light.turn_on
        entity_id: light.some_light
```

### INSTEON Hub에 알려진 이슈들

INSTEON Hub에는 허브 디자인에 지속되어온 세 가지 알려진 이슈가 있습니다.

1. 로그 파일에 허브 연결이 닫혔으며 다시 연결에 실패했다는 오류 메시지가 여러 개 표시되면 일반적으로 허브를 다시 시작하여 다시 연결해야합니다.

2. Home Assistant와 INSTEON 앱을 모두 사용할 수 없습니다. 그렇게하면 앱에서 변경 한 내용이 Home Assistant에 나타나지 않습니다. 그러나 일정 기간이 지나면 Home Assistant에서 변경 한 내용이 앱에 나타납니다.

3. 허브 응답 시간이 매우 느릴 수 있습니다. 이는 허브 폴링 장치가 자주 있기 때문입니다. 한 번에 하나의 INSTEON 메시지 만 브로드 캐스트 할 수 있으므로 Home Assistant와 주고받는 메시지가 지연될 수 있습니다.
