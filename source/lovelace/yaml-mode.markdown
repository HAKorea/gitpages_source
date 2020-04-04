---
title: "Lovelace YAML 모드(직접 편집 모드)"
description: "Advanced users can switch on YAML mode for editing the Lovelace UI."
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/n5xMtONydEo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

UI 대신 YAML로 작성하여 Home Assistant 화면을 커스텀 제작할 수 있습니다. 이렇게하려면 `configuration.yaml`에 다음 내용을 추가하여 Lovelace 통합구성요소를 yaml 모드로 설정하십시오.  

```yaml
lovelace:
  mode: yaml
```

모드를 변경하려면 홈어시스턴트를 다시 시작하십시오. 새 파일 `<config>/ui-lovelace.yaml`을 생성하고 Lovelace 설정을 추가하십시오. 이 작업을 시작하는 가장 좋은 방법은 UI에서 "구성 코드"를 복사하여 붙여넣어 수동 설정의 시작을 기존 UI와 동일하게 시작하는 것입니다.

- `둘러보기` 탭으로 이동.
- 세 개의 점 메뉴 (오른쪽 상단)를 클릭하고 `구성 UI`를 클릭하십시오.
- 세 개의 점 메뉴를 다시 클릭하고 `구성 코드 편집기`를 클릭하십시오.
- 현재 Lovelace UI의 설정이 표시됩니다. 이것을 `<config>/ui-lovelace.yaml` 파일에 복사하십시오.

YAML을 통해 UI를 제어하면 수정을 위한 홈어시스턴트 인터페이스를 더이상 사용할 수 없으며 새 엔티티가 자동으로 UI에 추가되지 않습니다.

`ui-lovelace.yaml`을 변경하면 홈어시스턴트를 다시시작하거나 페이지를 새로 고칠 필요가 없습니다. UI 상단의 메뉴에서 새로 고침 버튼을 누르기만 하면됩니다.

UI를 사용하여 Lovelace 인터페이스를 편집하도록 되돌리려면 `configuration.yaml`에서 `lovelace` 섹션을 제거하고 `ui-lovelace.yaml`의 내용을 Home Assistant의 구성 코드 섹션에 복사한 후 다시 시작하십시오.

### 고급 설정 

모두 고유한 YAML 파일이 있는 여러 대시 보드를 정의하고 모든 대시 보드에서 공유하는 사용자 지정 리소스를 추가할 수 있습니다.

대시 보드의 키는 URL로 사용되며 하이픈 (`-`)을 포함해야합니다.

```yaml
lovelace:
  mode: yaml
  # Include external resources only add when mode is yaml, otherwise manage in the resources in the lovelace configuration panel.
  resources:
    - url: /local/my-custom-card.js
      type: module
    - url: /local/my-webfont.css
      type: css
  # Add more dashboards
  dashboards:
    lovelace-generated: # Needs to contain a hyphen (-)
      mode: yaml
      filename: notexist.yaml
      title: Generated
      icon: mdi:tools
      show_in_sidebar: true
      require_admin: true
    lovelace-hidden:
      mode: yaml
      title: hidden
      show_in_sidebar: false
      filename: hidden.yaml
```

기본 대시 보드가 UI 구성되어있을 때 YAML 대시 보드를 추가할 수도 있습니다.
```yaml
lovelace:
  mode: storage
  # Add yaml dashboards
  dashboards:
    lovelace-yaml:
      mode: yaml
      title: YAML
      icon: mdi:script
      show_in_sidebar: true
      filename: lovelace.yaml
```

{% configuration Lovelace %}
mode:
  required: true
  description: "In what mode should the main Lovelace panel be, `yaml` or `storage` (UI managed)."
  type: string
resources:
  required: false
  description: "List of resources that should be loaded when you use Lovelace. Only use this when mode is `yaml`."
  type: list
  keys:
    url:
      required: true
      description: The URL of the resource to load.
      type: string
    type:
      required: true
      description: "The type of resource, this should be either `module` for a JavaScript module or `css` for a StyleSheet."
      type: string
dashboards:
  required: false
  description: Additional Lovelace YAML dashboards. The key is used for the URL and should contain a hyphen (`-`)
  type: map
  keys:
    mode:
      required: true
      description: "The mode of the dashboard, this should always be `yaml`. Dashboards in `storage` mode can be created in the Lovelace configuration panel."
      type: string
    filename:
      required: true
      description: "The file in your `config` directory where the Lovelace configuration for this panel is."
      type: string
    title:
      required: true
      description: "The title of the dashboard, will be used in the sidebar."
      type: string
    icon:
      required: false
      description: The icon to show in the sidebar.
      type: string
    show_in_sidebar:
      required: false
      description: Should this view be shown in the sidebar.
      type: boolean
      default: true
    require_admin:
      required: false
      description: Should this view be only accessible for admin users.
      type: boolean
      default: false
{% endconfiguration %}

Lovelace 대시 보드 구성의 최소 단위 예를 들면 다음과 같습니다. : 

```yaml
title: My Awesome Home
views:
    # View tab title.
  - title: Example
    cards:
        # The markdown card will render markdown text.
      - type: markdown
        title: Lovelace
        content: >
          Welcome to your **Lovelace UI**.
```

약간 더 발전된 예 :

```yaml
title: My Awesome Home
views:
    # View tab title.
  - title: Example
    # Unique path for direct access /lovelace/${path}
    path: example
    # Each view can have a different theme applied. Theme should be defined in the frontend.
    theme: dark-mode
    # The cards to show on this view.
    cards:
        # The filter card will filter entities for their state
      - type: entity-filter
        entities:
          - device_tracker.paulus
          - device_tracker.anne_there
        state_filter:
          - 'home'
        card:
          type: glance
          title: People that are home

        # The picture entity card will represent an entity with a picture
      - type: picture-entity
        image: https://www.home-assistant.io/images/default-social.png
        entity: light.bed_light

    # Specify a tab icon if you want the view tab to be an icon.
  - icon: mdi:home-assistant
    # Title of the view. Will be used as the tooltip for tab icon
    title: Second view
    cards:
        # Entities card will take a list of entities and show their state.
      - type: entities
        # Title of the entities card
        title: Example
        # The entities here will be shown in the same order as specified.
        # Each entry is an entity ID or a map with extra options.
        entities:
          - light.kitchen
          - switch.ac
          - entity: light.living_room
            # Override the name to use
            name: LR Lights

        # The markdown card will render markdown text.
      - type: markdown
        title: Lovelace
        content: >
          Welcome to your **Lovelace UI**.
```