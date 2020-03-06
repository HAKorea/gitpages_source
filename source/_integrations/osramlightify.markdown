---
title: 오스람(Osramlightify)
description: Instructions on how to integrate Osram Lightify into Home Assistant.
logo: osramlightify.png
ha_category:
  - Light
ha_release: 0.21
---

`osramlightify` 플랫폼을 사용하면 [Osram Lightify](https://www.osram.com/cb/lightify/index.jsp)를 Home Assistant에 연동할 수 있습니다.

```yaml
# Example configuration.yaml entry
light:
  - platform: osramlightify
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: "IP address of the Osram Lightify bridge, e.g., `192.168.1.50`."
  required: true
  type: string
allow_lightify_nodes:
  description: (true/false) If `true` then import individual lights, if `false` then skip them.
  required: false
  default: true
  type: boolean
allow_lightify_sensors:
  description: (true/false) If `true` then import contact and motion sensors, if `false` then skip them. Takes effect only if `allow_lightify_nodes` is `true`.
  required: false
  default: true
  type: boolean
allow_lightify_switches:
  description: (true/false) If `true` then import switches, if `false` then skip them. Takes effect only if `allow_lightify_nodes` is `true`.
  required: false
  default: true
  type: boolean
allow_lightify_groups:
  description: (true/false) If `true` then import groups, if `false` then skip them.
  required: false
  default: true
  type: boolean
interval_lightify_status:
  description: Minimum interval in seconds between querying light status (for both individual lights and groups).
  required: false
  default: 5
  type: integer
interval_lightify_conf:
  description: Minimum interval in seconds between querying groups and scenes configuration.
  required: false
  default: 3600
  type: integer
{% endconfiguration %}

현재 Osram Lightify 스위치 및 센서에는 많은 기능이 없습니다.
사용 가능한 유일한 방법은 사용 가능한지 여부를 추적하는 것입니다.
또한 센서의 경우 raw 값 목록이 `sensor_values` 속성으로 노출되며 센서에서 특정값의 의미를 알고있는 경우 이를 자동화에 사용할 수 있습니다.

[scan_interval](/docs/configuration/platform_options/#scan-interval)(기본적으로 30 초)을 `interval_lightify_status`와 같거나 작게 만드는 것이 좋습니다. 그렇지 않으면 예상대로 작동하지 않습니다.
`scan_interval`이 짧을수록 개별 조명과 그룹 간의 동기화 속도가 향상 될 수 있습니다. 예를 들어 그룹을 켜면 브리지를 쿼리하지 않고 모든 라이트가 즉시 `on`으로 업데이트 될 수 있습니다.

모든 조명 상태를 업데이트하려면 실제로 브리지에 대한 쿼리 하나만 필요합니다.

그룹에 관련 장면(scene)이 있는 경우, 조명 효과로 가져와서 UI의 `Effect` 드롭 다운에 표시됩니다. 드롭 다운에서 아이템을 클릭하거나 `light.turn_on` 서비스를 호출하여 장면을 적용 할 수 있습니다 :

```yaml
  - service: light.turn_on
    entity_id: light.bedroom
    data:
      effect: Romance
```
