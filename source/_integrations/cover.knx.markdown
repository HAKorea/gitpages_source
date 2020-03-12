---
title: "KNX 커버(Cover)"
description: "Instructions on how to integrate KNX covers with Home Assistant."
logo: knx.png
ha_category:
  - Cover
ha_release: 0.48
ha_iot_class: Local Push
---

<div class='note'>

이 통합구성요소를 사용하려면 `knx` 연동을 올바르게 구성해야합니다. [KNX Integration](/integrations/knx)을 참조하십시오.

</div>

`knx` 커버(Cover) 플랫폼은 KNX 커버에 대한 인터페이스로 사용됩니다.

설치에서 KNX 커버를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
cover:
  - platform: knx
    name: "Kitchen.Shutter"
    move_long_address: '3/0/0'
    move_short_address: '3/0/1'
    position_address: '3/0/3'
    position_state_address: '3/0/2'
    travelling_time_down: 51
    travelling_time_up: 61
```

{% configuration %}
name:
  description: A name for this device used within Home Assistant.
  required: false
  default: KNX Cover
  type: string
move_long_address:
  description: KNX group address for moving the cover full up or down.
  required: false
  type: string
move_short_address:
  description: KNX group address for moving the cover short time up or down. If the KNX device has a stop group address you can use that here.
  required: false
  type: string
position_address:
  description: KNX group address for moving the cover to the dedicated position.
  required: false
  type: string
position_state_address:
  description: Separate KNX group address for requesting the current position of the cover.
  required: false
  type: string
angle_address:
  description: KNX group address for moving the cover to the dedicated angle.
  required: false
  type: string
angle_state_address:
  description: Separate KNX group address for requesting the current angle of cover.
  required: false
  type: string
travelling_time_down:
  description: Time cover needs to travel down in seconds. Needed to calculate the intermediate positions of cover while traveling.
  required: false
  default: 25
  type: integer
travelling_time_up:
  description: Time cover needs to travel up in seconds. Needed to calculate the intermediate positions of cover while traveling.
  required: false
  default: 25
  type: integer
invert_position:
  description: Set this to true if your actuator report fully closed as 100%.
  required: false
  default: false
  type: boolean
invert_angle:
  description: Set this to true if your actuator reports tilt fully closed as 100%.
  required: false
  default: false
  type: boolean
{% endconfiguration %}
