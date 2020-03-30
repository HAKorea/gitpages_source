---
title: Picture Entity 카드
sidebar_label: Picture Entity
description: Displays the entity in form of an image. Instead of images from URL it can also show the picture of `camera` entities.
---

이미지 형태로 엔티티를 표시합니다. URL의 이미지 대신 `camera` 엔티티 그림을 표시할 수도 있습니다 .

<p class='img'>
  <img src='/images/lovelace/lovelace_picture_entity.gif' alt='Picture entity card'>
  엔터티 상태에 따라 배경이 변경됩니다.
</p>

{% configuration %}
type:
  required: true
  description: picture-entity
  type: string
entity:
  required: true
  description: "`entity_id`는 그림으로 사용됨."
  type: string
camera_image:
  required: false
  description: "사용할 카메라 `entity_id` (만일 이미 `entity`가 카메라 엔티티일 경우 필요 없음)."
  type: string
camera_view:
  required: false
  description: "만일 `stream`이 활성화된 경우 live는 라이브 뷰를 표시합니다."
  default: auto
  type: string
image:
  required: false
  description: 이미지의 URL.
  type: string
state_image:
  required: false
  description: "엔티티 상태를 이미지에 매핑 (`state: image URL`, 아래 예제 참조)."
  type: map
state_filter:
  required: false
  description: '[State-based CSS filters](#how-to-use-state_filter)'
  type: map
aspect_ratio:
  required: false
  description: "이미지의 높이를 너비의 비율로 만듭니다. 다음과 같은 값을 입력할 수 있습니다: `16x9`, `16:9`, `1.78`."
  type: string
name:
  required: false
  description: 엔터티 이름을 덮어씁니다.
  type: string
show_name:
  required: false
  description: 바닥글에 이름을 표시.
  type: boolean
  default: true
show_state:
  required: false
  description: 바닥글에 상태를 표시.
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
      description: "`action`이 `navigate`로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
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
{% endconfiguration %}

## Confirmation 옵션

boolean 대신 객체로 확인을 정의하면 더 많은 사용자 정의와 설정을 추가할 수 있습니다. : 
{% configuration %}
text:
  required: false
  description: 확인 대화 상자에 표시할 텍스트.
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

다른 [CSS filters](https://developer.mozilla.org/en-US/docs/Web/CSS/filter) 지정. 

```yaml
state_filter:
  "on": brightness(110%) saturate(1.2)
  "off": brightness(50%) hue-rotate(45deg)
```

## 사례

기본 사례 :

```yaml
type: picture-entity
entity: light.bed_light
image: /local/bed_light.png
```

각 상태에 따른 다른 이미지 사례 :

```yaml
type: picture-entity
entity: light.bed_light
state_image:
  "on": /local/bed_light_on.png
  "off": /local/bed_light_off.png
```

FFMPEG 카메라에 실시간 피드 표시 :

{% raw %}
```yaml
type: picture-entity
entity: camera.backdoor
camera_view: live
tap_action:
  action: call-service
  service: camera.snapshot
  service_data:
    entity_id: camera.backdoor
    filename: '/shared/backdoor-{{ now().strftime("%Y-%m-%d-%H%M%S") }}.jpg'
```
{% endraw %}

파일 이름은 시스템의 Home Assistant에서 쓸 수 있는 경로여야합니다. `whitelist_external_dirs` ([documentation](/docs/configuration/basic/))를 설정할 필요가 있을 수 있습니다. 
