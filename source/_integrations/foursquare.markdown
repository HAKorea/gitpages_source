---
title: 포스퀘어(Foursquare)
description: Instructions on how to the Foursquare API into Home Assistant.
logo: foursquare.png
ha_category:
  - Social
ha_release: 0.26
ha_iot_class: Cloud Polling and Cloud Push
ha_codeowners:
  - '@robbiet480'
---

`foursquare` 통합구성요소는 Foursquare [Real-Time API](https://developer.foursquare.com/overview/realtime)에서 푸시(push)를 받고 Swarm에서 사용자를 체크인하는 서비스를 허용합니다.

```yaml
# Example configuration.yaml entry
foursquare:
  access_token: "<foursquare access token>"
  push_secret: "<foursquare push secret>"
```

{% configuration %}
access_token:
  description: Foursquare API 액세스 토큰.
  required: true
  type: string
push_secret:
  description: Foursquare가 앱 대시 보드에서 제공하는 푸시 비밀정보
  required: true
  type: string
{% endconfiguration %}

#### 액세스 토큰 받기 ####

After you have registered your APP on your [My Apps Page](https://foursquare.com/developers/apps) you get a `CLIENT_ID` and you have specified a `REDIRECT_URL` which can be any URL you like, but since it will get your access token via an HTTP GET request, it should be a URL which will ignore the `access_token` HTTP GET variable. A good idea is to choose the URL of your Home Assistant.
Visit the following URL in your browser:
[My Apps Page](https://foursquare.com/developers/apps)에 APP를 등록한 후 `CLIENT_ID`가 표시되고 원하는 URL로 `REDIRECT_URL`을 지정했을 것입니다. 하지만, HTTP GET 요청을 통해 액세스 토큰을 얻으므로, `access_token` HTTP GET 변수를 무시하는 URL일 것입니다. 결국 홈어시스턴트의 URL을 선택하는 것이 좋습니다. 브라우저에서 다음 URL을 방문하십시오. :

```txt
https://foursquare.com/oauth2/authenticate?client_id=CLIENT_ID&response_type=token&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
```

`CLIENT_ID` 및 `YOUR_REGISTERED_REDIRECT_URL` 을 실제 값으로 변경하십시오. Foursquare 계정을 새로 만든 앱에 연결할지 묻는 OAuth 요청 랜딩 페이지가 나타납니다. "Yes"라고 하십시오. 그 후에는 HTTP GET 변수로 `access_token`을 사용하여 `REDIRECT_URL`으로 리디렉션됩니다. = 뒤에 모든 것을 복사하고 configuration.yaml에 `access_token`으로 붙여 넣으십시오.

### 실시간 API

연동 이후 `/api/foursquare`에서 Foursquare의 푸시를 허용합니다. 경로는 인증이 필요하지 않습니다.

Foursquare 체크인 이벤트를 즉시 사용하여 자동화 액션을 트리거 할 수 있습니다. 다음예를 보십시오. 

```yaml
automation:
  - alias: Trigger action when you check into a venue.
    trigger:
      platform: event
      event_type: foursquare.push
    action:
      service: script.turn_on
      entity_id: script.my_action
```

### 체크인 (Check ins)

사용자를 체크인하려면 `foursquare / checkin` 서비스를 사용하십시오.

Parameters:

- **venueId** (*Required*): 사용자가 체크인하는 Foursquare 장소.
- **eventId** (*Optional*): 사용자가 체크인하는 이벤트.
- **shout** (*Optional*): 체크인에 관한 메시지. 이 필드의 최대 길이는 140 자입니다.
- **mentions** (*Optional*): 체크인시 멘션. 이 매개 변수는 세미콜론으로 구분된 멘션 목록입니다. 단일 멘션은 “start, end, userid” 형식입니다. 여기서 start는 멘션을 나타내는 shout의 첫 문자 색인이고 end는 멘션 후 shout의 첫 번째 문자 색인이며 userid는 멘션된 사용자의 사용자 ID userid 접두사가 “fbu-”인 경우 멘션중인 Facebook 사용자 ID를 나타냅니다. shout의 문자 색인은 0부터 시작합니다.
- **broadcast** (*Optional*): “이 체크인을 브로드 캐스트하는 사람. 쉼표로 구분된 값 목록을 수락합니다 (비공개) 또는 공개 (친구와 공유), Facebook의 Facebook 공유, Twitter의 트위터 공유, Twitter의 팔로워 공유, 팔로워와 공유 (유명인 모드 사용자만), 유효한 값을 찾을 수 없는 경우, 기본값은 공개입니다.”
- **ll** (*Optional*): 사용자 위치의 위도 및 경도. 체크인시 사용자의 GPS 또는 기타 장치 보고 위치가 있는 경우에만 이 필드를 지정하십시오.
- **llAcc** (*Optional*): 사용자의 위도와 경도의 정확도 ( 미터).
- **alt** (*Optional*): 사용자 위치의 고도 (미터)
- **altAcc** (*Optional*): 사용자 위치의 수직 정확도 (미터).
