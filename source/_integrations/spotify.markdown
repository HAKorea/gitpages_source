---
title: 스포티파이(Spotify)
description: Instructions on how to integrate Spotify into Home Assistant.
logo: spotify.png
ha_category:
  - Media Player
ha_release: 0.43
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/j4aZFjAylMY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`spotify` 미디어 플레이어 플랫폼을 사용하면 Home Assistant에서 [Spotify](https://www.spotify.com/) 재생을 제어할 수 있습니다.

## 전제조건

- Spotify account
- Spotify application, properly configured (see below)

<div class='note'>
Spotify 통합구성요소(pause, play, next 등)를 제어하려면 프리미엄 계정이 필요합니다. 프리미엄 계정이 없는 경우 프런트 엔드 연동에 컨트롤이 표시되지 않습니다.
</div>

필요한 Spotify 응용 프로그램을 만들려면 : 

- Login to [Spotify Developer](https://developer.spotify.com)
- Visit the [My Applications](https://developer.spotify.com/my-applications/#!/applications) page
- Select **Create An App**. Enter any name and description. Once your application is created, view it and copy your **Client ID** and **Client Secret**, which are used in the Home Assistant configuration file.
- Add a **Redirect URI** in one of the following forms:

 SSL을 사용하지 않는 경우 :
  `http://<your_home_assistant_url_or_local_ip>/api/spotify`

 SSL을 사용하는 경우 :
  `https://<your_home_assistant_url_or_local_ip>/api/spotify`

- URI를 추가 한 후 **Save**을 클릭하십시오.

외부에서 접근 가능한 주소를 사용하는 경우 [HTTP 구성 요소](/integrations/http/)의 `base_url` 속성도 설정해야합니다. 경로 redirect URI와 동일한 base URL을 사용하여 설정해야합니다. 예를 들어, 경로 redirect에 (로컬 IP가 아닌) 도메인 이름을 사용한 경우 `base_url`에 동일한 도메인 이름을 사용하십시오.

## 설정

Spotify를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: spotify
    client_id: YOUR_CLIENT_ID
    client_secret: YOUR_CLIENT_SECRET
    aliases:
        abc123def456: 'Living Room'
        9183abas000: 'Bed Room'
```

{% configuration %}
client_id:
  description: Client ID from your Spotify application.
  required: true
  type: string
client_secret:
  description: Client Secret from your Spotify application.
  required: true
  type: string
cache_path:
  description: Path to cache authentication token.
  required: false
  type: string
  default: .spotify-token-cache
aliases:
  description: "Dictionary of device ids to be aliased, handy for devices that Spotify cannot properly determine the device name of. New devices will be logged to the `info` channel for ease of aliasing."
  required: false
  type: map
name:
  description: The name of the device used in the frontend.
  required: false
  type: string
  default: Spotify
{% endconfiguration %}

## 셋업

전제 조건, 설정이 완료되면 Home Assistant를 다시시작하십시오.
알림에서 **Spotify** 설정 요소를 사용할 수 있습니다.
"Link Spotify account"을 클릭하고 지침에 따라 Home Assistant에 Spotify 계정에 대한 액세스 권한을 부여하십시오.
Spotify 미디어 플레이어가 나타납니다. 인증을 완료한 후 파일을 다운로드하라는 메시지가 표시되면 다운로드를 폐기하십시오. 필요하지 않습니다.

## Sources

소스는 Spotify에서 이러한 장치로 스트리밍한 경우를 기준으로합니다. 소스가 없는 경우 전화기에서 집안의 다른 장치 (Bluetooth, echo 등)로 스트리밍하면 됩니다. 일단 소스를 전송하면 Spotify 개발자 콘솔에 전송/스트리밍할 장치로 소스가 표시됩니다. 
https://developer.spotify.com 로 이동하여 로그인하십시오. 상단 메뉴에서 "Console"을 클릭한 다음 왼쪽 메뉴에서 "Player"를 클릭하십시오. 목록에서 "/v1/me/player/devices"를 선택하십시오. 그런 다음 "Get token"를 클릭하고 약관에 동의 한 후 "Try it"를 클릭하십시오. 그러면 활성화된 Spotify 장치가 컬 라인 아래 오른쪽 패널에 나열됩니다 (예: "name": "Web Player (Chrome)").
이러한 이름은 예를 들어 입력 선택기에서 사용할 수 있습니다. : 

```yaml
  spotify_source:
    name: 'Source:'
    options:
      - Spotifyd@rock64
      - Web Player (Chrome)
```

장치는 전원이 켜져 있지 않으면 dev-console에 소스로 표시되지 않습니다.

## URI Links For Playlists/Etc.
[media_player.play_media](/integrations/media_player/#service-media_playerplay_media) 서비스의 일부인 `"media_content_type": "playlist"`, `"media_content_id": spotify:user:spotify:playlist:37i9dQZF1DWSkkUxEhrBdF"`(컨텐츠 ID에 따라 다름)와 같은 항목을 통해 재생목록을 보내서 확인할 수 있습니다. 홈어시스턴트 프론트 엔드의 서비스 제어판에서 이를 테스트 할 수 있습니다.


## 서비스
[Media Player component](/integrations/media_player/) 구성요소의 기본 서비스 외에 추가 서비스.

### `play_playlist` 서비스

재생 목록의 임의 위치에서 시작하는 옵션으로 Spotify 재생목록을 재생하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `media_content_id`     | no       | Spotify URI of playlist. Must be playlist kind of URI.
| `random_song`          | yes      | True to select random song at start, False to start from beginning.


위 재생목록 예는 "Reggae Infusions" 재생목록에 대한 URI 링크입니다.
[This support document from Spotify](https://support.spotify.com/us/article/sharing-music/)는 이 URI 값을 Spotify 구성요소의 재생목록에 사용하는 방법을 설명합니다.

## 미지원 기기들

- **Sonos**: Sonos는 Spotify Connect 장치이지만 공식 Spotify API에서는 지원되지 않습니다.