---
title: "조건부 카드 (Conditional Card)"
sidebar_label: Conditional
description: Displays another card based on entity states.
---

엔티티 상태에 따라 다른 카드를 표시합니다.

{% configuration %}
type:
  required: true
  description: conditional
  type: string
conditions:
  required: true
  description: 엔터티 ID 및 일치하는 상태 목록.
  type: list
  keys:
    entity:
      required: true
      description: 홈어시스턴트 엔티티 ID.
      type: string
    state:
      required: false
      description: 엔티티 상태는 이 값과 같습니다. *
      type: string
    state_not:
      required: false
      description: 엔티티 상태가 이 값과 다릅니다. *
      type: string
card:
  required: true
  description: 모든 조건이 일치하면 표시할 카드.
  type: map
{% endconfiguration %}

*하나는 필요합니다. (`state` 혹은 `state_not`)

참고 : 엔티티가 둘 이상인 조건은 'and' 조건으로 취급합니다. 즉, 카드가 표시 되려면 *모든* 엔티티가 설정된 주요 요구사항을 모두 충족해야합니다.

### 사례

```yaml
type: conditional
conditions:
  - entity: light.bed_light
    state: "on"
  - entity: switch.decorative_lights
    state_not: "off"
card:
  type: entities
  entities:
    - device_tracker.demo_paulus
    - cover.kitchen_window
    - group.kitchen
    - lock.kitchen_door
    - light.bed_light
```
