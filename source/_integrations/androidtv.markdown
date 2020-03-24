---
title: 안드로이드 TV(Android TV)
description: Instructions on how to integrate Android TV and Fire TV devices into Home Assistant.
logo: androidtv.png
ha_category:
  - Media Player
ha_release: 0.7.6
ha_iot_class: Local Polling
ha_codeowners:
  - '@JeffLIrion'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/m4kDsy36x5U" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`androidtv` 플랫폼을 사용하면 Android TV 장치 또는 [Amazon Fire TV](https://www.amazon.com/b/?node=8521791011)장치를 제어할 수 있습니다.

## 장치 준비

장치를 설정하려면 IP 주소를 찾고 ADB 디버깅을 활성화해야합니다. Android TV 장치의 경우 설명서를 참조하십시오.

Fire TV 장치의 지침은 다음과 같습니다.

- Turn on ADB Debugging on your Amazon Fire TV:
  - From the main (Launcher) screen, select Settings.
  - Select My Fire TV > Developer Options.
  - Select ADB Debugging.
- Find Amazon Fire TV device IP address:
  - From the main (Launcher) screen, select Settings.
  - Select My Fire TV > About > Network.


## 설정 

```yaml
# Example configuration.yaml entry
media_player:
  # Use the Python ADB implementation
  - platform: androidtv
    name: Android TV 1
    host: 192.168.0.111

  # Use an ADB server for sending ADB commands
  - platform: androidtv
    name: Android TV 2
    host: 192.168.0.222
    adb_server_ip: 127.0.0.1
```

{% configuration %}
host:
  description: Android TV / Fire TV 장치의 IP 주소.
  required: true
  type: string
name:
  description: 장치의 이름.
  required: false
  default: Android TV
  type: string
port:
  description: Android TV / Fire TV 장치의 포트.
  required: false
  default: 5555
  type: integer
adbkey:
  description: "`adbkey` 파일의 경로. 제공되지 않으면 홈어시스턴트가 필요한 경우 키를 생성합니다. (필요한 경우)"
  required: false
  type: string
adb_server_ip:
  description: ADB 서버의 IP 주소. 제공되면 통합구성요소는 [ADB Server](#2-adb-server)를 사용하여 장치와 통신.
  required: false
  type: string
adb_server_port:
  description: ADB 서버의 포트.
  required: false
  default: 5037
  type: integer
get_sources:
  description: 실행중인 앱을 소스 목록으로 검색할지 여부.
  required: false
  default: true
  type: boolean
apps:
  description: 키가 앱ID이고 값이 UI에 표시될 앱이름인 dictionary 입니다. 아래 예를 참조하십시오. ([These app names](https://github.com/JeffLIrion/python-androidtv/blob/5c39196ade3f88ab453b205fd15b32472d3e0482/androidtv/constants.py#L267-L283)은 백엔드 패키지에 설정되며 설정에 포함하지 않아도됩니다.)
  required: false
  default: {}
  type: map
device_class:
  description: "장치 유형: `auto` (Android TV 또는 Fire TV 장치인지 감지), `androidtv` 또는`firetv`."
  required: false
  default: auto
  type: string
state_detection_rules:
  description: 키가 앱ID이고 값이 상태 감지 규칙 목록인 dictionary; 자세한 내용은 [Custom State Detection](#custom-state-detection) 섹션을 참조하십시오.
  required: false
  default: {}
  type: map
turn_on_command:
  description: 기본 `turn_on` 명령을 대체 할 ADB 쉘 명령.
  required: false
  type: string
turn_off_command:
  description: 기본 `turn_off` 명령을 대체 할 ADB 쉘 명령.
  required: false
  type: string
{% endconfiguration %}

### 전체 설정

```yaml
# Example configuration.yaml entry
media_player:
  # Use the Python ADB implementation with a user-provided key to setup an
  # Android TV device. Provide an app name, override the default turn on/off
  # commands, and provide custom state detection rules.
  - platform: androidtv
    name: Android TV
    device_class: androidtv
    host: 192.168.0.222
    adbkey: "/config/android/adbkey"
    apps:
      com.amazon.tv.launcher: "Fire TV"
    turn_on_command: "input keyevent 3"
    turn_off_command: "input keyevent 223"
    state_detection_rules:
      'com.amazon.tv.launcher':
        - 'standby'
      'com.netflix.ninja':
        - 'media_session_state'
      'com.ellation.vrv':
        - 'audio_state'
      'com.plexapp.android':
        - 'paused':
            'media_session_state': 3  # this indentation is important!
            'wake_lock_size': 1       # this indentation is important!
        - 'playing':
            'media_session_state': 3  # this indentation is important!
        - 'standby'
      'com.amazon.avod':
        - 'playing':
            'wake_lock_size': 4  # this indentation is important!
        - 'playing':
            'wake_lock_size': 3  # this indentation is important!
        - 'paused':
            'wake_lock_size': 2  # this indentation is important!
        - 'paused':
            'wake_lock_size': 1  # this indentation is important!
        - 'standby'

  # Use an ADB server to setup a Fire TV device and don't get the running apps.
  - platform: androidtv
    name: Fire TV
    device_class: firetv
    host: 192.168.0.222
    adb_server_ip: 127.0.0.1
    adb_server_port: 5037
    get_sources: false
```

## ADB 셋업

이 통합구성요소는 ADB 명령을 Android TV / Fire TV 장치로 전송하여 작동합니다. 이를 달성하는 데는 두 가지 방법이 있습니다.

<div class='note'>
기기에 처음 연결하면 Android TV / Fire TV에 ​​연결 승인을 요청하는 대화 상자가 나타납니다. "always allow connections from this device" 이라는 상자를 선택하고 확인을 누르십시오.
</div>

### 1. 파이썬 ADB 구현

기본 접근 방식은 `adb-shell` Python 패키지를 사용하여 장치에 연결하는 것입니다. Home Assistant 0.101부터 인증에 키가 필요하고 `adbkey` 설정 옵션에서 키를 제공하지 않으면 Home Assistant가 키를 생성합니다.

Home Assistant 0.101 이전에는 이 ​​방법이 최신 장치에서는 제대로 작동하지 않았습니다. 이러한 문제를 해결하기 위해 노력했지만 문제가 발생하면 ADB 서버 옵션을 사용해야합니다.

### 2. ADB 서버

두 번째 옵션은 ADB 서버를 사용하여 Android TV 및 Fire TV 장치에 연결하는 것입니다.

Hass.io 사용자의 경우 [Android Debug Bridge](https://github.com/hassio-addons/addon-adb/blob/master/README.md) 애드온을 설치할 수 있습니다. 이 방법을 사용하면 Home Assistant는 ADB 명령을 서버로 전송한 다음 Android TV / Fire TV 장치로 전송하여 Home Assistant에 다시 보고합니다. 이 옵션을 사용하려면 `adb_server_ip` 옵션을 설정에 추가하십시오. 홈 어시스턴트와 동일한 머신에서 서버를 실행중인 경우이 값으로 `127.0.0.1`을 사용할 수 있습니다.

## ADB 문제 해결

Android TV 또는 Fire TV 장치 설정에 실패하면 ADB 연결에 문제가 있을 수 있습니다. 가능한 원인은 다음과 같습니다.

1. 장치의 IP 주소가 잘못되었습니다.

2. 장치에서 ADB를 사용할 수 없습니다.

3. 다른 기기에서 ADB를 통해 Android TV / Fire TV에 ​​이미 연결되어 있습니다. 하나의 장치 만 연결할 수 있으므로 다른 장치의 연결을 끊고 Android TV / Fire TV를 다시 시작한 다음 (가정용) 홈어시스턴트를 다시 시작하십시오.

4. ADB 연결을 승인해야합니다. 위의 [ADB Setup](#adb-setup) 섹션에있는 참고 사항을 참조하십시오.

5. 일부 Android TV 장치 (예: Android TV를 실행하는 Philips TV)는 Wi-Fi 인터페이스를 통한 초기 ADB 연결 요청만 수락합니다. TV가 유선 인 경우 WiFi에 연결하고 초기 연결을 다시 시도해야합니다. Wi-Fi를 통해 인증이 승인되면 유선 인터페이스를 통해 TV에 연결할 수도 있습니다.

6. 장치가 WiFi를 끊어 ADB 연결을 끊고 Home Assistant에서 엔터티를 사용할 수 없는 경우 깨우기 잠금 유틸리티(such as [Wakelock](https://github.com/d4rken/wakelock-revamp))를 설치하여 이 문제가 발생하지 않도록 할 수 있습니다. 일부 사용자는 Xiaomi Mi Box 장치에서이 문제를 보고했습니다.

7. 위에서 언급한 [Python ADB implementation](#1-python-adb-implementation) 접근 방식을 사용하는 경우 최신 장치에 문제가있을 수 있습니다. 이 경우 [ADB 서버](#2-adb-server) 방법을 대신 사용해야합니다.

## 서비스

### `media_player.select_source`

`media_player.select_source` 명령을 사용하여 장치에서 앱을 시작할 수 있습니다. 간단히 앱 ID를 `source` 로 제공하십시오. 앱 ID 앞에 `!`를 붙여서 앱을 중지 할 수도 있습니다. 예를 들어 다음과 같이 Netflix를 시작 및 중지하도록 [scripts](/docs/scripts)를 정의 할 수 있습니다.

```yaml
start_netflix:
  sequence:
  - service: media_player.select_source
    data:
      entity_id: media_player.fire_tv_living_room
      source: 'com.netflix.ninja'

stop_netflix:
  sequence:
  - service: media_player.select_source
    data:
      entity_id: media_player.fire_tv_living_room
      source: '!com.netflix.ninja'
```

### `androidtv.adb_command`

`androidtv.adb_command` 서비스를 사용하면 키 또는 ADB 쉘 명령을 Android TV / Fire TV 장치로 보낼 수 있습니다. 출력이 있으면 `'adb_response` 속성 (즉, 템플릿의 `state_attr('media_player.android_tv_living_room', 'adb_response')`)에 저장되고 INFO 레벨에 기록됩니다.


| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | Name(s) of Android TV / Fire TV entities.
| `command`              |       no | Either a key command or an ADB shell command.

[automation setup](/getting-started/automation/) 의 [action](/getting-started/automation-action/)에서 다음과 같이 보일 수 있습니다.

```yaml
action:
  service: androidtv.adb_command
  data:
    entity_id: media_player.androidtv_tv_living_room
    command: "HOME"
```

사용 가능한 주요 명령은 다음과 같습니다 :

- `POWER`
- `SLEEP`
- `HOME`
- `UP`
- `DOWN`
- `LEFT`
- `RIGHT`
- `CENTER`
- `BACK`
- `MENU`

주요 명령의 전체 목록은 [here](https://github.com/JeffLIrion/python-androidtv/blob/bf1058a2f746535921b3f5247801469c4567e51a/androidtv/constants.py#L143-L186)에서 찾을 수 있습니다 .

`GET_PROPERTIES` 명령을 사용하여 홈어시스턴트가 장치의 상태를 업데이트하는데 사용하는 속성을 검색 할 수도 있습니다. 이들은 미디어 플레이어의 `'adb_response'` 속성에 저장되고 INFO 레벨에서 기록됩니다. 이 정보는 백엔드 [androidtv](https://github.com/JeffLIrion/python-androidtv) 패키지에서 상태 감지를 개선하고 고유한 [custom state detection](#custom-state-detection) 규칙을 정의하는 데 사용될 수 있습니다.

다양한 의도(intents) 목록은 [here](https://gist.github.com/mcfrojd/9e6875e1db5c089b1e3ddeb7dba0f304)에서 찾을 수 있습니다

### `androidtv.download` 및 `androidtv.upload`

`androidtv.download` 서비스를 사용하여 Android TV / Fire TV 장치에서 홈어시스턴트 인스턴스로 파일을 다운로드 할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | Name of Android TV / Fire TV entity.
| `device_path`          |       no | The filepath on the Android TV / Fire TV device.
| `local_path`           |       no | The filepath on your Home Assistant instance.

마찬가지로 `androidtv.upload` 서비스를 사용하여 Home Assistant 인스턴스에서 Android TV / Fire TV 장치로 파일을 업로드 할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | Name(s) of Android TV / Fire TV entities.
| `device_path`          |       no | The filepath on the Android TV / Fire TV device.
| `local_path`           |       no | The filepath on your Home Assistant instance.

## 사용자 정의 상태 감지 (Custom State Detection)

Android TV 통합은 Android TV / Fire TV 장치를 정기적으로 폴링하고 소수의 속성을 수집하여 작동합니다. 불행히도 모든 앱이 준수하는 기기의 상태를 결정하기 위한 표준 API는 없습니다. 대신, 백엔드 `androidtv` 패키지는 상태를 판별하기 위해 수집하는 세 가지 특성을 사용합니다. : `audio_state`, `media_session_state`, `wake_lock_size`. 상태를 결정하는 올바른 로직은 현재 앱에 따라 다르며 백엔드 `androidtv` 패키지는 소수의 앱에 대해 앱별 상태 감지 로직을 구현합니다. 물론, `androidtv` 패키지의 각 앱마다 맞춤형 로직을 구현하는 것은 불가능합니다. 또한 올바른 상태 감지 로직은 장치 및 장치 설정에 따라 다를 수 있습니다.

이 문제에 대한 해결책은 `state_detection_rules` 설정 매개 변수로, 상태 감지에 대한 고유한 규칙을 제공할 수 있습니다. 키는 앱ID이고 값은 순서대로 평가되는 규칙 목록입니다. 유효한 규칙은 다음과 같습니다. :

* `'standby'`, `'playing'`, `'paused'`, `'idle'`, or `'off'`
  * If this is not a map, then this state will always be reported when this app is the current app
  * If this is a map, then its entries are conditions that will be checked.  If all of the conditions are true, then this state will be reported.  Valid conditions pertain to 3 properties (see the example configuration above):
    1. ``'media_session_state'``
    2. ``'audio_state'``
    3. ``'wake_lock_size'``
* `'media_session_state'` = try to use the `media_session_state` property to determine the state
* `'audio_state'` = try to use the `audio_state` property to determine the state

이러한 규칙을 결정하려면 [androidtv.adb_command](#androidtvadb_command) 섹션에 설명 된대로 `GET_PROPERTIES` 명령과 함께 `androidtv.adb_command` 서비스를 사용할 수 있습니다.