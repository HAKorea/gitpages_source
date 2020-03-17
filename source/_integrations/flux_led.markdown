---
title: 플럭스LED/매직라이트(Flux LED/MagicLight)
description: Instructions on how to setup Flux led/MagicLight within Home Assistant.
logo: magic_light.png
ha_category:
  - Light
ha_iot_class: Local Polling
ha_release: 0.25
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/EqZtinzD6yM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`flux_led`는 라이트 플랫폼으로서 홈어시스턴트에 연동됩니다. 전구와 컨트롤러의 여러 브랜드는 동일한 프로토콜을 사용하며 HF-LPB100 칩셋을 공통으로 사용합니다. MagicHome 앱으로 장치를 제어 할 수 있으면 전구나 컨트롤러 (예: WiFi LED 컨트롤러)가 작동 할 가능성이 높습니다.
전구의 예:

*Note* : 해당 제품들의 일부 Wifi 제품들은 [ESPHOME](https://hakorea.github.io/integrations/esphome/), [TASMOTA](https://tasmota.github.io/docs/#/installation/)와 같은 방식으로 변환하여 좀 더 다양한 기능을 활용할 수 있습니다. 

- [Flux Smart Lighting](https://www.fluxsmartlighting.com/)
- [Flux WiFi Smart LED Light Bulb4](https://amzn.to/2X0dVwu)
- [WIFI smart LED light Bulb1](https://amzn.to/2J2fksr)

컨트롤러의 예:

- [Ledenet WiFi RGBW Controller](https://amzn.to/2WZKXNa)
- [SUPERNIGHT WiFi Wireless LED Smart Controller](https://amzn.to/2WURx7w)


### 상세 설정

이러한 조명을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: flux_led
```

{% configuration %}
automatic_add:
  description: To enable the automatic addition of lights on startup.
  required: false
  default: false
  type: boolean
devices:
  description: A list of devices with their IP address.
  required: false
  type: list
  keys:
    name:
      description: A friendly name for the device.
      required: false
      type: string
    mode:
      description: "The chosen brightness mode, options are: `rgbw`, `rgb` and `w`."
      required: false
      default: rgbw
      type: string
    protocol:
      description: Set this to `ledenet` if you are using a ledenet bulb.
      required: false
      type: string
    custom_effect:
      description: A definition of the custom effect.
      required: false
      type: map
      keys:
        colors:
          description: A list of 1 to 16 colors, used in the effect loop (see example below). Defined as three comma-separated integers between 0 and 255 that represent the color in RGB. There is no way to set brightness, but you can define lower RGB values to simulate lower brightness. E.g., if you want 50% red, define it as `[127,0,0]` instead of `[255,0,0]`.
          required: true
          type: list
        speed_pct:
          description: A speed in percents (100 being the fastest), at which controller will transition between the colors.
          required: false
          type: integer
          default: 50
        transition:
          description: "A type of transition, which will be used to transition between the colors. Supported values are: `gradual`, `jump` and `strobe`."
          required: false
          type: string
          default: gradual
{% endconfiguration %}

<div class='note'>

컨트롤러 또는 전구 유형에 따라 밝기를 설정하는 두 가지 방법이 있습니다. 
통합구성요소의 기본값은 rgbw입니다. 장치에 별도의 흰색 채널이 있는 경우 다른 것을 지정할 필요가 없습니다. 흰색값을 변경하면 RGB 색상을 일정하게 유지하면서 흰색 채널의 밝기가 조정됩니다. 그러나 장치에 별도의 흰색 채널이 없는 경우 모드를 rgb로 설정해야합니다. 이 모드에서 장치는 동일한 색상을 유지하고 RGB 값을 조정하여 색상을 어둡게하거나 밝게합니다.

</div>


### 설정 예시

Will automatically search and add all lights on start up:
시작시 모든 조명을 자동으로 검색하고 추가합니다.

```yaml
# Example configuration.yaml entry
light:
  - platform: flux_led
    automatic_add: true
```

주어진 이름으로 두 개의 조명을 추가하고 45 초마다 무작위로 색상을 설정하는 자동화 규칙을 만듭니다.

```yaml
light:
# Example configuration.yaml entry
  - platform: flux_led
    devices:
      192.168.0.106:
        name: flux_lamppost
      192.168.0.109:
        name: flux_living_room_lamp

automation:
  alias: random_flux_living_room_lamp
  trigger:
    platform: time_pattern
    seconds: '/45'
  action:
    service: light.turn_on
    data:
      entity_id: light.flux_living_room_lamp
      effect: random
```

white 모드없이 조명을 추가합니다 :

```yaml
    192.168.1.10:
      name: NAME
      mode: "rgb"
```

rgb + white 모드로 조명을 추가합니다 (기본값). 슬라이더와 색상 선택기를 사용하여 흰색 및 RGB 채널을 독립적으로 조정할 수 있습니다.

```yaml
    192.168.1.10:
      name: NAME
      mode: "rgbw"
```

white 모드의 조명만 추가합니다. W 채널만 RGBW 컨트롤러에 연결되어 있고 밝기 값을 통해 화이트 레벨을 제어할 수있는 경우에 유용합니다.

```yaml
    192.168.1.10:
      name: NAME
      mode: "w"
```

Ledenet RGBW 컨트롤러와 같은 일부 장치는 밝기를 각 색상 채널에 전달하기 위해 약간 다른 프로토콜을 사용합니다. 장치가 켜지거나 꺼지고 색상이나 밝기가 변하지 않는 경우 LEDENET 프로토콜을 추가하십시오.

```yaml
light:
  - platform: flux_led
    devices:
      192.168.1.10:
        name: NAME
        protocol: 'ledenet'
```

### 효과

Flux Led 조명은 다른 조명 패키지에 포함되지 않은 많은 효과를 제공합니다. 이것들을 프론트 엔드에서 선택하거나 `light.turn_on` 명령의 효과 필드로 보낼 수 있습니다.

| Effect Name                                                                                                  | Description                                                        |
|--------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| `colorloop`                                                                                                  | Smoothly transitions through the rainbow.                          |
| `colorjump`                                                                                                  | Jumps through seven different rainbow colors.                      |
| `colorstrobe`                                                                                                | Strobes each rainbow color in a loop.                              |
| `red_fade`, `green_fade`, `blue_fade`, `yellow_fade`, `cyan_fade`, `purple_fade`, `white_fade`               | Fades between the color as indicated in the effect name and black. |
| `rg_cross_fade`                                                                                              | Fades between red and green.                                       |
| `rb_cross_fade`                                                                                              | Fades between red and blue.                                        |
| `gb_cross_fade`                                                                                              | Fades between green and blue.                                      |
| `red_strobe`, `green_strobe`, `blue_strobe`, `yellow_strobe`, `cyan_strobe`, `purple_strobe`, `white_strobe` | Strobes the color indicated by the effect name.                    |
| `random`                                                                                                     | Chooses a random color by selecting random values for R, G, and B. |
| `custom`                                                                                                     | Custom effect (if defined, see below).                             |

사용자는 자신만의 효과를 정의할 수 있습니다. 1 ~ 16 개의 색상 목록, 속도 및 전환 유형의 세 가지 매개 변수로 구성됩니다. 컨트롤러는 전환 및 속도가 세분화된 루프에서 색상을 변경할 수 있습니다. 다음은 루프에서 빨강, 노랑, 녹색, 시안, 파랑, 마젠타가 빠르게 깜박이는 사용자 정의 효과의 예입니다.

```yaml
light:
  - platform: flux_led
    devices:
      192.168.1.10:
        custom_effect:
          speed_pct: 100
          transition: 'strobe'
          colors:
            - [255,0,0]
            - [255,255,0]
            - [0,255,0]
            - [0,255,255]
            - [0,0,255]
            - [255,0,255]
```
