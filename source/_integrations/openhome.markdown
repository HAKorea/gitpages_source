---
title: Linn / OpenHome
description: Instructions on how to integrate Linn Ds and Openhome renderers into Home Assistant.
logo: linn.png
ha_category:
  - Media Player
ha_release: 0.39
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/ykxCh16cZgI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`openhome` 플랫폼을 사용하면 [Openhome Compliant Renderer](http://openhome.org/)로 [Linn Products Ltd](https://www.linn.co.uk) HiFi 스트리머 장비에 Home Assistant를 연결할 수 있습니다. 미디어 재생, 볼륨, 소스를 제어하고 현재 재생중인 항목을 볼 수 있습니다. Openhome 장치는 [the discovery component](/integrations/discovery/)를 사용하여 검색해야합니다. 장치 이름은 장치에 설정된 room 이름에서 가져옵니다.

### configuration.yaml 항목 예시

```yaml
discovery:
media_player:
  - platform: openhome
```

### 로컬 오디오 재생 동작 예시

```yaml
action:
  - service: media_player.play_media
    data_template:
      entity_id:
        - media_player.linn_bedroom
      media_content_id: "http://172.24.32.13/Doorbell.mp3"
      media_content_type: music
```

### 웹 스트림 재생 동작 예시

```yaml
  - service: media_player.play_media
    data_template:
      entity_id:
        - media_player.linn_bedroom
      media_content_id: "http://media-ice.musicradio.com:80/ClassicFMMP3"
      media_content_type: music
```

