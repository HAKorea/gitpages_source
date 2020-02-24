---
title: "Picture Glance Card"
sidebar_label: Picture Glance
description: "Show an image card and corresponding entity states as icon"
---

이미지 카드 및 해당 엔티티 상태를 아이콘으로 표시하십시오. 오른쪽의 엔티티는 Toggle 액션을 허용하고 다른 엔티티는 more-info-dialog를 표시합니다. 결국 그림안에 액션 및 상태를 표시할 수 있는 카드를 제작할 수 있습니다. 

<p class='img'>
  <img src='/images/lovelace/lovelace_picture_glance.gif' alt='Picture glance card for a living room'>
  거실용 Picture glance card.
</p>

{% configuration %}
type:
  required: true
  description: picture-glance
  type: string
entities:
  required: true
  description: 엔터티 또는 엔터티 개체 목록.
  type: list
title:
  required: false
  description: 카드 제목.
  type: string
image:
  required: false
  description: 배경 이미지 URL.
  type: string
camera_image:
  required: false
  description: 배경 이미지로서의 카메라 엔티티.
  type: string
camera_view:
  required: false
  description: '만일 `stream`이 활성화되면 "live"가 표시됩니다. '
  default: auto
  type: string
state_image:
  required: false
  description: 엔터티 상태를 기반으로 한 배경 이미지.
  type: map
  keys:
    state:
      type: string
      required: false
      description: "`state: image-url`, 아래 예를 참조."
state_filter:
  required: false
  description: '[State-based CSS filters](#how-to-use-state_filter)'
  type: map
aspect_ratio:
  required: false
  description: "이미지의 높이를 너비의 비율로 만듭니다. 다음과 같은 값 입력 가능: `16x9`, `16:9`, `1.78`."
  type: string
entity:
  required: false
  description: "`state_image` 과 `state_filter`에 사용할 엔티티."
  type: string
show_state:
  required: false
  description: 엔터티 상태 텍스트를 표시.
  type: boolean
  default: true
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
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
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
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
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
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
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래 `confirmation` 개체 참조"
      type: [boolean, map]
      default: "false"
{% endconfiguration %}

## 엔티티 옵션

엔티티를 문자열 대신 객체로 정의하면 사용자 정의 및 설정을 더 추가 할 수 있습니다. :

{% configuration %}
entity:
  required: true
  description: Home Assistant 엔티티 ID.
  type: string
icon:
  required: false
  description: 기본 아이콘을 덮어 씁니다..
  type: string
show_state:
  required: false
  description: 엔터티 상태 텍스트를 표시.
  type: boolean
  default: true
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
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
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
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
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
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래 `confirmation` 개체 참조"
      type: [boolean, map]
      default: "false"
{% endconfiguration %}

## Confirmation 옵션

boolean 대신 객체로 컨펌(Confirmation)을 정의하면 더 많은 사용자 정의 및 구성을 추가 할 수 있습니다:
{% configuration %}
text:
  required: false
  description: 컨펌 대화 상자에 표시 할 텍스트.
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

## state_filter 사용법

다른 [CSS filters](https://developer.mozilla.org/en-US/docs/Web/CSS/filter) 지정

```yaml
state_filter:
  "on": brightness(110%) saturate(1.2)
  "off": brightness(50%) hue-rotate(45deg)
entity: switch.decorative_lights
```

## 예시

```yaml
type: picture-glance
title: Living room
entities:
  - switch.decorative_lights
  - light.ceiling_lights
  - lock.front_door
  - binary_sensor.movement_backyard
  - binary_sensor.basement_floor_wet
image: /local/living_room.png
```

카메라 이미지를 배경으로 표시 :

```yaml
type: picture-glance
title: Living room
entities:
  - switch.decorative_lights
  - light.ceiling_lights
camera_image: camera.demo_camera
```

추가 엔티티없이 카메라 이미지를 표시 :

```yaml
type: picture-glance
title: Front garden
entities: []
camera_image: camera.front_garden_camera
```

엔티티 상태에 따라 다른 이미지를 사용 :

```yaml
type: picture-glance
title: Living room
entities:
  - switch.decorative_lights
  - light.ceiling_lights
state_image:
  "on": /local/living_room_on.png
  "off": /local/living_room_off.png
entity: group.living.room
```
