---
title: 볼류미오(Volumio)
description: How to set up the Volumio media player platform
logo: volumio.png
ha_category:
  - Media Player
ha_release: 0.41
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/UAFF88-3yak" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`Volumio` 플랫폼을 사용하면 Home Assistant에서 [Volumio](https://volumio.org/) 미디어 플레이어를 제어할 수 있습니다.

Volumio 플랫폼을 설정하는 바람직한 방법은 [discovery component](/integrations/discovery/)를 활성화하는 것입니다.

검색이 작동하지 않거나 특정 설정 변수가 필요한 경우 `configuration.yaml` 파일에 다음을 추가 할 수 있습니다.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: volumio
    host: homeaudio.local
    port: 3000
```

{% configuration %}
name:
  description: The name of the device.
  required: false
  default: Volumio
  type: string
host:
  description: The IP address or hostname of the device.
  required: true
  default: localhost
  type: string
port:
  description: The Port number of Volumio service.
  required: true
  default: 3000
  type: integer
{% endconfiguration %}
