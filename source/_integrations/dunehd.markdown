---
title: DuneHD
description: Instructions on how to integrate DuneHD media players into Home Assistant.
logo: dunehd.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.34
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/cWatz70P_pg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`dunehd` 미디어 플레이어 플랫폼을 사용하면 Home Assistant에서 [Dune HD media player](https://dune-hd.com/eng/products/full_hd_media_players)를 제어할 수 있습니다. 지원사항은 Dune이 게시한 공식 [IP protocol](https://dune-hd.com/support/ip_control/dune_ip_control_overview.txt)을 기반으로합니다.

펌웨어가 110127_2105_beta 이상인 장치가 지원됩니다. 일부 기능은 프로토콜 버전에 따라 다를 수 있습니다 (볼륨/음소거 제어는 버전 2 이상에서만 사용 가능).

Dune HD 플레이어를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: dunehd
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: IP address or hostname of the device, e.g., 192.168.1.32.
  required: true
  type: string
name:
  description: Name of the device.
  required: false
  default: DuneHD
  type: string
sources:
  description: A name-value dictionary of sources than can be requested to play.
  required: false
  type: string
{% endconfiguration %}
