---
title: 샤오미 필립스 조명(Xiaomi Philips Light)
description: "Instructions on how to integrate your Xiaomi Philips Lights within Home Assistant."
logo: philips.png
ha_category:
  - Light
ha_iot_class: Local Polling
ha_release: 0.53
---

`xiaomi_miio` 플랫폼을 사용하면 Xiaomi Philips LED Ball Lamp, Xiaomi Philips Zhirui LED Bulb E14 Candle Lamp, Xiaomi Philips Zhirui Downlight, Xiaomi Philips LED Ceiling Lamp, Xiaomi Philips Eyecare Lamp 2, Xiaomi Philips Moonlight Bedside Lamp, Philips Zhirui Desk Lamp의 상태를 제어할 수 있습니다 

## 제품 특색 

### Philips LED Ball Lamp, Philips Zhirui LED Candle Lamp, Philips Zhirui Downlight

지원 모델 : `philips.light.bulb`, `philips.light.candle`, `philips.light.candle2`, `philips.light.downlight`

* Power (on, off)
* Brightness
* Color temperature (175...333 mireds)
* Scene (1, 2, 3, 4)
* Delayed turn off (Resolution in seconds)
* Attributes
  - model
  - scene
  - delayed_turn_off

### Philips LED Ceiling Lamp

지원 모델 : `philips.light.ceiling`, `philips.light.zyceiling`

* Power (on, off)
* Brightness
* Color temperature (175...370 mireds)
* Scene (1, 2, 3, 4)
* Night light mode (on, off)
* Delayed turn off (Resolution in seconds)
* Attributes
  - model
  - scene
  - delayed_turn_off
  - night_light_mode
  - automatic_color_temperature

### Philips Eyecare Smart Lamp 2

지원 모델 : `philips.light.sread1`

* Eyecare light (on, off)
* Ambient light (on, off)
* Brightness (of each light)
* Scene (1, 2, 3, 4)
* Night light mode (on, off)
* Delayed turn off (Resolution in seconds)
* Eye fatigue reminder / notification (on, off)
* Eyecare mode (on, off)
* Attributes
  - model
  - scene
  - delayed_turn_off
  - night_light_mode
  - reminder
  - eyecare_mode

### Philips Zhirui Desk Lamp

지원 모델 : `philips.light.mono1`

* Power (on, off)
* Brightness
* Scene (1, 2, 3, 4)
* Delayed turn off (Resolution in seconds)
* Attributes
  - model
  - scene
  - delayed_turn_off

### Philips Moonlight Bedside Lamp

지원 모델 : `philips.light.moonlight`

* Power (on, off)
* Brightness
* Color
* Color temperature (153...588 mireds)
* Scene (1, 2, 3, 4, 5, 6)
* Attributes
  - model
  - scene
  - sleep_assistant
  - sleep_off_time
  - total_assistant_sleep_time
  - brand_sleep
  - brand



`configuration.yaml` 파일에서 API 토큰을 사용하려면 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token)의 지침을 따르십시오.

설치시 Xiaomi Philips Light를 추가하려면 configuration.yaml 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entries
light:
  - platform: xiaomi_miio
    name: Xiaomi Philips Smart LED Ball
    host: 192.168.130.67
    token: YOUR_TOKEN
    model: philips.light.bulb
```

{% configuration %}
host:
  description: miio light의 IP 주소.
  required: true
  type: string
token:
  description: miio light의 API 토큰.
  required: true
  type: string
name:
  description: miio light의 이름. 
  required: false
  type: string
  default: Xiaomi Philips Light
model:
  description: 조명의 이름. 유효한 값들은 `philips.light.sread1`, `philips.light.ceiling`, `philips.light.zyceiling`, `philips.light.moonlight`, `philips.light.bulb`, `philips.light.candle`, `philips.light.candle2`, `philips.light.mono1`, `philips.light.downlight`. 이 설정은 장치 모델 감지를 우회하는데 사용할 수 있으며 장치를 제대로 사용할 수 없는 경우 권장됩니다.
  required: false
  type: string
{% endconfiguration %}

## 플랫폼 서비스

### `xiaomi_miio.light_set_scene` 서비스

사용 가능한 4 가지 고정 씬(scenes) 중 하나를 설정하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.      |
| `scene`                   |       no | Scene, between 1 and 4.                               |

### `xiaomi_miio.light_set_delayed_turn_off` 서비스

지연 끄기.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.      |
| `time_period`             |       no | 지연된 꺼짐 시간.                 |

### `xiaomi_miio.light_reminder_on` (Eyecare Smart Lamp 2 only) 서비스

눈의 피로 알림(reminder)/통지(notification) 활성화

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.      |

### `xiaomi_miio.light_reminder_off` (Eyecare Smart Lamp 2 only) 서비스

눈의 피로 알림(reminder)/통지(notification) 비활성화. 

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.      |

### `xiaomi_miio.light_night_light_mode_on`  (Eyecare Smart Lamp 2 only) 서비스 

스마트 야간 조명 모드를 켭니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.      |

### `xiaomi_miio.light_night_light_mode_off`  (Eyecare Smart Lamp 2 only) 서비스

스마트 야간 조명 모드를 끕니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.      |

### `xiaomi_miio.light_eyecare_mode_on`  (Eyecare Smart Lamp 2 only) 서비스

아이(eye) 케어 모드를 켜십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.      |

### `xiaomi_miio.light_eyecare_mode_off`  (Eyecare Smart Lamp 2 only) 서비스

아이(eye) 케어 모드를 끄십시오. 

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 조명 엔티티에서만 작동.        |
