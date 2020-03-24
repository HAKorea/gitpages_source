---
title: 블라인드전문회사(Hunter Douglas PowerView)
description: Instructions on how to setup Hunter Douglas PowerView scenes within Home Assistant.
logo: hunter-douglas-powerview.png
ha_category:
  - Scene
ha_release: 0.15
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/b6YwgWDCWBA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Hunter Douglas PowerView](https://www.hunterdouglas.com/operating-systems/powerview-motorization/support) 플랫폼 장면(씬) 제어를 구현합니다. PowerView Hub를 쿼리하고 홈어시스턴트가 장면(씬)으로 표시합니다.

장면(씬)은 `scene.turn_on` 서비스를 사용하여 활성화 할 수 있습니다.

```yaml
# Example configuration.yaml entry
scene:
  platform: hunterdouglas_powerview
  address: IP_ADDRESS
```

{% configuration %}
address:
  description: IP address of the PowerView Hub, e.g., 192.168.1.10.
  required: true
  type: string
{% endconfiguration %}

## 자동화 사례

``` yaml
- alias: "blinds closed at night"
  trigger:
    platform: time
    at: "18:00:00"
  action:
    - service: scene.turn_on
      entity_id: scene.10877
```
