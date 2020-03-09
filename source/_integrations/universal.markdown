---
title: 유니버셜 Media Player
description: Instructions on how to create a universal media player in Home Assistant.
logo: home-assistant.png
ha_category:
  - Media Player
ha_release: 0.11
ha_quality_scale: internal
---

Universal Media Player는 Home Assistant의 여러 기존 엔티티를 하나의 미디어 플레이어 엔티티로 결합합니다. 전체 미디어 센터를 제어하는 ​​단일 엔터티를 만드는 데 사용됩니다.

Universal 미디어 플레이어에서 여러 미디어 플레이어 개체를 제어할 수 있습니다. 또한 Universal 미디어 플레이어를 사용하면 볼륨 및 전원 명령을 홈어시스턴트의 다른 엔티티로 다시 라우팅 할 수 있습니다. 이를 통해 전원 및 볼륨이 있는 텔레비전 또는 오디오 수신기와 같은 외부 장치를 제어 할 수 있습니다.

`configuration.yaml`에서 다음과 같이 Universal Media Player가 생성됩니다.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: universal
    name: MEDIA_PLAYER_NAME
    children:
      - media_player.CHILD_1_ID
      - media_player.CHILD_2_ID
    commands:
      turn_on:
        service: SERVICE
        data: SERVICE_DATA
      turn_off:
        service: SERVICE
        data: SERVICE_DATA
      volume_up:
        service: SERVICE
        data: SERVICE_DATA
      volume_down:
        service: SERVICE
        data: SERVICE_DATA
      volume_mute:
        service: SERVICE
        data: SERVICE_DATA
    attributes:
      is_volume_muted: ENTITY_ID|ATTRIBUTE
      state: ENTITY_ID|ATTRIBUTE
```

{% configuration %}
name:
  description: The name to assign the player.
  required: true
  type: string
children:
  description: Ordered list of child media players this entity will control.
  required: true
  type: list
state_template:
  description: "A [template](/topics/templating/) can be specified to render the state of the media player. This way, the state could depend on entities different from media players, like switches or input booleans."
  required: false
  type: template
commands:
  description: "Commands to be overwritten. Possible entries are `turn_on`, `turn_off`, `select_source`, `volume_set`, `volume_up`, `volume_down` and `volume_mute`."
  required: false
  type: string
attributes:
  description: "Attributes that can be overwritten. Possible entries are `is_volume_muted`, `state`, `source`, `source_list` and `volume_level`. The values should be an entity ID and state attribute separated by a pipe character (|). If the entity ID's state should be used, then only the entity id should be provided."
  required: false
  type: string
{% endconfiguration %}

Universal Media Player는 주로 `children` 중 하나를 모방합니다. Universal Media Player는 활성화 된 (not idle/off) 목록의 첫 번째 child을 제어합니다. 유니버설 미디어 플레이어는 또한 `state_template`이 제공되지 않으면 첫 번째 활성 child에서 상태를 상속합니다. `children:` 목록의 엔티티는 미디어 플레이어 여야하지만 상태 템플릿은 어떤 엔티티도 포함할 수 있습니다.

`turn_on` 명령, `turn_off` 명령 및 `state` 속성은 모두 함께 제공하는 것이 좋습니다. `state` 속성은 미디어 플레이어가 켜져 있는지 꺼져 있는지를 나타냅니다. `state`는 미디어 플레이어가 꺼져 있음을 나타내는 경우, 이 상태는 child의 상태보다 우선합니다. 모든 child가 idle/off 이고 상태가 켜져 있으면 Universal Media Player의 상태가 켜집니다.

`volume_up` 명령, `vol_down` 명령, `volume_mute` 명령 및 `_is_volume_muted` 속성을 모두 함께 제공하는 것이 좋습니다. `is_volume_muted` 속성은 볼륨이 음소거되면 True 또는 on 상태를 반환해야합니다. `volume_mute` 서비스는 음소거 설정을 토글합니다.

`select_source`를 명령으로 제공할 때, `source` 및 `source_list` 속성도 제공하는 것이 좋습니다. `source` 속성은 현재 선택된 소스이고, `source_list` 속성은 사용 가능한 모든 소스의 목록입니다.

## 사용법 예시

### 스위치가 있는 Chromecast 및 Kodi 제어

본 예에서는 텔레비전의 전원을 제어하는 ​​스위치를 사용할 수 있습니다. 볼륨을 높이고 볼륨을 낮추고 오디오를 음소거하는 스위치도 사용할 수 있습니다. 이들은 command line 스위치 또는 Home Assistant의 다른 엔티티일 수 있습니다. `turn_on` 및 `turn_off` 명령은 텔레비전으로 리디렉션되고 볼륨 명령은 오디오 수신기로 리디렉션됩니다. `select_source` 명령은 A/V 수신기로 직접 전달됩니다.

children은 Chromecast와 Kodi 플레이어입니다. Chromecast가 재생중인 경우 Universal Media Player는 해당 상태를 반영합니다. Chromecast가 idle 상태이고 Kodi가 재생중인 경우 universal 미디어 플레이어는 상태를 반영하도록 변경됩니다.

{% raw %}

```yaml
media_player:
  platform: universal
  name: Test Universal
  children:
    - media_player.living_room_cast
    - media_player.living_room_kodi
  commands:
    turn_on:
      service: switch.turn_on
      data:
        entity_id: switch.living_room_tv
    turn_off:
      service: switch.turn_off
      data:
        entity_id: switch.living_room_tv
    volume_up:
      service: switch.turn_on
      data:
        entity_id: switch.living_room_volume_up
    volume_down:
      service: switch.turn_on
      data:
        entity_id: switch.living_room_volume_down
    volume_mute:
      service: switch.turn_on
      data:
        entity_id: switch.living_room_mute
    select_source:
      service: media_player.select_source
      data_template:
        entity_id: media_player.receiver
        source: '{{ source }}'
    volume_set:
      service: media_player.volume_set
      data_template:
        entity_id: media_player.receiver
        volume_level: '{{ volume_level }}'

  attributes:
    state: switch.living_room_tv
    is_volume_muted: switch.living_room_mute
    volume_level: media_player.receiver|volume_level
    source: media_player.receiver|source
    source_list: media_player.receiver|source_list
```

{% endraw %}

#### Kodi CEC-TV control

이 예에서 [Kodi Media Player](/integrations/kodi)는 CEC 가능 장치 (예: Raspberry Pi 24/7에서 실행되는 OSMC/OpenElec)에서 실행되며 JSON-CEC Kodi 애드온이 설치된 연결된 TV를 켜고 끌 수 있습니다.

연결된 TV의 상태를 숨겨진 [input boolean](/integrations/input_boolean/)에 저장하므로 Kodi가 항상 'idle'인 동안 TV를 켜거나 끄고 universal 미디어 플레이어를 사용하여 상태를 템플릿으로 렌더링합니다.  Kodi Media Player도 숨길 수 있으며 universal만 표시합니다. 이제는 'idle'상태와 'off'상태를 구분할 수 있습니다. (몇 초가 지나가면 idle일 때 TV는 꺼집니다).

TV 상태를 저장하는데 사용되는 input boolean은 홈어시스턴트 `turn_on` 및 `turn_off` 액션을 사용할 때만 변경되므로 Kodi는 여러 가지 방법으로 제어 할 수 있으므로 필요할 때 이 input boolean을 업데이트하기 위한 자동화도 정의합니다.

완전한 설정은 다음과 같습니다. :

{% raw %}

```yaml
homeassistant:
  customize:
    input_boolean.kodi_tv_state:
      hidden: true
    media_player.kodi:
      hidden: true
    media_player.kodi_tv:
      friendly_name: Kodi

input_boolean:
  kodi_tv_state:

media_player:
- platform: universal
  name: Kodi TV
  state_template: >
    {% if is_state('media_player.kodi', 'idle') and is_state('input_boolean.kodi_tv_state', 'off') %}
    off
    {% else %}
    {{ states('media_player.kodi') }}
    {% endif %}
  children:
    - media_player.kodi
  commands:
    turn_on:
      service: media_player.turn_on
      data:
        entity_id: media_player.kodi
    turn_off:
      service: media_player.turn_off
      data:
        entity_id: media_player.kodi
  attributes:
    is_volume_muted: media_player.kodi|is_volume_muted
    volume_level: media_player.kodi|volume_level

- platform: kodi
  name: Kodi
  host: 192.168.1.10
  turn_on_action:
  - service: input_boolean.turn_on
    data:
      entity_id: input_boolean.kodi_tv_state
  - service: media_player.kodi_call_method
    data:
      entity_id: media_player.kodi
      method: Addons.ExecuteAddon
      addonid: script.json-cec
      params:
        command: activate
  turn_off_action:
  - service: input_boolean.turn_off
    data:
      entity_id: input_boolean.kodi_tv_state
  - service: media_player.media_stop
    data:
      entity_id: media_player.kodi
  - service: media_player.kodi_call_method
    data:
      entity_id: media_player.kodi
      method: Addons.ExecuteAddon
      addonid: script.json-cec
      params:
        command: standby

automation:
- alias: Turn on the TV when Kodi is activated
  trigger:
    platform: state
    entity_id: media_player.kodi_tv
    from: 'off'
    to: 'playing'
  action:
  - service: media_player.turn_on
    entity_id: media_player.kodi_tv

- alias: Turn off the TV when Kodi is in idle > 15 min
  trigger:
    platform: state
    entity_id: media_player.kodi_tv
    to: 'idle'
    for:
      minutes: 15
  action:
  - service: media_player.turn_off
    entity_id: media_player.kodi_tv
```

{% endraw %}
