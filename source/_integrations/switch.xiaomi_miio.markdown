---
title: "Xiaomi Smart WiFi Socket and Smart Power Strip"
description: "Instructions on how to integrate your Xiaomi Smart WiFi Socket aka Plug or Xiaomi Smart Power Strip within Home Assistant."
logo: xiaomi.png
ha_category:
  - Switch
ha_iot_class: Local Polling
ha_release: 0.56
---

`xiaomi_miio` 스위치 플랫폼은 플러그 일명 샤오미 스마트 와이파이 소켓, 샤오미 스마트 파워 스트립과 샤오미 Chuangmi 플러그 V1의 상태를 제어할 수 있습니다.

`configuration.yaml` 파일에서 사용할 API 토큰을 얻으려면 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token)의 지침을 따르십시오.

## Features

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

## Configuration

To add a plug to your installation, add the following to your `configuration.yaml` file:

```yaml
# Example configuration.yaml entries
switch:
  - platform: xiaomi_miio
    host: MIIO_IP_ADDRESS
    token: YOUR_TOKEN
```

{% configuration %}
host:
  description: The IP address of your miio device.
  required: true
  type: string
token:
  description: The API token of your miio device.
  required: true
  type: string
name:
  description: The name of your miio device.
  required: false
  type: string
  default: Xiaomi Miio Switch
model:
  description: The model of your miio device. Valid values are `chuangmi.plug.v1`, `qmi.powerstrip.v1`, `zimi.powerstrip.v2`, `chuangmi.plug.m1`, `chuangmi.plug.m3`, `chuangmi.plug.v2`, `chuangmi.plug.v3` and `chuangmi.plug.hmi205`. This setting can be used to bypass the device model detection and is recommended if your device isn't always available.
  required: false
  type: string
{% endconfiguration %}

## Platform Services

### Service `xiaomi_miio.switch_set_wifi_led_on` (Power Strip only)

Turn the wifi led on.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | Only act on a specific Xiaomi miIO switch entity.       |

### Service `xiaomi_miio.switch_set_wifi_led_off` (Power Strip only)

Turn the wifi led off.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | Only act on a specific Xiaomi miIO switch entity.       |

### Service `xiaomi_miio.switch_set_power_price` (Power Strip)

Set the power price.

| Service data attribute    | Optional | Description                                             |
|---------------------------|----------|---------------------------------------------------------|
| `entity_id`               |       no | Only act on a specific Xiaomi miIO switch entity.       |
| `price`                   |       no | Power price, between 0 and 999.                         |

### Service `xiaomi_miio.switch_set_power_mode` (Power Strip V1 only)

Set the power mode.

| Service data attribute    | Optional | Description                                                   |
|---------------------------|----------|---------------------------------------------------------------|
| `entity_id`               |       no | Only act on a specific Xiaomi miIO switch entity.             |
| `mode`                    |       no | Power mode, valid values are 'normal' and 'green'             |
