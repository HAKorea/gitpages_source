---
title: Media 캡처도구(media extractor)
description: Instructions on how to integrate the Media Extractor into Home Assistant.
logo: home-assistant.png
ha_category:
  - Media Player
ha_release: 0.49
ha_quality_scale: internal
---

`media_extractor` 통합구성요소는 스트림 URL을 가져와서 미디어 플레이어 엔티티로 보냅니다. 이 통합구성요소는 적절히 설정된 경우 엔티티의 특정 스트림을 추출할 수 있습니다.

<div class='note'>
Media extractor는 스트림을 트랜스 코딩하지 않고 요청된 쿼리와 일치하는 스트림을 찾으려고합니다.
</div>

설치에서 Media extractor 서비스를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_extractor:
```

{% configuration %}
default_query:
  description: 모든 장치에 대한 기본 스트림 쿼리를 설정.
  required: false
  default: best
  type: string
customize:
  description: 엔터티 특정 값을 설정.
  required: false
  type: list
{% endconfiguration %}

```yaml
# Example configuration.yaml entry
media_extractor:
  default_query: worst
  customize:
    media_player.my_sonos:
      video: bestvideo
      music: bestaudio[ext=mp3]
```

이 구성은 mp3 확장자를 가진 'bestaudio'와 같은 모든 서비스 호출에 대한 쿼리를 설정합니다.


```json
{
  "entity_id": "media_player.my_sonos",
  "media_content_id": "https://soundcloud.com/bruttoband/brutto-11",
  "media_content_type": "music"
}
```

설명이 포함된 쿼리 예 :

 * **bestvideo**: Best video only stream
 * **best**: Best video + audio stream
 * **bestaudio[ext=m4a]**: Best audio stream with m4a extension
 * **worst**: Worst video + audio stream
 * **bestaudio[ext=m4a]/bestaudio[ext=ogg]/bestaudio**: Best m4a audio, otherwise best ogg audio and only then any best audio

검색에 대한 추가 정보는 [here](https://github.com/rg3/youtube-dl#format-selection)

### Use the service

**개발자 도구**에서 <img src='/images/screenshots/developer-tool-services-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> **Services** 항목을 사용하십시오. 드롭 다운 메뉴 **Domain** 및 **Services**에서 `play_media`에서 `media_extractor`를 선택하고 위의 JSON 샘플과 같은 것을 **Service Data** 필드에 입력 한 다음 **CALL SERVICE**를 누르십시오. 

주어진 URL에서 파일을 다운로드합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      yes | Name(s) of entities to seek media on, e.g., `media_player.living_room_chromecast`. Defaults to all.
| `media_content_id`     |       no | The ID of the content to play. Platform dependent.
| `media_content_type`   |       no | The type of the content to play. Must be one of MUSIC, TVSHOW, VIDEO, EPISODE, CHANNEL or PLAYLIST MUSIC.
