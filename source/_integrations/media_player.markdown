---
title: 미디어 플레이어
description: Instructions on how to setup your media players with Home Assistant.
logo: home-assistant.png
ha_category:
  - Media Player
ha_release: 0.7
ha_quality_scale: internal
---

네트워크의 미디어 플레이어와 상호 작용합니다.

## 서비스

### 미디어 컨트롤 서비스
사용가능한 서비스 : `turn_on`, `turn_off`, `toggle`, `volume_up`, `volume_down`, `volume_set`, `volume_mute`, `media_play_pause`, `media_play`, `media_pause`, `media_stop`, `media_next_track`, `media_previous_track`, `clear_playlist`, `shuffle_set`, `play_media`, `select_source`, `select_sound_mode`

| Service data attribute | Optional | Description                                      |
| ---------------------- | -------- | ------------------------------------------------ |
| `entity_id`            |      no | 특정 미디어 플레이어를 타겟팅합니다. 모든 미디어 플레이어를 대상으로하려면 `all`을 사용. |

#### `media_player.volume_mute` 서비스

| Service data attribute | Optional | Description                                      |
|------------------------|----------|--------------------------------------------------|
| `entity_id`            |      no | 특정 미디어 플레이어를 타겟팅합니다. 모든 미디어 플레이어를 대상으로하려면 `all`을 사용. |
| `is_volume_muted`      |       no | True/false for mute/unmute                       |

#### `media_player.volume_set` 서비스

| Service data attribute | Optional | Description                                      |
|------------------------|----------|--------------------------------------------------|
| `entity_id`            |      yes | 특정 미디어 플레이어를 타겟팅합니다. 모든 미디어 플레이어를 대상으로하려면 `all`을 사용. |
| `volume_level`         |       no | 볼륨 레벨을위한 float. 범위 0..1               |

#### `media_player.media_seek` 서비스

| Service data attribute | Optional | Description                                            |
|------------------------|----------|--------------------------------------------------------|
| `entity_id`            |      no | 특정 미디어 플레이어를 타겟팅합니다. 모든 미디어 플레이어를 대상으로하려면 `all`을 사용.       |
| `seek_position`        |       no | 탐색할 위치. 형식은 플랫폼에 따라 다릅니다.  |

#### `media_player.play_media` 서비스

| Service data attribute | Optional | Description                                                                                                                                                            |
| -----------------------| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `entity_id`            |      no | 특정 미디어 플레이어를 타겟팅합니다. 모든 미디어 플레이어를 대상으로하려면 `all`을 사용.                                                                                                                       |
| `media_content_id`     |       no | 미디어 식별자. 이 형식은 통합구성요소에 따라 다릅니다. 예를 들어 Sonos 및 Cast에는 URL을 제공하고 iTunes에는 재생 목록 ID 만 제공 할 수 있습니다                    |
| `media_content_type`   |       no | 미디어 타입. `music`, `tvshow`, `video`, `episode`, `channel`, `playlist` 중의 하나여야함. 예를 들어, 음악을 재생하려면 `media_content_type`을 `music`으로 설정하십시오. |

#### `media_player.select_source` 서비스

| Service data attribute | Optional | Description                                          |
| ---------------------- | -------- | ---------------------------------------------------- |
| `entity_id`            |      no | 특정 미디어 플레이어를 타겟팅합니다. 모든 미디어 플레이어를 대상으로하려면 `all`을 사용.     |
| `source`               |       no | 전환할 소스의 이름. 플랫폼에 따라 다릅니다. |

#### `media_player.select_sound_mode` 서비스

현재 [Denon AVR](/integrations/denonavr/), [Songpal](/integrations/songpal)에서만 지원됩니다.

| Service data attribute | Optional | Description                                          |
| ---------------------- | -------- | ---------------------------------------------------- |
| `entity_id`            |       no | 특정 미디어 플레이어를 대상. 예를 들면 `media_player.marantz`|
| `sound_mode`           |       no | 전환할 사운드 모드의 이름. 플랫폼에 따라 다릅니다.|

#### `media_player.shuffle_set` 서비스

 [Sonos](/integrations/sonos), [Spotify](/integrations/spotify), [MPD](/integrations/mpd), [Kodi](/integrations/kodi), [Squeezebox](/integrations/squeezebox), [Universal](/integrations/universal)에서만 현재 지원됩니다.

| Service data attribute | Optional | Description                                          |
| ---------------------- | -------- | ---------------------------------------------------- |
| `entity_id`            |       no | 특정 미디어 플레이어를 대상. 예를 들면 `media_player.spotify`|
| `shuffle`              |       no | `true`/`false` for enabling/disabling shuffle        |

### 장치 클래스 (Device Class)

프론트 엔드에 미디어 플레이어가 표시되는 방식은 [customize section](/getting-started/customizing-devices/)에서 수정할 수 있습니다. 미디어 플레이어에 지원되는 장치 클래스는 다음과 같습니다.
 
- **tv**: 장치는 텔레비전 유형 장치입니다.
- **speaker**: 장치는 스피커 또는 스테레오 타입 장치입니다.
