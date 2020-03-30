---
title: "Entity Button 카드"
sidebar_label: Entity Button
description: "The Entity Button card allows you to add buttons to perform tasks"
---

Entity Button 카드를 사용하면 작업을 수행하기 위해 버튼을 추가할 수 있습니다.

<p class='img'>
<img src='/images/lovelace/lovelace_entity_button_card.png' alt='Screenshot of the entity button card'>
Entity Button 카드의 스크린 샷
</p>

```yaml
type: entity-button
entity: light.living_room
```

{% configuration %}
type:
  required: true
  description: entity-button
  type: string
entity:
  required: true
  description: Home Assistant entity ID.
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어씁니다.
  type: string
  default: 엔터티 이름
icon:
  required: false
  description: 아이콘 또는 엔터티 그림을 덮어씁니다.
  type: string
  default: 엔터티 도메인 아이콘
show_name:
  required: false
  description: 이름을 표시
  type: boolean
  default: "true"
show_icon:
  required: false
  description: 아이콘 표시.
  type: boolean
  default: "true"
icon_height:
  required: false
  description: 아이콘의 높이를 설정하십시오. UI 구성에서 처리하는 픽셀 단위입니다. (고급 사용자는 원하는 경우 다른 CSS 값을 사용할 수 있습니다)
  type: string
  default: auto
tap_action:
  required: false
  description: 탭할 때 액션
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
      description: "`action`이 `call-service`로 정의된 경우 호출할 서비스 (예: `media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래 `confirmation` 개체 참조"
      type: [boolean, map]
      default: "false"
hold_action:
  required: false
  description: 길게 누를 때 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate` 로 정의된 경우 탐색할 경로 (예: `/lovelace/0/`)"
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
      description: "`action`이 `call-service`로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래 `confirmation` 개체 참조"
      type: [boolean, map]
      default: "false"
double_tap_action:
  required: false
  description: 더블탭 할때 액션
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
      description: "`action`이 `call-service`로 정의된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래 `confirmation` 개체 참조"
      type: [boolean, map]
      default: "false"
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
{% endconfiguration %}

## Confirmation 옵션

boolean 대신 객체로 컴펌(Confirmation)을 정의하면 더 많은 사용자 정의와 설정을 추가할 수 있습니다:
{% configuration %}
text:
  required: false
  description: 컨펌 대화 상자에 표시할 텍스트.
  type: string
exemptions:
  required: false
  description: "`exemption` 객체 목록. 아래 참조"
  type: list
{% endconfiguration %}

## Exemptions 옵션

{% configuration badges %}
user:
  required: true
  description: View 탭을 볼 수 있는 사용자 ID.
  type: string
{% endconfiguration %}

## 사례 

제목과 스크립트 서비스 예:

```yaml
type: entity-button
name: Turn Off Lights
tap_action:
  action: call-service
  service: script.turn_on
  service_data:
    entity_id: script.turn_off_lights
entity: script.turn_off_lights
```

<p class='img'>
<img src='/images/lovelace/lovelace_entity_button_complex_card.png' alt='Screenshot of the entity button card'>
제목과 스크립트 서비스가 포함된 Entity Button 카드의 스크린 샷
</p>
