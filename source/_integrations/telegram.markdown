---
title: 텔레그램(Telegram)
description: Instructions on how to add Telegram notifications to Home Assistant.
logo: telegram.png
ha_category:
  - Notifications
ha_release: 0.7.5
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/qskqdjUZcRY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`telegram` 플랫폼은 [Telegram](https://web.telegram.org)을 사용하여 Home Assistant에서 Android 장치, Windows 전화 또는 iOS 장치로 알림을 전달합니다.

## 셋업

요구 사항은 다음과 같습니다.

- [Telegram bot](https://core.telegram.org/bots)이 필요합니다. 다음 [instructions](https://core.telegram.org/bots#6-botfather)에 따라 하나를 생성하고 봇에 대한 토큰을 받으십시오.
- [Telegram bot in Home Assistant](/integrations/telegram_chatbot)을 설정하고 상호작용할 수있는 API 키 및 허용된 chat ID를 정의해야합니다. 
- 허용된 사용자의 `chat_id`

**방법 1 :** [GetIDs bot](https://t.me/getidsbot)에 메시지를 보내면 `chat_id`를 얻을 수 있습니다.

**방법 2 :** `chat_id`를 검색하려면 `https://api.telegram.org/botYOUR_API_TOKEN/getUpdates`를 방문하거나 봇에게 메시지를 **보낸 후** `$ curl -X GET https://api.telegram.org/botYOUR_API_TOKEN/getUpdates`를 사용하십시오. `YOUR_API_TOKEN`을 실제 토큰으로 바꾸십시오.

결과 집합에는 `chat` 섹션에 chat ID가 `id` 로 포함됩니다.

```json
{
	"ok": true,
	"result": [{
		"update_id": 254199982,
		"message": {
			"message_id": 27,
			"from": {
				"id": 123456789,
				"first_name": "YOUR_FIRST_NAME YOUR_NICK_NAME",
				"last_name": "YOUR_LAST_NAME",
				"username": "YOUR_NICK_NAME"
			},
			"chat": {
				"id": 123456789,
				"first_name": "YOUR_FIRST_NAME YOUR_NICK_NAME",
				"last_name": "YOUR_LAST_NAME",
				"username": "YOUR_NICK_NAME",
				"type": "private"
			},
			"date": 1678292650,
			"text": "test"
		}
	}]
}
```

**방법 3 :** chat ID를 직접받는 다른 방법은 아래에 설명되어 있습니다. 명령행에서 Python 인터프리터를 시작하십시오.

```shell
$ python3
>>> import telegram
>>> bot = telegram.Bot(token='YOUR_API_TOKEN')
>>> chat_id = bot.getUpdates()[-1].message.chat_id
>>> print(chat_id)
123456789
```

<div class='note'>
새 chat ID를 추가하려면 active configuaration을 비활성화하여 실제 ID 결과를 확인해야합니다, 그렇지 않으면 빈 결과 배열 만 표시될 수 있습니다.
</div>

## 설정 

설치에서 텔레그램 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry for the Telegram Bot
telegram_bot:
  - platform: polling
    api_key: YOUR_API_KEY
    allowed_chat_ids:
      - CHAT_ID_1
      - CHAT_ID_2
      - CHAT_ID_3

# Example configuration.yaml entry for the notifier
notify:
  - name: NOTIFIER_NAME
    platform: telegram
    chat_id: CHAT_ID_2
```

`telegram_bot` 설정에 대해서는 [Telegram chatbot page](/integrations/telegram_chatbot/)에 언급된 플랫폼을 참조하십시오.

{% configuration %}
name:
  description: 선택적 매개 변수 `name`을 설정하면 여러 알리미를 만들 수 있습니다. 알리미는 'notify.NOTIFIER_NAME' 서비스에 바인딩합니다.
  required: false
  default: notify
  type: string
chat_id:
  description: 사용자의 chat ID.
  required: true
  type: integer
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.

### 텍스트 메시지

```yaml
...
action:
  service: notify.NOTIFIER_NAME
  data:
    title: '*Send a message*'
    message: "That's an example that _sends_ a *formatted* message with a custom inline keyboard."
    data:
      inline_keyboard:
        - 'Task 1:/command1, Task 2:/command2'
        - 'Task 3:/command3, Task 4:/command4'
```

{% configuration %}
title:
  description: "'%title\n%message'로 구성됩니다."
  required: false
  type: string
message:
  description: 메시지 텍스트.
  required: true
  type: string
keyboard:
  description: 사용자 정의 키보드를 만들기위한 쉼표로 구분된 명령행 목록
  required: false
  type: list
inline_keyboard:
  description: 콜백 데이터가 연결된 버튼이있는 사용자 지정 인라인 키보드를 만들기 위해 쉼표로 구분된 명령행 목록.
  required: false
  type: list
{% endconfiguration %}

### 사진 지원

```yaml
...
action:
  service: notify.NOTIFIER_NAME
  data:
    title: Send an images
    message: "That's an example that sends an image."
    data:
      photo:
        - url: http://192.168.1.28/camera.jpg
          username: admin
          password: secrete
        - file: /tmp/picture.jpg
          caption: Picture Title xy
        - url: http://somebla.ie/video.png
          caption: I.e. for a Title
```

{% configuration %}
url:
  description: 이미지의 원격 경로, 혹은 `file` 설정 옵션이 필요합니다.
  required: true
  type: string
file:
  description: 이미지의 로컬 경로, 혹은 `url` 설정 옵션이 필요합니다.
  required: true
  type: string
caption:
  description: 이미지의 제목.
  required: false
  type: string
username:
  description: HTTP 인증이 필요한 URL의 사용자 이름.
  required: false
  type: string
password:
  description: HTTP 인증이 필요한 URL의 비밀번호.
  required: false
  type: string
authentication:
  description: HTTP 요약 인증을 사용하려면 'digest'로 설정.
  required: false
  default: basic
  type: string
verify_ssl:
  description: 서버의 SSL 인증서 유효성 검증을 건너뛰려면 false로 설정.
  required: false
  default: true
  type: boolean
keyboard:
  description: 사용자 정의 키보드를 만들기 위한 쉼표로 구분된 명령행 목록.
  required: false
  type: list
inline_keyboard:
  description: 콜백 데이터가 연결된 버튼이 있는 사용자 지정 인라인 키보드를 만들기 위해 쉼표로 구분된 명령행 목록.
  required: false
  type: list
{% endconfiguration %}

<div class='note'>

Home Assistant 버전 0.48부터는 알림에 포함할 파일의 [whitelist the source folder](/docs/configuration/basic/)를 추가해야합니다.

```yaml
configuration.yaml
...
homeassistant:
  whitelist_external_dirs:
    - /tmp
    - /home/kenji/data
```

</div>

### 비디오 지원

```yaml
...
action:
  service: notify.NOTIFIER_NAME
  data:
    title: Send a video
    message: "That's an example that sends a video."
    data:
      video:
        - url: http://192.168.1.28/camera.mp4
          username: admin
          password: secrete
        - file: /tmp/video.mp4
          caption: Video Title xy
        - url: http://somebla.ie/video.mp4
          caption: I.e. for a Title
```

{% configuration %}
url:
  description: 비디오의 원격 경로, 혹은 `file` 설정 옵션이 필요합니다.
  required: true
  type: string
file:
  description: 비디오의 로컬 경로, 혹은 `url` 설정 옵션이 필요합니다.
  required: true
  type: string
caption:
  description: 비디오의 제목.
  required: false
  type: string
username:
  description: HTTP 인증이 필요한 URL의 사용자 이름.
  required: false
  type: string
password:
  description: HTTP 인증이 필요한 URL의 비밀번호.
  required: false
  type: string
authentication:
  description: HTTP 요약 인증을 사용하려면 'digest'로 설정.
  required: false
  default: basic
  type: string
verify_ssl:
  description: 서버의 SSL 인증서 유효성 검증을 건너뛰려면 false로 설정
  required: false
  default: true
  type: boolean
keyboard:
  description: 사용자 정의 키보드를 만들기위한 쉼표로 구분된 명령행 목록.
  required: false
  type: list
inline_keyboard:
  description: 콜백 데이터가 연결된 버튼이 있는 사용자 지정 인라인 키보드를 만들기 위해 쉼표로 구분된 명령행 목록.
  required: false
  type: list
{% endconfiguration %}

### 문서 지원

```yaml
...
action:
  service: notify.NOTIFIER_NAME
  data:
    title: Send a document
    message: "That's an example that sends a document and a custom keyboard."
    data:
      document:
        file: /tmp/whatever.odf
        caption: Document Title xy
    keyboard:
      - '/command1, /command2'
      - '/command3, /command4'
```

{% configuration %}
url:
  description: 문서의 원격 경로, 혹은 `file` 설정 옵션이 필요합니다. 
  required: true
  type: string
file:
  description: 문서의 로컬 경로, 혹은 `url` 설정 옵션이 필요합니다.
  required: true
  type: string
caption:
  description: 문서의 제목.
  required: false
  type: string
username:
  description: HTTP 인증이 필요한 URL의 사용자 이름.
  required: false
  type: string
password:
  description: HTTP 인증이 필요한 URL의 비밀번호.
  required: false
  type: string
authentication:
  description: HTTP 요약 인증을 사용하려면 'digest'로 설정.
  required: false
  default: basic
  type: string
verify_ssl:
  description: 서버의 SSL 인증서 유효성 검증을 건너 뛰려면 false로 설정
  required: false
  default: true
  type: boolean
keyboard:
  description: 사용자 정의 키보드를 만들기 위한 쉼표로 구분된 명령행 목록.
  required: false
  type: list
inline_keyboard:
  description: 콜백 데이터가 연결된 버튼이 있는 사용자 지정 인라인 키보드를 만들기 위해 쉼표로 구분된 명령행 목록.
  required: false
  type: list
{% endconfiguration %}

### 위치 지원

```yaml
...

action:
  service: notify.NOTIFIER_NAME
  data:
    title: Send location
    message: Location updated.
    data:
      location:
        latitude: 32.87336
        longitude: 117.22743
```

{% configuration %}
latitude:
  description: 보낼 위도.
  required: true
  type: float
longitude:
  description: 보낼 경도.
  required: true
  type: float
keyboard:
  description: 사용자 정의 키보드를 만들기위한 쉼표로 구분된 명령행 목록
  required: false
  type: list
inline_keyboard:
  description: 콜백 데이터가 연결된 버튼이 있는 사용자 지정 인라인 키보드를 만들기 위해 쉼표로 구분된 명령행 목록.
  required: false
  type: list
{% endconfiguration %}
