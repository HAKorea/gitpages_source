---
title: 메트릭스(Matrix)
description: Matrix chatbot support
logo: matrix.png
ha_category:
  - Hub
  - Notifications
ha_release: 0.69
ha_codeowners:
  - '@tinloaf'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/jr2mXSKq3B4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 통합구성요소를 통해 매트릭스 rooms에 메시지를 보낼뿐만 아니라 매트릭스 rooms에 메시지를 보낼 수 있습니다. 설정된 명령 중 하나가 트리거 될 때 이벤트를 발생시켜 명령에 반응합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Notifications](#notifications)

## 설정

```yaml
# Example configuration.yaml entry
matrix:
  homeserver: https://matrix.org
  username: "@my_matrix_user:matrix.org"
  password: supersecurepassword
  rooms:
    - "#hasstest:matrix.org"
  commands:
    - word: my_command
      name: my_command
```

{% configuration %}
username:
  description: "The matrix username that Home Assistant should use to log in. *Note*: You must specify a full matrix ID here, including the homeserver domain, e.g., '@my_matrix_bot:matrix.org'. Please note also that the '@' character has a special meaning in YAML, so this must always be given in quotes."
  required: true
  type: string
password:
  description: The password for your Matrix account.
  required: true
  type: string
homeserver:
  description: "The full URL for your homeserver. If you use the default matrix.org homeserver, this is 'https://matrix.org'."
  required: true
  type: string
verify_ssl:
  description: Verify the homeservers certificate.
  required: false
  type: string
  default: true
rooms:
  description: "The list of rooms that the bot should join and listen for commands (see below) in. While you can limit the list of rooms that a certain command applies to on a per-command basis (see below), you must still list all rooms here that commands should be received in. Rooms can be given either by their internal ID (e.g., '!cURbafjkfsMDVwdRDQ:matrix.org') or any of their aliases (e.g., '#matrix:matrix.org')."
  required: false
  type: [string]
  default: empty
commands:
  description: "A list of commands that the bot should listen for. If a command is triggered (via its *word* or *expression*, see below), an event is fired that you can handle using automations. Every command consists of these possible configuration options:"
  required: false
  type: map
  default: empty
  keys:
    word:
      description: "Specifies a word that the bot should listen for. If you specify 'my_command' here, the bot will react to any message starting with '!my_command'."
      required: false
      type: string
    expression:
      description: "Specifies a regular expression (in python regexp syntax) that the bot should listen to. The bot will react to any message that matches the regular expression."
      required: false
      type: string
    name:
      description: "The name of the command. This will be an attribute of the event that is fired when this command triggers."
      required: true
      type: string
    rooms:
      description: "A list of rooms that the bot should listen for this command in. If this is not given, the *rooms* list from the main config is used. Please note that every room in this list must also be in the main *room* config."
      required: false
      type: [string]
      default: empty
{% endconfiguration %}

### 이벤트 데이터

명령이 트리거되면 `matrix_command` 이벤트가 시작됩니다. 이벤트는 `name` 필드에 명령 이름을 포함합니다.

명령어가 단어(word) 명령어인 경우 `data` 필드에는 명령어의 인수 목록, 즉 단어 뒤에 있는 모든 항목이 공백으로 나뉩니다. 명령이 표현식(expression) 명령인 경우, `data` 필드는 메시지와 일치하는 정규식의 [group dictionary](https://docs.python.org/3.6/library/re.html?highlight=re#re.match.groupdict)를 포함합니다.

### 종합적인 설정 예

이 예제는 [matrix `notify` platform](#notifications)도 사용합니다.

{% raw %}
```yaml
# The Matrix component
matrix:
  homeserver: https://matrix.org
  username: "@my_matrix_user:matrix.org"
  password: supersecurepassword
  rooms:
    - "#hasstest:matrix.org"
    - "#someothertest:matrix.org"
  commands:
    - word: testword
      name: testword
      rooms:
        - "#someothertest:matrix.org"
    - expression: "My name is (?P<name>.*)"
      name: introduction

notify:
  - name: matrix_notify
    platform: matrix
    default_room: "#hasstest:matrix.org"

automation:
  - alias: 'React to !testword'
    trigger:
      platform: event
      event_type: matrix_command
      event_data:
        command: testword
    action:
      service: notify.matrix_notify
      data:
        message: 'It looks like you wrote !testword'
  - alias: 'React to an introduction'
    trigger:
      platform: event
      event_type: matrix_command
      event_data:
        command: introduction
    action:
      service: notify.matrix_notify
      data_template:
        message: "Hello {{trigger.event.data.args['name']}}"
```
{% endraw %}

이 설정은 다음과 같습니다. : 

- "#someothertest:matrix.org"(*이것만*) room에서 "!testword"를 들어보십시오. 이러한 메시지가 나타나면 "#hasstest:matrix.org" 채널에 "It looks like you wrote !testword" 라는 메시지가 표시됩니다.
- "My name is <any string>"과 일치하는 메시지가 있는지 두 room에서 듣고 "Hello <the string>"으로 "#hasstest:matrix.org"로 응답하십시오.

## 알림(Notifications)

`matrix` 플랫폼을 사용하면 Home Assistant에서 [Matrix](https://matrix.org/) Rooms로 알림을 전달할 수 있습니다. Rooms은 그룹 채팅뿐만 아니라 직접 대화도 가능합니다.

설치에서 매트릭스 알림을 사용하려면 먼저 [Matrix component](#configuration)를 설정해야합니다. 그런 다음 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: matrix
    default_room: ROOM_ID_OR_ALIAS
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
default_room:
  description: The room all messages will be sent to, when no other target is given.
  required: true
  type: string
{% endconfiguration %}

대상(Target) room을 미리 만들어야하며, room 설정 대화 상자에서 room ID를 얻을 수 있습니다. 기본적으로 room은 `"!<randomid>:homeserver.tld"` 형식의 canonical ID를 갖지만 `"#roomname:homeserver.tld"`와 같은 별칭(aliases)을 할당할 수도 있습니다. YAML에서 특수 문자 (`!`,`#`)를 이스케이프하려면 room ID 또는 별명(aliases)을 따옴표로 묶어야합니다. 개별 rooms 정책에 따라 알림 계정을 rooms에 초대해야 할 수도 있습니다.

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.
