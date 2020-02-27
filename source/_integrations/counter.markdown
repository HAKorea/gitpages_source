---
title: 카운터(Counter)
description: Instructions on how to integrate counters into Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.53
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`counter`는 자동화에 의해 실행된 상황의 횟수를 계산할 수 있도록 해주는 통합구성요소입니다.

## 설정

카운터를 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오. :

```yaml
# Example configuration.yaml entry
counter:
  my_custom_counter:
    initial: 30
    step: 1
```

{% configuration %}
"[alias]":
  description: 카운터의 별칭. 여러 항목이 허용됩니다. `alias` 실제 값은 사용자가 대체할 수 있습니다.
  required: true
  type: map
  keys:
    name:
      description: 카운터의 친숙한 이름.
      required: false
      type: string
    initial:
      description: 홈 어시스턴트가 시작되거나 카운터가 재설정 될 때 초기 값입니다.
      required: false
      type: integer
      default: 0
    restore:
      description: 홈 어시스턴트가 시작될 때 마지막으로 알려진 값을 복원하십시오.
      required: false
      type: boolean
      default: true
    step:
      description: 카운터의 증가분 / 단계 값.
      required: false
      type: integer
      default: 1
    minimum:
      description: 카운터가 가질 최소값
      required: false
      type: integer
    maximum:
      description: 카운터가 가질 최대값
      required: false
      type: integer
    icon:
      description: 카운터에 표시 할 아이콘입니다.
      required: false
      type: icon
{% endconfiguration %}

[materialdesignicons.com](https://materialdesignicons.com/) 에서 입력에 사용할 아이콘을 선택 하고 이름 앞에 접두사 `mdi:`를 붙입니다  예로서 `mdi:car`, `mdi:ambulance` 혹은 `mdi:motorbike`.

### 복원 상태

이 통합구성요소는 엔티티가 기본값 `restore` 기본값인 `true` 설정했는지에 따라 Home Assistant 중지 이전의 상태를 자동으로 복원합니다.  설정이 기능을 사용하지 않으려면 `restore` 를 `false`로 변경합니다.

만일 `restore` 가 `false`로 설정되고 , `initial` 값이 이전 상태가 발견 될 때 혹은 카운터가 리셋되었을때 사용되게 되어 있습니다.

## 서비스

제공 서비스 : `increment`, `decrement`, `reset` and `configure`.

#### Service `counter.increment`

단계에 대해 1 또는 제공된 값으로 카운터를 증가시킵니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 동작할 entitiy의 이름입니다. 예) `counter.my_custom_counter`. |

#### Service `counter.decrement`

단계에 대해 1 또는 주어진 값으로 카운터를 감소시킵니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 동작할 entitiy의 이름입니다. 예) `counter.my_custom_counter`. |

#### Service `counter.reset`

이 서비스를 통해 카운터는 초기값으로 재설정됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 동작할 entitiy의 이름입니다. 예) `counter.my_custom_counter`. |

#### Service `counter.configure`

이 서비스를 사용하면 실행 중에 카운터의 속성을 변경할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 동작할 entitiy의 이름입니다. 예) `counter.my_custom_counter`. |
| `minimum`              |     yes  | 최소값으로 새 값을 설정하십시오. 값이 없을시 최소를 비활성화합니다. |
| `maximum`              |     yes  | 최대 값을 새로 설정하십시오. 값이 없을시 최소를 비활성화합니다. |
| `step`                 |     yes  | 단계의 새 값을 설정하십시오. |
| `initial`              |     yes  | 초기 값으로 새 값을 설정하십시오. |
| `value`                |     yes  | 카운터 상태를 주어진 값으로 설정하십시오. |



### Use the service

**Developer Tools**에서 **Services** 탭을 선택하십시오. **Domains** 목록에서 **counter**를 선택하고, **Service**를 선택한 뒤, enter 아래 샘플과 같은 **Service Data** 필드로 들어간 뒤, **CALL SERVICE**를 누르세요.

```json
{
  "entity_id": "counter.my_custom_counter"
}
```

## 예시

### 홈 어시스턴트 오류 계산

카운터를 사용하여 Home Assistant에서 잡은 오류를 계산하려면, `fire_event: true`를 `configuration.yaml`에 다음과 같이 추가하세요 :

```yaml
# Example configuration.yaml entry
system_log:
  fire_event: true
```

### 오류 계산 - 설정 예시
```yaml
# Example configuration.yaml entry
automation:
- id: 'errorcounterautomation'
  alias: Error Counting Automation
  trigger:
    platform: event
    event_type: system_log_event
    event_data:
      level: ERROR
  action:
    service: counter.increment
    entity_id: counter.error_counter
    
counter:
  error_counter:
    name: Errors
    icon: mdi:alert  
```
