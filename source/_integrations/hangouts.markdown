---
title: 구글 행아웃(Google Hangouts)
description: Hangouts chatbot support
logo: hangouts.png
ha_category:
  - Hub
  - Notifications
ha_release: 0.77
ha_config_flow: true
---

이 연동을 통해 [Google 행 아웃](https://hangouts.google.com) 대화에 메시지를 보내고 대화의 메시지에 반응 할 수 있습니다. 설정된 명령중 하나가 트리거될 때 이벤트를 발생시켜 명령에 반응합니다. 홈어시스턴트는 Smartisan YQ603 전화를 가장하여 Google 기기에 표시됩니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Notifications](#notifications)

## 프론트 엔드를 통한 연동 설정

Menu: *설정* -> *통합구성요소*

Configure the integration:
* Enter your **Google Mail Address** and **Password**
* In the authentication form there is an Optional Field: **Authorization Code** which should only be used if you get an invalid login error with email and password (see note below for details).
* If you secured your account with 2-factor authentication you will be asked for a 2-factor authentication token.

## 수동 인증

이메일과 비밀번호가 정확하지만 통합구성요소에서 로그인이 유효하지 않다고 표시되면 수동 인증 방법을 사용해야합니다.

수동 방법을 사용하려면 먼저 인증 코드를 얻어야합니다 (자세한 내용은 <a href="#steps-to-obtain-authorization-code">instructions below</a> 참조).

코드를 받으면 이메일, 비밀번호 및 인증 코드로 양식을 작성하여 인증을 완료하십시오.

### 인증 코드를 얻는 단계 :

1. To obtain your authorization code, open [this URL](https://accounts.google.com/o/oauth2/programmatic_auth?scope=https%3A%2F%2Fwww.google.com%2Faccounts%2FOAuthLogin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email&client_id=936475272427.apps.googleusercontent.com&device_name=hangups) in your browser.
2. Log into your Google account normally.
3. You should be redirected to a loading screen. Copy the `oauth_code` cookie value set by this page and paste it here.

To obtain the `oauth_code` cookie value using Chrome or Firefox, follow the steps below:

* Press F12 to open developer tools.
* Select the "Application" (Chrome) or "Storage" (Firefox) tab.
* In the sidebar, expand "Cookies" and select `https://accounts.google.com`
* In the cookie list, double click on the value for the `oauth_code` cookie to select it, and copy the value. This is the authorization code

<div class='note'>
"you" 메시지를 작성하면 자신에게 메시지를 쓰거나 그룹에서 알림을 받을 수 없습니다. 가장 좋은 방법은 이 연동을 위해 새 Google 행아웃 계정을 만드는 것입니다.<br>
<br>
2 단계 인증으로 계정을 보호한 경우 : 앱 또는 SMS를 통한 인증만 지원됩니다. 휴대 전화에서 프롬프트로 확인을 지원하지 않습니다.<br>
<br>
수동 인증 해결 방법은 Google 행아웃에서 봇을 비공식적으로 지원한 결과입니다.
</div>

인증 토큰이 생성되어 내부적으로 저장됩니다.

```yaml
# Example configuration.yaml entry
hangouts:
  intents:
    HangoutsHelp:
      sentences:
        - Help
    LivingRoomTemperature:
      sentences:
        - What is the temperature in the living room
      conversations:
        - id: CONVERSATION_ID1
        - id: CONVERSATION_ID2
  default_conversations:
    - id: CONVERSATION_ID1
  error_suppressed_conversations:
    - id: CONVERSATION_ID2
```

{% configuration %}
intents:
  description: "Intents that the hangouts integration should understand."
  required: false
  type: map
  default: empty
  keys:
    '`<INTENT NAME>`':
      description: "Single intent entry."
      required: true
      type: map
      keys:
        sentences:
          description: "Sentences that should trigger this intent."
          required: true
          type: list
        conversations:
          description: "A list of conversations that triggers this intent. If no conversation are given, every conversations triggers the intent."
          required: false
          type: [map]
          default: empty
          keys:
            id:
              description: "Specifies the id of the conversation. *The conversation id can be obtained from the `hangouts.conversations` entity.*"
              required: true
              type: string
default_conversations:
  description: "A list of conversations that are used for intents if no `conversations` entry for an intent is given."
  required: false
  type: [map]
  default: empty
  keys:
    id:
      description: "Specifies the id of the conversation. *The conversation id can be obtained from the `hangouts.conversations` entity.*"
      required: true
      type: string
error_suppressed_conversations:
  description: "A list of conversations that won't get a message if the intent is not known."
  required: false
  type: [map]
  default: empty
  keys:
    id:
      description: "Specifies the id of the conversation. *The conversation id can be obtained from the `hangouts.conversations` entity.*"
      required: true
      type: string
{% endconfiguration %}

대화(conversations)는 미리 작성해야하며, conversation ID는 `hangouts.conversations` 엔티티에서 얻을 수 있습니다. conversations ID 또는 별명(alias)을 따옴표로 묶어 YAML에서 특수 문자 (`!`, `#`)를 이스케이프하십시오.

`HangoutsHelp` 의도(intent)는 연동작업의 일부이며 연동작업에서 이해할 수 없는 모든 문장의 목록을 이 대화에서 반환합니다.

## 문장 추가 

{% raw %}

```yaml
# The Hangouts component
hangouts:
  intents:
    HassLightSet:
      sentences:
        - Toggle {name}.
      conversations:
        - id: CONVERSATION_ID1
    Ping:
      sentences:
        - How many Conversation do you know
  error_suppressed_conversations:
    - id: CONVERSATION_ID2

intent_script:
  Ping:
    speech:
      text: I know {{ states('hangouts.conversations') }} conversations
```

{% endraw %}

이 설정은 다음과 같습니다. :

- 특정 대화에서 특정 위치의 조명을 토글합니다.
- 봇이 알고 있는 대화를 반환하십시오.

## 고급 사용자 정의 문장 추가

문장에는 슬롯 (중괄호: `{name}`)과 선택적 단어 (대괄호: `[the]`)가 포함될 수 있습니다. 슬롯값은 의도(intent)로 전달되며 템플릿 내에서 사용할 수 있습니다.

다음 설정은 다음 문장을 처리 할 수 ​​있습니다.

- Change the lights to red
- Change the lights to green
- Change the lights to blue
- Change the lights to the color red
- Change the lights to the color green
- Change the lights to the color blue

{% raw %}

```yaml
# Example configuration.yaml entry
hangouts:
  intents:
    ColorLight:
      sentences:
        - Change the lights to [the color] {color}

intent_script:
  ColorLight:
    speech:
      text: Changed the lights to {{ color }}.
    action:
      service: light.turn_on
      data_template:
        rgb_color:
          - "{% if color == 'red' %}255{% else %}0{% endif %}"
          - "{% if color == 'green' %}255{% else %}0{% endif %}"
          - "{% if color == 'blue' %}255{% else %}0{% endif %}"
```

{% endraw %}

## 서비스

### `hangouts.update` 서비스

대화 목록을 업데이트합니다.

| Service data attribute | Optional | Description                                      |
|------------------------|----------|--------------------------------------------------|
|                        |          |                                                  |

### `hangouts.send_message` 서비스

주어진 대화에 메시지를 보냅니다.

| Service data attribute | Optional | Description                                      |
|------------------------|----------|--------------------------------------------------|
| target                 | List of targets with id or name. [Required] | [{"id": "UgxrXzVrARmjx_C6AZx4AaABAagBo-6UCw"}, {"name": "Test Conversation"}] |
| message                | List of message segments, only the "text" field is required in every segment. [Required] | [{"text":"test", "is_bold": false, "is_italic": false, "is_strikethrough": false, "is_underline": false, "parse_str": false, "link_target": "http://google.com"}, ...] |
| data                   | Extra options | {"image_file": "path"} / {"image_url": "url"} |

### `hangouts.reconnect` 서비스

행아웃 봇을 다시 연결합니다.

| Service data attribute | Optional | Description                                      |
|------------------------|----------|--------------------------------------------------|
|                        |          |                                                  |

## 고급

### IP 변경후 자동 재연결

행아웃 연동에서 IP 주소 변경 여부를 감지할 수 없으므로 Google 서버에 자동으로 다시 연결할 수 없습니다. 이 문제에 대한 해결 방법입니다.

{% raw %}

```yaml
sensor:
  - platform: rest
    resource: https://api.ipify.org/?format=json
    name: External IP
    value_template: '{{ value_json.ip }}'
    scan_interval: 10

automation:
  - alias: Reconnect Hangouts
    trigger:
      - entity_id: sensor.external_ip
        platform: state
    condition:
      - condition: template
        value_template: '{{ trigger.from_state.state != trigger.to_state.state }}'
      - condition: template
        value_template: '{{ not is_state("sensor.external_ip", "unavailable") }}'
    action:
      - service: hangouts.reconnect
```

{% endraw %}

## 알림(Notifications)

`hangouts` 플랫폼을 사용하면 홈어시스턴트에서 [Google Hangouts](https://hangouts.google.com/) 대화에 알림을 전달할 수 있습니다. 대화는 그룹 채팅뿐만 아니라 직접 대화도 가능합니다.

설치에서 행아웃 알림을 사용하려면 먼저 행아웃 구성 요소를 설정해야합니다. 그런 다음 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry  
notify:
  - name: NOTIFIER_NAME
    platform: hangouts
    default_conversations:
      - id: CONVERSATION_ID1
      - id: CONVERSATION_ID2
```

{% configuration %}
name:
  description: "Setting the optional parameter `name` allows multiple notifiers to be created. The default value is `notify`. The notifier will bind to the service `notify.NOTIFIER_NAME`."
  required: false
  type: string
default_conversations:
  description: "The conversations all messages will be sent to, when no other target is given."
  required: true
  type: [map]
  keys:
    id:
      description: "Specifies the id of the conversation. *The conversation id can be obtained from the `hangouts.conversations` entity.*"
      required: true
      type: string
{% endconfiguration %}

### conversation ID 찾기

대화(conversation)는 미리 작성해야하며, conversation ID는 `hangouts.conversations` 엔티티에서 얻을 수 있으며, 사이드 바에서 이 아이콘 <img src='/images/screenshots/developer-tool-states-icon.png' class='no-shadow' height='38' />로 표시되는 상태 개발자 도구에서 찾을 수 있습니다. 웹 브라우저 검색 도구를 사용하여 `hangouts.conversations` 엔티티를 찾으십시오. 아래와 같은 것을 찾을 수 있습니다.

```json
0: {
  "id": "<Hangout ID>",
  "name": "A simple hangout",
  "users": [
    "Steve",
    "Jo"
  ]
}
```

계정이 여러 행아웃 대화에 있는 경우 더 많을 수 있습니다. 봇이 대화에 있도록 설정하려면 예에서 `<Hangout ID>`가 있는 ID가 필요합니다. conversation ID 또는 별명(alias)을 따옴표로 묶어 YAML에서 특수 문자 (`!`, `#`)를 이스케이프하십시오.

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.