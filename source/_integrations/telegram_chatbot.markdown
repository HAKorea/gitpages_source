---
title: "텔레그램 챗봇"
description: "Telegram chatbot support"
logo: telegram.png
ha_category:
  - Hub
ha_release: 0.42
ha_iot_class: Cloud Push
---

모바일 또는 데스크톱 장치에서 송수신 기능을 사용하여 홈 어시스턴트와 메시지 또는 명령을 주고받습니다.

이 통합구성요소는 [polling](/integrations/telegram_polling) 플랫폼 또는 다음으로 구성된 [Telegram Bot account](https://core.telegram.org/bots)에서 메시지를 보내거나 이전에 보낸 메시지를 편집하는 알림 서비스를 만듭니다. [webhooks](/integrations/telegram_webhooks) 및 메시지 수신시 이벤트를 트리거합니다.

메시지를 받을 필요가 없는 경우 [broadcast](/integrations/telegram_broadcast) 플랫폼을 대신 사용할 수 있습니다.

## 알림 서비스

제공 서비스 : `send_message`, `send_photo`, `send_document`, `send_location`, `send_sticker`, `edit_message`, `edit_replymarkup`, `edit_caption`, `answer_callback_query`, `delete_message`, `leave_chat`.

### `telegram_bot.send_message` 서비스

알림을 보냅니다.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `message`                 |       no | 알림의 메시지 본문. |
| `title`                   |      yes | 알림의 제목입니다. 예: '%title\n%message'. |
| `target`                  |      yes | 알림을 보낼 사전 승인 된 chat_id 또는 user_id의 배열. 첫 번째로 허용되는 chat_id가 기본값. |
| `parse_mode`              |      yes | 메시지 텍스트 파서: `html` 혹은 `markdown`. |
| `disable_notification`    |      yes | 메시지를 자동으로 보내기위한 True/False. iOS 사용자와 웹 사용자는 알림을받지 않으며, Android 사용자는 소리없이 알림을 받습니다. 기본값은 False. |
| `disable_web_page_preview`|      yes | 메시지의 링크에 대한 링크 미리보기를 사용하지 않는 경우 True/false. |
| `keyboard`                |      yes | 사용자 정의 키보드를 만들기 위한 쉼표로 구분 된 명령 행 목록. `[]`로 사용자 정의 키보드가 없는 것으로 재설정. 예:`["/command1, /command2", "/command3"]` |
| `inline_keyboard`         |      yes | 콜백 데이터가 연결된 버튼이있는 사용자 지정 인라인 키보드를 만들기 위해 쉼표로 구분 된 명령 행 목록. 예:  `["/button1, /button2", "/button3"]` or `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.send_photo` 및 `telegram_bot.send_sticker` 서비스

사진을 보냅니다. 

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `url`                     |       no | 이미지의 원격 경로. |
| `file`                    |       no | 이미지의 로컬 경로.  |
| `caption`                 |      yes | 이미지의 제목. |
| `username`                |      yes | HTTP 기본 인증이 필요한 URL의 사용자 이름. |
| `password`                |      yes | HTTP 기본 인증이 필요한 URL의 비밀번호. |
| `authentication`          |      yes | 사용할 인증 방법을 정의하십시오. `digest`는 HTTP 다이제스트 인증을 사용합니다. 기본은 `basic` 입니다. |
| `target`                  |      yes | 알림을 보낼 사전 승인 된 chat_id 또는 user_id의 배열입니다. 첫 번째로 허용되는 chat_id가 기본값. |
| `disable_notification`     |      yes | 메시지를 조용히 보내기 True/false. iOS 사용자와 웹 사용자는 알림을 받지 않으며, Android 사용자는 소리없이 알림을 받습니다. 기본값은 False. |
| `verify_ssl`              |      yes | HTTPS URL에 대한 서버의 SSL 인증서를 확인하는 경우 True / false. 기본값은 True. |
| `keyboard`                |      yes | 커스텀 키보드를 만들기 위한 쉼표로 구분 된 명령행 목록. `[]`로 사용자 정의 키보드가 없는 것으로 재설정. 예:`["/command1, /command2", "/command3"]` |
| `inline_keyboard`         |      yes | 연관된 콜백 데이터가 있는 버튼으로 사용자 정의 인라인 키보드를 만들기 위한 쉼표로 구분된 명령행 목록. 예: `["/button1, /button2", "/button3"]` or `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.send_video` 서비스

비디오 보내기.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `url`                     |       no | 비디오의 원격 경로. |
| `file`                    |       no | 비디오의 로컬 경로.  |
| `caption`                 |      yes | 비디오의 제목. |
| `username`                |      yes | HTTP 기본 인증이 필요한 URL의 사용자 이름. |
| `password`                |      yes | HTTP 기본 인증이 필요한 URL의 비밀번호. |
| `authentication`          |      yes | 사용할 인증 방법을 정의하십시오. `digest`는 HTTP 다이제스트 인증을 사용합니다. 기본은 `basic` 입니다. |
| `target`                  |      yes | 알림을 보낼 사전 승인 된 chat_id 또는 user_id의 배열입니다. 첫 번째로 허용되는 chat_id가 기본값입니다. |
| `disable_notification`    |      yes | 메시지를 자동으로 보내려면 True/False 입니다. iOS 사용자와 웹 사용자는 알림을 받지 않습니다. Android 사용자에게는 소리가 들리지 않는 알림이 수신됩니다. 기본값은 False입니다. |
| `verify_ssl`              |      yes | HTTPS URL에 대한 서버의 SSL 인증서를 확인하는 True/False 기본값은 True.
| `keyboard`                |      yes | 커스텀 키보드를 만들기 위한 쉼표로 구분 된 명령행 목록. `[]`로 사용자 정의 키보드가 없는 것으로 재설정. 예:`["/command1, /command2", "/command3"]` |
| `inline_keyboard`         |      yes | 연관된 콜백 데이터가 있는 버튼으로 사용자 정의 인라인 키보드를 만들기 위한 쉼표로 구분된 명령행 목록. 예: `["/button1, /button2", "/button3"]` or `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.send_document` 서비스

문서를 보냅니다. 

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `url`                     |       no | 문서의 원격 경로. |
| `file`                    |       no | 문서의 로컬 경로.  |
| `caption`                 |      yes | 문서의 제목. |
| `username`                |      yes | HTTP 기본 인증이 필요한 URL의 사용자 이름. |
| `password`                |      yes | HTTP 기본 인증이 필요한 URL의 비밀번호. |
| `authentication`          |      yes | 사용할 인증 방법을 정의하십시오. `digest`는 HTTP 다이제스트 인증을 사용합니다. 기본은 `basic` 입니다. |
| `target`                  |      yes | 알림을 보낼 사전 승인된 chat_id 또는 user_id의 배열입니다. 첫 번째로 허용되는 chat_id가 기본값입니다. | |
| `disable_notification`    |      yes | 메시지를 자동으로 보내려면 True/False 입니다. iOS 사용자와 웹 사용자는 알림을 받지 않습니다. Android 사용자에게는 소리가 들리지 않는 알림이 수신됩니다. 기본값은 False입니다. |
| `verify_ssl`              |      yes | HTTPS URL에 대한 서버의 SSL 인증서를 확인하는 True/False 기본값은 True. |
| `keyboard`                |      yes | 커스텀 키보드를 만들기 위한 쉼표로 구분 된 명령행 목록. `[]`로 사용자 정의 키보드가 없는 것으로 재설정. 예:`["/command1, /command2", "/command3"]` |
| `inline_keyboard`         |      yes | 연관된 콜백 데이터가 있는 버튼으로 사용자 정의 인라인 키보드를 만들기 위한 쉼표로 구분된 명령행 목록. 예: `["/button1, /button2", "/button3"]` or `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.send_location` 서비스

위치를 전송합니다.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `latitude`                |       no | 보낼 위도. |
| `longitude`               |       no | 보낼 경도.  |
| `target`                  |      yes | 알림을 보낼 사전 승인 된 chat_id 또는 user_id의 배열입니다. 첫 번째로 허용되는 `chat_id`가 기본값입니다. |
| `disable_notification`    |      yes | 메시지를 자동으로 보내려면 True / false입니다. iOS 사용자와 웹 사용자는 알림을받지 않으며, Android 사용자는 소리없이 알림을받습니다. 기본값은 False입니다. |
| `keyboard`                |      yes | 커스텀 키보드를 만들기 위한 쉼표로 구분 된 명령행 목록. `[]`로 사용자 정의 키보드가 없는 것으로 재설정. 예:`["/command1, /command2", "/command3"]` |
| `inline_keyboard`         |      yes | 연관된 콜백 데이터가 있는 버튼으로 사용자 정의 인라인 키보드를 만들기 위한 쉼표로 구분된 명령행 목록. 예: `["/button1, /button2", "/button3"]` or `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.edit_message` 서비스

대화에서 이전에 보낸 메시지를 편집합니다. 

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `message_id`              |       no | 편집할 메시지의 ID. 누른 버튼에서 콜백에 응답할 때 원본 메시지의 ID는 {% raw %}`{{trigger.event.data.message.message_id}}`{% endraw %}에 있습니다. `"last"`를 사용하여 `chat_id`에 전송된 마지막 메시지 참조 가능. |
| `chat_id`                 |       no | 메시지를 편집할 chat_id.  |
| `message`                 |       no | 알림 메시지 본문. |
| `title`                   |      yes | 알림의 제목입니다. '% title \ n % message'로 구성됩니다. |
| `parse_mode`              |      yes | 메시지 텍스트 파서 : `html` 혹은 `markdown`. |
| `disable_web_page_preview`|      yes | 메시지의 링크에 대한 링크 미리보기를 사용하지 않도록 설정하는 경우 True/False. |
| `inline_keyboard`         |      yes | 연관된 콜백 데이터가 있는 버튼으로 사용자 정의 인라인 키보드를 만들기 위한 쉼표로 구분된 명령행 목록. 예: `["/button1, /button2", "/button3"]` or `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.edit_caption` 서비스

이전에 보낸 메시지의 캡션을 편집합니다.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `message_id`              |       no | 편집할 메시지의 ID. 누른 버튼에서 콜백에 응답할 때 원본 메시지의 ID는 {% raw %}`{{trigger.event.data.message.message_id}}`{% endraw %}에 있습니다. `"last"`를 사용하여 `chat_id`에 전송된 마지막 메시지 참조 가능. |
| `chat_id`                 |       no | 캡션을 편집 할 chat_id.  |
| `caption`                 |       no | 알림의 메시지 본문. |
| `disable_web_page_preview`|      yes | 메시지의 링크에 대한 링크 미리보기를 사용하지 않도록 설정하는 경우 True/False. |
| `inline_keyboard`         |      yes | 연관된 콜백 데이터가 있는 버튼으로 사용자 정의 인라인 키보드를 만들기 위한 쉼표로 구분된 명령행 목록. 예: `["/button1, /button2", "/button3"]` or `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.edit_replymarkup` 서비스

이전에 보낸 메시지의 인라인 키보드를 편집합니다.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `message_id`              |       no | 편집할 메시지의 ID. 누른 버튼에서 콜백에 응답할 때 원본 메시지의 ID는 {% raw %}`{{trigger.event.data.message.message_id}}`{% endraw %}에 있습니다. `"last"`를 사용하여 `chat_id`에 전송된 마지막 메시지 참조 가능. |
| `chat_id`                 |       no | reply_markup을 편집 할 수있는 chat_id.  |
| `disable_web_page_preview`|      yes | 메시지의 링크에 대한 링크 미리보기를 사용하지 않도록 설정하는 경우 True/False. |
| `inline_keyboard`         |      yes | 연관된 콜백 데이터가 있는 버튼으로 사용자 정의 인라인 키보드를 만들기 위한 쉼표로 구분된 명령행 목록. 예: `["/button1, /button2", "/button3"]` 혹은 `[[["Text btn1", "/button1"], ["Text btn2", "/button2"]], [["Text btn3", "/button3"]]]` |

### `telegram_bot.answer_callback_query` 서비스

온라인 키보드 버튼을 클릭하여 생성 된 콜백 쿼리에 응답합니다. 답변은 채팅 화면 상단에 알림 또는 경보으로 사용자에게 표시됩니다.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `message`                 |       no | 알림의 형식이 지정되지 않은 문자 메시지 본문. |
| `callback_query_id`       |       no | 콜백 응답의 고유 ID `telegram_callback` 이벤트 데이터: {% raw %}`{{ trigger.event.data.id }}`{% endraw %} |
| `show_alert`              |      yes | 영구 알림(permanent notification)을 표시하려면 True/false입니다. 기본값은 False입니다. |

### `telegram_bot.delete_message` 서비스

대화에서 이전에 보낸 메시지를 삭제합니다.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `message_id`              |       no | 메시지의 ID를 삭제하십시오. 누른 버튼으로 콜백에 응답하면 원래 메시지의 ID : {% raw %}`{{ trigger.event.data.message.message_id }}`{% endraw %}. `"last"`를 사용하여 `chat_id`에 전송된 마지막 메시지 참조 가능. |
| `chat_id`                 |       no | 메시지를 삭제할 chat_id.  |

### `telegram_bot.leave_chat` 서비스

추가된 채팅 그룹에서 봇을 제거합니다.

| Service data attribute    | Optional | Description                                      |
|---------------------------|----------|--------------------------------------------------|
| `chat_id`                 |       no | 봇을 제거 할 위치의 chat_id  |

## `telegram` 알림 플랫폼

[`telegram` notification platform](/integrations/telegram)을 작동하기 위해 `telegram_bot` 연동이 필요하며 알림 (메시지, 사진, 문서 및 위치)을 전송하기 위한 사용자 정의 단축키 (`notify.USERNAME`)를 생성하도록 설계되었습니다. 이전 문법으로 특정 `chat_id`에 추가하여 이전 버전과의 호환성을 허용합니다.

필요한 YAML 설정은 다음같이 줄어듭니다. :

```yaml
notify:
  - name: NOTIFIER_NAME
    platform: telegram
    chat_id: USER_CHAT_ID
```

## 이벤트 트리거 (Event triggering)

`/thecommand` 혹은 `/othercommand with some args` 같은 것들을.

홈어시스턴트가 수신하면 이벤트 버스에서 `telegram_command` 이벤트를 다음과 같은 `event_data`와 함께 시작합니다. :

```yaml
command: "/thecommand"
args: "<any other text following the command>"
from_first: "<first name of the sender>"
from_last: "<last name of the sender>"
user_id: "<id of the sender>"
chat_id: "<origin chat id>"
chat: "<chat info>"
```

`/`로 시작하지 않는 다른 메시지는 간단한 텍스트로 처리되어 이벤트 버스에서 `telegram_text` 이벤트를 다음과 같은 `event_data` :

```yaml
text: "some text received"
from_first: "<first name of the sender>"
from_last: "<last name of the sender>"
user_id: "<id of the sender>"
chat_id: "<origin chat id>"
chat: "<chat info>"
```

예를 들어 [press from an inline button](https://core.telegram.org/bots#inline-keyboards-and-on-the-fly-updating)에서 메시지가 전송되면 콜백 쿼리가 수신됩니다. 홈어시스턴트는 다음과 같이 `telegram_callback` 이벤트를 시작합니다.

```yaml
data: "<data associated to action callback>"
message: <message origin of the action callback>
from_first: "<first name of the sender>"
from_last: "<last name of the sender>"
user_id: "<id of the sender>"
id: "<unique id of the callback>"
chat_instance: "<chat instance>"
chat_id: "<origin chat id>"
```

### 설정 샘플

간단한 핑퐁 사례 

```yaml
alias: 'Telegram bot that reply pong to ping'
trigger:
  platform: event
  event_type: telegram_command
  event_data:
    command: '/ping'
action:
  - service: notify.notify
    data:
      message: 'pong'
```

`notify.telegram`과의 키보드 상호 작용을 보여주는 예

```yaml
trigger:
  platform: event
  event_type: telegram_command
  event_data:
    command: '/start'
action:
  - service: notify.telegram
    data:
      message: 'commands'
      data:
        keyboard:
          - '/ping, /alarm'
          - '/siren'
```

관련 명령 "/ siren"을 트리거하는 자동화.

```yaml
trigger:
  platform: event
  event_type: telegram_command
  event_data:
    command: '/siren'
action:
  - service: homeassistant.turn_on
    entity_id: switch.vision_zm1601eu5_battery_operated_siren_switch_9_0
  - delay:
      seconds: 10
  - service: homeassistant.turn_off
    entity_id: switch.vision_zm1601eu5_battery_operated_siren_switch_9_0
```

실제 event_data 사용을 보여주는 예제 : 


{% raw %}
```yaml
- alias: 'Kitchen Telegram Speak'
  trigger:
    platform: event
    event_type: telegram_command
    event_data:
      command: '/speak'
  action:
    - service: notify.kitchen_echo
      data_template:
        message: >
          Message from {{ trigger.event.data["from_first"] }}. {% for state in trigger.event.data["args"] %} {{ state }} {% endfor %}
```
{% endraw %}

### 콜백 쿼리 및 인라인 키보드를 사용한 샘플 자동화

'EDIT', 'NO' 및 'REMOVE BUTTON' 버튼이 있는 인라인 키보드를 표시하는 일반 텍스트의 간단한 리피터로 구성된 단순한 자동화 기능을 갖춘 인라인 키보드의 일부 콜백 기능을 보여주는 간단한 예

- 'EDIT', 'NO' 및 'REMOVE BUTTON'
- 'NO'를 누르면 간단한 알림 만 표시됩니다. (콜백 쿼리에 응답).
- 'REMOVE BUTTON'를 누르면 해당 버튼을 제거하는 인라인 키보드가 변경됩니다.

텍스트 반복 :

{% raw %}
```yaml
- alias: 'Telegram bot that repeats text'
  trigger:
    platform: event
    event_type: telegram_text
  action:
    - service: telegram_bot.send_message
      data_template:
        title: '*Dumb automation*'
        target: '{{ trigger.event.data.user_id }}'
        message: 'You said: {{ trigger.event.data.text }}'
        disable_notification: true
        inline_keyboard:
          - "Edit message:/edit_msg, Don't:/do_nothing"
          - "Remove this button:/remove button"
```
{% endraw %}

메시지 에디터 :

{% raw %}
```yaml
- alias: 'Telegram bot that edits the last sent message'
  trigger:
    platform: event
    event_type: telegram_callback
    event_data:
      command: '/edit_msg'
  action:
    - service: telegram_bot.answer_callback_query
      data_template:
        callback_query_id: '{{ trigger.event.data.id }}'
        message: 'Editing the message!'
        show_alert: true
    - service: telegram_bot.edit_message
      data_template:
        message_id: '{{ trigger.event.data.message.message_id }}'
        chat_id: '{{ trigger.event.data.chat_id }}'
        title: '*Message edit*'
        inline_keyboard:
          - "Edit message:/edit_msg, Don't:/do_nothing"
          - "Remove this button:/remove button"
        message: >
          Callback received from {{ trigger.event.data.from_first }}.
          Message id: {{ trigger.event.data.message.message_id }}.
          Data: {{ trigger.event.data.data }}
```
{% endraw %}

키보드 에디터 :

{% raw %}
```yaml
- alias: 'Telegram bot that edits the keyboard'
  trigger:
    platform: event
    event_type: telegram_callback
    event_data:
      command: '/remove button'
  action:
    - service: telegram_bot.answer_callback_query
      data_template:
        callback_query_id: '{{ trigger.event.data.id }}'
        message: 'Callback received for editing the inline keyboard!'
    - service: telegram_bot.edit_replymarkup
      data_template:
        message_id: 'last'
        chat_id: '{{ trigger.event.data.chat_id }}'
        inline_keyboard:
          - "Edit message:/edit_msg, Don't:/do_nothing"
```
{% endraw %}

'NO' 답변만 인지 :

{% raw %}
```yaml
- alias: 'Telegram bot that simply acknowledges'
  trigger:
    platform: event
    event_type: telegram_callback
    event_data:
      command: '/do_nothing'
  action:
    - service: telegram_bot.answer_callback_query
      data_template:
        callback_query_id: '{{ trigger.event.data.id }}'
        message: 'OK, you said no!'
```
{% endraw %}

텔레 그램 콜백은 일반 메시지와 동일한 방식으로 인수 및 명령을 지원합니다. 

{% raw %}
```yaml
- alias: 'Telegram bot repeats arguments on callback query'
  trigger:
    platform: event
    event_type: telegram_callback
    event_data:
      command: '/repeat'
  action:
    - service: telegram_bot.answer_callback_query
      data_template:
        show_alert: true
        callback_query_id: '{{ trigger.event.data.id }}'
        message: 'I repeat: {{trigger.event.data["args"]}}'
```
{% endraw %}

이 경우, `/ repeat 1 2 3`으로 콜백을 하면 팝업창에 `I repeat : [1, 2, 3]` 라고 알림이 뜹니다. 

`telegram_bot` 기능을보다 복잡하게 사용하려면 [AppDaemon](/docs/ecosystem/appdaemon/tutorial/)을 사용하는 것이 좋습니다.

이것이 바로 이전의 4가지의 자동화가 간단한 AppDaemon 앱을 통한 방법입니다 : 

```python
import appdaemon.plugins.hass.hassapi as hass


class TelegramBotEventListener(hass.Hass):
    """Event listener for Telegram bot events."""

    def initialize(self):
        """Listen to Telegram Bot events of interest."""
        self.listen_event(self.receive_telegram_text, "telegram_text")
        self.listen_event(self.receive_telegram_callback, "telegram_callback")

    def receive_telegram_text(self, event_id, payload_event, *args):
        """Text repeater."""
        assert event_id == "telegram_text"
        user_id = payload_event["user_id"]
        msg = "You said: ``` %s ```" % payload_event["text"]
        keyboard = [
            [("Edit message", "/edit_msg"), ("Don't", "/do_nothing")],
            [("Remove this button", "/remove button")],
        ]
        self.call_service(
            "telegram_bot/send_message",
            title="*Dumb automation*",
            target=user_id,
            message=msg,
            disable_notification=True,
            inline_keyboard=keyboard,
        )

    def receive_telegram_callback(self, event_id, payload_event, *args):
        """Event listener for Telegram callback queries."""
        assert event_id == "telegram_callback"
        data_callback = payload_event["data"]
        callback_id = payload_event["id"]
        chat_id = payload_event["chat_id"]
        # keyboard = ["Edit message:/edit_msg, Don't:/do_nothing",
        #             "Remove this button:/remove button"]
        keyboard = [
            [("Edit message", "/edit_msg"), ("Don't", "/do_nothing")],
            [("Remove this button", "/remove button")],
        ]

        if data_callback == "/edit_msg":  # Message editor:
            # Answer callback query
            self.call_service(
                "telegram_bot/answer_callback_query",
                message="Editing the message!",
                callback_query_id=callback_id,
                show_alert=True,
            )

            # Edit the message origin of the callback query
            msg_id = payload_event["message"]["message_id"]
            user = payload_event["from_first"]
            title = "*Message edit*"
            msg = "Callback received from %s. Message id: %s. Data: ``` %s ```"
            self.call_service(
                "telegram_bot/edit_message",
                chat_id=chat_id,
                message_id=msg_id,
                title=title,
                message=msg % (user, msg_id, data_callback),
                inline_keyboard=keyboard,
            )

        elif data_callback == "/remove button":  # Keyboard editor:
            # Answer callback query
            self.call_service(
                "telegram_bot/answer_callback_query",
                message="Callback received for editing the " "inline keyboard!",
                callback_query_id=callback_id,
            )

            # Edit the keyboard
            new_keyboard = keyboard[:1]
            self.call_service(
                "telegram_bot/edit_replymarkup",
                chat_id=chat_id,
                message_id="last",
                inline_keyboard=new_keyboard,
            )

        elif data_callback == "/do_nothing":  # Only Answer to callback query
            self.call_service(
                "telegram_bot/answer_callback_query",
                message="OK, you said no!",
                callback_query_id=callback_id,
            )
```
