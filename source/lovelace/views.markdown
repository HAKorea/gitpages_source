---
title: "Views"
description: "The Lovelace UI is a powerful and configurable interface for Home Assistant."
---

UI에 카드를 표시하려면 View에서 카드를 정의해야합니다. View는 `card size` 를 기준으로 열의 카드를 정렬합니다. 일부 카드를 그룹화하려면 `stack` 카드를 사용해야합니다.

<p class="img">
  <img src="/images/lovelace/lovelace_views.png" alt="Views toolbar">
  제목과 아이콘을 사용하여 View의 내용을 나타냅니다.
</p>

{% configuration views %}
views:
  required: true
  description: view 설정 목록.
  type: list
  keys:
    title:
      required: true
      description: 제목 또는 이름.
      type: string
    badges:
      required: false
      description: badge로 표시할 엔티티 ID 또는 `badge` 개체 목록.
      type: list
    cards:
      required: false
      description: View에 표시할 카드.
      type: list
    path:
      required: false
      description: 경로는 URL로 사용되며, 자세한 내용은 아래를 참조.
      type: string
      default: view index
    icon:
      required: false
      description: Material Design Icons의 아이콘 이름.
      type: string
    panel:
      required: false
      description: 패널모드의 View로 렌더링. 아래 추가 정보 참조
      type: boolean
      default: false
    background:
      required: false
      description: CSS를 사용하여 배경 스타일 지정. 아래 추가 정보 참조.
      type: string
    theme:
      required: false
      description: view와 cards에 테마적용. 아래 추가 정보 참조.
      type: string
    visible:
      required: false
      description: "모든 사용자 또는 `visible` 개별 개체 목록에서 View탭을 숨기거나 표시합니다." 
      type: [boolean, list]
      default: true
{% endconfiguration %}

## Visible의 옵션

view 탭을 표시하기위한 조건을 지정하기 위해 부울(boolean) 대신 객체로 `visible`을 정의하는 경우 :

{% configuration badges %}
user:
  required: true
  description: view 탭을 볼 수 있는 사용자 ID (사용자 설정 페이지에있는 고유한 16 진수 값).
  type: string
{% endconfiguration %}

#### 사례 

View config:

```yaml
- title: Living room
  badges:
    - device_tracker.demo_paulus
    - entity: light.ceiling_lights
      name: Ceiling Lights
      icon: mdi:bulb
    - entity: switch.decorative_lights
      image: /local/lights.png
```

## 경로

경로를 통해 다른 view에서 또다른 view에 연결할 수 있습니다. 이를 위해 내비게이션 (`navigation_path`)을 지원하는 카드를 사용하십시오. 경로에 특수 문자를 사용하지 마십시오. 숫자로 경로를 시작하지 마십시오. 그러면 파서가 경로를 뷰인덱스(view index)로 읽습니다.

### 사례 

View config:

```yaml
- title: Living room
  # the final path is /lovelace/living_room
  path: living_room
```

Picture card config:

```yaml
- type: picture
  image: /local/living_room.png
  tap_action:
    action: navigate
    navigation_path: /lovelace/living_room
```

## Icons

아이콘을 정의하면 제목이 툴팁(tool-tip)으로 사용됩니다.

### 사례

```yaml
- title: Garden
  icon: mdi:flower
```

## Visible

view를 구분해서 전체 또는 사용자별로 지정할 수 있습니다. (참고: 탭표시 전용. URL 경로는 여전히 액세스 가능)

### 사례

```yaml
views:
  - title: Ian
    visible:
      - user: 581fca7fdc014b8b894519cc531f9a04
    cards:
      ...
  - title: Chelsea
    visible:
      - user: 6e690cc4e40242d2ab14cf38f1882ee6
    cards:
      ...
  - title: Admin
    visible: db34e025e5c84b70968f6530823b117f
    cards:
      ...
```

## 패널 모드 (Panel mode)

이렇게하면 첫 번째 카드가 전체 너비로 렌더링되고 이 View의 다른 카드는 렌더링되지 않습니다. `map`,`stack` 또는 `picture-elements`와 같은 카드에 적합합니다.

### 사례

```yaml
- title: Map
  panel: true
  cards:
    - type: map
      entities:
        - device_tracker.demo_paulus
        - zone.home
```

## 테마

View와 해당 카드에 대해 별도의 [theme](/integrations/frontend/#themes)를 설정하십시오.

### 사례

```yaml
- title: Home
  theme: happy
```

### 배경 (Background)

[theme](/integrations/frontend/#themes)를 사용하여 뷰의 배경 스타일을 지정할 수 있습니다. CSS 변수 `lovelace-background`를 사용할 수 있습니다. 아래 예를 사용하려는 월페이퍼의 경우 더 많은 옵션을 찾을 수 있습니다. [참고][https://developer.mozilla.org/en-US/docs/Web/CSS/background].

#### 사례

```yaml
# Example configuration.yaml entry
frontend:
  themes:
    example:
      lovelace-background: center / cover no-repeat url("/local/background.png") fixed
```

## 뱃지 (Badges)

### 상태 라벨 벳지(State Label Badge)

상태 라벨 벳지는 벳지의 상태를 보여줍니다. 

```yaml
type: state-label
entity: light.living_room
```

{% configuration state_label %}
type:
  required: true
  description: 엔터티 버튼
  type: string
entity:
  required: true
  description: 홈어시스턴트 entity ID.
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어씁니다.
  type: string
  default: Name of Entity
icon:
  required: false
  description: 아이콘 또는 엔터티 그림을 덮어씁니다.
  type: string
  default: Entity Domain Icon
image:
  required: false
  description: 이미지의 URL.
  type: string
show_name:
  required: false
  description: 이름 표시.
  type: boolean
  default: "true"
show_icon:
  required: false
  description: 아이콘 표시.
  type: boolean
  default: "true"
tap_action:
  required: false
  description: 탭(tap)할 시 액션.
  type: map
  keys:
    action:
      required: true
      description: "실행할 액션 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`toggle`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의된 경우 탐색할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이`url`로 정의된 경우 탐색 경로 (예: `https : // www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`call-service`로 정의된 `action` 일 때 호출할 서비스 (예: `media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의될 때 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "`action`을 컨펌하는 확인 대화 상자를 표시하십시오. 아래의 `confirmation` 개체를 참조하십시오."
      type: [boolean, map]
      default: "false"
hold_action:
  required: false
  description: 길게 누르기 액션
  type: map
  keys:
    action:
      required: true
      description: "실행할 액션 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의된 경우 탐색할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url`로 정의된 경우 탐색 경로 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 호출할 서비스 (예: `media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의된 경우 포함할 서비스 데이터 (예: `entity_id : media_player.bedroom`)."
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래 `confirmation` 객체 참조"
      type: [boolean, map]
      default: "false"
double_tap_action:
  required: false
  description: 더블 탭에서 액션
  type: map
  keys:
    action:
      required: true
      description: "실행할 액션 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의될 때 (예: `/lovelace/0/`) 탐색할 경로"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url`로 정의될 때 (예: `https://www.home-assistant.io`) 탐색할 경로"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의될 때 (예: `media_player.media_play_pause`) 호출할 서비스"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의될 때 (예: `entity_id: media_player.bedroom`) 포함할 서비스 데이터"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시. 아래 `confirmation` 객체 참조"
      type: [boolean, map]
      default: "false"
{% endconfiguration %}

#### 확인 옵션 (Options For Confirmation)

boolean 대신 객체로 확인(confirmation)을 정의하면 더 많은 사용자 정의와 설정을 추가할 수 있습니다. :

{% configuration confirmation %}
text:
  required: false
  description: 확인 대화 상자에 표시할 텍스트.
  type: string
exemptions:
  required: false
  description: "`exemption` 객체 목록. 아래 참조"
  type: list
{% endconfiguration %}

#### 면제 옵션 (Options For Exemptions)

{% configuration badges %}
user:
  required: true
  description: 보기 탭을 볼 수 있는 사용자 ID. 
  type: string
{% endconfiguration %}

### 엔티티 필터 뱃지 (Entity Filter Badge)

이 뱃지를 사용하면 특정 상태에 있을 때만 추적하려는 엔터티 목록을 정의할 수 있습니다. 끄는 것을 잊어 버린 조명을 보여주고 가족들이 집에있을 때만 목록을 보여주는데 매우 유용합니다. 

{% configuration filter_badge %}
type:
  required: true
  description: entity-filter
  type: string
entities:
  required: true
  description: 엔터티 ID 또는 `entity`개체 목록은 아래 참조 
  type: list
state_filter:
  required: true
  description: 상태 또는 `filter` 객체를 나타내는 문자열 목록은 아래를 참조
  type: list
{% endconfiguration %}

#### 엔티티 옵션 (Options For Entities)

엔티티를 문자열 대신 객체로 정의(엔티티 ID 앞에 `entity:` 추가)하면 더 많은 사용자 정의와 설정을 추가할 수 있습니다.

{% configuration entities %}
type:
  required: false
  description: "사용자 정의 뱃지 유형 설정: `custom:my-custom-badge`"
  type: string
entity:
  required: true
  description: 홈어시스턴트 엔티티 ID.
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어씁니다.
  type: string
icon:
  required: false
  description: 아이콘 또는 엔터티 그림을 덮어씁니다.
  type: string
image:
  required: false
  description: 이미지의 URL.
  type: string
state_filter:
  required: false
  description: 상태 또는 `filter` 객체를 나타내는 문자열 목록은 아래를 참조.
  type: list
{% endconfiguration %}

#### state_filter 옵션 (Options For state_filter)

state_filter를 문자열 대신 객체로 정의하면(state value 앞에 `value:`를 추가) 필터에 더 많은 사용자 정의를 추가할 수 있습니다. :

{% configuration state_filter %}
value:
  required: true
  description: 상태를 나타내는 문자열.
  type: string
operator:
  required: false
  description: "비교에 사용할 연산자. (예: `==`, `<=`, `<`, `>=`, `>`, `!=` 혹은 `regex`)"
  type: string
attribute:
  required: false
  description: 상태 대신 사용할 엔티티의 속성.
  type: string
{% endconfiguration %}

#### 사례

집에 활성된 스위치 혹은 조명만 표시

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
