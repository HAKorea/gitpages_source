---
title: "Views"
description: "The Lovelace UI is a powerful and configurable interface for Home Assistant."
---

To display cards on the UI you have to define them in views. Views sort cards in columns based on their `card size`. If you want to group some cards you have to use `stack` cards.
UI에 카드를 표시하려면 View에서 카드를 정의해야합니다. View는 `card size` 를 기준으로 열의 카드를 정렬합니다. 일부 카드를 그룹화하려면 `stack` 카드를 사용해야합니다.

<p class="img">
  <img src="/images/lovelace/lovelace_views.png" alt="Views toolbar">
  제목과 아이콘을 사용하여 View의 내용을 설명하십시오.
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
      description: badge로 표시 할 엔티티 ID 또는 `badge` 개체 목록.
      type: list
    cards:
      required: false
      description: View에 표시 할 카드.
      type: list
    path:
      required: false
      description: 경로는 URL에서 사용되며, 자세한 내용은 아래를 참조하십시오.
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

If you define `visible` as objects instead of a boolean to specify conditions for displaying the view tab:
view 탭을 표시하기위한 조건을 지정하기 위해 부울(boolean) 대신 객체로 `visible`을 정의하는 경우 :

{% configuration badges %}
user:
  required: true
  description: view 탭을 볼 수있는 사용자 ID (사용자 설정 페이지에있는 고유한 16 진수 값).
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

You can link to one view from another view by its path. For this use cards that support navigation (`navigation_path`). Do not use special characters in paths. Do not begin a path with a number. This will cause the parser to read your path as a view index.
경로를 통해 다른 view에서 또다른 view에 연결할 수 있습니다. 이를 위해 내비게이션 (`navigation_path`)을 지원하는 카드를 사용하십시오. 경로에 특수 문자를 사용하지 마십시오. 숫자로 경로를 시작하지 마십시오. 그러면 파서가 경로를 뷰인덱스로 읽습니다.

### Example

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

If you define an icon the title will be used as a tool-tip.
아이콘을 정의하면 제목이 툴팁(tool-tip)으로 사용됩니다.

### 사례

```yaml
- title: Garden
  icon: mdi:flower
```

## Visible

view를 구분해서 전체 또는 사용자별로 지정할 수 있습니다. (참고 : 이것은 탭표시 전용입니다. URL 경로는 여전히 액세스 가능합니다)

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

This renders the first card on full width, other cards in this view will not be rendered. Good for cards like `map`, `stack` or `picture-elements`.
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

Set a separate [theme](/integrations/frontend/#themes) for the view and its cards.
View와 해당 카드에 대해 별도의 [theme](/integrations/frontend/#themes)를 설정하십시오.

### 사례

```yaml
- title: Home
  theme: happy
```

### 배경 (Background)

You can style the background of your views with a [theme](/integrations/frontend/#themes). You can use the CSS variable `lovelace-background`. For wallpapers you probably want to use the example below, more options can be found [here](https://developer.mozilla.org/en-US/docs/Web/CSS/background).
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

The State Label badge allows you to dislay a state badge
상태 라벨 벳지는 벳지 상태를 보여줍니다. 

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
  description: 친숙한 이름을 덮어 씁니다.
  type: string
  default: Name of Entity
icon:
  required: false
  description: 아이콘 또는 엔터티 그림을 덮어 씁니다.
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
  description: 탭할시 액션.
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`toggle`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의 된 경우 탐색할 경로 (예 :`/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이`url`로 정의 된 경우 탐색 경로 (예 :`https : // www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`call-service`로 정의 된 `action` 일 때 호출 할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의될 때 (예: `entity_id: media_player.bedroom`)을 포함할 서비스 데이터 "
      type: string
      default: none
    confirmation:
      required: false
      description: "`action`을 컨펌하는 확인 대화 상자를 표시하십시오. 아래의 `confirmation`개체를 참조하십시오."
      type: [boolean, map]
      default: "false"
hold_action:
  required: false
  description: 길게 누르기 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate`로 정의된 경우 탐색할 경로 (예 :`/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url`로 정의 된 경우 탐색 경로 (예 :`https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service`로 정의 된 경우 호출할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service`로 정의 된 경우 포함 할 서비스 데이터 (예 :`entity_id : media_player.bedroom`). Service data to include (e.g. `entity_id: media_player.bedroom`) when `action` defined as "
      type: string
      default: none
    confirmation:
      required: false
      description: "Present a confirmation dialog to confirm the action. See `confirmation` object below"
      type: [boolean, map]
      default: "false"
double_tap_action:
  required: false
  description: Action to take on double tap
  type: map
  keys:
    action:
      required: true
      description: "Action to perform (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "Path to navigate to (e.g. `/lovelace/0/`) when `action` defined as `navigate`"
      type: string
      default: none
    url_path:
      required: false
      description: "Path to navigate to (e.g. `https://www.home-assistant.io`) when `action` defined as `url`"
      type: string
      default: none
    service:
      required: false
      description: "Service to call (e.g. `media_player.media_play_pause`) when `action` defined as `call-service`"
      type: string
      default: none
    service_data:
      required: false
      description: "Service data to include (e.g. `entity_id: media_player.bedroom`) when `action` defined as `call-service`"
      type: string
      default: none
    confirmation:
      required: false
      description: "Present a confirmation dialog to confirm the action. See `confirmation` object below"
      type: [boolean, map]
      default: "false"
{% endconfiguration %}

#### Options For Confirmation

If you define confirmation as an object instead of boolean, you can add more customization and configurations:
{% configuration confirmation %}
text:
  required: false
  description: Text to present in the confirmation dialog.
  type: string
exemptions:
  required: false
  description: "List of `exemption` objects. See below"
  type: list
{% endconfiguration %}

#### Options For Exemptions

{% configuration badges %}
user:
  required: true
  description: User id that can see the view tab.
  type: string
{% endconfiguration %}

### Entity Filter Badge

This badge allows you to define a list of entities that you want to track only when in a certain state. Very useful for showing lights that you forgot to turn off or show a list of people only when they're at home.

{% configuration filter_badge %}
type:
  required: true
  description: entity-filter
  type: string
entities:
  required: true
  description: A list of entity IDs or `entity` objects, see below.
  type: list
state_filter:
  required: true
  description: List of strings representing states or `filter` objects, see below.
  type: list
{% endconfiguration %}

#### Options For Entities

If you define entities as objects instead of strings (by adding `entity:` before entity ID), you can add more customization and configurations:

{% configuration entities %}
type:
  required: false
  description: "Sets a custom badge type: `custom:my-custom-badge`"
  type: string
entity:
  required: true
  description: Home Assistant entity ID.
  type: string
name:
  required: false
  description: Overwrites friendly name.
  type: string
icon:
  required: false
  description: Overwrites icon or entity picture.
  type: string
image:
  required: false
  description: The URL of an image.
  type: string
state_filter:
  required: false
  description: List of strings representing states or `filter` objects, see below.
  type: list
{% endconfiguration %}

#### Options For state_filter

If you define state_filter as objects instead of strings (by adding `value:` before your state value), you can add more customization to your filter:

{% configuration state_filter %}
value:
  required: true
  description: String representing the state.
  type: string
operator:
  required: false
  description: Operator to use in the comparison. Can be `==`, `<=`, `<`, `>=`, `>`, `!=` or `regex`.
  type: string
attribute:
  required: false
  description: Attribute of the entity to use instead of the state.
  type: string
{% endconfiguration %}

#### Examples

Show only active switches or lights in the house

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

Specify filter for a single entity

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
