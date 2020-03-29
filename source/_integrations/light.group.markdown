---
title: 조명 그룹(Light Group)
description: "Instructions for how to setup light groups within Home Assistant."
ha_category:
  - Light
ha_release: 0.65
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/sgomUe6R3MI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

그룹 조명 플랫폼을 사용하면 여러 조명을 하나의 엔티티로 결합할 수 있습니다. 조명 그룹의 모든 자식 조명은 평소와 같이 계속 사용할 수 있지만 그룹화된 조명의 상태를 제어하면 명령이 각 자식 조명으로 전달됩니다.

설치시 이 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: group
    name: Kitchen Lights
    entities:
      - light.kitchen_ceiling_lights
      - light.kitchen_under_cabinet_lights
      - light.kitchen_spot_lights
      - light.pendant_lights
```

{% configuration %}
  name:
    description: 조명 그룹의 이름입니다. 기본값은 "Light Group"입니다.
    required: false
    type: string
  entities:
    description: 조명 그룹에 포함할 엔티티 목록입니다.
    required: true
    type: [string, list]
{% endconfiguration %}

<p class='img'>
<img src='/images/integrations/light/group.png'>
조명 그룹 "주방 조명"의 예.
</p>

모든 조명의 지원되는 기능이 함께 추가됩니다. 예를 들어, 밝기 전용 조명 그룹에 RGB 조명이 하나 있으면 조명 그룹에 색상 선택기가 표시됩니다.

## 스크립트 사례 (Script Example)

위의 조명 그룹을 사용하는 스크립트의 예는 다음과 같습니다.

```yaml
script:
  turn_on_kitchen_lights:
    alias: Kitchen lights on
    sequence:
      service: light.turn_on
      data:
        entity_id: light.kitchen_lights
        brightness: 100
```
