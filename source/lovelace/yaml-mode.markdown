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

아주 최소한의 예로서, 이를 동작시키는데 필요한 최소값은 다음과 같습니다.

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

약간 더 발전된 예는 프런트엔드를 커스텀 제작하는데 사용할 수 있는 추가 요소를 보여줍니다.

```yaml
title: My Awesome Home
# Include external resources
resources:
  - url: /local/my-custom-card.js
    type: js
  - url: /local/my-webfont.css
    type: css

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
