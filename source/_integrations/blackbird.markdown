---
title: 미디어 입력소스 스위치(Monoprice Blackbird Matrix Switch)
description: Instructions on how to integrate Monoprice Blackbird 4k 8x8 HDBaseT Matrix Switch into Home Assistant.
logo: monoprice.svg
ha_category:
  - Media Player
ha_release: 0.68
ha_iot_class: Local Polling
---

`blackbird` 플랫폼을 사용하면 직렬 연결을 사용하여 [Monoprice Blackbird Matrix Switch](https://www.monoprice.com/product?p_id=21819)를 제어할 수 있습니다.

To add a Blackbird device to your installation, add the following to your `configuration.yaml` file:
설치에 Blackbird 장치를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: blackbird
    port: /dev/ttyUSB0
    zones:
      1:
        name: Living Room
    sources:
      3:
        name: BluRay
```

{% configuration %}
port:
  description: The serial port to which Blackbird matrix switch is connected. [`port`](#port) and [`host`](#host) cannot be specified concurrently.
  required: exclusive
  type: string
host:
  description: The IP address of the Blackbird matrix switch. [`port`](#port) and [`host`](#host) cannot be specified concurrently.
  required: exclusive
  type: string
zones:
  description: This is the list of zones available. Valid zones are 1, 2, 3, 4, 5, 6, 7, 8. Each zone must have a name assigned to it.
  required: true
  type: map
  keys:
    ZONE_NUMBER:
      description: The name of the zone.
      type: string
sources:
  description: The list of sources available. Valid source numbers are 1, 2, 3, 4, 5, 6, 7, 8. Each source number corresponds to the input number on the Blackbird matrix switch. Similar to zones, each source must have a name assigned to it.
  required: true
  type: map
  keys:
    ZONE_NUMBER:
      description: The name of the source.
      type: string
{% endconfiguration %}

### `blackbird.set_all_zones` 서비스

모든 구역(zone)을 동일한 입력 소스로 설정하십시오. 이 서비스를 사용하면 집에있는 모든 TV를 즉시 동기화 할 수 있습니다. 제공된 `entity_id`와 상관없이 모든 영역이 업데이트됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | String that points at an `entity_id` of a zone.
| `source` | no | String of source name to activate.
