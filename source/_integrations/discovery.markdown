---
title: Discovery
description: Instructions on how to setup Home Assistant to discover new devices.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.7
ha_quality_scale: internal
---

홈어시스턴트는 네트워크에서 [zeroconf](https://en.wikipedia.org/wiki/Zero-configuration_networking)/[mDNS](https://en.wikipedia.org/wiki/Multicast_DNS) 그리고 [uPnP](https://en.wikipedia.org/wiki/Universal_Plug_and_Play) 장치를 검색하고 자동으로 설정 할 수 있습니다. 현재 `discovery` 통합구성요소는 다음을 감지 할 수 있습니다. :

 * [Apple TV](/integrations/apple_tv/)
 * [Belkin WeMo switches](/integrations/wemo/)
 * [Bluesound speakers](/integrations/bluesound)
 * [Bose Soundtouch speakers](/integrations/soundtouch)
 * [Denon network receivers](/integrations/denonavr/)
 * [DirecTV receivers](/integrations/directv)
 * [DLNA DMR enabled devices](/integrations/dlna_dmr)
 * [Enigma2 media player](/integrations/enigma2)
 * [Frontier Silicon internet radios](/integrations/frontier_silicon)
 * [Google Cast](/integrations/cast)
 * [Linn / Openhome](/integrations/openhome)
 * [Logitech Harmony Hub](/integrations/harmony)
 * [Logitech media server (Squeezebox)](/integrations/squeezebox)
 * [Netgear routers](/integrations/netgear)
 * [Panasonic Viera](/integrations/panasonic_viera)
 * [Philips Hue](/integrations/hue)
 * [Plex media server](/integrations/plex#media-player)
 * [Roku media player](/integrations/roku#media-player)
 * [SABnzbd downloader](/integrations/sabnzbd)
 * [Samsung SyncThru Printer](/integrations/syncthru)
 * [Samsung TVs](/integrations/samsungtv)
 * [Sonos speakers](/integrations/sonos)
 * [Telldus Live](/integrations/tellduslive/)
 * [Wink](/integrations/wink/)
 * [Yamaha media player](/integrations/yamaha)
 * [Yeelight Sunflower bulb](/integrations/yeelightsunflower/)
 * [Xiaomi Gateway (Aqara)](/integrations/xiaomi_aqara/)

Google Chromecast 및 Belkin WeMo 스위치를 자동으로 추가 할 수 있습니다.
Philips Hue의 경우 사용자의 일부 설정이 필요합니다.

<div class='note'>

Zeroconf 검색 가능 통합구성요소 [Axis](/integrations/axis/)/[ESPHome](/integrations/esphome/)/[HomeKit](/integrations/homekit_controller/)/[Tradfri](/integrations/tradfri/)는 [zeroconf](/integrations/zeroconf) 통합구성요소를 사용 하여 검색을 하도록 마이그레이션되었습니다.
</div>

이 통합구성요소를 사용하려면, `configuration.yaml` 파일에 다음 행을 추가 하십시오. :

```yaml
# Example configuration.yaml entry
discovery:
  ignore:
    - sonos
    - samsung_tv
  enable:
    - homekit
```

{% configuration discovery %}
ignore:
  description:  `discovery` 로 절대 자동 설정되지 못하게하는 기능입니다.
  required: false
  type: list
enable:
  description:  `discovery`로 기본검색이 되게하고 해당 리스트만 플랫폼에서 나타나지 않도록 설정하는 기능입니다.
  required: false
  type: list
{% endconfiguration %}

ignore에 유효한 값은 다음과 같습니다. :

 * `apple_tv`: Apple TV
 * `belkin_wemo`: Belkin WeMo switches
 * `bluesound`: Bluesound speakers
 * `bose_soundtouch`: Bose Soundtouch speakers
 * `denonavr`: Denon network receivers
 * `directv`: DirecTV receivers
 * `enigma2`: Enigma2 media players
 * `frontier_silicon`: Frontier Silicon internet radios
 * `google_cast`: Google Cast
 * `harmony`: Logitech Harmony Hub
 * `igd`: Internet Gateway Device
 * `logitech_mediaserver`: Logitech media server (Squeezebox)
 * `netgear_router`: Netgear routers
 * `octoprint`: Octoprint
 * `openhome`: Linn / Openhome
 * `panasonic_viera`: Panasonic Viera
 * `philips_hue`: Philips Hue
 * `plex_mediaserver`: Plex media server
 * `roku`: Roku media player
 * `sabnzbd`: SABnzbd downloader
 * `samsung_printer`: Samsung SyncThru Printer
 * `samsung_tv`: Samsung TVs
 * `sonos`: Sonos speakers
 * `songpal` : Songpal
 * `tellstick`: Telldus Live
 * `wink`: Wink Hub
 * `yamaha`: Yamaha media player
 * `yeelight`: Yeelight lamps and bulbs (not only Yeelight Sunflower bulb)
 * `xiaomi_gw`: Xiaomi Aqara gateway

enable에 유효한 값은 다음과 같습니다. :

 * `dlna_dmr`: DLNA DMR 지원 장치 

## Troubleshooting

### UPnP

홈 어시스턴트는 uPnP 검색이 작동하도록 장치와 동일한 네트워크에 있어야합니다.
Home Assistant가 [Docker container](/docs/installation/docker/)에서 실행되는 경우 `--net=host`를 사용하여 해당 호스트를 네트워크에 배치하십시오.

### Windows

#### 64-bit Python
현재 64 비트 버전의 Python 및 Windows에서이 통합을 실행 하는 데 <a href='https://bitbucket.org/al45tair/netifaces/issues/17/dll-fails-to-load-windows-81-64bit'>known issue</a>가 있습니다.

### could not install dependency netdisco

`Not initializing discovery because could not install dependency netdisco==0.6.1`를 로그에서 확인했다면, `python3-dev` 혹은 `python3-devel` 패키지를 시스템에 수동을 설치해야합니다. 예) `sudo apt-get install python3-dev` 혹은 `sudo dnf -y install python3-devel`. 이후 Home Assistant를 다시 시작하면 discovery가 작동합니다. 여전히 오류가 발생하면 gcc시스템에서 사용 가능한 컴파일러 (`gcc`) 가 있는지 확인하십시오.

### DSM and Synology

DSM/Synology 경우, debian-chroot를 통해 설치하려면 [이 포럼의 게시물을 참조하세요.](https://community.home-assistant.io/t/error-starting-home-assistant-on-synology-for-first-time/917/15).
