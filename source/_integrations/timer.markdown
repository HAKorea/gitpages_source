---
title: 타이머(timer)
description: Instructions on how to integrate timers into Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.57
ha_quality_scale: internal
---

`timer` 통합구성요소의 목적은 (동적으로)기간에 따라 자동화를 단순화합니다

타이머가 끝나거나 취소되면 해당 이벤트가 시작됩니다. 이를 통해 주어진 지속시간이 경과됬거나 취소되었기 때문에 타이머가 `active`에서 `idle`로 전환되었는지 구별할 수 있습니다. 자동화에서 타이머를 제어하려면 아래 언급된 서비스를 사용할 수 있습니다. 이미 실행중인 타이머에서 `start`서비스를 호출하면, 취소되거나 완료된 이벤트를 트리거하지 않고 타이머를 완료하고 다시시작해야하는 시간이 재설정됩니다. 예를 들어 모션센서에 의해 트리거되는 시간이 지정된 조명을 쉽게 만들 수 있습니다. 타이머를 시작하면 타이머가 일시중지되지 않은 경우 시작된 이벤트가 트리거되며, 이 경우 다시시작된 이벤트가 트리거됩니다.

<div class='note warning'>
  현재 구현 타이머에서는 다시시작해도 타이머가 지속되지 않습니다. 다시시작하면 초기설정과 함께 다시 유휴(idle)상태가 됩니다.
</div>

## 설정 (Configuration)

설치에 타이머를 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
timer:
  laundry:
    duration: '00:01:00'
```

{% configuration %}
"[alias]":
  description: 타이머의 별칭. 여러 항목이 허용.
  required: true
  type: map
  keys:
    name:
      description: 타이머의 친숙한 이름.
      required: false
      type: string
    duration:
      description: 홈어시스턴트 시작시의 초기 지속시간입니다. 예로서 초단위 또는 `00:00:00`
      required: false
      type: [integer, time]
      default: 0
    icon:
      description: 상태 카드의 사용자 정의 아이콘을 설정.
      required: false
      type: icon
{% endconfiguration %}

[materialdesignicons.com](https://materialdesignicons.com/)에서 타이머에 사용할 아이콘을 선택하고 이름 앞에 `mdi :`를 붙입니다. 예를 들어 `mdi : car`,`mdi : ambulance` 또는 `mdi : motorbike`

## 이벤트 (Events)

|           Event | Description |
| --------------- | ----------- |
| timer.cancelled | 타이머가 취소되면 시작 |
| timer.finished | 타이머가 완료되면 시작 |
| timer.started | 타이머가 시작되면 시작|
| timer.restarted | 타이머가 다시 시작되면 시작 |
| timer.paused | 타이머가 일시 중지되면 시작 |

## 서비스 (Services)

### `timer.start` 서비스

제공된 지속시간으로 타이머를 시작하거나 다시시작합니다. 지속시간이 제공되지 않으면 초기값으로 다시시작하거나 남은 지속시간으로 일시중지된 타이머를 계속합니다. 새 지속시간이 제공되면 홈어시스턴트가 다시시작될 때까지(기본값이 로드됨) 타이머의 새 기본값이 됩니다. 지속시간은 초단위 또는 읽기쉬운 `01:23:45` 형식으로 지정할 수 있습니다. 
`entity_id: all`을 사용할 수도 있으며 모든 활성 타이머가 시작됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 활동을 시작할 entitiy 이름, 예: `timer.timer0`. |
| `duration`             |      yes | 타이머가 끝날 때까지 지속되는 시간 (초) 또는 `00:00:00` |

### `timer.pause` 서비스

실행중인 타이머를 일시 중지. 이는 나중에 계속할 수 있도록 남은 지속 시간이 유지됩니다. `entity_id: all`을 사용할 수도 있으며 모든 활성 타이머가 일시 중지됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 활동을 시작할 entitiy 이름, 예: `timer.timer0`. |

### `timer.cancel` 서비스

활성 타이머를 취소하십시오. `timer.finished` 이벤트를 발생시키지 않고 지속시간을 마지막으로 알려진 초기값으로 재설정합니다. `entity_id: all`을 사용할 수도 있으며 모든 활성 타이머가 취소됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 활동을 시작할 entitiy 이름, 예: `timer.timer0`. |

### `timer.finish` 서비스

예정된 시간보다 빨리 실행중인 타이머를 수동으로 완료하십시오. `entity_id: all`을 사용할 수도 있으며 모든 활성 타이머가 완료됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | Name of the entity to take action, e.g., `timer.timer0`. |

### `timer.reload` 서비스

홈어시스턴트 자체를 다시시작하지 않고 `timer` 설정을 다시로드하십시오. 이 서비스에는 서비스 데이터 속성이 없습니다.

### 서비스 사용하기 

**Developer Tools** 에서 <img src='/images/screenshots/developer-tool-services-icon.png' alt='service developer tool icon' class="no-shadow" height="38" />**Services** 선택하십시오. **domain** 목록에서 **timer**를 선택하고 **service**를 선택한 다음 **service data** 필드에 아래 샘플과 같은 것을 입력하고 **CALL SERVICE**를 누르십시오.

```json
{
  "entity_id": "timer.timer0"
}
```

## 사례 (Examples)

30 초 동안 `test`라는 타이머를 설정하십시오.

```yaml
# Example configuration.yaml entry
timer:
  test:
    duration: '00:00:30'
```

### 프론트 엔드에서 타이머 제어 

```yaml
# Example automations.yaml entry
- alias: Timerswitch
  id: 'Timerstart'
  # Timer is started when the switch pumprun is set to on.
  trigger:
  - platform: state
    entity_id: switch.pumprun
    to: 'on'
  action:
  - service: timer.start
    entity_id: timer.test

# When timer is stopped, the time run out, another message is sent
- alias: Timerstop
  id: 'Timerstop'
  trigger:
  - platform: event
    event_type: timer.finished
    event_data:
      entity_id: timer.test
  action:
  - service: notify.nma
    data:
      message: "Timer stop"
```

### 타이머를 수동으로 제어

[`script`](/integrations/script/) 통합구성요소를 사용하면 타이머를 수동으로 제어 할 수 있습니다 (위의 타이머 구성 샘플 참조).

```yaml
script:
  start_timer:
    alias: Start timer
    sequence:
      - service: timer.start
        entity_id: timer.test
  pause_timer:
    alias: Pause timer
    sequence:
      - service: timer.pause
        entity_id: timer.test
  cancel_timer:
    alias: Cancel timer
    sequence:
      - service: timer.cancel
        entity_id: timer.test
  finish_timer:
    alias: Finish timer
    sequence:
      - service: timer.finish
        entity_id: timer.test
```
