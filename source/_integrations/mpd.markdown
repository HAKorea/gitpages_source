---
title: 뮤직 플레이어 데몬(MPD)
description: Instructions on how to integrate Music Player Daemon into Home Assistant.
logo: mpd.png
ha_category:
  - Media Player
ha_release: pre 0.7
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

`mpd` 플랫폼을 사용하면 Home Assistant에서 [Music Player Daemon](https://www.musicpd.org/)을 제어할 수 있습니다. 안타깝게도 재생 목록을 조작하거나 (노래 추가 또는 삭제) 노래간에 전환을 추가 할 수 없습니다.

재생 목록 조작이 불가능하더라도 play_media 서비스를 사용하여 기존 저장된 재생 목록을 자동화 또는 장면(scene)의 일부로 로드 할 수 있습니다.

설치에 MPD를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: mpd
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: IP address of the Host where Music Player Daemon is running.
  required: true
  type: string
port:
  description: Port of the Music Player Daemon.
  required: false
  type: integer
  default: 6600
name:
  description: Name of your Music Player Daemon.
  required: false
  type: string
  default: MPD
password:
  description: Password for your Music Player Daemon.
  required: false
  type: string
{% endconfiguration %}

"DeckMusic"이라는 저장된 재생 목록을 로드하고 볼륨을 설정하는 스크립트 예 :

```yaml
relaxdeck:
    sequence:
    - service: media_player.play_media
      data:
        entity_id: media_player.main
        media_content_type: playlist
        media_content_id: DeckMusic

    - service: media_player.volume_set
      data:
        entity_id: media_player.main
        volume_level: 0.60
```

이 플랫폼은 [Pi MusicBox](https://www.pimusicbox.com/)에서 사용하는 [Mopidy-MPD](https://docs.mopidy.com/en/latest/ext/mpd/)와 더불어 [Music Player Daemon](https://docs.mopidy.com/en/latest/ext/mpd/)과 [mopidy](https://www.mopidy.com/)이 다같이 작동합니다