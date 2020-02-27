---
title: "Entity Filter 카드"
sidebar_label: Entity Filter
description: "This card allows you to define a list of entities that you want to track only when in a certain state. Very useful for showing lights that you forgot to turn off or show a list of people only when they're at home. "
---

이 카드를 사용하면 특정 상태에 있을 때만 추적하려는 엔티티 목록을 정의할 수 있습니다. 깜빡 잊고 전등을 끄지 않은 상태를 보여주거나, 집안에 있는 사람만 리스트에 나타나게 하고 싶을 때 매우 유용합니다. 

이 유형의 카드는 여러 엔티티를 허용하는 나머지 카드와 함께 사용하는 방법으로 [glance](/lovelace/glance/) 혹은 [picture-glance](/lovelace/picture-glance/)를 사용할 수 있습니다. 기본적으로 [entities](/lovelace/entities/) 카드 모델을 사용합니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_entity_filter.png' alt='Screenshot of the entity filter card'>
엔터티 필터 카드의 스크린 샷.
</p>

{% configuration %}
type:
  required: true
  description: entity-filter
  type: string
entities:
  required: true
  description: 엔터티 ID 또는 `entity` 개체 목록 은 아래를 참조
  type: list
state_filter:
  required: true
  description: 상태 또는 `filter` 객체를 나타내는 문자열 목록은 아래를 참조 
  type: list
card:
  required: false
  description: 결과를 렌더링하는 카드로 전달하는 추가 옵션.
  type: map
  default: entities card
show_empty:
  required: false
  description: 필터에 의해 반환된 엔티티가 없을 때 카드를 숨길 수 있습니다.
  type: boolean
  default: true
{% endconfiguration %}

## 엔티티 옵션 (Options For Entities)

엔티티를 문자열 대신 객체로 정의하는 경우 (엔티티 ID 앞에 `entity :`를 추가하여), 더 많은 사용자 정의 및 설정을 추가할 수 있습니다.

{% configuration %}
entity:
  required: true
  description: Home Assistant entity ID.
  type: string
type:
  required: false
  description: "custom card 유형을 설정 : `custom:my-custom-card`"
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어 씁니다.
  type: string
icon:
  required: false
  description: 아이콘 또는 엔터티 그림을 덮어 씁니다.
  type: string
secondary_info:
  required: false
  description: "추가 정보를 표시. 값: `entity-id`, `last-changed`."
  type: string
format:
  required: false
  description: "상태의 형식을 지정하는 방법. 현재 타임 스탬프 센서에만 사용. 유효한 값 : `relative`, `total`, `date`, `time`, `datetime`."
  type: string
state_filter:
  required: false
  description: 상태 또는 `filter` 객체를 나타내는 문자열 목록은 아래를 참조.
  type: list
{% endconfiguration %}

## state_filter 옵션 

state_filter를 문자열 대신 객체로 정의(상태 값 앞에 `value :`를 추가하여)하면 필터에 더 많은 사용자 정의를 추가 할 수 있습니다

{% configuration %}
value:
  required: true
  description: 상태를 나타내는 문자열.
  type: string
operator:
  required: false
  description: 비교에 사용할 연산자. `==`, `<=`, `<`, `>=`, `>`, `!=` 혹은 `regex` 사용 가능.
  type: string
attribute:
  required: false
  description: 상태 대신 사용할 엔티티의 속성.
  type: string
{% endconfiguration %}

### 사례

집에 활성화된 스위치 또는 전등 만 표시 :

```yaml
type: entity-filter
entities:
  - entity: light.bed_light
    name: Bed
  - light.kitchen_lights
  - light.ceiling_lights
state_filter:
  - "on"
```

[glance](/lovelace/glance/)로 집에있는 사람만 표시 :

```yaml
type: entity-filter
entities:
  - device_tracker.demo_paulus
  - device_tracker.demo_anne_therese
  - device_tracker.demo_home_boy
state_filter:
  - home
card:
  type: glance
  title: People at home
```

단일 엔터티에 대한 필터 지정

```yaml
type: entity-filter
state_filter:
  - "on"
  - operator: ">"
    value: 90
entities:
  - sensor.water_leak
  - sensor.outside_temp
  - entity: sensor.humidity_and_temp
    state_filter:
      - operator: ">"
        value: 50
        attribute: humidity
```

<p class='img'>
  <img src='/images/lovelace/lovelace_entity_filter_glance.png' alt='Entity filter combined with glance card'>
  Glance 카드와 결합된 Entity Filter.
</p>
