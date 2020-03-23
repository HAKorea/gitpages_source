---
title: Clementine Music Player
description: Instructions on how to integrate Clementine Music Player within Home Assistant.
logo: clementine.png
ha_category:
  - Media Player
ha_release: 0.39
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/si85LRnecwc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`clementine` 플랫폼을 사용하면 [Clementine Music Player](https://www.clementine-player.org)를 제어할 수 있습니다.

Clementine Player를 Home Assistant에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: clementine
    host: 192.168.0.20
```

{% configuration %}
host:
  description: The IP address of the Clementine Player e.g., 192.168.0.20.
  required: true
  type: string
port:
  description: The remote control port.
  required: false
  default: 5500
  type: integer
access_token:
  description: The authorization code needed to connect.
  required: false
  type: integer
name:
  description: The name you would like to give to the Clementine player.
  required: false
  default: Clementine Remote
  type: string
{% endconfiguration %}

Clementine은 네트워크 원격 제어 프로토콜을 통한 연결을 허용하도록 설정되어야합니다.

Clementine `Tools > Preferences > Network remote control` 설정 메뉴를 통해 이를 설정할 수 있습니다. `Use network remote control`을 활성화하고 사용 사례에 대한 다른 옵션을 설정하십시오.

이 통합구성요소는 `play_media` 서비스를 구현하지 않으므로 재생 목록에 트랙을 추가할 수 없습니다.