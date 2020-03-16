---
title: 보스 사운드터치(Bose Soundtouch)
description: Instructions on how to integrate Bose Soundtouch devices into Home Assistant.
logo: soundtouch.png
ha_category:
  - Media Player
ha_release: 0.34
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/GoWRsaS54JM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`soundtouch` 플랫폼을 통해 Home Assistant에서 [Bose Soundtouch](https://www.soundtouch.com/) 스피커를 제어 할 수 있습니다 .

기본적으로 홈 어시스턴트에서 제공하는 자동 검색을 지원하므로 `configuration.yaml`에 추가할 필요가 없습니다 

또는 `configuration.yaml` 파일에 다음을 추가 할 수 있습니다.

```yaml
# Example configuration.yaml
media_player:
  - platform: soundtouch
    host: 192.168.1.1
    port: 8090
    name: Soundtouch Living Room
```

또는 여러 호스트

```yaml
# Example configuration.yaml with many devices
media_player:
  - platform: soundtouch
    host: 192.168.1.1
    port: 8090
    name: Soundtouch Living Room
  - platform: soundtouch
    host: 192.168.1.1
    port: 8090
    name: Soundtouch kitchen
```

{% configuration %}
host:
  description: The host name or address of the Soundtouch device.
  required: true
  type: string
name:
  description: The name of the device used in the frontend.
  required: true
  default: Bose Soundtouch
  type: string
port:
  description: The port number.
  required: false
  default: 8090
  type: integer
{% endconfiguration %}

```media_player.play_media``` 을 사용하여 6 개의 사전 설정된 preset들 중 하나를 전환할 수 있습니다.

```yaml
# Play media preset
- service: media_player.play_media
  data:
    entity_id: media_player.soundtouch_living_room
    media_content_id: 1..6
    media_content_type: PLAYLIST
```

HTTP (HTTPS가 아닌) URL을 재생할 수도 있습니다. :

```yaml
# Play media URL
- service: media_player.play_media
  data:
    entity_id: media_player.soundtouch_living_room
    media_content_id: http://example.com/music.mp3
    media_content_type: MUSIC
```

### Text-to-Speech 서비스

홈어시스턴트가 HTTPS가 아닌 HTTP 로 설정된 경우에만 [Google Text-to-Speech](/integrations/google_translate) 또는 [Amazon Polly](/integrations/amazon_polly)와 같은 TTS services를 사용할 수 있습니다. (현재 장치에 한해, 펌웨어 업그레이드 예정)

SSL로 인터넷에 Home Assistant 설치를 게시하려는 경우 해결 방법은 HTTPS 웹서버를 리버스 프록시 (예 : [nginx](/docs/ecosystem/nginx/))로 설정하고 Home Assistant 설정을 로컬 네트워크에서 HTTP로 구성하는 것입니다. 이렇게 하면 Soundtouch 장치는 로컬에서 HTTP의 TTS 파일에 액세스 할 수 있으며 인터넷의 설정은 HTTPS입니다.

### `play_everywhere` 서비스

마스터에서 멀티룸 (zone)을 만들고 다른 모든 장치 (슬레이브)에서 동일한 콘텐츠를 재생합니다

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `master` | no | `entity_id` of the master device

### `create_zone` 서비스

마스터에서 멀티룸 (zone)을 만들고 선택한 슬레이브에서 재생

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `master` | no | `entity_id` of the master device|
| `slaves` | no | List of slaves `entity_id`      |

### `add_zone_slave` 서비스

기존 영역(zone)에 슬레이브 추가

| Service data attribute | Optional | Description  |
| ---------------------- | -------- | ------------ |
| `master` | no | `entity_id` of the master device |
| `slaves` | no | List of slaves `entity_id` to add|

### `remove_zone_slave` 서비스

기존 영역(zone)에서 슬레이브를 제거합니다.

마지막 슬레이브를 제거하면 영역이 파괴됩니다. 슬레이브를 다시 추가하려면 새로운 영역을 생성해야합니다

| Service data attribute | Optional | Description      |
| ---------------------- | -------- | ---------------- |
| `master` | no | `entity_id` of the master device     |
| `slaves` | no | List of slaves `entity_id` to remove |
