---
title: 모노프라이스 앰프(Monoprice 6-Zone Amplifier)
description: Instructions on how to integrate Monoprice 6-Zone Home Audio Controller into Home Assistant.
logo: monoprice.svg
ha_category:
  - Media Player
ha_release: 0.56
ha_iot_class: Local Polling
ha_codeowners:
  - '@etsinko'
---

`monoprice` 플랫폼을 사용하면 직렬 연결을 사용하여 [Monoprice 6-Zone Amplifier](https://www.monoprice.com/product?p_id=10761)를 제어할 수 있습니다.

Monoprice 장치를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: monoprice
    port: /dev/ttyUSB0
    zones:
      11:
        name: Main Bedroom
      12:
        name: Living Room
      13:
        name: Kitchen
      14:
        name: Bathroom
      15:
        name: Dining Room
      16:
        name: Guest Bedroom
    sources:
      1:
        name: Sonos
      5:
        name: Chromecast
```

{% configuration %}
port:
  description: The serial port to which Monoprice amplifier is connected.
  required: true
  type: string
zones:
  description: This is the list of zones available. Valid zones are 11, 12, 13, 14, 15 or 16. In case multiple Monoprice devices are stacked together the list of valid zones is extended by 21, 22, 23, 24, 25 or 26 for the second device and 31, 32, 33, 34, 35 or 36 for the third device. Each zone must have a name assigned to it.
  required: true
  type: integer
sources:
  description: The list of sources available. Valid source numbers are 1, 2, 3, 4, 5 or 6. Each source number corresponds to the input number on the Monoprice amplifier. Similar to zones, each source must have a name assigned to it.
  required: true
  type: integer
{% endconfiguration %}

### `monoprice.snapshot` 서비스

하나 이상의 영역(zone) 상태에 대한 스냅샷(snapshot)을 만듭니다. 이 서비스 및 다음 서비스는 초인종 또는 알림음을 재생하고 나중에 재생을 재개하려는 경우에 유용합니다. `entity_id`가 제공되지 않으면 모든 영역이 스냅샷됩니다.

다음 속성이 스냅샷에 저장됩니다.
- Power status (On/Off)
- Mute status (On/Off)
- Volume level
- Source

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | String or list of strings that point at `entity_id`s of zones.

### `monoprice.restore` 서비스

하나 혹은 하나 이상의 스피커에서 이전에 찍은 스냅샷을 복원합니다. `entity_id`가 제공되지 않으면 모든 영역이 복원됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | String or list of strings that point at `entity_id`s of zones.
