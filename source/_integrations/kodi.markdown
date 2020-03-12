---
title: 코디(Kodi)
description: Instructions on how to integrate Kodi into Home Assistant.
logo: kodi.png
ha_category:
  - Notifications
  - Media Player
ha_release: pre 0.7
ha_iot_class: Local Push
ha_codeowners:
  - '@armills'
---

`kodi` 플랫폼을 사용하면 Home Assistant에서 [Kodi](https://kodi.tv/) 멀티미디어 시스템을 제어할 수 있습니다.

Kodi 플랫폼을 설정하는 기본 방법은 Kodi 설치에서 활성화된 [web interface](https://kodi.wiki/view/Web_interface)가 필요한 [discovery component](/integrations/discovery/)를 활성화하는 것입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Media Player](#configuration)
- [Notifications](#notifications)

## 설정

검색(discovery이 작동하지 않거나 특정 설정 변수가 필요한 경우 `configuration.yaml` 파일에 다음을 추가 할 수 있습니다.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: kodi
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: The host name or address of the device that is running XBMC/Kodi.
  required: true
  type: string
port:
  description: The HTTP port number.
  required: false
  type: integer
  default: 8080
tcp_port:
  description: The TCP port number. Used for WebSocket connections to Kodi.
  required: false
  type: integer
  default: 9090
name:
  description: The name of the device used in the frontend.
  required: false
  type: string
proxy_ssl:
  description: Connect to Kodi with HTTPS and WSS. Useful if Kodi is behind an SSL proxy.
  required: false
  type: boolean
  default: false
username:
  description: The XBMC/Kodi HTTP username.
  required: false
  type: string
password:
  description: The XBMC/Kodi HTTP password.
  required: false
  type: string
turn_on_action:
  description: Home Assistant script sequence to call when turning on.
  required: false
  type: list
turn_off_action:
  description: Home Assistant script sequence to call when turning off.
  required: false
  type: list
enable_websocket:
  description: Enable websocket connections to Kodi via the TCP port. The WebSocket connection allows Kodi to push updates to Home Assistant and removes the need for Home Assistant to poll. If websockets don't work on your installation this can be set to `false`.
  required: false
  type: boolean
  default: true
timeout:
  description: Set timeout for connections to Kodi. Defaults to 5 seconds.
  required: false
  type: integer
  default: 5
{% endconfiguration %}

### 서비스

#### `kodi.add_to_playlist` 서비스

기본 재생 목록에 음악을 추가합니다 (즉, playlistid=0).

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | Name(s) of the Kodi entities where to add the media. |
| `media_type` | yes | Media type identifier. It must be one of SONG or ALBUM. |
| `media_id` | no | Unique Id of the media entry to add (`songid` or `albumid`). If not defined, `media_name` and `artist_name` are needed to search the Kodi music library. |
| `media_name` | no| Optional media name for filtering media. Can be 'ALL' when `media_type` is 'ALBUM' and `artist_name` is specified, to add all songs from one artist. |
| `artist_name` | no | Optional artist name for filtering media. |

#### `kodi.call_method` 서비스

선택적 매개 변수를 사용하여 [Kodi JSONRPC API](https://kodi.wiki/?title=JSON-RPC_API) 메소드를 호출하십시오. Kodi API 호출의 결과는 Home Assistant 이벤트인 `kodi_call_method_result`에서 리디렉션됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | Name(s) of the Kodi entities where to run the API method. |
| `method` | yes | Name of the Kodi JSONRPC API method to be called. |
| any other parameter | no | Optional parameters for the Kodi API call. |

### 이벤트 트리거하기(Event triggering)

`kodi.call_method` 서비스를 호출할 때 Kodi JSONRPC API가 데이터를 리턴하면 홈어시스턴트가 수신할 때 다음 `event_data`와 함께 이벤트 버스에서 `kodi_call_method_result` 이벤트를 발생시킵니다.

```yaml
entity_id: "<Kodi media_player entity_id>"
result_ok: <boolean>
input: <input parameters of the service call>
result: <data received from the Kodi API>
```

### Kodi turn on/off 예시

`turn_on_action` 및 `turn_off_action` 매개 변수를 사용하면 홈어시스턴트 작업을 조합하여 Kodi 인스턴스를 켜거나 끌 수 있습니다. **이전의 `turn_off_action` 옵션 목록에 대한 마이그레이션 지침**을 포함하여 이 사용법의 몇 가지 예가 있습니다.

#### Wake on LAN으로 Kodi 켜기

이 설정으로 Kodi 장치에서 `media_player/turn_on`을 호출하면 _magic packet_ 이 지정된 MAC 주소로 전송됩니다. 이 서비스를 사용하려면 먼저 Home Assistant에서 [`wake_on_lan`](/integrations/wake_on_lan) 통합구성요소를 설정해야합니다. 이는 `wake_on_lan:`을 `configuration.yaml`에 추가하기 만하면됩니다.

```yaml
media_player:
  - platform: kodi
    host: 192.168.0.123
    turn_on_action:
      - service: wake_on_lan.send_magic_packet
        data:
          mac: aa:bb:cc:dd:ee:ff
          broadcast_address: 192.168.255.255
```

#### API 호출로 Kodi 끄기

다음은 Kodi를 끄도록 각 이전 옵션을 설정하는 동등한 방법입니다 (`quit`, `hibernate`, `suspend`, `reboot` 또는 `shutdown`).

- **Quit** method (before was `turn_off_action: quit`)

```yaml
media_player:
  - platform: kodi
    host: 192.168.0.123
    turn_off_action:
      service: kodi.call_method
      data:
        entity_id: media_player.kodi
        method: Application.Quit
```

- **Hibernate** method (before was `turn_off_action: hibernate`)

```yaml
media_player:
  - platform: kodi
    host: 192.168.0.123
    turn_off_action:
      service: kodi.call_method
      data:
        entity_id: media_player.kodi
        method: System.Hibernate
```

- **Suspend** method (before was `turn_off_action: suspend`)

```yaml
media_player:
  - platform: kodi
    host: 192.168.0.123
    turn_off_action:
      service: kodi.call_method
      data:
        entity_id: media_player.kodi
        method: System.Suspend
```

- **Reboot** method (before was `turn_off_action: reboot`)

```yaml
media_player:
  - platform: kodi
    host: 192.168.0.123
    turn_off_action:
      service: kodi.call_method
      data:
        entity_id: media_player.kodi
        method: System.Reboot
```

- **Shutdown** method (before was `turn_off_action: shutdown`)

```yaml
media_player:
  - platform: kodi
    host: 192.168.0.123
    turn_off_action:
      service: kodi.call_method
      data:
        entity_id: media_player.kodi
        method: System.Shutdown
```

#### Kodi JSON-CEC 애드온으로 TV 켜고 끄기

CEC 가능 TV (예: OSMC / OpenElec 및 Rasperry Pi에서 실행되는 시스템과 같은 시스템)에 연중 무휴로 연결된 Kodi 장치의 경우 이 설정을 통해 Kodi는 항상 홈어시스턴트에서 연결된 TV를 켜고 끌 수 있습니다 활성 및 준비 :

```yaml
media_player:
  - platform: kodi
    host: 192.168.0.123
    turn_on_action:
      service: kodi.call_method
      data:
        entity_id: media_player.kodi
        method: Addons.ExecuteAddon
        addonid: script.json-cec
        params:
          command: activate
    turn_off_action:
    - service: media_player.media_stop
      data:
        entity_id: media_player.kodi
    - service: kodi.call_method
      data:
        entity_id: media_player.kodi
        method: Addons.ExecuteAddon
        addonid: script.json-cec
        params:
          command: standby
```

<div class='note'>

이 예제와 다음은 kodi 플레이어에 [script.json-cec](https://github.com/joshjowen/script.json-cec) 플러그인이 설치되어 있어야합니다. 또한 kodi 플레이어에서 인증없이 ndpoints standby, toggle, activate를 표시합니다. 주의해서 사용하십시오.

</div>

### Kodi 서비스 사례

#### 시간 함수로 일부 채널에서 PVR을 켜는 간단한 스크립트

{% raw %}
```yaml
script:
  play_kodi_pvr:
    alias: Turn on the silly box
    sequence:
      - alias: TV on
        service: media_player.turn_on
        data:
          entity_id: media_player.kodi
      - alias: Play TV channel
        service: media_player.play_media
        data_template:
          entity_id: media_player.kodi
          media_content_type: "CHANNEL"
          media_content_id: >
            {% if (now().hour < 14) or ((now().hour == 14) and (now().minute < 50)) %}
              10
            {% elif (now().hour < 16) %}
              15
            {% elif (now().hour < 20) %}
              2
            {% elif (now().hour == 20) and (now().minute < 50) %}
              10
            {% elif (now().hour == 20) or ((now().hour == 21) and (now().minute < 15)) %}
              15
            {% else %}
              10
            {% endif %}
```
{% endraw %}

#### 스마트 재생 목록을 재생하는 간단한 스크립트

{% raw %}
```yaml
script:
  play_kodi_smp:
    alias: Turn on the silly box with random Firefighter Sam episode
    sequence:
      - alias: TV on
        service: media_player.turn_on
        data:
          entity_id: media_player.kodi
      - service: media_player.play_media
        data:
          entity_id: media_player.kodi
          media_content_type: DIRECTORY
          media_content_id: special://profile/playlists/video/feuerwehrmann_sam.xsp
```
{% endraw %}

#### Kodi 비디오 라이브러리 업데이트 트리거

```yaml
script:
  update_library:
    alias: Update Kodi Library
    sequence:
      - alias: Call Kodi update
        service: kodi.call_method
        data:
          entity_id: media_player.kodi
          method: VideoLibrary.Scan
```

## 알림

`kodi` 알림 플랫폼을 사용하면 Home Assistant에서 [Kodi](https://kodi.tv/) 멀티미디어 시스템으로 메시지를 보낼 수 있습니다.

설치에 Kodi를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - platform: kodi
    name: NOTIFIER_NAME
    host: IP_ADDRESS
```

{% configuration %}
name:
  description: Name displayed in the frontend. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  type: string
host:
  description: The host name or address of the device that is running Kodi.
  required: true
  type: string
port:
  description: The HTTP port number.
  required: false
  default: 8080
  type: integer
proxy_ssl:
  description: Connect to kodi with HTTPS. Useful if Kodi is behind an SSL proxy.
  required: false
  default: "`false`"
  type: boolean
username:
  description: The XBMC/Kodi HTTP username.
  required: false
  type: string
password:
  description: The XBMC/Kodi HTTP password.
  required: false
  type: string
{% endconfiguration %}

### 스크립트 사례

```yaml
kodi_notification:
  sequence:
  - service: notify.NOTIFIER_NAME
    data:
      title: "Home Assistant"
      message: "Message to KODI from Home Assistant!"
      data:
        displaytime: 20000
        icon: "warning"
```

#### 메시지 변수들

{% configuration %}
title:
  description: Title that is displayed on the message.
  required: false
  type: string
message:
  description: Message to be displayed.
  required: true
  type: string
data:
  description: Configure message properties
  required: false
  type: map
  keys:
    icon:
      description: "Kodi comes with 3 default icons: `info`, `warning` and `error`, an URL to an image is also valid."
      required: false
      default: "`info`"
      type: string
    displaytime:
      description: Length in milliseconds the message stays on screen.
      required: false
      default: "`10000` ms"
      type: integer
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.