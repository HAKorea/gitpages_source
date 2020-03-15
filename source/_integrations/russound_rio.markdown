---
title: 러스사운드 RIO(Russound RIO)
description: Instructions on how to integrate Russound RIO devices into Home Assistant.
logo: russound.png
ha_category:
  - Media Player
ha_release: 0.49
ha_iot_class: Local Push
---

이 `russound_rio` 플랫폼을 사용하면 RIO 프로토콜을 사용하는 Russound 장치를 제어할 수 있습니다.

플랫폼은 사용 가능한 모든 영역과 소스를 자동으로 감지합니다. 각 영역(zone)은 입력으로 사용 가능한 소스가 있는 미디어 플레이어 장치로 추가됩니다. 선택한 소스에서 이를 보고하면 미디어 정보가 지원됩니다.

설치에 장치를 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: russound_rio
    host: 192.168.1.10
    name: Russound
```

{% configuration %}
host:
  description: The IP of the TCP gateway.
  required: true
  type: string
port:
  description: The port of the TCP gateway.
  required: false
  default: 9621
  type: integer
name:
  description: The name of the device.
  required: true
  type: string
{% endconfiguration %}
