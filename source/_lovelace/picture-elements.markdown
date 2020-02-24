---
title: "Picture Elements Card"
sidebar_label: Picture Elements
description: "Picture elements card is one of the most versatile types of cards"
---

그림 요소 카드(Picture elements card)는 가장 다양한 유형의 카드 중 하나입니다.

카드를 사용하면 아이콘이나 텍스트, 심지어 서비스를 배치 할 수 있습니다! 좌표를 기준으로 한 이미지 평면도를 상상 하고 제한없이 [picture-glance](/lovelace/picture-glance/)를 활용하는 것을 상상해보십시오 !

<p class='img'>
  <img src='/images/lovelace/lovelace_picture_elements.gif' alt='A functional floorplan powered by picture elements'>
  그림 요소로 구동되는 기능적인 평면도(floorplan)
</p>

{% configuration %}
type:
  required: true
  description: picture-elements
  type: string
image:
  required: true
  description: 이미지의 URL.
  type: string
elements:
  required: true
  description: 요소 목록
  type: list
title:
  required: false
  description: 카드 제목
  type: string
state_filter:
  required: false
  description: '[상태기반 CSS filters](#how-to-use-state_filter)'
  type: map
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
{% endconfiguration %}

## 요소들 (Elements)

### 상태 뱃지 (State Badge)

{% configuration %}
type:
  required: true
  description: state-badge
  type: string
entity:
  required: true
  description: 엔터티 ID
  type: string
style:
  required: true
  description: CSS를 사용하여 요소를 배치하고 스타일을 지정.
  type: map
  default: "position: absolute, transform: translate(-50%, -50%)"
title:
  required: false
  description: 상태 뱃지 툴팁(tooltip). 숨기려면 null로 설정
  type: string
tap_action:
  required: false
  description: 탭할시 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`toggle`"
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
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래`confirmation` 개체 참조"
      type: [boolean, map]
      default: "false"
hold_action:
  required: false
  description: 길게 누를때 액션
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
  description: 터블탭 누를때 액션
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

### 엔티티 상태를 나타내는 아이콘

{% configuration %}
type:
  required: true
  description: state-icon
  type: string
entity:
  required: true
  description: 사용할 엔티티 ID.
  type: string
icon:
  required: false
  description: 아이콘을 덮어 씁니다.
  type: string
title:
  required: false
  description: 아이콘 툴팁(tooltip). 숨기려면 null로 설정.
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
style:
  required: true
  description: CSS를 사용하여 요소를 배치하고 스타일을 지정
  type: string
  default: "position: absolute, transform: translate(-50%, -50%)"
{% endconfiguration %}

### 상태 텍스트가 있는 라벨 (Label with state text)

{% configuration %}
type:
  required: true
  description: state-label
  type: string
entity:
  required: true
  description: 엔터티 ID
  type: string
prefix:
  required: false
  description: 엔터티 상태 이전의 텍스트.
  type: string
suffix:
  required: false
  description: 엔터티 상태 이후의 텍스트.
  type: string
title:
  required: false
  description: 라벨 tooltip. 숨기려면 null로 설정.
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
style:
  required: true
  description: CSS를 사용하여 요소를 배치하고 스타일을 지정
  type: string
  default: "position: absolute, transform: translate(-50%, -50%)"
{% endconfiguration %}

### 서비스 콜 버튼 (Service Call Button)

{% configuration %}
type:
  required: true
  description: service-button
  type: string
title:
  required: true
  description: 버튼 라벨
  type: string
service:
  required: true
  description: light.turn_on
  type: string
service_data:
  required: false
  description: 사용할 서비스 데이터.
  type: map
style:
  required: true
  description: CSS를 사용하여 요소를 배치하고 스타일을 지정.
  type: string
  default: "position: absolute, transform: translate(-50%, -50%)"
{% endconfiguration %}

### 아이콘 요소

{% configuration %}
type:
  required: true
  description: icon
  type: string
icon:
  required: true
  description: "보여줄 아이콘 (예: `mdi:home`)"
  type: string
title:
  required: false
  description: 아이콘 툴팁(tooltip). 숨기려면 null로 설정.
  type: string
entity:
  required: false
  description: 추가 정보/토글에 사용할 엔티티
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
style:
  required: true
  description: CSS를 사용하여 요소를 배치하고 스타일을 지정
  type: string
  default: "position: absolute, transform: translate(-50%, -50%)"
{% endconfiguration %}

### 이미지 요소

{% configuration %}
type:
  required: true
  description: image
  type: string
entity:
  required: false
  description: state_image 및 state_filter에 사용할 엔티티이며 액션의 대상이기도 함
  type: string
title:
  required: false
  description: 이미지 tooltip. 숨기려면 null로 설정.
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
image:
  required: false
  description: 표시할 이미지.
  type: string
camera_image:
  required: false
  description: 카메라 엔티티.
  type: string
camera_view:
  required: false
  description: '`stream`이 활성화 된 경우 "live"는 라이브 뷰를 표시합니다.'
  default: auto
  type: string
state_image:
  required: false
  description: '[State-based images](#how-to-use-state_image)'
  type: map
filter:
  required: false
  description: Default CSS filter
  type: string
state_filter:
  required: false
  description: '[State-based CSS filters](#how-to-use-state_filter)'
  type: map
aspect_ratio:
  required: false
  description: 높이 너비 비율..
  type: string
  default: "50%"
style:
  required: true
  description: CSS를 사용하여 요소를 배치하고 스타일을 지정.
  type: string
  default: "position: absolute, transform: translate(-50%, -50%)"
{% endconfiguration %}

### 조건부 요소 (Conditional Element)

조건부(conditional) 카드와 마찬가지로 이 요소를 사용하면 엔터티 상태를 기반으로 하위 요소를 표시 할 수 있습니다.

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
      description: HA entity ID.
      type: string
    state:
      required: false
      description: 엔티티 상태는 이 값과 같습니다.*
      type: string
    state_not:
      required: false
      description: 엔티티 상태는 이 값과 다릅니다.*
      type: string
elements:
  required: true
  description: 조건이 충족 될 때 표시할 모든 유형의 하나 이상의 요소입니다. 예는 아래를 참조하십시오.
  type: list
{% endconfiguration %}

## 확인 옵션 (Options For Confirmation)

boolean 대신 객체로 확인을 정의하면 더 많은 사용자 정의 및 설정을 추가 할 수 있습니다.:
{% configuration %}
text:
  required: false
  description: 확인 대화 상자에 표시 할 텍스트.
  type: string
exemptions:
  required: false
  description: "`exemption` 리스트 개체. 아래 참조"
  type: list
{% endconfiguration %}

## 면제 옵션 (Options For Exemptions)

{% configuration badges %}
user:
  required: true
  description: 보기 탭을 볼 수있는 사용자 ID.
  type: string
{% endconfiguration %}

### 커스텀 요소 (Custom Elements)

{% configuration %}
type:
  required: true
  description: '카드 이름 `custom:` 접두어 (예: `custom:my-custom-card`)'
  type: string
style:
  required: true
  description: CSS를 사용하여 요소를 배치하고 스타일을 지정.
  type: string
  default: "position: absolute, transform: translate(-50%, -50%)"
{% endconfiguration %}

사용자 정의 요소를 만들고 참조하는 프로세스는 사용자 정의 카드와 동일합니다. 보다 자세한 정보를 위해 [developer docs on creating custom cards](https://developers.home-assistant.io/docs/en/lovelace_custom_card.html)를 참조하십시오. 

## 스타일 객체 사용법

[CSS](https://en.wikipedia.org/wiki/Cascading_Style_Sheets)를 사용하여 요소 배치 및 스타일 지정. 더 많은/다른 키도 가능합니다. 

```yaml
style:
  # Positioning of the element
  left: 50%
  top: 50%
  # Overwrite color for icons
  "--paper-item-icon-color": pink
```

## state_image 사용법

엔티티의 상태에 따라 표시할 다른 이미지를 지정.

```yaml
state_image:
  "on": /local/living_room_on.jpg
  "off": /local/living_room_off.jpg
```

## state_filter 사용법

다른 [CSS 필터](https://developer.mozilla.org/en-US/docs/Web/CSS/filter) 지정 


```yaml
state_filter:
  "on": brightness(110%) saturate(1.2)
  "off": brightness(50%) hue-rotate(45deg)
```

## 클릭 앤 홀드를 사용하는 방법 (How to use click-and-hold)

`hold_action` 옵션이 지정되면, 엔티티를 클릭하여 0.5 초 이상 유지하면 해당 액션이 수행됩니다.

```yaml
tap_action:
  action: toggle
hold_action:
  action: call-service
  service: light.turn_on
  service_data:
    entity_id: light.bed_light
    brightness_pct: 100
```

## 예시

```yaml
type: picture-elements
image: /local/floorplan.png
elements:
  - type: state-icon
    tap_action:
      action: toggle
    entity: light.ceiling_lights
    style:
      top: 47%
      left: 42%
  - type: state-icon
    tap_action:
      action: toggle
    entity: light.kitchen_lights
    style:
      top: 30%
      left: 15%
  - type: state-label
    entity: sensor.outside_temperature
    style:
      top: 82%
      left: 79%
  - type: service-button
    title: Turn lights off
    style:
      top: 95%
      left: 60%
    service: homeassistant.turn_off
    service_data:
      entity_id: group.all_lights
  - type: icon
    icon: mdi:home
    tap_action:
      action: navigate
      navigation_path: /lovelace/0
    style:
      top: 10%
      left: 10%
```

## 이미지 예시 

```yaml
type: picture-elements
image: /local/floorplan.png
elements:
  # state_image & state_filter - toggle on click
  - type: image
    entity: light.living_room
    tap_action:
      action: toggle
    image: /local/living_room.png
    state_image:
      "off": /local/living_room_off.png
    filter: saturate(.8)
    state_filter:
      "on": brightness(120%) saturate(1.2)
      style:
        top: 25%
        left: 75%
        width: 15%
  # Camera, red border, rounded-rectangle - show more-info on click
  - type: image
    entity: camera.driveway_camera
    camera_image: camera.driveway_camera
    style:
      top: 5%
      left: 10%
      width: 10%
      border: 2px solid red
      border-radius: 10%
  # Single image, state_filter - call-service on click
  - type: image
    entity: media_player.living_room
    tap_action:
      action: call-service
      service: media_player.media_play_pause
      service_data:
        entity_id: media_player.living_room
    image: /local/television.jpg
    filter: brightness(5%)
    state_filter:
      playing: brightness(100%)
    style:
      top: 40%
      left: 75%
      width: 5%
```

## 조건부 예시

```yaml
type: picture-elements
image: /local/House.png
elements:
  # conditionally show TV off button shortcut when dad's away and daughter is home
  - type: conditional
    conditions:
      - entity: sensor.presence_daughter
        state: 'home'
      - entity: sensor.presence_dad
        state: 'not_home'
    elements:
      - type: state-icon
        entity: switch.tv
        tap_action:
          action: toggle
        style:
          top: 47%
          left: 42%
```
