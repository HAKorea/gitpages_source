---
title: "Entity 카드"
sidebar_label: Entities
description: "Entities will be the most common type of card that will also be the most familiar to people using the standard interface. It groups items together very close to how groups used to do."
---

엔티티는 표준 인터페이스를 사용하는 사람들에게 가장 친숙한 가장 일반적인 유형의 카드입니다. 그룹(group)이 사용했던 방식과 매우 유사하게 항목을 그룹화합니다. 

{% configuration %}
type:
  required: true
  description: entities
  type: string
entities:
  required: true
  description: "엔터티 ID 또는 `entity` 개체 목록은 아래를 참조"
  type: list
title:
  required: false
  description: 카드 제목.
  type: string
icon:
  required: false
  description: 제목 왼쪽에 표시되는 아이콘
  type: string
show_header_toggle:
  required: false
  description: 모든 엔티티를 켜거나 끄는 버튼.
  type: boolean
  default: true
theme:
  required: false
  description: "`themes.yaml`에서 내 테마로 설정."
  type: string
{% endconfiguration %}

## 엔티티 옵션 (Options For Entities)

엔터티를 문자열 대신 개체로 정의(엔티티 ID 앞에 `entity :`를 추가)하면 사용자 지정 및 설정을 더 추가 할 수 있습니다.

{% configuration %}
entity:
  required: true
  description: 홈어시스턴트 엔티티 ID.
  type: string
type:
  required: false
  description: "custom card 유형을 설정: `custom:my-custom-card`"
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어 씁니다.
  type: string
icon:
  required: false
  description: 아이콘 또는 엔터티 picture를 덮어 씁니다.
  type: string
image:
  required: false
  description: 엔터티  picture를 덮어 씁니다.
  type: string
secondary_info:
  required: false
  description: "추가 정보를 표시. 값 : `entity-id`, `last-changed`, `last-triggered` (자동화 및 스크립트만 적용)."
  type: string
format:
  required: false
  description: "상태의 형식을 지정하는 방법. 현재 타임 스탬프 센서에만 사용. 유효한 값 : `relative`, `total`, `date`, `time`, `datetime`."
  type: string
header:
  required: false
  description: 렌더링 할 머릿글 위젯. [header documentation](/lovelace/header-footer/) 참조.
  type: map
footer:
  required: false
  description: 렌더링 할 바닥글 위젯. [footer documentation](/lovelace/header-footer/) 참조.
  type: map
tap_action:
  required: false
  description: 탭할 시 액션
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
      description: "`action`이 `call-service` 로 정의된 경우 호출 할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
hold_action:
  required: false
  description: 길게 눌렀을 때의 액션
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
      description: "`action`이 `call-service` 로 정의된 경우 호출 할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
double_tap_action:
  required: false
  description: 더블탭을 눌렀을때의 액션
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
      description: "`action`이 `call-service` 로 정의된 경우 호출 할 서비스 (예 :`media_player.media_play_pause`"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`"
      type: string
      default: none
{% endconfiguration %}

## 특수 행 요소 (Special Row Elements)

### Call Service

{% configuration %}
type:
  required: true
  description: call-service
  type: string
name:
  required: true
  description: 메인 라벨.
  type: string
service:
  required: true
  description: "`media_player.media_play_pause`같은 서비스"
  type: string
icon:
  required: false
  description: "보여줄 아이콘 (예: `mdi:home`)"
  type: string
  default: "`mdi:remote`"
action_name:
  required: false
  description: 버튼 라벨.
  type: string
  default: "`Run`"
service_data:
  required: false
  description: 사용할 서비스 데이터.
  type: map
{% endconfiguration %}

### Cast

홈어시스턴트 캐스트를 시작하기위한 특별 행.

{% configuration %}
type:
  required: true
  description: cast
  type: string
view:
  required: true
  description: 표시해야하는 View의 경로.
  type: string
name:
  required: false
  description: 행에 표시 할 이름
  type: string
  default: Home Assistant Cast
icon:
  required: false
  description: 사용할 아이콘
  type: string
  default: "`hass:television`"
hide_if_unavailable:
  required: false
  description: 브라우저에서 전송을 사용할 수 없는 경우이 행을 숨김. 
  type: boolean
  default: false
{% endconfiguration %}

### 구분선 (Divider)

{% configuration %}
type:
  required: true
  description: divider
  type: string
style:
  required: false
  description: CSS를 사용하여 요소(elements)의 스타일을 지정.
  type: string
  default: "height: 1px, background-color: var(--secondary-text-color)"
{% endconfiguration %}

### 섹션 (Section)

{% configuration %}
type:
  required: true
  description: section
  type: string
label:
  required: false
  description: 섹션 라벨
  type: string
{% endconfiguration %}

### 웹링크 (Weblink)

{% configuration %}
type:
  required: true
  description: weblink
  type: string
url:
  required: true
  description: "웹사이트 URL (또는 내부 URL 예: `/hassio/dashboard` 혹은 `/panel_custom_name`)"
  type: string
name:
  required: false
  description: 링크 라벨
  type: string
  default: url path
icon:
  required: false
  description: "보여줄 아이콘 (예: `mdi:home`)"
  type: string
  default: "`mdi:link`"
{% endconfiguration %}

## 사례

엔티티 행 :

```yaml
type: entities
title: Entities card sample
show_header_toggle: true
header:
  image: 'https://www.home-assistant.io/images/lovelace/header-footer/balloons-header.png'
  type: picture
entities:
  - entity: alarm_control_panel.alarm
    name: Alarm Panel
  - device_tracker.demo_paulus
  - switch.decorative_lights
  - group.all_lights
  - group.all_locks
```

특별한 행 :

```yaml
type: entities
title: Entities card sample
show_header_toggle: true
entities:
  - type: call-service
    icon: mdi:power
    name: Bed light
    action_name: Toggle light
    service: light.toggle
    service_data:
      entity_id: light.bed_light
  - type: divider
  - type: weblink
    name: Home Assistant
    url: https://www.home-assistant.io/
    icon: mdi:home-assistant
```

<div class='note'>
엔티티 유형 구분선(divider) 및 웹링크(Weblink)는 아직 UI ​​편집기에서 지원되지 않으며 '예상 값 유형 ...'에 대한 경고가 표시됩니다. 경고를 무시하고 편집 내용을 저장하여 확인할 수 있습니다.
</div>
