---
title: 구글 캘린더 이벤트(Google Calendar Event)
description: "Instructions on how to use Google Calendars in Home Assistant."
logo: google_calendar.png
ha_category:
  - Calendar
ha_iot_class: Cloud Polling
ha_release: 0.33
---

`google` 캘린더 플랫폼을 사용하면 [Google Calendars](https://calendar.google.com)에 연결하고 Binary 센서를 생성 할 수 있습니다. 생성된 센서는 캘린더의 이벤트를 기준으로 또는 일치하는 이벤트에 대해서만 트리거 할 수 있습니다. 이 통합구성요소를 처음 설정하면 config 디렉토리에 새 구성 파일 `google_calendars.yaml`이 생성되며 여기에는 모든 캘린더에 대한 정보가 포함됩니다. 또한 Google 캘린더에서 이벤트를 추가할 수 있습니다.

<iframe width="690" height="437" src="https://www.youtube.com/embed/OEzpG-iDDlA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## 전제 조건

[Google Developers Console](https://console.developers.google.com/start/api?id=calendar)에서 Client ID 및 Client 비밀번호 생성

1. Follow the wizard using the following information. 
1. When it gets to the point of asking _Which API are you using?_ just click cancel.
1. Under APIs & Services (left sidebar) > Credentials, click on the menu item, 'OAuth consent screen'.
1. Set the 'Application Name' (the name of the application asking for consent) to anything you want. We suggest "Home-Assistant".
1. Save this page. You don't have to fill out anything else here.
1. Click on the menu item, Credentials, then click 'Create credentials' > OAuth client ID.
1. Set the Application type to 'Other' and give this credential set a name (like "Home Assistant Credentials") then click 'Create'.
1. Copy the client ID and client secret from the page that follows into a text editor temporarily as you will need to put these in your `configuration.yaml` file.
1. Click on the menu item, Library, then search for "Google Calendar API" and enable it (if it isn't already enabled automatically through this process).

나중에이 애플리케이션의 OAuth에 "Google Calendar API "보다 더 많은 범위(scope)를 추가하려면 홈어시스턴트 프로파일에서 토큰 파일을 삭제해야합니다. 더 많은 API 액세스를 추가하기 위해 다시 인증하면 새로 고침 토큰이 손실됩니다. Google 서비스에 따라 다른 인증을 사용하는 것이 좋습니다.

## 설정 

홈어시스턴트에 Google 캘린더를 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오 :

```yaml
# Example configuration.yaml entry
google:
  client_id: YOUR_CLIENT_ID
  client_secret: YOUR_CLIENT_SECRET
```

{% configuration %}
client_id:
  description: 전제조건 단계에서 생성한 Clinet ID를 사용하십시오..
  required: true
  type: string
client_secret:
  description: 전제 조건 단계에서 생성 한 Client 비밀번호를 사용하십시오..
  required: true
  type: string
track_new_calendar:
  description: >
    새 캘린더가 감지되면 Binary 센서를 자동으로 생성합니다. 시스템은 시작시에만 새 캘린더를 검색합니다.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

다음에 Home Assistant를 실행하거나 다시 시작하면 새 알림 (왼쪽 아래 모서리에있는 작은 벨 아이콘)이 나타납니다. 해당 알림을 클릭하면 링크와 인증 코드가 표시됩니다. 해당 링크를 클릭하면 알림에 있는 코드를 입력해야하는 Google 웹 사이트가 열립니다. 그러면 인증된 계정이 읽을 수 있는 모든 Google 캘린더에 홈어시스턴트 서비스에 대한 읽기 전용 액세스 권한이 부여됩니다.

## 캘린더 설정 

`google_calendars.yaml` 파일 편집

단일 캘린더의 기본 항목은 다음과 같습니다. : 

```yaml
- cal_id: "*****@group.calendar.google.com"
  entities:
  - device_id: test_everything
    name: Give me everything
    track: true
- cal_id: "*****@group.calendar.google.com"
  entities:
  - device_id: test_important
    name: Important Stuff
    track: true
    search: "#Important"
    offset: "!!"
  - device_id: test_unimportant
    name: UnImportant Stuff
    track: true
    search: "#UnImportant"
```

{% configuration %}
cal_id:
  description: 이 캘린더의 Google *generated* 고유ID
  required: true
  type: string
  default: "**DO NOT CHANGE THE DEFAULT VALUE**"
entities:
  description: 네, 달력에 여러 개의 센서를 사용할 수 있습니다!
  required: true
  type: list
  keys:
    device_id:
      description: >
        모든 자동화/스크립트의 이름이 장치를 참조하는데 사용합니다.
      required: true
      type: string
    name:
      description: 프런트 엔드에 표시되는 센서 이름은 무엇입니까.
      required: true
      type: string
    track:
      description: "센서를 생성해야는지(`true`) 무시해야는지(`false`)" 
      required: true
      type: boolean
      default: true
    search:
      description: 설정시 일치하는 이벤트에 대해서만 트리거
      required: false
      type: string
    offset:
      description: >
        "센서에서 사전 트리거(pre-trigger) 상태 변경을 지정하기 위해 이벤트 제목에서 숫자앞에 오는 문자세트입니다. HH:MM 또는 MM 포맷이어야 합니다."
      required: false
      type: string
      default: "!!"
    ignore_availability:
      description: "`free`/`busy` 플래그를 고려해야 하는지"
      required: false
      type: boolean
      default: true
    max_results:
      description: "검색할 최대 항목수"
      required: false
      type: integer
      default: 5
{% endconfiguration %}

이로서 우리는 Binary 센서 `calendar.test_unimportant` 와 `calendar.test_important`를 가질수 있습니다. 이 센서는 각각에 대해 설정된 검색 값과 일치하는 동일한 캘린더의 이벤트를 기반으로 자신을 켜거나 끕니다.
이벤트를 필터링하지 않고 항상 사용가능한 다음 이벤트를 표시하는 센서 `calendar.test_everything` 이 있습니다.

그러나 모든 이벤트를 기반으로 전환(toggle)하기를 원한다면 어떻게해야합니까?
단지 *search* 매개 변수를 생략하면 됩니다. 

<div class='note warning'>

`search`에 `#`부호를 사용하는 경우 전체 검색어를 따옴표로 묶으십시오.
그렇지 않으면 해시 기호 뒤에 오는 모든 것이 YAML 주석으로 간주됩니다.

</div>

### 센서 속성

 - **offset_reached**: If set in the event title and parsed out will be `on`/`off` once the offset in the title in minutes is reached. So the title `Very important meeting #Important !!-10` would trigger this attribute to be `on` 10 minutes before the event starts. 
 - **all_day**: `true`/`false` if this is an all day event. Will be `false` if there is no event found.
 - **message**: The event title with the `search` and `offset` values extracted. So in the above example for **offset_reached** the **message** would be set to `Very important meeting`
 - **description**: The event description.
 - **location**: The event Location.
 - **start_time**: Start time of event.
 - **end_time**: End time of event.

### `google.add_event` 서비스

`google.add_event` 서비스를 사용하여 캘린더에 새 캘린더 이벤트를 만들 수 있습니다. 캘린더 ID는 `google_calendars.yaml` 파일에서 찾을 수 있습니다. 모든 날짜와 시간은 현지 시간으로, 연동은 `configuration.yaml` 파일에서 시간대를 가져옵니다.

| Service data attribute | Optional | Description | Example |
| ---------------------- | -------- | ----------- | --------|
| `calendar_id` | no | The id of the calendar you want. | *****@group.calendar.google.com
| `summary` | no | Acts as the title of the event. | Bowling
| `description` | yes | The description of the event. | Birthday bowling
| `start_date_time` | yes | The date and time the event should start. | 2019-03-10 20:00:00
| `end_date_time` | yes | The date and time the event should end. | 2019-03-10 23:00:00
| `start_date` | yes | The date the whole day event should start. | 2019-03-10
| `end_date` | yes | The date the whole day event should end. | 2019-03-11
| `in` | yes | Days or weeks that you want to create the event in. | "days": 2

<div class='note'>

You either use `start_date_time` and `end_date_time`, or `start_date` and `end_date`, or `in`.

</div>

## 자동화에서 캘린더 사용하기 

자동화에서 캘린더를 하드 코딩하는 대신 캘린더를 특수 이벤트 또는 재발행 이벤트에 대한 외부 스케줄러로 사용할 수 있습니다.

이벤트가 시작되는 즉시 트리거 :

```yaml
    trigger:
      platform: state
      entity_id: calendar.calendar_name
      to: 'on'
```

이벤트 제목에 특정 텍스트를 사용하면 지정된 이벤트에서 특정 자동화 흐름(flow)을 시작하는 조건을 설정하고 다른 이벤트는 무시할 수 있습니다.

예를 들어 이 조건을 따르는 액션은 'vacation' 이라는 이벤트에 대해서만 실행됩니다. : 

{% raw %}
```yaml
    condition:
        condition: template
        value_template: "{{is_state_attr('calendar.calendar_name', 'message', 'vacation') }}"
```
{% endraw %}
