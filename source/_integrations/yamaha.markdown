---
title: Yamaha Network Receivers
description: Instructions on how to integrate Yamaha Network Receivers into Home Assistant.
logo: yamaha.png
ha_category:
  - Media Player
ha_release: 0.16
---

`yamaha` 플랫폼을 사용하면 Home Assistant에서 [Yamaha Network Receivers](https://usa.yamaha.com/products/audio-visual/av-receivers-amps/rx)를 제어할 수 있습니다.

지원 기기들 :

- [HTR-4065](https://www.yamaha.com/cchtr4065/)
- [RX-V473](https://ca.yamaha.com/en/products/audio_visual/av_receivers_amps/rx-v473/specs.html)
- [RX-V573](https://ca.yamaha.com/en/products/audio_visual/av_receivers_amps/rx-v573/specs.html)
- [RX-V673](https://ca.yamaha.com/en/products/audio_visual/av_receivers_amps/rx-v673/specs.html)
- [RX-V773](https://ca.yamaha.com/en/products/audio_visual/av_receivers_amps/rx-v773/specs.html)
- 이외 

Yamaha Network Receiver를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: yamaha
```

{% configuration %}
name:
  description: Name of the device. This overrides the default name (often model number) that is returned by the device.
  required: false
  type: string
host:
  description: IP address or hostname of the device.
  required: false
  type: string
source_ignore:
  description: List of sources to hide in the front-end.
  required: false
  type: list
source_names:
  description: Mapping of internal AVR source names to custom ones, allowing one to rename e.g., `HDMI1` to `ChromeCast`.
  required: false
  type: list
zone_ignore:
  description: List of zones to hide in the front-end.
  required: false
  type: list
zone_names:
  description: Mapping of zone names to custom ones, allowing one to rename e.g., `Main_Zone` to `Family Room`.
  required: false
  type: list
{% endconfiguration %}

### 장치 검색시 알아둘 점

- `discovery` 통합구성요소가 활성화 된 경우 UPNP를 사용하여 네트워크의 모든 장치를 검색합니다.
- 둘 이상의 영역(zone)을 지원하는 Receiver의 경우 Home Assistant는 플레이어가 지원하는 영역 당 "$ name Zone 2", "$ name Zone 3"이라는 하나의 미디어 플레이어를 추가합니다.
- `host`를 수동으로 지정하면 Receiver에서 네트워크 대기를 활성화 **해야합니다**, 그렇지 않으면 Receiver를 끈 경우 Home Assistant 시작이 중단됩니다.
- 경우에 따라 Receiver 펌웨어의 알려진 버그로 인해 자동 검색이 실패합니다. Receiver의 IP 주소 또는 호스트 이름 (DNS에서 검색 할 수있는 경우)을 통해 수동으로 지정할 수 있습니다.

### 지원 동작

- 야마하가 만든 미디어 플레이어는 전원 켜기/끄기, 음소거, 볼륨 조절 및 소스 선택을 지원합니다. 재생 및 정지와 같은 재생 컨트롤은 이를 지원하는 소스들에서 사용할 수 있습니다.
- `play_media` 서비스는 `NET RADIO` 소스에 대해서만 구현됩니다. `media_id`는 vtuner 서비스에서 메뉴 경로의 `>`로 구분된 문자열입니다. 예를 들어 `Bookmarks>Internet>WAMC 90.3 FM`입니다.

### 설정 사례

전체 설정 예는 아래 샘플과 같습니다.
```yaml
# Example configuration.yaml entry
media_player:
  - platform: yamaha
    host: 192.168.0.10
    source_ignore:
      - "AUX"
      - "HDMI6"
    source_names:
      HDMI1: "ChromeCast"
      AV4: "Vinyl"
    zone_ignore:
      - "Zone_2"
    zone_names:
      Main_Zone: "Family Room"
```

### `play_media` script 예시

스크립트에서 `play_media` 기능을 사용하여 미디어 플레이어 사전 설정을 쉽게 구축 할 수 있습니다. 스크립트에서 완료되면 시퀀스를 통해 소스 마다 볼륨을 설정할 수도 있습니다.

```yaml
# Example play_media script
#
# This is for an environment where Zone 2 of the receiver named
# `Living Room Stereo` drives outdoor speakers on the porch.
script:
 rp_porch:
    alias: "Radio Paradise Porch"
    sequence:
      - service: media_player.turn_on
        data:
          entity_id: media_player.living_room_stereo_zone_2
      - service: media_player.volume_set
        data:
          entity_id: media_player.living_room_stereo_zone_2
          volume_level: 0.48
      - service: media_player.play_media
        data:
          entity_id: media_player.living_room_stereo_zone_2
          media_content_type: "NET RADIO"
          media_content_id: "Bookmarks>Internet>Radio Paradise"

```

### `enable_output` 서비스

수신기에서 출력 포트(HDMI)를 활성화 또는 비활성화합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | String or list of strings that point at `entity_id`s of Yamaha receivers.
| `port` | no | Port to enable or disable, e.g., `hdmi1`.
| `enabled` | no | To enable set true, otherwise set to false.
