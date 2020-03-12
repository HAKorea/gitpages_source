---
title: 파나소닉 Viera TV
description: Instructions on how to integrate a Panasonic Viera TV into Home Assistant.
logo: panasonic.png
ha_category:
  - Media Player
ha_release: 0.17
ha_iot_class: Local Polling
---

`panasonic_viera` 플랫폼을 사용하면 Panasonic Viera TV를 제어할 수 있습니다.

현재 알려진 지원 모델 :

- TC-P65VT30
- TX-32AS520E
- TX-32DSX609
- TX-49DX650B
- TX-50DX700B
- TX-55CX700E
- TX-55CX680B
- TX-55EXW584
- TX-65EXW784
- TX-L42ET50
- TX-P42STW50
- TX-P50GT30Y
- TX-P50GT60E
- TH-32ES500
- TX-42AS650
- TX55ASW654

모델이 목록에없는 경우 테스트를 수행하고 모든 것이 올바르게 작동하면 [GitHub](https://github.com/home-assistant/home-assistant.io/blob/current/source/_integrations/panasonic_viera.markdown)의 목록에 추가하십시오

`mac:` 으로 MAC 주소를 지정하면 일부 Panasonic Viera TV에서 Home Assistant로 TV를 켤 수 있습니다.

이 플랫폼이 작동하려면 TV가 홈어시스턴트 인스턴스와 동일한 네트워크에 있어야합니다. Home Assistant 인스턴스에 여러개의 네트워크 인터페이스가 있는 경우 `broadcast_address`를 지정해야합니다.

TV를 설치시 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: panasonic_viera
    host: 192.168.0.10
```

{% configuration %}
host:
  description: The IP of the Panasonic Viera TV, e.g., `192.168.0.10`.
  required: true
  type: string
port:
  description: The port number of your Panasonic Viera TV.
  required: false
  default: 55000
  type: integer
mac:
  description: The MAC address of your Panasonic Viera TV, e.g., `AA:BB:CC:DD:99:1A`.
  required: false
  type: string
broadcast_address:
  description: The broadcast address on which to send the Wake-On-Lan packet.
  required: false
  default: 255.255.255.255
  type: string
app_power:
  description: Set to `true` if your Panasonic Viera TV supports "Turn on via App".
  required: false
  default: false
  type: boolean
name:
  description: The name you would like to give to the Panasonic Viera TV.
  required: false
  default: Panasonic Viera TV
  type: string
{% endconfiguration %}

### `play_media` 스크립트 예제

`play_media` 기능은 TV 웹브라우저에서 웹페이지 및 기타 미디어 유형 (이미지, 동영상)을 여는데 사용할 수 있습니다.

```yaml
# Example play_media script that can be triggered when someone is detected at the door
#
script:
  front_door_camera:
    alias: "Show who's at the door"
    sequence:
      - service: media_player.turn_on
        data:
          entity_id: media_player.living_room_tv
      - service: media_player.play_media
        data:
          entity_id: media_player.living_room_tv
          media_content_type: "url"
          media_content_id: "http://google.com"
      - delay:
        seconds: 5
      - service: media_player.media_stop
        data:
          entity_id: media_player.living_room_tv
```
