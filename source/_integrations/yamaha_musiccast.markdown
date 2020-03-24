---
title: Yamaha MusicCast
description: Instructions on how to integrate Yamaha MusicCast Receivers into Home Assistant.
logo: yamaha.png
ha_category:
  - Media Player
ha_release: 0.53
ha_codeowners:
  - '@jalmeroth'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/NIHZxNjeEg0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`yamaha_musiccast` 플랫폼을 사용하면 Home Assistant에서 [Yamaha MusicCast Receivers](https://usa.yamaha.com/products/audio_visual/hifi_components/index.html)를 제어할 수 있습니다.

지원되는 장치는 [독일어 사이트](https://de.yamaha.com/de/products/contents/audio_visual/musiccast/products.html)에 나와 있습니다.

Yamaha MusicCast Receiver를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: yamaha_musiccast
    host: 192.168.xx.xx
```

{% configuration %}
host:
  description: IP address or hostname of the device.
  required: true
  type: string
port:
  description: UDP source port. If multiple devices are present, specify a different port per device.
  required: false
  type: integer
  default: 5005
interval_seconds:
  description: Polling interval in seconds.
  required: false
  type: integer
  default: 480
{% endconfiguration %}

### 지원 동작

현재 이 통합구성요소는 전원 켜기/끄기, 음소거, 볼륨 제어 및 소스 선택을 지원합니다. 재생 및 정지와 같은 재생 컨트롤은 이를 지원하는 소스에서 사용할 수 있습니다.

### 설정 사례

전체 설정 사례는 아래 샘플과 같습니다.
```yaml
# Example configuration.yaml entry
media_player:
  - platform: yamaha_musiccast
    host: 192.168.178.97
    port: 5005
```
