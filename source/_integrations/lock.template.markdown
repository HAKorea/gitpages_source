---
title: 템플릿 락(Template Lock)
description: "Instructions on how to integrate Template Locks into Home Assistant."
ha_category:
  - Lock
ha_release: 0.81
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`template` 플랫폼은 구성 요소를 결합하는 lock을 만듭니다.

예를 들어, 모터를 작동하는 토글 스위치가 있는 차고 도어와 도어의 개폐 여부를 알려주는 센서가 있는 경우 차고 도어가 열려 있는지 또는 닫혀 있는지를 알 수 있는 lock 장치로 결합할 수 있습니다.

이를 통해 GUI를 단순화하고 자동화를 보다 쉽게 ​​작성할 수 있습니다. 결합한 연동장치를 `hidden` 으로 표시하여 자체적으로 나타나지 않도록 할 수 있습니다.

optimistic mode에서 lock은 모든 명령 후에 즉시 상태를 변경합니다. 그렇지 않으면 lock은 템플릿에서 상태 확인을 기다립니다. 올바르지 않은 lock 조작이 발생하면 이를 사용 가능하게 하십시오.

## 설정

설치에서 Template Lock 을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

{% raw %}

```yaml
# Example configuration.yaml entry
lock:
  - platform: template
    name: Garage door
    value_template: "{{ is_state('sensor.door', 'on') }}"
    lock:
      service: switch.turn_on
      data:
        entity_id: switch.door
    unlock:
      service: switch.turn_off
      data:
        entity_id: switch.door
```

{% endraw %}

{% configuration %}
  name:
    description: 프론트 엔드에서 사용할 이름.
    required: false
    type: string
    default: Template Lock
  value_template:
    description: Lock 상태를 설정하기위한 템플릿을 정의.
    required: true
    type: template
  availability_template:
    description: 구성 요소의 `available` 상태를 가져 오도록 템플리트를 정의합니다. 템플릿이 `true`를 반환하면 장치는 `available`입니다. 템플릿이 다른 값을 반환하면 장치를 사용할 수 없게됩니다. `availability_template`이 설정되어 있지 않으면 구성 요소는 항상 `available`입니다.
    required: false
    type: template
    default: true
 lock:
    description: Defines an action to run when the lock is locked.
    required: true
    type: action
  unlock:
    description: Defines an action to run when the lock is unlocked. 
    required: true
    type: action
  optimistic:
    description: Flag that defines if lock works in optimistic mode.
    required: false
    type: boolean
    default: false
{% endconfiguration %}

## 고려 사항

로드하는데 추가 시간이 걸리는 플랫폼 상태를 사용하는 경우 시작하는 동안 템플릿 잠금이 `unknown` 상태가 될 수 있습니다. 그러면 해당 플랫폼이 로드를 완료할 때까지 로그 파일에 오류 메시지가 나타납니다. 템플릿에서 `is_state ()` 함수를 사용하면 이런 상황을 피할 수 있습니다. 예를 들어 {% raw %}`{{ is_state('switch.source', 'on') }}`{% endraw %} 대신 `true`/`false`를 반환하고 절대로 알 수 없는 결과를 내지 않는 이에 상응하는 {% raw %}`{{ is_state('switch.source', 'on') }}`{% endraw %}를 쓰면 됩니다. 

## 사례 

이 섹션에서는이 lock을 사용하는 방법에 대한 실제 예를 제공합니다.

### Lock from Switch

이 예는 스위치에서 데이터를 복사하는 lock을 보여줍니다.

{% raw %}

```yaml
lock:
  - platform: template
    name: Garage Door
    value_template: "{{ is_state('switch.source', 'on') }}"
    lock:
      service: switch.turn_on
      data:
        entity_id: switch.source
    unlock:
      service: switch.turn_off
      data:
        entity_id: switch.source
```

{% endraw %}

### Optimistic Mode

이 예는 Optimistic Mode에서의 lock을 보여줍니다. 이 lock은 명령 후 즉시 상태를 변경하며 센서의 상태 업데이트를 기다리지 않습니다.

{% raw %}

```yaml
lock:
  - platform: template
    name: Garage Door
    value_template: "{{ is_state('sensor.skylight.state', 'on') }}"
    optimistic: true
    lock:
      service: switch.turn_on
      data:
        entity_id: switch.source
    unlock:
      service: switch.turn_off
      data:
        entity_id: switch.source
```

{% endraw %}

### 센서 1개 스위치 2개

이 예는 센서에서 상태를 가져오고 두 개의 순간 스위치를 사용하여 장치를 제어하는 ​​잠금을 보여줍니다.

{% raw %}

```yaml
lock:
  - platform: template
    name: Garage Door
    value_template: "{{ is_state('sensor.skylight.state', 'on') }}"
    lock:
      service: switch.turn_on
      data:
        entity_id: switch.skylight_open
    unlock:
      service: switch.turn_on
      data:
        entity_id: switch.skylight_close
```

{% endraw %}
