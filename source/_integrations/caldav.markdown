---
title: 캘린더연동(CalDav)
description: Instructions on how to integrate a WebDav calendar into Home Assistant.
ha_category:
  - Calendar
ha_iot_class: Cloud Polling
ha_release: '0.60'
---

`caldav` 플랫폼을 사용하면 WebDav 캘린더에 연결하고 이진 센서를 생성할 수 있습니다. 개별 캘린더마다 다른 센서가 생성되거나 사용자가 정의한 기준과 일치하는 사용자 정의 캘린더를 지정할 수 있습니다 (자세한 내용은 아래 참조). 해당 일정에 진행중인 이벤트가있는 경우이 센서는 `on`이되고 이벤트가 늦은 시간에 있거나 이벤트가없는 경우 `off`가 됩니다.
WebDav 일정은 대략 15 분마다 업데이트됩니다.

### 전제 조건

CalDav 서버 및 credentials이 필요합니다. 이 통합구성요소는 [Baikal](http://sabre.io/baikal/)에 대해 테스트되었지만 RFC4791을 준수하는 모든 연동이 작동해야합니다. [Nextcloud](https://nextcloud.com/) 및 [Owncloud](https://owncloud.org/)가 제대로 작동합니다.

Python caldav 라이브러리를 컴파일하려면 추가 시스템 패키지가 필요할 수 있습니다. 데비안 기반 시스템에서 다음과 같이 설치하십시오 :

```bash
$ sudo apt-get install libxml2-dev libxslt1-dev zlib1g-dev
```

### 기본 셋업

홈어시스턴트에 WebDav 캘린더를 통합하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry for baikal
calendar:
  - platform: caldav
    username: john.doe@test.com
    password: !secret caldav
    url: https://baikal.my-server.net/cal.php/calendars/john.doe@test.com/default
```

```yaml
# Example configuration.yaml entry for nextcloud, calendars will be found automatically
calendar:
  - platform: caldav
    username: john.doe
    password: !secret caldav
    url: https://nextcloud.example.com/remote.php/dav
```

이 예에서는 계정에 있는 각 캘린더에 대한 기본 이진 센서를 생성합니다. 진행중인 이벤트가있는 경우 해당 캘린더는 `on` 상태이고 그렇지 않은 경우 `off` 상태입니다. 하루 종일 지속되는 이벤트는 해당 캘린더에서 무시됩니다.
이를 고려하거나 고급 이벤트 필터링을 위해 사용자 정의 달력을 설정해야합니다.

### 사용자 정의 달력

특정 조건과 일치하는 이벤트에 대해 여러 이진 센서를 만들 수 있습니다.

```yaml
# Example configuration.yaml entry
calendar:
  - platform: caldav
    username: john.doe@test.com
    password: !secret caldav
    url: https://baikal.my-server.net/cal.php/calendars/john.doe@test.com/default
    custom_calendars:
      - name: 'HomeOffice'
        calendar: 'Agenda'
        search: 'HomeOffice'
      - name: 'WarmupFlat'
        calendar: 'Agenda'
        search: 'Warmup'
```

이렇게하면 켈린더 이름 Agenda에 대해 "HomeOffice" 및 "WarmupFlat"이라는 두 가지 이진 센서가 만들어집니다. `search`에 지정된 정규식과 일치하는 진행중인 이벤트가있는 경우 해당 센서가 `on` 상태가됩니다. 사용자 정의 달력에서 하루 종일 지속되는 이벤트가 고려됩니다.

맞춤 캘린더를 설정할 때 기본 캘린더는 더 이상 생성되지 않습니다.

{% configuration %}
url:
  required: true
  description: The full URL to your calendars.
  type: string
username:
  required: false
  description: Username for authentication.
  type: string
password:
  required: false
  description: Password for authentication.
  type: string
calendars:
  required: false
  description: >
    List of the calendars to filter.
    Empty or absent means no filtering, i.e. all calendars will be added.
  type: list
custom_calendars:
  required: false
  description: Details on any custom binary sensor calendars you want to create.
  type: list
  keys:
    name:
      required: true
      description: The name of your custom calendar.
      type: string
    calendar:
      required: true
      description: The source calendar to search on.
      type: string
    search:
      required: true
      description: >
        Regular expression for filtering the events based on
        the content of their summary, description or location.
      type: string
{% endconfiguration %}

### Sensor 속성

 - **offset_reached**: 이벤트 제목에 설정되고 파싱된 경우 분 단위의 제목 오프셋에 도달하면 on/off 됩니다. 따라서 매우 중요한 미팅 !!-10이라는 제목은 이벤트가 시작되기 10 분 전에 이 속성이 트리거되도록합니다.
 - **all_day**: 하루 종일 이벤트 인 경우 `True/False` 이벤트가 없으면 `False`가 됩니다.
 - **message**: `search` 값이 추출된 이벤트 제목입니다. 위의 `offset_reached` 예에서 메시지는 매우 중요한 회의로 설정됩니다.
 - **description**: 이벤트 설명.
 - **location**: 이벤트 위치.
 - **start_time**: 이벤트 시작 시간
 - **end_time**: 이벤트 종료 시간

### 사례

All events of the calendars "private" and "holidays". Note that all day events are not included.
캘린더의 모든 이벤트는 "private" 및 "holidays"입니다. 하루 종일 일정은 포함되지 않습니다.
```yaml
# Example configuration.yaml entry for nextcloud
calendar:
  - platform: caldav
    url: https://nextcloud.example.com/remote.php/dav
    username: 'me'
    password: !secret caldav
    calendars:
      - private
      - holidays
```

휴일이 아닌 경우 음악으로 기상알림을 자동화하는 기능의 전체 예
전제 조건 : "Holiday"이 포함된 일정 관리 항목을 작성하는 "work"이라는 일정 관리가 있습니다.

사용자 정의 캘린더 이름은 기본 캘린더 + 사용자 정의 캘린더의 이름으로 구성됩니다.

```yaml
# configuration.yaml
calendar:
  - platform: caldav
    url: https://nextcloud.example.com/remote.php/dav
    username: 'me'
    password: !secret caldav
    custom_calendars:
      - name: holiday
        calendar: work
        search: 'Holiday'

# automations.yaml
- id: wakeup
  alias: worktime wakeup
  trigger:
    platform: time
    at: '06:40:00'
  action:
  - service: media_player.media_play
    entity_id: media_player.bedroom
  condition:
  - condition: state
    entity_id: calendar.work_holiday
    state: 'off'
```
