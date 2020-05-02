---
title: 타일(Tile)
description: Instructions on how to use Tile to track devices in Home Assistant.
logo: tile.png
ha_release: 0.58
ha_category:
  - Presence Detection
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@bachya'
---

<div class='videoWrapper'>
<iframe width="775" height="436" src="https://www.youtube.com/embed/VZ7LmLMch1w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`tile` 플랫폼을 통해 Home Assistant는 [Tile® Bluetooth 추적기](https://www.thetileapp.com)를 활용할 수 있습니다. 공식 Tile 모바일앱은 모바일 장치의 Bluetooth 및 GPS를 사용하여 Tile 장치의 실제 추적을 처리합니다.

Tile을 Home Assistant에 통합하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
device_tracker:
  - platform: tile
    username: email@address.com
    password: MY_PASSWORD_123
```

{% configuration %}
  username:
    description: the email address for the Tile account
    required: true
    type: string
  password:
    description: the password for the Tile account
    required: true
    type: string
  monitored_variables:
    description: the Tile types to monitor; valid values are `TILE` and `PHONE` (default is for all types to be included)
    required: false
    type: list
  show_inactive:
    description: whether to show expired/disabled Tiles
    required: false
    type: boolean
    default: false
{% endconfiguration %}

`tile` 플랫폼을 반복하여 여러 개의 타일 계정을 사용할 수 있습니다. `known_devices.yaml`에서 추적된 장치의 이름은 `tile_<tile_identifier>`입니다. Tile 앱에서 타일을 클릭하면 `<tile_identifier>`를 찾을 수 있습니다.