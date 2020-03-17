---
title: "샤오미 공기청정기 및 가습기"
description: "Instructions on how to integrate your Xiaomi Air Purifier and Xiaomi Air Humidifier within Home Assistant."
logo: xiaomi.png
ha_category:
  - Fan
ha_iot_class: Local Polling
ha_release: 0.57
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/vKUJs1IOnTk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The `xiaomi_miio` fan 플랫폼을 사용하면 샤오미 공기 청정기, 공기 가습기와 공기 정화기를 제어 할 수 있습니다.

지원되는 장치:

| Name                | Model                  | Model no. |
| ------------------- | ---------------------- | --------- |
Air Purifier          | zhimi.airpurifier.v1   | |
Air Purifier 2        | zhimi.airpurifier.v2   | FJY4006CN |
Air Purifier V3       | zhimi.airpurifier.v3   | |
Air Purifier V5       | zhimi.airpurifier.v5   | |
Air Purifier Pro      | zhimi.airpurifier.v6   | |
Air Purifier Pro V7   | zhimi.airpurifier.v7   | |
Air Purifier 2 (mini) | zhimi.airpurifier.m1   | |
Air Purifier (mini)   | zhimi.airpurifier.m2   | |
Air Purifier MA1      | zhimi.airpurifier.ma1  | |
Air Purifier 2S       | zhimi.airpurifier.ma2  | |
Air Purifier 2S       | zhimi.airpurifier.mc1  | |
Air Purifier Super    | zhimi.airpurifier.sa1  | |
Air Purifier Super 2  | zhimi.airpurifier.sa2  | |
Air Humidifier        | zhimi.humidifier.v1    | |
Air Humidifier CA1    | zhimi.humidifier.ca1   | |
Air Humidifier CB1    | zhimi.humidifier.cb1   | |
Air Fresh VA2         | zhimi.airfresh.va2     | |


## 제품 사양 (Home Assistant에서 나타나는 entity)

### Air Purifier 2 et al.

- Power (on, off)
- Operation modes (auto, silent, favorite, idle)
- Buzzer (on, off)
- Child lock (on, off)
- LED (on, off), LED brightness (bright, dim, off)
- Favorite Level (0...16)
- Attributes
  - model
  - temperature
  - humidity
  - aqi
  - mode
  - filter_hours_used
  - filter_life_remaining
  - favorite_level
  - child_lock
  - led
  - motor_speed
  - average_aqi
  - purify_volume
  - learn_mode
  - sleep_time
  - sleep_mode_learn_count
  - extra_features
  - turbo_mode_supported
  - auto_detect
  - use_time
  - button_pressed
  - buzzer
  - led_brightness
  - sleep_mode

### Air Purifier Pro (zhimi.airpurifier.v6)

- Power (on, off)
- Operation modes (auto, silent, favorite)
- Child lock (on, off)
- LED (on, off)
- Favorite Level (0...16)
- Attributes
  - model
  - temperature
  - humidity
  - aqi
  - mode
  - filter_hours_used
  - filter_life_remaining
  - favorite_level
  - child_lock
  - led
  - motor_speed
  - average_aqi
  - purify_volume
  - learn_mode
  - sleep_time
  - sleep_mode_learn_count
  - extra_features
  - turbo_mode_supported
  - auto_detect
  - use_time
  - button_pressed
  - filter_rfid_product_id
  - filter_rfid_tag
  - filter_type
  - illuminance
  - motor2_speed
  - volume

### Air Purifier Pro V7 (zhimi.airpurifier.v7)

- Power (on, off)
- Operation modes (auto, silent, favorite)
- Child lock (on, off)
- LED (on, off)
- Favorite Level (0...16)
- Attributes
  - model
  - temperature
  - humidity
  - aqi
  - mode
  - filter_hours_used
  - filter_life_remaining
  - favorite_level
  - child_lock
  - led
  - motor_speed
  - average_aqi
  - learn_mode
  - extra_features
  - turbo_mode_supported
  - button_pressed
  - filter_rfid_product_id
  - filter_rfid_tag
  - filter_type
  - illuminance
  - motor2_speed
  - volume

### Air Purifier 2S (zhimi.airpurifier.mc1)

- Power (on, off)
- Operation modes (auto, silent, favorite)
- Buzzer (on, off)
- Child lock (on, off)
- LED (on, off)
- Favorite Level (0...16)
- Attributes
  - model
  - temperature
  - humidity
  - aqi
  - mode
  - filter_hours_used
  - filter_life_remaining
  - favorite_level
  - child_lock
  - led
  - motor_speed
  - average_aqi
  - learn_mode
  - extra_features
  - turbo_mode_supported
  - button_pressed
  - filter_rfid_product_id
  - filter_rfid_tag
  - filter_type
  - illuminance
  - buzzer

### Air Purifier V3 (zhimi.airpurifier.v3)

- Power (on, off)
- Operation modes (auto, silent, favorite, idle, medium, high, strong)
- Child lock (on, off)
- LED (on, off)
- Attributes
  - model
  - aqi
  - mode
  - led
  - buzzer
  - child_lock
  - illuminance
  - filter_hours_used
  - filter_life_remaining
  - motor_speed
  - average_aqi
  - volume
  - motor2_speed
  - filter_rfid_product_id
  - filter_rfid_tag
  - filter_type
  - purify_volume
  - learn_mode
  - sleep_time
  - sleep_mode_learn_count
  - extra_features
  - auto_detect
  - use_time
  - button_pressed

### Air Humidifier (zhimi.humidifier.v1)

- On, Off
- Operation modes (silent, medium, high, strong)
- Buzzer (on, off)
- Child lock (on, off)
- LED (on, off), LED brightness (bright, dim, off)
- Target humidity (30, 40, 50, 60, 70, 80)
- Attributes
  - model
  - temperature
  - humidity
  - mode
  - buzzer
  - child_lock
  - trans_level
  - target_humidity
  - led_brightness
  - button_pressed
  - use_time
  - hardware_version

### Air Humidifier CA (zhimi.humidifier.ca1)

- On, Off
- Operation modes (silent, medium, high, auto)
- Buzzer (on, off)
- Child lock (on, off)
- LED (on, off), LED brightness (bright, dim, off)
- Target humidity (30, 40, 50, 60, 70, 80)
- Dry mode (on, off)
- Attributes
  - model
  - temperature
  - humidity
  - mode
  - buzzer
  - child_lock
  - trans_level
  - target_humidity
  - led_brightness
  - button_pressed
  - use_time
  - hardware_version
  - motor_speed
  - depth
  - dry

### Air Humidifier CB (zhimi.humidifier.cb1)

- On, Off
- Operation modes (silent, medium, high, auto)
- Buzzer (on, off)
- Child lock (on, off)
- LED (on, off), LED brightness (bright, dim, off)
- Target humidity (30, 40, 50, 60, 70, 80)
- Dry mode (on, off)
- Attributes
  - speed
  - speed_list
  - model
  - temperature
  - humidity
  - mode
  - buzzer
  - child_lock
  - target_humidity
  - led_brightness
  - use_time
  - hardware_version
  - motor_speed
  - depth
  - dry
  - supported_features
 
### Air Fresh VA2

* Power (on, off)
* Operation modes (auto, silent, interval, low, middle, strong)
* Buzzer (on, off)
* Child lock (on, off)
* LED (on, off), LED brightness (bright, dim, off)
* Attributes
  - model
  - aqi
  - average_aqi
  - temperature
  - humidity
  - co2
  - mode
  - led
  - led_brightness
  - buzzer
  - child_lock
  - filter_life_remaining
  - filter_hours_used
  - use_time
  - motor_speed
  - extra_features

API 토큰을 파일 에서 사용하기 위해 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token) 에 대한 지시사항을 따르십시오 `configuration.yaml`.

Xiaomi 공기 청정기를 추가하려면, `configuration.yaml` 에 다음을 추가 하십시오.:

```yaml
fan:
# Example configuration.yaml entry
  - platform: xiaomi_miio
    host: 192.168.130.66
    token: YOUR_TOKEN
```

{% configuration %}
host:
  description: The IP address of your miio fan.
  required: true
  type: string
token:
  description: The API token of your miio fan.
  required: true
  type: string
name:
  description: The name of your miio fan.
  required: false
  type: string
  default: Xiaomi Air Purifier
model:
  description: miio fan의 모델입니다. 해당 기기의 값을 위의 표를 참조하여 찾으세요. ( 예) `zhimi.airpurifier.v2`). 이 설정은 장치 모델 감지를 자동으로 찾는 것을 피하는 데 사용할 수 있으며 장치를 사용할 수없는 경우에 상세설정으로 권장합니다. 
  required: false
  type: string
{% endconfiguration %}

## 플랫폼 서비스

### Service `fan.set_speed`

팬 속도 / 작동 모드를 설정하십시오.

| Service data attribute    | Optional | Description                                                         |
|---------------------------|----------|---------------------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.                         |
| `speed`                   |       no | fan 속도. 유효한 값은 'Auto', 'Silent', 'Favorite'및 'Idle'입니다.    |

### Service `xiaomi_miio.fan_set_buzzer_on` (Air Purifier Pro 제외)

부저를 켭니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_buzzer_off` (Air Purifier Pro 제외)

부저를 끕니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_led_on` (Air Purifiers 만 해당)

LED를 켭니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_led_off` (Air Purifiers 만 해당)

LED를 끕니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_child_lock_on`

아동용 잠금 장치를 켭니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_child_lock_off`

아동용 잠금 장치를 끕니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_led_brightness` (Air Purifier 2S, Air Purifier Pro 제외)

LED 밝기를 설정하십시오. 지원되는 값은 0 (Bright), 1 (Dim), 2 (Off)입니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |
| `brightness`              |       no | 0에서 2 사이의 밝기.                                      |

### Service `xiaomi_miio.fan_set_favorite_level` (Air Purifiers 만 해당)

작동 모드의 즐겨찾기를 단계별 "favorite"로 설정하십시오.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.               |
| `level`                   |       no | 레벨은 0에서 16 사이입니다.                               |

### Service `xiaomi_miio.fan_set_auto_detect_on` (Air Purifier 2S and Air Purifier Pro 만 해당)

자동 감지를 켭니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 	특정 Xiaomi miIO fan entity에서만 작동합니다.            |

### Service `xiaomi_miio.fan_set_auto_detect_off` (Air Purifier 2S and Air Purifier Pro 만 해당)

자동 감지를 끕니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_learn_mode_on` (Air Purifier 2 만 해당)

학습 모드를 켭니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_learn_mode_off` (Air Purifier 2 만 해당)

학습 모드를 끕니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_volume` (Air Purifier Pro 만 해당)

음량을 설정하십시오.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |
| `volume`                  |       no | Volume, between 0 and 100.                              |

### Service `xiaomi_miio.fan_reset_filter` (Air Purifier 2 만 해당)

필터 수명과 사용량을 재설정하십시오.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `xiaomi_miio.fan_set_extra_features` (Air Purifier 만 해당)

추가 기능을 설정하십시오.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |
| `features`                |       no | 정수, 0 과 1 값으로 구분.                                 |

### Service `xiaomi_miio.fan_set_target_humidity` (Air Humidifier 만 해당)

목표 습도를 설정하십시오.

| Service data attribute    | Optional | Description                                                     |
|---------------------------|----------|-----------------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.                     |
| `humidity`                |       no | 목표습도. 설정 허용값은 30, 40, 50, 60, 70 및 80입니다.           |

### Service `fan.xiaomi_miio_set_dry_on` (Air Humidifier CA and CB)

건조 모드를 켭니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |

### Service `fan.xiaomi_miio_set_dry_off` (Air Humidifier CA and CB)

건조 모드를 끄십시오.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO fan entity에서만 작동합니다.             |
