---
title: "KNX Scene"
description: "Instructions on how to integrate KNX Scenes into Home Assistant."
logo: knx.png
ha_category:
  - Scene
ha_release: 0.63
---

<div class='note'>
  
이 통합구성요소를 사용하려면 `knx` 연동을 올바르게 설정해야합니다. [KNX Integration](/integrations/knx)을 참조하십시오.

</div>

`knx` scenes 플랫폼을 사용하면 [KNX](https://www.knx.org/) 장면(씬)을 트리거할 수 있습니다.

## 설정

설치에서 KNX scene을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
scene:
  - name: Romantic
    platform: knx
    address: 8/8/8
    scene_number: 23
```

{% configuration %}
address:
  description: KNX group address for the scene.
  required: true
  type: string
scene_number:
  description: KNX scene number to be activated. ( 1 ... 64 )
  required: true
  type: integer
name:
  description: A name for this device used within Home Assistant.
  required: false
  type: string
{% endconfiguration %}
