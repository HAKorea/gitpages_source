---
title: "Scenes"
description: "Instructions on how to setup scenes within Home Assistant."
---

특정 엔티티가 원하는 상태를 캡처하는 장면(scene)을 만들 수 있습니다. 예를 들어 장면(scene)에서 조명 A를 켜고 조명 B를 밝게 빨간색으로 지정하도록 지정할 수 있습니다.

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

보다시피, 각 `entity_id`의 상태를 정의하는 두 가지 방법이 있습니다 :

- 엔티티와 직접 `state`를 정의하십시오. `state`는 반드시 정의해야합니다.
- 속성으로 복잡한 상태를 정의하십시오. `developer-tools-> state`에서 특정 엔티티에 사용 가능한 모든 속성을 볼 수 있습니다.

`scene.turn_on` 서비스를 사용하지 않고 장면(scene)을 활성화 할 수 있습니다 ('scene.turn_off' 서비스 없음).

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

## 장면을 정의하지 않고 적용 (Applying a scene without defining it)

`scene.apply` 서비스를 사용하면 설정을 통해 먼저 장면을 정의하지 않고도 장면을 적용 할 수 있습니다. 대신 서비스 데이터의 일부로 상태를 전달합니다. 데이터의 형식은 설정의 `entities`필드와 동일합니다.

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

## 장면 새로고침 (Reloading scenes)

장면 설정을 변경할 때마다 `scene.reload` 서비스를 호출하여 장면을 다시로드 할 수 있습니다.