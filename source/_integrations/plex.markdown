---
title: Plex 미디어 서버
description: Instructions on how to integrate Plex into Home Assistant.
logo: plex.png
ha_category:
  - Media Player
  - Sensor
featured: true
ha_release: 0.7.4
ha_iot_class: Local Push
ha_config_flow: true
ha_codeowners:
  - '@jjlawren'
---

`plex` 통합구성요소로 [Plex Media Server](https://plex.tv)에 연결할 수 있습니다. 
연결되면 연결된 Plex Media Server에서 미디어를 재생하는 [Plex Clients](https://www.plex.tv/apps-devices/)가 [Media Players](/integrations/media_player/)로 표시되고 Home Assistant의 [Sensor](/integrations/sensor/)를 통해 재생 상태를 보고합니다. 미디어 플레이어를 사용하면 미디어 재생을 제어하고 현재 재생중인 항목을 볼 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Media Player](#media-player)
- [Sensor](#sensor)

[claim interface](https://plex.tv/claim)를 통해 Plex 계정에서 Plex 서버를 요청한 경우 홈어시스턴트는 인증을 요구합니다.

Plex 통합구성요소를 활성화하는 기본 방법은 **설정** -> **통합구성요소**를 사용하는 것입니다. Plex 계정으로 로그인하기 위해 [plex.tv](https://plex.tv) 웹사이트로 리디렉션됩니다. 액세스 권한이 부여되면 Home Assistant는 해당 계정으로 링크된 서버에 연결합니다. 계정에서 여러 Plex 서버를 사용할 수 있는 경우 통합구성요소 페이지에서 원하는 서버를 선택하여 설정을 완료하라는 메시지가 표시됩니다. 홈어시스턴트가 [Plex Web](https://app.plex.tv/web/app) 인터페이스의 **Settings** -> **Authorized Devices**에서 인증된 장치로 표시됩니다.

<div class='note info'>

연동을 설정할 때 로컬 및 보안 연결이 선호됩니다. 초기 설정 후 Plex 서버에 대한 모든 연결은 Plex 서비스에 연결하지 않고 직접 이루어집니다.

</div>

[discovery](/integrations/discovery/)가 활성화되고 로컬 Plex 서버가 발견되면 레거시 `media_player` 설정 (즉, `plex.conf` 파일)을 가져옵니다. **Settings** -> **(Server Name)** -> **Settings** -> **Network** 에서 Plex Web App을 통해 GDM을 활성화하고 **Enable local network discovery (GDM)** 을 선택할 수 있습니다.

`plex` 통합구성요소는 `configuration.yaml`을 통해 설정할 수도 있습니다 :

```yaml
# Example configuration.yaml entry
plex:
  token: MYSECRETTOKEN
```

<div class='note warning'>

`configuration.yaml`을 사용할 때 하나의 Plex 서버만 설정할 수 있습니다. 더 많은 서버를 추가하려면 **설정** -> **통합구성요소** 를 통해 설정하십시오.

</div>

{% configuration %}
host:
  description: The IP address or hostname of your Plex server.
  required: false
  type: string
port:
  description: The port of your Plex Server.
  required: false
  default: 32400
  type: integer
token:
  description: A valid X-Plex-Token for your Plex server. If provided without `host` and `port`, a connection URL will be retreived from Plex.
  required: false
  type: string
server:
  description: Name of Plex server to use if multiple servers are associated with the token's Plex account. Only used if `token` is provided without `host` and `port`.
  required: false
  type: string
ssl:
  description: Use HTTPS to connect to Plex server, **NOTE:** host **must not** be an IP when this option is enabled.
  required: false
  default: false
  type: boolean
verify_ssl:
  description: Verify the SSL certificate of your Plex server. You may need to disable this check if your local server enforces secure connections with the default certificate.
  required: false
  default: true
  type: boolean
media_player:
  description: Options to set the default behavior of `media_player` entities for new Integrations. **NOTE:** These options are exposed as Configuration Options (**Integrations** -> **Configured** --> **Plex** --> **Gear Icon**). Configuration Options will take precedence.
  required: false
  type: map
  keys:
    show_all_controls:
      description: Forces all controls to display. Ignores dynamic controls (ex. show volume controls for client A but not for client B) based on detected client capabilities. This option allows you to override this detection if you suspect it to be incorrect.
      required: false
      default: false
      type: boolean
    use_episode_art:
      description: Display TV episode art instead of TV show art.
      required: false
      default: false
      type: boolean
{% endconfiguration %}

```yaml
# Complete configuration.yaml entry
plex:
  host: 192.168.1.100
  port: 32400
  token: MY_SECRET_TOKEN
  ssl: true
  verify_ssl: true
  media_player:
    use_episode_art: true
    show_all_controls: false
```

## Media Player

`plex` media_player 플랫폼은 연결된 각 클라이언트 장치에 대해 미디어 플레이어 엔티티를 만듭니다. 이 엔티티는 장치에서 지원하는 경우 미디어 정보, 재생 진행률 및 재생 컨트롤을 표시합니다.

### `play_media` 서비스

연결된 클라이언트에서 노래, 재생 목록, TV 에피소드 또는 비디오를 재생합니다.

#### Music

| Service data attribute | Optional | Description                                                                                            | Example                                                                                                                                                       |
| ---------------------- | -------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `entity_id`            | no       | `entity_id` of the client                                                                              | media_player.theater_plex                                                                                                                                     |
| `media_content_id`     | no       | Quote escaped JSON with `library_name`, `artist_name`, `album_name`, `track_name`, `shuffle` (0 or 1). | { \\"library_name\\" : \\"My Music\\", \\"artist_name\\" : \\"Adele\\", \\"album_name\\" : \\"25\\", \\"track_name\\" : \\"hello\\", \\"shuffle\\": \\"0\\" } |
| `media_content_type`   | no       | Type of media to play, in this case `MUSIC`                                                            | MUSIC                                                                                                                                                         |

#### Playlist

| Service data attribute | Optional | Description                                                  | Example                                                                  |
| ---------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------------------ |
| `entity_id`            | no       | `entity_id` of the client                                    | media_player.theater_plex                                                |
| `media_content_id`     | no       | Quote escaped JSON with `playlist_name`, `shuffle` (0 or 1). | { \\"playlist_name\\" : \\"The Best of Disco\\" \\"shuffle\\": \\"0\\" } |
| `media_content_type`   | no       | Type of media to play, in this case `PLAYLIST`               | PLAYLIST                                                                 |

#### TV Episode

| Service data attribute | Optional | Description                                                                                                 | Example                                                                                                                                                    |
| ---------------------- | -------- | ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `entity_id`            | no       | `entity_id` of the client                                                                                   | media_player.theater_plex                                                                                                                                  |
| `media_content_id`     | no       | Quote escaped JSON with `library_name`, `show_name`, `season_number`, `episode_number`, `shuffle` (0 or 1). | { \\"library_name\\" : \\"Adult TV\\", \\"show_name\\" : \\"Rick and Morty\\", \\"season_number\\" : 2, \\"episode_number\\" : 5, \\"shuffle\\": \\"0\\" } |
| `media_content_type`   | no       | Type of media to play, in this case `EPISODE`                                                               | EPISODE                                                                                                                                                    |

#### Video

| Service data attribute | Optional | Description                                                               | Example                                                                                             |
| ---------------------- | -------- | ------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `entity_id`            | no       | `entity_id` of the client                                                 | media_player.theater_plex                                                                           |
| `media_content_id`     | no       | Quote escaped JSON with `library_name`, `video_name`, `shuffle` (0 or 1). | { \\"library_name\\" : \\"Adult Movies\\", \\"video_name\\" : \\"Blade\\", \\"shuffle\\": \\"0\\" } |
| `media_content_type`   | no       | Type of media to play, in this case `VIDEO`                               | VIDEO                                                                                               |

### Compatibility

| Client                           | Limitations                                                                                                                                                     |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Any (when all controls disabled) | A stop button will appear but is not functional.                                                                                                                |
| Any (when casting)               | Controlling playback will work but with error logging.                                                                                                          |
| Any (remote client)              | Controls disabled.                                                                                                                                              |
| Apple TV (PlexConnect)           | Controls disabled.  Music does not work.                                                                                                                        |
| iOS                              | None                                                                                                                                                            |
| NVidia Shield                    | Mute disabled. Volume set below 2 will cause error logging. Controlling playback when the Shield is both a client and a server will work but with error logging |
| Plex Web                         | None                                                                                                                                                            |
| Tivo Plex App                    | Only play, pause, stop/off controls enabled                                                                                                                     |

### Notes

* `plex` 통합구성요소는 여러 Plex 서버를 지원합니다. 설정 > 통합구성요소 에서 추가 연결을 설정할 수 있습니다.
* `configuration.yaml`을 통해 서버를 설정할 때 다음과 같은 오류가 발생할 수 있습니다.

  ```txt
  ERROR:plexapi:http://192.168.1.10:32400: ('Connection aborted.', BadStatusLine("''",))
  INFO:homeassistant.components.media_player.plex:No server found at: http://192.168.1.10:32400
  ```

  이 문제가 발생하면 Plex Media 서버에서 `Server`>`Network`>`Secure connections` 설정을 확인하십시오 : `Preferred` 또는 `Required`로 설정되어 있으면 `ssl` 및 `verify_ssl` 설정 옵션을 각각 `true` 및 `false`로 수동 설정해야합니다.
* 'playing' 상태를 제대로 얻으려면 Plex 라이브러리의 'Movies' 섹션 아래에 동영상이 있어야합니다.

## Sensor

`plex` 센서 플랫폼은 주어진 [Plex Media Server](https://plex.tv/)에서의 활동을 모니터링합니다. 현재 보고있는 사용자 수를 상태로 표시하는 센서를 만듭니다. 자세한 내용을 보려면 센서를 클릭하면 누가 무엇을 보고 있는지 표시됩니다.