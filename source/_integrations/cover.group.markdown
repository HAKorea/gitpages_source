---
title: "개폐장치 그룹(Cover Group)"
description: "Instructions how to setup grouped covers in Home Assistant."
ha_category:
  - Cover
ha_release: 0.66
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`group` 플랫폼은 하나에 여러 개폐장치 요소를 결합하는 커버를 만들 수 있습니다.

설치시 `Cover Groups`을 사용하려면, `configuration.yaml` 파일에 다음을 추가 하십시오.:

```yaml
# Example configuration.yaml entry
cover:
  - platform: group
    entities:
      - cover.hall_window
      - cover.living_room_window
```

{% configuration %}
  name:
    description: 프론트 엔드에서 사용할 이름입니다.
    required: false
    type: string
    default: "Cover Group"
  entities:
    description: 제어하려는 모든 개폐장치 entity의 목록입니다.
    required: true
    type: [string, list]
{% endconfiguration %}

## 활용 내용

동일한 지원 기능을 가진 동일제품의 개폐장치를 그룹화하는 경우  (`open`/`close`/`stop`/`position`/`tilt controls` 지원 등), 제한없이 모두 활용 가능합니다. 서로 다른 기능을 가진 개폐장치를 묶은 경우, 해당 기능을 지원하는 개폐장치에만 영향을 미칩니다.