---
title: 장면(씬,Scenes)
description: Instructions on how to setup scenes within Home Assistant.
logo: home-assistant.png
ha_category:
  - Organization
ha_release: 0.15
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/U3_b7GAsh3Y?start=1538" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

특정 엔티티가 원하는 상태를 설정하는 장면(scene)을 만들 수 있습니다. 예를 들어 장면에서 조명 A를 켜고 조명 B를 밝게 빨간색으로 지정하도록 할 수 있습니다.

```yaml
# Example configuration.yaml entry
scene:
  - name: Romantic
    entities:
      light.tv_back_light: on
      light.ceiling:
        state: on
        xy_color: [0.33, 0.66]
        brightness: 200
  - name: Movies
    entities:
      light.tv_back_light:
        state: on
        brightness: 125
      light.ceiling: off
      media_player.sony_bravia_tv:
        state: on
        source: HDMI 1
        state: on
```

{% configuration %}
name:
  description: 친숙한 장면 이름.
  required: true
  type: string
entities:
  description: 제어 할 엔티티 및 원하는 상태.
  required: true
  type: list
{% endconfiguration %}

다음과 같이, 각각의 `entity_id` 상태를 정의하는 두 가지 방법이 있습니다

- 엔티티와 직접 `state`를 정의하십시오. 반드시 `state`를 정의해야합니다.
- 속성으로 복잡한 상태를 정의하십시오. `developer-tools-> state` 에서 특정 엔티티에 사용 가능한 모든 속성을 볼 수 있습니다. 

`scene.turn_on` 서비스를 사용하지 않고 장면을 활성화 할 수 있습니다 (scene.turn_off '서비스 없음').

```yaml
# Example automation
automation:
  trigger:
    platform: state
    entity_id: device_tracker.sweetheart
    from: "not_home"
    to: "home"
  action:
    service: scene.turn_on
    entity_id: scene.romantic
```

## 장면을 정의하지 않고 적용

`scene.apply` 서비스를 사용하면 설정을 통해 먼저 장면을 정의하지 않고도 장면을 적용 할 수 있습니다. 대신 서비스 데이터의 일부로 상태를 전달합니다. 데이터의 형식은 설정에서 `entities` 필드와 동일합니다.

```yaml
# Example automation
automation:
  trigger:
    platform: state
    entity_id: device_tracker.sweetheart
    from: "not_home"
    to: "home"
  action:
    service: scene.apply
    data:
      entities:
        light.tv_back_light:
          state: on
          brightness: 100
        light.ceiling: off
        media_player.sony_bravia_tv:
          state: on
          source: HDMI 1
```

## 장면 새로고침

장면 구성을 변경할 때마다 `scene.reload` 서비스를 호출 하여 장면을 다시로드 할 수 있습니다.

## 즉석에서 장면 만들기

`scene.create`서비스 를 호출하여 별도 설정할 필요없이 새 장면을 만듭니다. 이 장면은 설정을 다시로드 한 후에 삭제됩니다.

공백 대신 밑줄로 소문자로 `scene_id`를 전달해야합니다. 장면을 구성 할 때와 같은 형식으로 엔티티를 지정할 수도 있습니다. `snapshot_entities` 매개 변수를 사용하여 현재 상태의 스냅샷을 작성할 수도 있습니다. 이 경우 스냅샷을 만들려는 모든 엔터티의 `entity_id`를 지정해야합니다. `entities`와 `snapshot_entities`는 결합 할 수 있지만 적어도 둘 중 하나를 사용해야합니다.

장면이 이전에 `scene.create`에 의해 생성 된 경우 덮어 씁니다. YAML에서 장면을 만든 경우 로그 파일에 경고 만 표시됩니다. 

```yaml
# Example automation using entities
automation:
  trigger:
    platform: homeassistant
    event: start
  action:
    service: scene.create
    data:
      scene_id: my_scene
      entities:
        light.tv_back_light:
          state: on
          brightness: 100
        light.ceiling: off
        media_player.sony_bravia_tv:
          state: on
          source: HDMI 1
```

다음 예제는 창이 열리면 일부 엔티티를 끕니다. 창을 다시 닫은 후 엔터티의 상태가 복원됩니다.

```yaml
# Example automation using snapshot
- alias: Window opened
  trigger:
  - platform: state
    entity_id: binary_sensor.window
    from: 'off'
    to: 'on'
  condition: []
  action:
  - service: scene.create
    data:
      scene_id: before
      snapshot_entities:
      - climate.ecobee
      - light.ceiling_lights
  - service: light.turn_off
    data:
      entity_id: light.ceiling_lights
  - service: climate.set_hvac_mode
    data:
      entity_id: climate.ecobee
      hvac_mode: 'off'
- alias: Window closed
  trigger:
  - platform: state
    entity_id: binary_sensor.window
    from: 'on'
    to: 'off'
  condition: []
  action:
  - service: scene.turn_on
    data:
      entity_id: scene.before
```
