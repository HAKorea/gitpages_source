---
title: 데콘즈(deCONZ)
description: Instructions on how to setup ConBee/RaspBee devices with deCONZ from dresden elektronik within Home Assistant.
logo: deconz.jpeg
ha_category:
  - Hub
  - Binary Sensor
  - Cover
  - Light
  - Scene
  - Sensor
  - Switch
ha_release: 0.61
ha_iot_class: Local Push
ha_config_flow: true
ha_quality_scale: platinum
ha_codeowners:
  - '@kane610'
---
<iframe width="690" height="437" src="https://www.youtube.com/embed/LeuHpBdwmag?start=634" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[dresden elektronik](https://www.dresden-elektronik.de)의 [deCONZ](https://www.dresden-elektronik.de/funk/software/deconz.html)는 ConBee/RaspBee Zigbee 게이트웨이와 통신하고 게이트웨이에 연결된 Zigbee 장치를 보여주는 소프트웨어입니다.

[deCONZ REST API](https://dresden-elektronik.github.io/deconz-rest-doc/).

현재 홈 어시스턴트에서 다음 장치 유형이 지원됩니다. :


- [Binary Sensor](#binary-sensor)
- [Climate](#climate)
- [Cover](#cover)
- [Light](#light)
- [Scene](#scene)
- [Sensor](#sensor)
- [Switch](#switch)

## deCONZ를 실행하는 권장 방법

홈어시스턴트를 운영하는 경우 add-on store에 [deCONZ 공식 add-on](https://github.com/home-assistant/hassio-addons/tree/master/deconz)이 사용가능합니다. 
그렇지 않으면 [community container](https://hub.docker.com/r/marthoc/deconz/) 를 사용하십시오.

### 지원되는 장치 

[deCONZ wiki](https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/Supported-Devices)에서 지원되는 장치 리스트를 참조하십시오. 

## 설정

`configuration.yaml` 파일에 `discovery : `가 있으면 Home Assistant는 네트워크에서 deCONZ를 자동으로 감지합니다.

API 키가 없는 경우 Philips Hue와 유사한 원 클릭 기능을 사용하여 deCONZ 용 API 키를 생성 할 수 있습니다. Phoscon 앱에서 **Settings** → **Gateway** → **Advanced** → **Authenticate app** 으로 이동 한 후 홈어시스턴트 프론트 엔드의 deCONZ 설정을 사용하여 API 키를 작성하십시오. deCONZ 설정을 마치면 설정 항목으로 저장됩니다.

통합구성요소 페이지로 이동하여 deCONZ를 수동으로 추가 할 수 있습니다.

## 디버깅 

deCONZ 또는 연동에 문제가있는 경우 로그에 디버그 출력을 추가 할 수 있습니다.

```yaml
logger:
  default: info
  logs:
    pydeconz: debug
    homeassistant.components.deconz: debug
```

## 문제 해결

문제가 발생하여 문제를 보고하려는 경우 항상 최신 [deCONZ software version](https://github.com/dresden-elektronik/deconz-rest-plugin/releases) 및 [latest firmware for hardware](http://deconz.dresden-elektronik.de/deconz-firmware/?C=M;O=D)를 사용하고 있는지 확인하십시오 .

## 장치 서비스

사용 가능한 서비스: `configure` 및 `deconz.device_refresh`.

### `deconz.configure` 서비스

[REST-API](https://dresden-elektronik.github.io/deconz-rest-doc/rest/) 를 사용하여 deCONZ에서 장치의 속성 설정

| Service data attribute | Optional | Description |
|-----------|----------|-------------|
| `field` | No | deCONZ에서 특정 장치를 나타내는 문자열. |
| `entity` | No | deCONZ에서 장치의 특정 홈어시스턴트 엔티티를 나타내는 문자열. |
| `data` | No | 특정 데이터를 변경하려는 JSON 객체 데이터. |

`entity` 또는 `field`가 제공되어야 합니다. 둘 다 존재하면 `field`는 특정`entity`에 해당하는 장치경로 아래의 하위 경로로 해석됩니다. :

```json
{ "field": "/lights/1", "data": {"name": "light2"} }
```

```json
{ "entity": "light.light1", "data": {"name": "light2"} }
```

```json
{ "entity": "light.light1", "field: "/state", "data": {"on": true} }
```

```json
{ "field": "/config", "data": {"permitjoin": 60} }
```

#### `deconz.device_refresh` 서비스

Home Assistants가 최근에 다시 시작된 후 deCONZ에 추가된 장치로 새로 고칩니다.

참고 : 새 센서가 추가되면 deCONZ가 자동으로 Home Assistant에 신호를 보내지만 이 시점에서(deCONZ v2.05.35) 다른 장치를 추가할 경우 이 서비스를 사용하여 수동으로 추가하거나 홈 어시스턴트를 다시 시작해야합니다.

## 리모콘 장치

원격 제어 (ZHASwitch 범주)는 일반 엔티티로 표시되지 않고  페이로드가 `id`와 `event`인 `deconz_event`라는 이벤트로 표시되고 Aqara Magic Cube의 경우 `gesture`로 나타납니다. Id는 deCONZ의 장치 이름이고 Event는 스위치의 순간 상태입니다. gesture는 90도 뒤집기, 180도 뒤집기, 시계 방향 및 시계 반대 방향 회전과 같은 Aqara Magic Cube 특정 이벤트에 사용됩니다. 그러나 deCONZ에 의해 보고된 sensor.device_name_battery_level 이라는 스위치의 배터리 수준을 표시하는 센서 엔티티가 작성됩니다. 

Typical values for switches, the event codes are 4 numbers where the first and last number are of interest here. 
스위치의 일반적인 값인 이벤트 코드는 4개의 숫자입니다. 여기서 첫 번째 숫자와 마지막 숫자가 중요합니다.

| Switch code | Description |
|-------------|-------------|
| 1XXX | Button #1 up to #8 |
| XXX1 | Button hold |
| XXX2 | Button short release |
| XXX3 | Button long release |

Where for example on a Philips Hue Dimmer, 2001 would be holding the dim up button.
예를 들어 Philips Hue Dimmer에서 2001은 dim up 버튼을 눌림을 의미합니다.

For the IKEA Tradfri remote the first digit equals, 1 for the middle button, 2 for up, 3 for down, 4 for left, and 5 for right (e.g., "event: 1002" for middle button short release).
IKEA Tradfri 리모컨의 첫 번째 숫자는 가운데 버튼의 경우 1, 위 버튼의 경우 2, 아래로의 경우 3, 최측의 경우 4, 왼쪽의 경우 5입니다 (예 : 가운데 버튼의 짧은 릴리스의 경우 "이벤트 : 1002").

Aqara Magic Cube의 특정 제스처는 : 

| Gesture | Description |
|---------|-------------|
| 0 | Awake |
| 1 | Shake |
| 2 | Free fall |
| 3 | Flip 90 |
| 4 | Flip 180 |
| 5 | Move on any side |
| 6 | Double tap on any side |
| 7 | Turn clockwise |
| 8 | Turn counter clockwise |

### 이벤트 찾기 (Finding your events)

**개발자 도구->이벤트**로 이동하십시오 . **Listen to events** 섹션에서 `deconz_event`를 추가하고 **START LISTENING**을 누릅니다. deCONZ의 모든 이벤트가 표시되고 로그를 모니터링하는 동안 원격 버튼을 누르면 원하는 이벤트를 쉽게 찾을 수 있습니다.

### 장치 트리거

자동화에서 원격 제어 장치 사용을 단순화하기 위해 deCONZ 통합구성요소는 장치를 장치 트리거로 표시합니다. 이렇게하면 가능한 모든 버튼 누름 및 회전 변형이 보입니다. 이 목록은 수동으로 선별된 목록이며 deCONZ가 지원하는 것만큼 초기에는 완성되지 않습니다.

장치 트리거로 현재 지원되는 장치 :

- Hue Dimmer Remote
- Hue Tap
- Symfonisk Sound Controller
- Trådfri On/Off Switch
- Trådfri Open/Close Remote
- Trådfri Remote Control
- Trådfri Wireless Dimmer
- Aqara Double Wall Switch
- Aqara Mini Switch
- Aqara Round Switch
- Aqara Square Switch
- Aqara Magic Cube

#### 새로운 장치 트리거에 대한 지원 요청

추가 장치에 대한 지원을 요청하려면 장치 모델(디버그 로그에서 얻을 수 있음)과 동작 및 버튼 이벤트 매핑 (예 : Hue dimmer remote model “RWL021”, Short press on 1000)이 필요합니다.

## 사례

### YAML

#### 무선 Dimmer의 input number를 통한 스텝업 및 스텝다운 
{% raw %}

```yaml
automation:
  - alias: 'Toggle lamp from dimmer'
    initial_state: 'on'
    trigger:
      platform: event
      event_type: deconz_event
      event_data:
        id: remote_control_1
        event: 1002
    action:
      service: light.toggle
      entity_id: light.lamp

  - alias: 'Increase brightness of lamp from dimmer'
    initial_state: 'on'
    trigger:
      platform: event
      event_type: deconz_event
      event_data:
        id: remote_control_1
        event: 2002
    action:
      - service: light.turn_on
        data_template:
          entity_id: light.lamp
          brightness: >
            {% set bri = state_attr('light.lamp', 'brightness') | int %}
            {{ [bri+30, 249] | min }}

  - alias: 'Decrease brightness of lamp from dimmer'
    initial_state: 'on'
    trigger:
      platform: event
      event_type: deconz_event
      event_data:
        id: remote_control_1
        event: 3002
    action:
      - service: light.turn_on
        data_template:
          entity_id: light.lamp
          brightness: >
            {% set bri = state_attr('light.lamp', 'brightness') | int %}
            {{ [bri-30, 0] | max }}

  - alias: 'Turn lamp on when turning cube clockwise'
    initial_state: 'on'
    trigger:
      platform: event
      event_type: deconz_event
      event_data:
        id: remote_control_1
        gesture: 7
    action:
      service: light.turn_on
      entity_id: light.lamp
```

{% endraw %}

### Appdaemon

#### Appdaemon event helper

마지막 이벤트의 id와 이벤트 데이터를 표시하는 속성을 나타내는 상태 센서 `sensor.deconz_event`를 작성하는 헬퍼 앱.

Put this in `apps.yaml`:
{% raw %}

```yaml
deconz_helper:
  module: deconz_helper
  class: DeconzHelper
```

`deconz_helper.py`에 다음을 넣으십시오 : 

```python
import appdaemon.plugins.hass.hassapi as hass
import datetime
from datetime import datetime


class DeconzHelper(hass.Hass):
    def initialize(self) -> None:
        self.listen_event(self.event_received, "deconz_event")

    def event_received(self, event_name, data, kwargs):
        event_data = data["event"]
        event_id = data["id"]
        event_received = datetime.now()

        self.log(f"Deconz event received from {event_id}. Event was: {event_data}")
        self.set_state(
            "sensor.deconz_event",
            state=event_id,
            attributes={
                "event_data": event_data,
                "event_received": str(event_received),
            },
        )
```

{% endraw %}

참고 : 하나의 이벤트가 전송되기 전에는 해당 이벤트가 표시되지 않습니다

#### Appdaemon 원격 템플릿

{% raw %}

```yaml
remote_control:
  module: remote_control
  class: RemoteControl
  event: deconz_event
  id: dimmer_switch_1
```

```python
import appdaemon.plugins.hass.hassapi as hass


class RemoteControl(hass.Hass):
    def initialize(self):
        if "event" in self.args:
            self.listen_event(self.handle_event, self.args["event"])

    def handle_event(self, event_name, data, kwargs):
        if data["id"] == self.args["id"]:
            self.log(data["event"])
            if data["event"] == 1002:
                self.log("Button on")
            elif data["event"] == 2002:
                self.log("Button dim up")
            elif data["event"] == 3002:
                self.log("Button dim down")
            elif data["event"] == 4002:
                self.log("Button off")
```

{% endraw %}

#### Appdaemon 원격 템플릿

[Teachingbirds](https://community.home-assistant.io/u/teachingbirds/summary)의 커뮤니티앱 . 이 앱은 Ikea Tradfri 리모컨을 사용하여 재생/일시정지, 볼륨 증가 및 감소, 다음 및 이전 트랙으로 Sonos 스피커를 제어합니다.

{% raw %}

```yaml
sonos_remote_control:
  module: sonos_remote
  class: SonosRemote
  event: deconz_event
  id: sonos_remote
  sonos: media_player.sonos
```

{% endraw %}

{% raw %}

```python
import appdaemon.plugins.hass.hassapi as hass


class SonosRemote(hass.Hass):
    def initialize(self):
        self.sonos = self.args["sonos"]
        if "event" in self.args:
            self.listen_event(self.handle_event, self.args["event"])

    def handle_event(self, event_name, data, kwargs):
        if data["id"] == self.args["id"]:
            if data["event"] == 1002:
                self.log("Button toggle")
                self.call_service("media_player/media_play_pause", entity_id=self.sonos)

            elif data["event"] == 2002:
                self.log("Button volume up")
                self.call_service("media_player/volume_up", entity_id=self.sonos)

            elif data["event"] == 3002:
                self.log("Button volume down")
                self.call_service("media_player/volume_down", entity_id=self.sonos)

            elif data["event"] == 4002:
                self.log("Button previous")
                self.call_service(
                    "media_player/media_previous_track", entity_id=self.sonos
                )

            elif data["event"] == 5002:
                self.log("Button next")
                self.call_service("media_player/media_next_track", entity_id=self.sonos)
```

{% endraw %}

## Binary 센서

다음과 같은 센서 유형이 지원 :

- 화재/연기 감지
- 개폐 감지
- 재실 감지
- 누수 감지

`entity_id` 이름은 `binary_sensor.device_name`이며, 여기서 `device_name`은 deCONZ에 정의되어 있습니다.

### 검증된 Binary 센서 장치 

- 개폐 감지
  - Xiaomi Smart Home Security Door & Window Contact Sensor
- 재실 감지
  - IKEA Trådfri Motion Sensor
  - Philips Hue Motion Sensor
  - Xiaomi Motion Sensor
  - Xiaomi Smart Home Aqara Human Body Sensor
- 누수 감지
  - Xiaomi Aqara water leak Sensor

## Climate 

설정 지침 은 [deCONZ main integration](/integrations/deconz/) 을 참조하십시오 .

Climate는 통상 온도 조절기를 나타냅니다.

climate 플랫폼의 장치는 센서로 식별되므로 climate 장치인 "센서"를 정의하는 수동 선별 목록이 있습니다.

`entity_id` 이름은 `climate.device_name`이며, 여기서 `device_name`은 deCONZ에 정의되어 있습니다.

#### 검증된 climate 장치

- Bitron Thermostat 902010/32
- Eurotronic SPZB0001

## Cover (개폐 장치)

Cover는 환기 댐퍼 또는 스마트 창 덮개와 같은 장치입니다.

Cover 플랫폼의 장치는 라이트로 식별되므로 어떤 "Light"가 Cover인지를 정의하는 수동으로 선별된 목록이 있습니다. 따라서 deCONZ(Phoscon App)에서 Cover 장치를 Light 장치로 추가합니다.

`entity_id` 이름은 `cover.device_name`이며, 여기서 `device_name`은 deCONZ에 정의되어 있습니다.

### 검증된 cover 장치

- Keen vents
- Xiaomi Aqara Curtain controller

## 조명 (Light)

`entity_id` 이름은 `light.device_name`이며, 여기서 `device_name`은 deCONZ에 정의되어 있습니다. deCONZ에서 생성 된 Light 그룹은 Home Assistant에서 `light.group_name_in_deconz`라는 Light로 생성되므로 사용자는 deCONZ에 대한 단일 API 호출만으로 Light 그룹을 제어 할 수 있습니다.

### 검증된 light 장치

- IKEA Trådfri bulb E14 WS Opal 400lm
- IKEA Trådfri bulb E14 WS Opal 600lm
- IKEA Trådfri bulb E27 WS clear 806lm
- IKEA Trådfri bulb E27 WS clear 950lm
- IKEA Trådfri bulb E27 WS Opal 980lm
- IKEA Trådfri bulb E27 WS Opal 1000lm
- IKEA Trådfri bulb E27 WS & RGB Opal 600lm
- IKEA Trådfri bulb GU10 W 400lm
- IKEA Trådfri FLOALT LED light panel
- Innr BY-265, BY-245
- OSRAM Classic A60 W clear - LIGHTIFY
- OSRAM Flex RGBW
- OSRAM Gardenpole RGBW
- Philips Hue White A19
- Philips Hue White Ambiance A19
- Philips Hue Hue White ambiance Milliskin (recessed spotlight) LTW013
- Philips Hue LightStrip Plus
- Busch Jaeger ZigBee Light Link univ. relai (6711 U) with ZigBee Light Link control element 6735-84
- Xiaomi Aqara Smart Led Bulb (white) E27 ZNLDP12LM 

## 장면 (Scene)

`entity_id` 이름은`scene.group_scene_name`이 됩니다. 여기서 `group`은 장면(scene)이 속한 그룹이고 장면 이름, 그룹과 이름 모두 deCONZ에 정의되어 있습니다.

## 센서

다음과 같은 센서 유형이 지원됩니다. : 


- 습도 센서
- 조도 센서
- 압력 센서
- 스위치
- 온도 센서

`entity_id` 이름은 `sensor.device_name`이며, 여기서 `device_name`은 deCONZ에 정의되어 있습니다. 스위치는 일반 엔티티로 노출되지 않습니다. 자세한 내용은 [deCONZ main integration](/integrations/deconz/)을 참조하십시오.

### 검증된 센서 장치

- 습도 센서
  - Xiaomi Aqara Humidity/Temperature Sensor
  - Xiaomi MiJia Smart Temperature & Humidity Sensor
- 조도 센서
- 압력 센서
- 스위치
  - IKEA Trådfri Wireless Dimmer
  - Philips Hue Motion Sensor
  - IKEA Trådfri Remote
  - Philips Hue Dimmer Switch
  - Xiaomi Aqara Smart Light Switch
  - Xiaomi Aqara Smart Wireless Switch
  - Xiaomi Smart Home Wireless Switch
- 온도 센서
  - Xiaomi Temperature/Humidity Sensor
- 개폐 센서
  - Xiaomi Window / Door Sensor with Temperature

### DECONZ 일광 센서 (daylights)

deCONZ Daylight 센서는 버전 2.05.12 이후 deCONZ 소프트웨어에 내장된 특수 센서입니다. Home Assistant에는 sensor.daylight라는 센서로 표시됩니다. 센서의 상태 값은 일광 단계에 해당하는 문자열입니다 (아래 설명 은 deCONZ 구현의 기반이되는 https://github.com/mourner/suncalc 에서 가져옴).

| Sensor State | Description |
|--------------|-------------|
| sunrise_start | 일출 (태양의 가장자리가 수평선에 나타남) |
| sunrise_end | 일출이 끝납니다 (태양의 아래쪽 가장자리가 수평선에 닿음) |
| golden_hour_1 | 아침 황금 시간 (소프트 라이트, 사진 촬영에 가장 좋은 시간) |
| solar_noon | 정오 (태양이 가장 높은 위치에 있음) |
| golden_hour_2 | 저녁 황금 시간 |
| sunset_start | 일몰이 시작됩니다 (태양의 아래쪽 가장자리가 수평선에 닿음) |
| sunset_end | 일몰 (해가 수평선 아래에서 사라지고, 저녁 시민 황혼이 시작됩니다) |
| dusk | 황혼 (저녁 해상 황혼의 시작) |
| nautical_dusk | 해상 황혼 (저녁 천문 황혼 시작) |
| night_start | 야간 시작 (천문학적 관측에 충분한 어둠) |
| nadir | nadir (밤의 가장 어두운 순간, 태양은 가장 낮은 위치에 있습니다) |
| night_end | 밤의 끝 (아침 천문학적 황혼이 시작된다) |
| nautical_dawn | 해상 새벽 (아침 해상 황혼이 시작됩니다) |
| dawn | 새벽 (아침 황혼이 시작됩니다) |

센서에는 "daylight" 라는 속성이 있는데, 센서 상태가 `golden_hour_1`, `solar_noon` 또는 `golden_hour_2`이면 `true`값을 가지며 그렇지 않으면 `false`입니다.

이러한 상태는 자동화에서 트리거 (예 : 특정 일광 단계가 시작되거나 종료 될 때 트리거) 또는 조건 (예 : 특정 일광 단계에있는 경우에만 트리거)으로 사용될 수 있습니다.

## 스위치

스위치는 전원 플러그 및 사이렌과 같은 장치입니다.

스위치 플랫폼의 장치는 Light으로 식별되므로 스위치인 "Light"을 정의하는 수동으로 선별된 목록이 있습니다.

`entity_id` 이름은 `switch.device_name`이며, 여기서 `device_name`은 deCONZ에 정의되어 있습니다.

### 검증된 스위치 장치

- Innr SP120
- Innr ZB-ONOFFPlug-D0005/SmartThings Smart Plug (2019) (without power measurements)
- Osram Lightify plug
- Osram Outdoor plug
- Heiman siren
