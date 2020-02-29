---
title: "샤오미 Smart WiFi Socket and Smart Power Strip"
description: "Instructions on how to integrate your Xiaomi Smart WiFi Socket aka Plug or Xiaomi Smart Power Strip within Home Assistant."
logo: xiaomi.png
ha_category:
  - Switch
ha_iot_class: Local Polling
ha_release: 0.56
---

`xiaomi_miio` 스위치 플랫폼은 플러그 일명 샤오미 스마트 와이파이 소켓, 샤오미 스마트 파워 스트립과 샤오미 Chuangmi 플러그 V1의 상태를 제어할 수 있습니다.

`configuration.yaml` 파일에서 사용할 API 토큰을 얻으려면 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token)의 지침을 따르십시오.

## Features (특징)

### Xiaomi Smart WiFi Socket

Supported models: `chuangmi.plug.m1`, `chuangmi.plug.m3`, `chuangmi.plug.v2`, `chuangmi.plug.hmi205`

- Power (on, off)
- Attributes
  - Temperature

### Xiaomi Chuangmi Plug V1

Supported models: `chuangmi.plug.v1`, `chuangmi.plug.v3`

- Power (on, off)
- USB (on, off)
- Attributes
  - Temperature

### Xiaomi Smart Power Strip

Supported models: `qmi.powerstrip.v1`, `zimi.powerstrip.v2`

- Power (on, off)
- Wifi LED (on, off)
- Power Price (0...999)
- Power Mode (green, normal) (Power Strip V1 only)
- Attributes
  - Temperature
  - Current
  - Load power
  - Wifi LED
  - Mode (Power Strip V1 only)

### Xiaomi Air Conditioning Companion V3

Supported models: `lumi.acpartner.v3` (the socket of the `acpartner.v1` and `v2` isn't switchable!)

* Power (on, off)
* Attributes
  - Load power

## 설정

설치에 플러그를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entries
switch:
  - platform: xiaomi_miio
    host: MIIO_IP_ADDRESS
    token: YOUR_TOKEN
```

{% configuration %}
host:
  description: miio 장치의 IP 주소.
  required: true
  type: string
token:
  description: miio 장치의 API 토큰.
  required: true
  type: string
name:
  description: miio 장치의 이름.
  required: false
  type: string
  default: Xiaomi Miio Switch
model:
  description: miio 장치의 모델. 유효값들은 `chuangmi.plug.v1`, `qmi.powerstrip.v1`, `zimi.powerstrip.v2`, `chuangmi.plug.m1`, `chuangmi.plug.m3`, `chuangmi.plug.v2`, `chuangmi.plug.v3`, `chuangmi.plug.hmi205`. 이 세팅은 장치 모델 감지를 우회하는 데 사용할 수 있으며 장치를 항상 사용할 수 없는 경우 권장됩니다.
  required: false
  type: string
{% endconfiguration %}

## 플랫폼 서비스

### `xiaomi_miio.switch_set_wifi_led_on` (Power Strip only) 서비스

Wi-Fi LED 전원을 끕니다. 

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 스위치 엔티티에서만 작동.       |

### `xiaomi_miio.switch_set_wifi_led_off` (Power Strip only) 서비스

Wi-Fi LED 전원을 끕니다.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 스위치 엔티티에서만 작동.       |

### `xiaomi_miio.switch_set_power_price` (Power Strip) 서비스

전기료를 설정.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 스위치 엔티티에서만 작동.       |
| `price`                   |       no | 전기료 (0-999)                      |

### `xiaomi_miio.switch_set_power_mode` (Power Strip V1 only) 서비스

전원모드 설정.

| Service data attribute    | Optional | Description                                                   |
|---------------------------|----------|---------------------------------------------------------------|
| `entity_id`               |       no | 특정 Xiaomi miIO 스위치 엔티티에서만 작동.           |
| `mode`                    |       no | 전원 모드, 유효한 값은 'normal' 및 'green'             |
