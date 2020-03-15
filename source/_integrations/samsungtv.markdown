---
title: 삼성 스마트 TV(Samsung Smart TV)
description: Instructions on how to integrate a Samsung Smart TV into Home Assistant.
logo: samsung.png
ha_category:
  - Media Player
ha_release: 0.13
ha_iot_class: Local Polling
ha_codeowners:
  - '@escoand'
---

`samsungtv` 플랫폼을 사용하면 [Samsung Smart TV](https://www.samsung.com/uk/tvs/all-tvs/)를 제어 할 수 있습니다.

### 셋업

TV가 처음 연결되면 TV에서 홈어시스턴트를 수락하여 통신을 허용해야합니다.

보통은 `discovery` 통합구성요소가 동작하는 상태이므로 자동으로 홈어시스턴트에 `삼성 TV`가 나타납니다. 
하지만 `discovery`를 비활성화 시킨 상태에서 아래와 같은 UI에서 쉽게 셋업 가능합니다. 

그럴 경우 홈어시스턴트 UI화면에서 **설정** -> **통합구성요소** -> **통합구성요소** **`+`** 추가를 선택하면 `삼성 TV`를 추가할 수 있습니다. 최근에는 별도 아래 설정을 하지 않더라도 한번에 연동할 수 있습니다. 

### 설정

[discovery component](/integrations/discovery/)에 의존하지 않고 TV를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: samsungtv
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: "The IP of the Samsung Smart TV, e.g., `192.168.0.10`."
  required: true
  type: string
port:
  description: The port of the Samsung Smart TV. If set to 8001, the new websocket connection will be used (required for 2016+ TVs) - for installs other than Hass.io or Docker you may need to install a Python package, see below.
  required: false
  type: integer
  default: 55000
name:
  description: The name you would like to give to the Samsung Smart TV.
  required: false
  type: string
timeout:
  description: The timeout for communication with the TV in seconds.
  required: false
  type: time
  default: 0 (no timeout)
mac:
  description: "The MAC address of the Samsung Smart TV, e.g., `00:11:22:33:44:55:66`. Required for power on support via wake on lan."
  required: false
  type: string
broadcast_address:
  description: The broadcast address on which to send the Wake-On-Lan packet.
  required: false
  default: 255.255.255.255
  type: string
{% endconfiguration %}

### 지원 모델

모델이 목록에없는 경우 테스트를 수행하고 모든 것이 올바르게 작동하면 [GitHub](https://github.com/home-assistant/home-assistant.io/tree/current/source/_integrations/samsungtv.markdown)의 목록에 추가하십시오

#### Naming

첫 글자 (U, P, L, H & K)는 화면 유형 (예: LED 또는 플라즈마)을 나타냅니다. 두 번째 문자는 지역을 나타내며 E는 유럽, N은 북미, A는 아시아 및 호주입니다. 다음 두 숫자는 화면 크기를 나타냅니다. 모델을 추가하는 경우 목록에 추가하기 전에 처음 4자를 제거하십시오.

예를 들어, 모델 `UN55NU7100`의 경우, `UN55`는 LED, 북미, 55 인치 TV이며 아래에 나열된 모델 번호는 `NU7100`입니다.

#### 실험완료하고 동작하는 모델들

- C7700
- D5500
- D6100
- D6300SF
- D6500
- D6505
- D6900 (WOL did not work)
- D7000
- D8000
- EH5300
- EH5600
- ES5500
- ES5700
- ES6100
- ES6300
- ES6800
- F4580
- F6300
- F6400
- F6400AF
- F6500
- F7000
- F8000BF
- K5579 (port must be set to 8001, On/Off, Forward/Backward, Volume control, but no Play button)
- K5600AK (partially supported, turn on works but state is not updated)
- K6500AF (port must be set to 8001)
- KS7005 (port must be set to 8001, MAC address must be provided, On/Off, Volume are OK, no channel change)
- KS7502 (port must be set to 8001, turn on doesn't work, turn off works fine)
- KS8000 (port must be set to 8001)
- KS8005 (port must be set to 8001)
- KS8500 (port must be set to 8001)
- KU6020 (port must be set to 8001)
- KU6100 (port must be set to 8001)
- KU6290 (port must be set to 8001)
- KU6400U (port must be set to 8001)
- KU7000 (port must be set to 8001)
- M5620 (port must be set to 8001)
- MU6170UXZG (port must be set to 8001)
- NU7090 (port must be set to 8801, On/Off, MAC must be specified for Power On)
- NU7400 (port set to 8001)
- NU8000
- U6000 (port must be set to 8001)
- U6300 (port must be set to 8001)
- UE6199UXZG (port must be set to 8001, On/Off, Forward/Backward, Volume control, but no Play button)
- UE65KS8005 (port must be set to 8001, On/Off, Forward/Backward, Volume are OK, but no Play button)
- UE49KU6470 (port must be set to 8001, On/Off, Forward/Backward, Volume are OK, but no Play button)
- UE46ES5500 (partially supported, turn on doesn't work)

#### 테스트했지만 동작하지 않았던 모델들

- J5200 - Unable to see state and unable to control
- J5500 - State is always "on" and unable to control (but port 8001 *is* open)
- J6200 - State is always "on" and unable to control (but port 8001 *is* open)
- J6300 - State is always "on" and unable to control (but port 8001 *is* open)
- JS8005 - State tracking working but unable to control (but port 8001 *is* open)
- JS9000 - State is always "on" and unable to control (but port 8001 *is* open)
- JS9500 - State is always "on" and unable to control (but port 8001 *is* open)
- JU6445K - State is always "on" and unable to control (but port 8001 *is* open)
- JU6800 - Unable to see state and unable to control
- JU7000 - Unable to see state and unable to control (but port 8001 *is* open)
- JU7500 - Unable to see state and unable to control
- MU6125 - Unable to see state and unable to control (Tested on UE58MU6125 on port 8001 and 8801)
- MU6300 - Port set to 8001, turning on works, status not working reliably, turning off is not permanent (it comes back on)
- MU6400 - Unable to see state and unable to control (using latest 1270 firmware. Had limited functionality on previous firmware)
- Q60 – Turning on works, turning off does not work, State is always "off".
- Q6F – Port set to 8001, turning on works, turning off does not work, status not working reliably.
- Q7F - State is always "off" and unable to control via port 8001.
- Q9F - Turning on works, turning off does not work. State is correct. Nothing else works. Port 8001.

None of the 2014 (H) and 2015 (J) model series (e.g., J5200) will work, since Samsung have used a different (encrypted) type of interface for these.

### 사용법

#### 채널 전환

다음 페이로드로 `media_player.play_media` 서비스를 호출하여 채널을 변경할 수 있습니다.

```javascript
{
  "entity_id": "media_player.office_tv",
  "media_content_id": "590",
  "media_content_type": "channel"
}
```
#### 소스 선택 (Selecting a source)

소스 선택이 아직 구현되지 않았습니다.

### Hass.io

추가 조치가 필요하지 않습니다

### Docker

추가 조치가 필요하지 않습니다

### 다른 설치 방법

홈어시스턴트 설치에 `websocket-client` Python 패키지를 설치해야합니다. 이는 아마도 다음과 같이 이루어질 것입니다 :

```bash
pip3 install websocket-client
```

venv 설치를 사용하는 경우 venv를 활성화하는 것을 기억하십시오.