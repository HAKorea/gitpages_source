---
title: "조명 스위치"
description: "Instructions on how to set up a light switch within Home Assistant."
ha_category:
  - Light
ha_release: 0.83
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

조명 스위치 플랫폼을 사용하면 기존 스위치를 제어하여 Home Assistant의 조명과 같은 스위치를 사용할 수 있습니다.

홈 어시스턴트 세계에선 벽면 플러그는 스위치입니다. 이 플랫폼을 사용하면 이 스위치를 광원으로 노출하여 크리스마스 트리를 제어하는 ​​벽면 플러그를 조명 그룹에 추가 할 수 있습니다.

설치시 이 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
light:
  - platform: switch
    name: Christmas Tree Lights
    entity_id: switch.christmas_tree_lights
```

{% configuration %}
  name:
    description: 조명 스위치의 이름
    required: false
    type: string
    default: Light Switch
  entity_id:
    description: "조명 소스로 제어하기 위한 스위치 엔티티의 `entity_id`"
    required: true
    type: string
{% endconfiguration %}

조명 스위치는 전등 켜기/끄기 만 지원합니다.
