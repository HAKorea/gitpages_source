---
title: 구글 플레이 뮤직 데스트탑 플레이어(GPMDP)
description: Instructions on how to integrate GPMDP into Home Assistant.
logo: gpmdp.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: '0.20'
---

`gpmdp` 미디어 플레이어 플랫폼을 사용하면 홈어시스턴트의 컴퓨터에서 실행되는 [GPMDP](https://www.googleplaymusicdesktopplayer.com/) 인스턴스를 제어할 수 있습니다.

먼저 GPMDP 설정에서 "Enable playback API"을 확인한 다음 방화벽에 인바운드 규칙을 추가하여 GPMDP를 실행하는 컴퓨터의 포트 5672에 액세스할 수 있도록 해야합니다.

그런 다음 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: gpmdp
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: The IP address of the computer running GPMDP.
  required: true
  type: string
name:
  description: Name of the player.
  required: false
  default: GPM Desktop Player
  type: string
{% endconfiguration %}
