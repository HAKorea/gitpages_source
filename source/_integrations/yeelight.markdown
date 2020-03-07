---
title: 샤오미 Yeelight
description: Instructions on how to setup Yeelight Wifi devices within Home Assistant.
logo: yeelight.png
ha_category:
  - Light
ha_release: 0.32
ha_iot_class: Local Polling
ha_codeowners:
  - '@rytilahti'
  - '@zewelor'
---

`yeelight` 통합구성요소로 Home Assistant를 사용하여 Yeelight Wifi 전구를 제어할 수 있습니다. Yeelight 설정 방법에는 수동 또는 자동의 두 가지 방법이 있습니다.

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- **Light** - 조명을 지원하기위한 yeelight 플랫폼.
- **Sensor** - 센서 지원을 위한 yeelight 플랫폼. 천장 조명용으로 현재 야간 모드 센서만 있습니다.

### 설정 사례 (자동)
조명이 WiFi 네트워크에 연결되고 홈 어시스턴트에서 감지 된 후, 발견 된 이름은 `Overview` 보기의 `Light` 섹션에 표시됩니다. `customize.yaml` 파일에 다음을 추가하십시오. 

```yaml
# Example customize.yaml entry
light.yeelight_color1_XXXXXXXXXXXX:
  friendly_name: Living Room
light.yeelight_color2_XXXXXXXXXXXX:
  friendly_name: Downstairs Toilet
```

### 설정 사례 (수동)

이러한 표시등을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오. :

```yaml
# Example configuration.yaml entry
discovery:
  ignore:
    - yeelight
yeelight:
  devices:
    192.168.1.25:
      name: Living Room
```

{% configuration %}
devices:
  required: true
  description: Yeelight 장치 목록.
  type: map
  keys:
    ip:
      description: 전구의 IP 주소.
      required: true
      type: map
      keys:
        name:
          description: 장치의 친숙한 이름.
          required: false
          type: string
        transition:
          description: 시간에 따른 부드러운 전환 (ms).
          required: false
          type: integer
          default: 350
        use_music_mode:
          description: 음악 모드 활성화.
          required: false
          type: boolean
          default: false
        save_on_change:
          description: Home Assistant에서 전구 상태를 변경하면 비휘발성 메모리에 전구 상태를 저장합니다.
          required: false
          type: boolean
          default: false
        nightlight_switch_type:
          description: 야간 모드를 제어하기 위해 다른 엔티티를 추가합니다 (지원하는 모델의 경우). 현재는 `light` 만 지원됩니다. 일반조명 모드용과 야간조명 모드용으로 각각 2 개의 조명 개체를 만듭니다.
          required: false
          type: string
        model:
          description: "Yeelight 모델. 가능한 값은 `mono1`,`color1`,`color2`,`strip1`,`bslamp1`,`ceiling1`,`ceiling2`,`ceiling3`,`ceiling4` 입니다. 이 설정은 모델별 기능을 활성화하는 데 사용됩니다. 예: 특정 색온도 범위"
          required: false
          type: string
custom_effects:
  description: 추가할 사용자 정의 효과 목록. 아래 예를 확인하십시오
  required: false
  type: map
  keys:
    name:
      description: 효과의 이름.
      required: true
      type: string
    flow_params:
       description: 효과를위한 Flow params.
       required: true
       type: map
       keys:
         count:
           description: 이 flow를 실행하는 횟수 (영원히 실행하려면 0).
           required: false
           type: integer
           default: 0
         transitions:
           description: 해당 효과에 대한 전환 목록은 [example](#custom-effects)를 확인하십시오 .
           required: true
           type: list
{% endconfiguration %}

#### 음악 모드  

Per default the bulb limits the amount of requests per minute to 60, a limitation which can be bypassed by enabling the music mode. In music mode the bulb is commanded to connect back to a socket provided by the integration and it tries to keep the connection open, which may not be wanted in all use-cases.
기본적으로 전구는 분당 요청 수를 60 개로 제한합니다. 이정도 제한은 음악 모드 활성화시 무시할 수 있습니다. 음악 모드에서 전구는 통합구성요소에서 제공하는 소켓에 다시 연결하라는 명령을 받고 연결을 열린 상태로 유지하려고 시도하지만 모든 사용 사례에서 원치 않을 수 있습니다.
**Also note that bulbs in music mode will not update their state to "unavailable" if they are disconnected, which can cause delays in Home Assistant. Bulbs in music mode may also not react to commands from Home Assistant the first time if the connection is dropped. If you experience this issue, turn the light off and back on again in the frontend and everything will return to normal.**
**또한 음악 모드의 전구는 연결이 끊어지면 상태를 "사용할 수 없음"으로 업데이트하지 않으므로 Home Assistant에서 지연이 발생할 수 있습니다. 연결이 끊어지면 음악 모드의 전구도 홈어시스턴트의 명령에 반응하지 않을 수 있습니다. 이 문제가 발생하면 프런트 엔드에서 표시등을 껐다가 다시 켜면 모든 것이 정상으로 돌아옵니다.** 

### 초기 셋업 

<div class='note'>

Home Assistant를 통해 조명을 제어하기 전에 Yeelight 앱([Android](https://play.google.com/store/apps/details?id=com.yeelight.cherry&hl=fr), [IOS](https://itunes.apple.com/us/app/yeelight/id977125608?mt=8) )을 사용하여 전구를 설정해야합니다. 
벌브 속성에서 "LAN Control"(이전의 "개발자 모드")을 활성화해야합니다. LAN Control은 전구에 최신 펌웨어가 설치된 경우에만 사용할 수 있습니다. 전구를 연결 한 후 응용 프로그램에서 펌웨어를 업데이트 할 수 있습니다. 
전구 IP를 확인하십시오 (라우터, 소프트웨어, 핑 사용).
"LAN Control"를 활성화하는 방법에 대한 정보는 [here](https://www.yeelight.com/faqs/lan_control)에서 찾을 수 있습니다.

</div>

### 지원 모델

<div class='note warning'>
이 통합구성요소는 다음 모델에서 작동하도록 테스트되었습니다. 다른 모델이 있고 작동중인 경우 알려주십시오.
</div>

| Model ID   | Model number | Product name                                     |
|------------|--------------|--------------------------------------------------|
| `mono1`    | YLDP01YL     | LED Bulb (White)                                 |
| ?          | YLDP05YL     | LED Bulb (White) - 2nd generation                |
| `color1`   | YLDP02YL     | LED Bulb (Color)                                 |
| `color1`   | YLDP03YL     | LED Bulb (Color) - E26                           |
| `color2`   | YLDP06YL     | LED Bulb (Color) - 2nd generation                |
| `strip1`   | YLDD01YL     | Lightstrip (Color)                               |
| `strip1`   | YLDD02YL     | Lightstrip (Color)                               |
| ?          | YLDD04YL     | Lightstrip (Color)
| `bslamp1`  | MJCTD01YL    | Xiaomi Mijia Bedside Lamp - WIFI Version!        |
| `bslamp1`  | MJCTD02YL    | Xiaomi Mijia Bedside Lamp II                     |
| `RGBW`     | MJDP02YL     | Mi Led smart Lamp - white and color WIFI Version |
| `lamp1`    | MJTD01YL     | Xiaomi Mijia Smart LED Desk Lamp (autodiscovery isn't possible because the device doesn't support mDNS due to the small amount of RAM) |
| `ceiling1` | YLXD01YL     | Yeelight Ceiling Light                           |
| `ceiling2` | YLXD03YL     | Yeelight Ceiling Light - Youth Version           |
| ?, may be `ceiling3` | YLXD04YL     | Yeelight Ceiling Light (Jiaoyue 450)   |
| `ceiling3` | YLXD05YL     | Yeelight Ceiling Light (Jiaoyue 480)             |
| `ceiling4` | YLXD02YL     | Yeelight Ceiling Light (Jiaoyue 650)             |
| `mono`     | YLTD03YL     | Yeelight Serene Eye-Friendly Desk Lamp           |

## 플랫폼 서비스

### `yeelight.set_mode` 서비스

작동 모드를 설정하십시오.

| Service data attribute    | Optional | Description                                                                                 |
|---------------------------|----------|---------------------------------------------------------------------------------------------|
| `entity_id`               |       no | 특정 조명에서만 작동 lights.                                                              |
| `mode`                    |       no | 작동 모드. 유효한 값은 'last', 'normal', 'rgb', 'hsv', 'color_flow', 'moonlight'. |

### `yeelight.start_flow` 서비스

특정 transition으로 flow 시작

| Service data attribute    | Optional | Description                                                                                 |
|---------------------------|----------|---------------------------------------------------------------------------------------------|
| `entity_id`               |       no | 특정 조명에서만 작동 lights.                                                              |
| `count`                   |      yes | 이 flow을 실행하는 횟수 (영원히 실행하려면 0).                                    |
| `action`                  |      yes | flow가 중지된 후 수행할 액션. 예: 'recover', 'stay', 'off'. 기본: 'recover' |
| `transitions`             |       no | transitions 배열. [examples below](#custom-effects) 참조.                                |

### `yeelight.set_color_scene` 서비스

조명을 지정된 RGB 색상 및 밝기로 변경합니다. 조명이 꺼져 있으면 켜집니다.

| Service data attribute    | Optional | Description                                                                                 |
|---------------------------|----------|---------------------------------------------------------------------------------------------|
| `entity_id`               |       no | 특정 조명에서만 작동 lights.                                                              |
| `rgb_color`               |       no | 조명하려는 RGB 색상을 나타내는 0에서 255 사이의 3 개의 정수를 포함하는 목록입니다. 대괄호 안에 RGB로 색상을 나타내는 세 개의 쉼표로 구분 된 정수.|
| `brightness`              |       no | 설정할 밝기 값 (1-100)..                                                        |

### `yeelight.set_hsv_scene` 서비스

조명을 지정된 HSV 색상 및 밝기로 변경합니다. 조명이 꺼져 있으면 켜집니다.

| Service data attribute    | Optional | Description                                                                                 |
|---------------------------|----------|---------------------------------------------------------------------------------------------|
| `entity_id`               |       no | 특정 조명에서만 작동 lights.                                                              |
| `hs_color`                |       no | 빛의 색조(hue)와 채도(saturation)를 나타내는 두 개의 부동 소수점을 포함하는 목록입니다. 색조는 0-360으로 조정되고 채도는 0-100으로 조정됩니다.    |
| `brightness`              |       no | 설정할 밝기 값 (1-100).                                                        |

### `yeelight.set_color_temp_scene` 서비스

조명을 지정된 색온도로 변경합니다. 조명이 꺼져 있으면 켜집니다

| Service data attribute    | Optional | Description                                                                                 |
|---------------------------|----------|---------------------------------------------------------------------------------------------|
| `entity_id`               |       no | 특정 조명에서만 작동                                                               |
| `kelvin`                  |       no | 캘빈 온도                                                                |
| `brightness`              |       no | 설정할 밝기 값 (1-100)..                                                        |

### `yeelight.set_color_flow_scene` 서비스

색상 flow을 시작합니다. 이 서비스와 [yeelight.start_flow](# service-yeelightstart_flow)의 차이점에 따라 이 서비스 호출은 다른 Yeelight API 호출을 사용합니다. 조명이 꺼져 있으면 켜집니다. 복잡한 flow 처리 등에는 펌웨어 차이가 있을 수 있습니다.

| Service data attribute    | Optional | Description                                                                                 |
|---------------------------|----------|---------------------------------------------------------------------------------------------|
| `entity_id`               |       no | 특정 조명에서만 작동.                                                              |
| `count`                   |      yes | 이 flow를 실행하는 횟수입니다 (영원히 실행하려면 0)..                                    |
| `action`                  |      yes | flow가 중지된 후 수행 할 액션. 예: 'recover', 'stay', 'off'. 기본값 'recover' |
| `transitions`             |       no | transitions 배열. [아래 예시](#custom-effects) .                                |

### `yeelight.set_auto_delay_off_scene` 서비스

지정된 밝기로 조명을 켜고 지정된 시간(분)후에 다시 끄도록 타이머를 설정합니다. 조명이 꺼져 있으면 켜집니다.

| Service data attribute    | Optional | Description                                                                                 |
|---------------------------|----------|---------------------------------------------------------------------------------------------|
| `entity_id`               |       no | 특정 조명에서만 작동                                                              |
| `minutes`                 |       no | 조명을 자동으로 끄기 전에 대기하는 시간입니다.                             |
| `brightness`              |       no | 설정할 밝기 값 (1-100)..                                                        |

## 예시

이 섹션에서는이 조명을 사용하는 방법에 대한 실제 예제를 제공합니다.

### 전체 설정 

이 예는 선택적 설정 옵션을 사용하는 방법을 보여줍니다.

```yaml
# Example configuration.yaml entry
yeelight:
  devices:
    192.168.1.25:
      name: Living Room
      transition: 1000
      use_music_mode: true
      save_on_change: true
```

### 여러 개의 전구 

이 예는 설정에 여러 벌브를 추가하는 방법을 보여줍니다.

```yaml
yeelight:
  devices:
    192.168.1.25:
      name: Living Room
    192.168.1.13:
      name: Front Door
```

### 커스텀 효과

이 예제는 설정에서 사용자 정의 효과를 추가하는 방법을 보여줍니다. 효과를 켜려면 [light.turn_on](/integrations/light/#service-lightturn_on) 서비스를 사용할 수 있습니다 .

`RGBTransition`, `HSVTransition`, `TemperatureTransition`, `SleepTransition`이 가능한 트랜지션입이다.

배열 값은 다음과 같습니다. : 
- RGBTransition : [빨강, 녹색, 파랑, 지속 시간, 밝기], 빨강 / 녹색 / 파랑이 0에서 255 사이의 정수이고, 지속 시간은 밀리 초 (최소 50)이고 최종 밝기는 0-100 (%)으로 전환됩니다.
- HSV 전환 : [hue, saturation, duration, brightness] 색조는 0에서 359 사이의 정수, 채도 0 -100, 밀리 초 단위의 지속 시간 (최소 50) 및 최종 밝기 0-100 (%)
- 온도 전환 : 온도가 1700에서 6500 사이의 최종 색 온도, 밀리 초 단위의 지속 시간 (최소 50) 및 0-100 (%)으로 전환하기위한 최종 밝기와 함께 [온도, 지속 시간, 밝기]
- SleepTransition : 효과 시간 (밀리 초) 동안 지속 시간이 정수인 [duration] (최소 50)

전환 및 예상되는 매개 변수에 대한 자세한 내용은 [python-yeelight documentation](https://yeelight.readthedocs.io/en/stable/flow.html) 설명서를 참조하십시오.

```yaml
yeelight:
  devices:
    192.168.1.25:
      name: Living Room
  custom_effects:
    - name: 'Fire Flicker'
      flow_params:
        count: 0
        transitions:
          - TemperatureTransition: [1900, 1000, 80]
          - TemperatureTransition: [1900, 2000, 60]
          - SleepTransition:       [1000]
```
