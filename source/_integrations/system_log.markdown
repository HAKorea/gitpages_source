---
title: 시스템 로그(System Log)
description: Summary of errors and warnings in Home Assistant during runtime.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.58
ha_quality_scale: internal
---

`system_log` 통합구성요소는 기록된 모든 오류 및 경고에 대한 정보를 Home Assistant에 저장합니다. 수집된 모든 정보는 프론트 엔드에서 직접 액세스 할 수 있으며 `개발자 도구` 아래의 `info` 섹션으로 이동하십시오. 로그 데이터로 Home Assistant에 과부하를 주지 않기 위해 마지막 50 개의 오류 및 경고만 저장됩니다. 이전 항목은 자동으로 로그에서 삭제됩니다. `max_entries` 매개 변수를 사용하여 저장된 로그 항목 수를 변경할 수 있습니다.

## 설정

이 통합구성요소는 `프론트 엔드`에 의해 자동으로 로드됩니다. (프런트 엔드를 사용하는 경우 아무 것도 할 필요가 없습니다.) 그렇게하지 않거나 매개 변수를 변경하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.


```yaml
system_log:
  max_entries: MAX_ENTRIES
```

{% configuration %}
max_entries:
  description: Number of entries to store (older entries are discarded).
  required: false
  type: integer
  default: 50
fire_event:
  description: Whether events are fired (required when used for triggers).
  required: false
  type: string
  default: false
{% endconfiguration %}

## 서비스

### `clear` 서비스

시스템 로그를 수동으로 지우려면, 이 서비스를 호출하십시오.

### `write` 서비스

로그 항목을 작성하십시오. 

| Service data attribute | Optional | Description                                                                     |
| ---------------------- | -------- | ------------------------------------------------------------------------------- |
| `message`              | no       | Message to log                                                                  |
| `level`                | yes      | Log level: debug, info, warning, error, critical. Defaults to 'error'.          |
| `logger`               | yes      | Logger name under which to log the message. Defaults to 'system_log.external'.  |

## 이벤트

오류 및 경고는 이벤트 `system_log_event`로 게시되므로 경고 또는 오류가 발생할 때마다 트리거되는 자동화를 작성할 수 있습니다. 각 이벤트에는 다음 정보가 포함됩니다.

| Field       | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| `level`     | Either `WARNING` or `ERROR` depending on severity.                          |
| `source`    | File that triggered the error, e.g., `core.py` or `media_player/yamaha.py`. |
| `exception` | Full stack trace if available, an empty string otherwise.                   |
| `message`   | Descriptive message of the error, e.g., "Error handling request".           |
| `timestamp` | Unix timestamp with as a double, e.g., 1517241010.237416.                   |

이러한 이벤트의 실제 예는 홈어시스턴트 로그 파일 (`home-assistant.log`) 또는 시스템 로그를 보면 찾을 수 있습니다. 예를 들면 다음과 같습니다.

```text
2019-02-14 16:20:35 ERROR (MainThread) [homeassistant.loader] Unable to find integration system_healt
2019-02-14 16:20:36 ERROR (MainThread) [homeassistant.components.device_tracker] Error setting up platform google_maps
Traceback (most recent call last):
  File "/home/fab/Documents/repos/ha/home-assistant/homeassistant/integrations/device_tracker/__init__.py", line 184, in
[...]
```

메시지 ( "Unable to find integration system_healt"), source (`homeassistant.loader`) 및 level (`ERROR`)을 로그에서 쉽게 추출할 수 있습니다.  정확한 타임 스탬프가 나오고, stack trace가 있을 경우 또한 출력됩니다. 추가 출력이 존재하는 `google_map` 통합구성요소로 인한 또 다른 오류가 있습니다.

## 사례 

다음은 `system_log`에 의해 게시된 이벤트를 사용하는 몇 가지 예입니다. 이것이 작동하려면 `fire_event`를 `true`로 설정해야합니다.

### Warnings의 갯수를 카운트

warning이 기록될 때마다 증가하는 `counter`가 생성됩니다.

```yaml
counter:
  warning_counter:
    name: Warnings
    icon: mdi:alert

automation:
  - alias: Count warnings
    trigger:
      platform: event
      event_type: system_log_event
      event_data:
        level: WARNING
    action:
      service: counter.increment
      entity_id: counter.warning_counter
```

### 조건 메시지(Conditional Messages)

이 자동화는 메시지에 "service"라는 오류나 경고가 기록될 때마다 지속적인 알림을 생성합니다.

{% raw %}
```yaml
automation:
  - alias: Create notifications for "service" errors
    trigger:
      platform: event
      event_type: system_log_event
    condition:
      condition: template
      value_template: '{{ "service" in trigger.event.data.message }}'
    action:
      service: persistent_notification.create
      data_template:
        title: Something bad happened
        message: '{{ trigger.event.data.message }}'
```
{% endraw %}

### 로그로 기록하기

이 자동화는 문이 열릴 때 새 로그 항목을 작성합니다.

{% raw %}
```yaml
automation:
  - alias: Log door opened
    trigger:
      platform: state
      entity_id: binary_sensor.door
      from: 'off'
      to: 'on'
    action:
      service: system_log.write
      data_template:
        message: 'Door opened!'
        level: info
```
{% endraw %}
