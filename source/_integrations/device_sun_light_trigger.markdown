---
title: 재실 기반 조명(Presence-based Lights)
description: Instructions on how to automate your lights with Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: pre 0.7
ha_quality_scale: internal
---

홈어시스턴트에는 `device_sun_light_trigger` 조명을 자동화하는데 도움이 되는 내장 통합구성요소 기능이 있습니다. 

 * 해가 지고 사람들이 집에 있을 때 불빛이 희미 해집니다
 * 해가 진 후에 사람들이 집에 돌아오면 불을 켭니다
 * 모든 사람들이 집을 떠날 때 불을 끄십시오

이 통합구성요소를 위해서는 [sun](/integrations/sun/), [device_tracker](/integrations/device_tracker/), [person](/integrations/person/) 그리고 [light](/integrations/light/) 통합구성요소가 활성화 되어야합니다.

이 연동을 가능하게하려면 configuration.yaml 파일에 다음 행을 추가 하십시오.

```yaml
# Example configuration.yaml entry
device_sun_light_trigger:
```

{% configuration %}
light_group:
  description: 켜져야 할 특정 조명/조명그룹을 지정하십시오.
  required: false
  type: string
light_profile:
  description: 조명을 켤 때 사용할 조명 프로파일을 지정하십시오.
  required: false
  default: relax
  type: string
device_group:
  description: 추적할 그룹을 지정하십시오. 그룹에는 device_trackers 또는 person이 포함될 수 있습니다.
  required: false
  type: string
disable_turn_off:
  description: 모두가 집을 떠날 때 조명이 꺼지도록합니다.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

전체 설정 예는 다음과 같습니다. :

```yaml
# Example configuration.yaml entry
device_sun_light_trigger:
  light_group: group.living_room
  light_profile: relax
  device_group: group.my_devices
  disable_turn_off: 1
```
