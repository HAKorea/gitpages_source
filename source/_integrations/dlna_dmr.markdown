---
title: DLNA 디지털 미디어 렌더러
description: Instructions on how to integrate a DLNA DMR device into Home Assistant.
logo: dlna.png
ha_category:
  - Media Player
ha_release: 0.76
ha_iot_class: Local Push
---

`dlna_dmr` 플랫폼을 사용하면 DLNA 지원 TV 또는 라디오와 같은 [DLNA Digital Media Renderer](https://www.dlna.org/)를 제어할 수 있습니다

삼성 TV와 같은 일부 장치는 재생에 사용되는 소스에 대해 다소 까다롭습니다. TTS 서비스는 이러한 장치와 함께 작동하지 않을 수 있습니다. play_media 서비스가 작동하지 않으면 DLNA/DMS (예: [MiniDLNA](https://sourceforge.net/projects/minidlna/))에서 재생해보십시오.

## 설정

DLNA DMR 장치를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: dlna_dmr
    url: http://192.168.0.10:9197/description.xml
```

{% configuration %}
url:
  description: "장치 설명. `.xml` 파일의 URL (예 : `http://192.168.0.10:9197/description.xml`)"
  required: true
  type: string
listen_ip:
  description: "장치에서 이벤트를 수신하기 위한 IP. IP가 제대로 감지되지 않을 때만 설정하십시오."
  required: false
  type: string
listen_port:
  description: 장치의 이벤트를 수신 대기하는 포트.
  required: false
  default: 8301
  type: integer
name:
  description: "기기에 부여하려는 이름. (예: TV living room.)"
  required: false
  type: string
callback_url_override:
  description: "Override the advertised callback URL. 홈어시스턴트 인스턴스에 직접 연결할 수 없는 경우 (예 : 브리지 된 네트워킹없이 도커 컨테이너에서 실행) 이벤트에 대해 이 콜백 URL을 알리십시오."
  required: false
  type: string
{% endconfiguration %}
