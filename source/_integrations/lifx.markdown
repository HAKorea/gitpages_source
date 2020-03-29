---
title: LIFX
description: Instructions on how to integrate LIFX into Home Assistant.
logo: lifx.png
ha_category:
  - Light
ha_iot_class: Local Polling
ha_release: 0.81
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/TXjSIOPo9LU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`lifx` 통합구성요소를 통해 [LIFX](https://www.lifx.com)를 Home Assistant에 연동할 수 있습니다.

_lifx 통합은 Windows를 지원하지 않습니다. `lifx_legacy` 라이트 플랫폼 (기본 기능 지원)을 대신 사용할 수 있습니다 ._

설정 패널 내부의 **통합구성요소 페이지**로 이동하여 LIFX 연동을 설정할 수 있습니다.

## Set state

LIFX 전구는 꺼져 있어도 색상과 밝기를 변경할 수 있습니다. 이렇게하면 낮 동안 조명을 제어하여 동작 탐지기나 외부 버튼 등을 켜는 이벤트가 수신될 때 설정이 정확히 반영됩니다.

정상적인 `light.turn_on` 호출은 항상 전원을 켜기 때문에 사용할 수 없습니다. 따라서 LIFX에는 현재 전원 상태에 영향을 주지 않고 색상을 변경할 수 있는 자체 서비스 호출이 있습니다.

### `lifx.set_state` 서비스

조명을 새로운 상태로 변경하십시오.

| Service data attribute | Description |
| ---------------------- | ----------- |
| `entity_id` | String or list of strings that point at `entity_id`s of lights. Else targets all.
| `transition` | Duration (in seconds) for the light to fade to the new state.
| `zones` | List of integers for the zone numbers to affect (each LIFX Z strip has 8 zones, starting at 0).
| `infrared` | Automatic infrared level (0..255) when light brightness is low (for compatible bulbs).
| `power` | Turn the light on (`True`) or off (`False`). Leave out to keep the power as it is.
| `...` | Use `color_name`, `brightness` etc. from [`light.turn_on`]({{site_root}}/integrations/light/#service-lightturn_on) to specify the new state.

## 조명 효과

LIFX 플랫폼은 여러 가지 조명 효과를 지원합니다. 일반 [`light.turn_on`]({{site_root}}/integrations/light/#service-lightturn_on) 서비스의 `effect` 속성을 사용하여 기본 옵션으로 이러한 효과를 시작할 수 있습니다. 예를 들면 다음과 같습니다.
```yaml
automation:
  - alias: ...
    trigger:
      # ...
    action:
      - service: light.turn_on
        data:
          entity_id: light.office, light.kitchen
          effect: lifx_effect_pulse
```

그러나 조명 효과를 완전히 제어하려면 다음과 같이 전용 서비스 요청을 사용해야합니다.
```yaml
script:
  colorloop_start:
    alias: 'Start colorloop'
    sequence:
      - service: lifx.effect_colorloop
        data:
          entity_id: group.livingroom
          brightness: 255
          period: 10
          spread: 30
          change: 35
```

사용 가능한 조명 효과 및 옵션은 다음과 같습니다.

### `lifx.effect_pulse` 서비스

색상을 변경한 다음 다시 플래시 효과를 실행하십시오.

| Service data attribute | Description |
| ---------------------- | ----------- |
| `entity_id` | String or list of strings that point at `entity_id`s of lights. Else targets all.
| `color_name` | A color name such as `red` or `green`.
| `rgb_color` | A list containing three integers representing the RGB color you want the light to be.
| `brightness` | Integer between 0 and 255 for how bright the color should be.
| `period` | The duration of a single pulse (in seconds).
| `cycles` | The total number of pulses.
| `mode` | The way to change between colors. Valid modes: `blink` (default - direct transition to new color for 'period' time with original color between cycles), `breathe` (color fade transition to new color and back to original), `ping` (short pulse of new color), `strobe` (light turns off between color changes), `solid`(light does not return to original color between cycles).
| `power_on` | Set this to False to skip the effect on lights that are turned off (defaults to True).

### `lifx.effect_colorloop` 서비스

color wheel 주변으로 색상이 반복되는 효과를 실행합니다. 모든 여기 참가한 라이트는 유사한 (완전히 일치하지 않지만) 색상을 유지하도록 조정됩니다.

| Service data attribute | Description |
| ---------------------- | ----------- |
| `entity_id` | String or list of strings that point at `entity_id`s of lights. Else targets all.
| `brightness` | Number between 0 and 255 indicating brightness of the effect. Leave this out to maintain the current brightness of each participating light.
| `period` | Duration (in seconds) between starting a new color change.
| `transition` | Duration (in seconds) where lights are actively changing color.
| `change` | Hue movement per period, in degrees on a color wheel (ranges from 0 to 359).
| `spread` | Maximum color difference between participating lights, in degrees on a color wheel (ranges from 0 to 359).
| `power_on` | Set this to False to skip the effect on lights that are turned off (defaults to True).

### `lifx.effect_stop` 서비스

아무 것도하지 않는 효과를 실행하면 실행중인 다른 효과가 중지됩니다.

| Service data attribute | Description |
| ---------------------- | ----------- |
| `entity_id` | String or list of strings that point at `entity_id`s of lights. Else targets all.


## 고급 설정

사용 가능한 일부 수동 설정 옵션이 있습니다. 자동 설정에서 LIFX 장치를 찾지 못하는 비정상적인 네트워크 설정에서만 필요합니다.

```yaml
# Example configuration.yaml entry
lifx:
  light:
    - server: IP_ADDRESS
      port: 56700
      broadcast: IP_ADDRESS
```

{% configuration %}
server:
  description: Your server address. Will listen on all interfaces if omitted.
  required: false
  type: string
port:
  description: The UDP port for discovery. Will listen on a random port if omitted.
  required: false
  type: integer
broadcast:
  description: The broadcast address for discovering lights. Can also set this to the IP address of a bulb to skip discovery.
  required: false
  type: string
{% endconfiguration %}
