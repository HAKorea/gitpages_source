---
title: 조명(Light)
description: Instructions on how to setup your lights with Home Assistant.
logo: home-assistant.png
ha_category:
  - Light
ha_release: pre 0.7
ha_quality_scale: internal
---

이 통합구성요소로 다양한 조명을 추적하고 제어 할 수 있습니다. 특정 조명 하드웨어에 대한 설명서를 읽고 이를 활성화하는 방법을 배우십시오.

### 기본 켜기 값 (Default turn-on values)

조명이 켜질 때 기본 색상 및 밝기 값을 설정하려면 사용자정의 light_profiles.csv를 만드십시오. (
`light.turn_on`의 `profile` 속성에서 아래에 설명 된대로)

`.default` 접미사는 각 조명의 엔티티 식별자에 추가되어 기본값을 정의해야합니다 (예 : `light.ceiling_2`의 `id` 필드는`light.ceiling_2.default`입니다). 모든 조명의 기본값을 정의하기 위해 식별자 `group.all_lights.default`를 사용할 수 있습니다. 개별 설정은 항상 `all_lights` 기본 설정보다 우선합니다.

### `light.turn_on` 서비스

[groups]({{site_root}}/integrations/group/)를 사용하여 하나의 조명을 켜거나 여러 개의 조명을 켭니다.

대부분의 라이트는 모든 속성을 지원하지는 않습니다. 특정 조명의 통합구성요소 문서에서 힌트를 확인할 수 있지만 일반적으로 문제를 해결하고 작동하는 것을 확인해야합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | `entity_id`의 조명을 가리키는 문자열 또는 문자열 목록. 모든 조명을 대상으로하려면 `entity_id`로 모두 사용하십시오.
| `transition` | yes | 조명이 새 상태로 전환되는 데 걸리는 시간 (초)을 나타내는 숫자입니다.
| `profile` | yes | [내장 프로파일](https://github.com/home-assistant/home-assistant/blob/master/homeassistant/components/light/light_profiles.csv) 중 하나의 이름을 가진 문자열 (휴식, 활력, 집중력, 읽기) 이거나 현재 작업 디렉토리의 `light_profiles.csv`에 정의 된 사용자 정의 프로파일 중 하나입니다. 조명 프로파일은 xy 색상과 밝기를 정의합니다. 프로파일이 제공되고 밝기가 설정되면 프로파일 밝기를 덮어 씁니다.
| `hs_color` | yes | 빛의 색조와 채도를 나타내는 두 개의 floats을 포함하는 목록입니다. 색조는 0-360으로 조정되고 채도는 0-100으로 조정됩니다.
| `xy_color` | yes | 빛을 원하는 xy 색상을 나타내는 두 개의 floats을 포함하는 목록입니다. XY의 색상을 나타내는 두 개의 쉼표로 구분 된 floats. 색조 차트는 다음에서 훌륭한 차트를 찾을 수 있습니다. : [Hue Color Chart](https://developers.meethue.com/documentation/core-concepts#color_gets_more_complicated). 
| `rgb_color` | yes |  조명의 RGB 색상을 나타내는 0에서 255 사이의 3 개의 정수를 포함하는 목록입니다. 대괄호 안에 RGB로 색상을 나타내는 세 개의 쉼표로 구분 된 정수. 지정된 RGB 값은 조명의 밝기를 변경하지 않고 색상 만 변경합니다.
| `white_value` | yes | 전용 백색 LED의 밝기를 나타내는 0에서 255 사이의 정수입니다.
| `color_temp` | yes | 빛의 색 온도를 나타내는 mireds의 정수입니다.
| `kelvin` | yes | 또는 색 온도를 켈빈으로 지정할 수 있습니다.
| `color_name` | yes | 색 이름의 사람이 읽을 수 있는 문자열 색상 이름, `blue` 또는 `goldenrod`. [CSS3 color names](https://www.w3.org/TR/css-color-3/#svg-color) 지원. 
| `brightness` | yes | 조명의 밝기를 나타내는 0에서 255 사이의 정수입니다. 여기서 0은 조명이 꺼져 있음을 의미하고 1은 최소 밝기이고 255는 조명이 지원하는 최대 밝기입니다.
| `brightness_pct`| yes | 또는 밝기를 백분율 (0과 100 사이의 숫자)로 지정할 수 있습니다. 여기서 0은 조명이 꺼져 있음을 의미하고 1은 최소 밝기이고 100은 조명이 지원하는 최대 밝기입니다.
| `flash` | yes | 빛이 깜박이도록 합니다. `short` 혹은 `long`.
| `effect`| yes | 효과를 적용합니다.  `colorloop` 혹은 `random`.

<div class='note'>

엔터티에 속성을 적용 하려면, 설정에 `data:`룰 추가해야 합니다. 아래 예를 참조하십시오

</div>

```yaml
# Example configuration.yaml entry
automation:
- id: one
  alias: Turn on light when motion is detected
  trigger:
    - platform: state
      entity_id: binary_sensor.motion_1
      to: 'on'
  action:
    - service: light.turn_on
      data:
        entity_id: light.living_room
        brightness: 255
        kelvin: 2700
```
```yaml
# Ledlist morning on, red
- id: llmor
  alias: Stair morning on
  trigger:
  - at: '05:00'
    platform: time
  action:
    - service: light.turn_on
      data:
        entity_id: light.ledliststair
        brightness: 130
        rgb_color: [255,0,0]
```

### `light.turn_off` 서비스

하나 또는 여러 개의 조명을 끕니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | 조명의 `entity_id`를 가리키는 문자열 또는 문자열 목록. 모든 라이트를 대상으로하려면 모두 `entity_id`로 사용하십시오  
| `transition` | yes | 조명이 새 상태로 전환하는 데 걸리는 시간을 초 단위로 나타내는 정수입니다.

### `light.toggle` 서비스

여러개의 조명 [groups]({{site_root}}/integrations/group/)혹은 하나 이상의 조명 상태를 토글합니다. [`turn_on`](#service-lightturn_on)서비스와 동일한 인수를 취합니다.

*참고* : `light.toggle`이 조명 그룹에 사용되는 경우, 각 조명의 개별 상태를 전환합니다