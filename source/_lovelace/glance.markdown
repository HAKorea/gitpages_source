---
title: "glance 카드"
sidebar_label: Glance
description: "The Glance card allows you to see a list of entities at a glance."
---

Glance 카드는 매우 컴팩트합니다. 빠르고 쉬운 개요를 위해 여러 센서를 그룹화하는데 매우 유용합니다.이를 [entity-filter](/lovelace/entity-filter/)카드와 함께 사용하여 동적 카드를 만들 수 있습니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_glance_card.png' alt='Screenshot of the glance card'>
glance 카드의 스크린 샷.
</p>

{% configuration %}
type:
  required: true
  description: glance
  type: string
entities:
  required: true
  description: "엔터티 ID 또는 `entity` 개체 목록은 아래를 참조"
  type: list
title:
  required: false
  description: 카드 제목
  type: string
show_name:
  required: false
  description: 엔터티 이름을 표시.
  type: boolean
  default: "true"
show_icon:
  required: false
  description: 엔터티 아이콘을 표시.
  type: boolean
  default: "true"
show_state:
  required: false
  description: 엔터티 상태 텍스트를 표시.
  type: boolean
  default: "true"
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
columns:
  required: false
  description: 표시할 열의 수입니다. 지정하지 않으면 번호가 자동으로 설정.
  type: integer
{% endconfiguration %}

## 엔티티 옵션

엔티티를 문자열 대신 객체로 정의하면 사용자 정의와 설정을 더 추가할 수 있습니다. :

{% configuration %}
entity:
  required: true
  description: Home Assistant 엔티티 ID.
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어씁니다.
  type: string
icon:
  required: false
  description: 아이콘을 덮어씁니다.
  type: string
image:
  required: false
  description: 엔터티 그림을 덮어씁니다.
  type: string
show_last_changed:
  required: false
  description: 마지막으로 변경된 이후의 상대 시간으로 상태 표시를 덮어씁니다.
  type: boolean
  default: false
show_state:
  required: false
  description: 엔터티 상태 텍스트를 표시
  type: boolean
  default: true
tap_action:
  required: false
  description: 탭할 시의 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의된 경우 탐색할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url`로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 호출할 서비스 (예: `media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`"
      type: string
      default: none
    confirmation:
      required: false
      description: "액션을 컨펌하는 확인 대화 상자를 표시. 아래의 `confirmation` 개체를 참조."
      type: [boolean, map]
      default: "false"
hold_action:
  required: false
  description: 길게 눌렀을 때 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의된 경우 탐색할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url`로 정의된 경우 (예: `https://www.home-assistant.io`"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 호출할 서비스 (예: `media_player.media_play_pause`"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`"
      type: string
      default: none
    confirmation:
      required: false
      description: "액션을 컨펌하는 확인 대화 상자를 표시. 아래의 `confirmation` 개체를 참조."
      type: [boolean, map]
      default: "false"
double_tap_action:
  required: false
  description: 더블탭을 눌렀을 때의 실행
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url`로 정의된 경우 (예: `https://www.home-assistant.io`"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 호출할 서비스 (예: `media_player.media_play_pause`"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`"
      type: string
      default: none
    confirmation:
      required: false
      description: "액션을 컨펌하는 확인 대화 상자를 표시. 아래의 `confirmation` 개체를 참조."
      type: [boolean, map]
      default: "false"
{% endconfiguration %}

## Confirmation 옵션 

boolean 대신 객체로 confirmation을 정의하면 더 많은 사용자 정의와 설정을 추가할 수 있습니다.

{% configuration %}
text:
  required: false
  description: confirmation 대화 상자에 표시할 텍스트.
  type: string
exemptions:
  required: false
  description: "`exemption` 목록 객체. 아래 참조"
  type: list
{% endconfiguration %}

## 면제 옵션 (Options For Exemptions)

{% configuration badges %}
user:
  required: true
  description: 보기 탭을 볼 수 있는 사용자 ID.
  type: string
{% endconfiguration %}

## Examples

기본 예시 :

```yaml
type: glance
title: Glance card sample
entities:
  - binary_sensor.movement_backyard
  - light.bed_light
  - binary_sensor.basement_floor_wet
  - sensor.outside_temperature
  - light.ceiling_lights
  - switch.ac
  - lock.kitchen_door
```

<p class='img'>
<img src='/images/lovelace/lovelace_glance_card.png' alt='Screenshot of the glance card with custom title'>
custom 제목이 있는 Glance 카드의 스크린 샷.
</p>

엔티티를 오브젝트로 정의하고 사용자 정의 이름을 적용하십시오. :

```yaml
type: glance
title: Better names
entities:
  - entity: binary_sensor.movement_backyard
    name: Movement?
  - light.bed_light
  - binary_sensor.basement_floor_wet
  - sensor.outside_temperature
  - light.ceiling_lights
  - switch.ac
  - lock.kitchen_door
  - entity: switch.wall_plug_switch
    tap_action:
      action: toggle
```
