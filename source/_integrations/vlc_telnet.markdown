---
title: VLC 미디어 플레이어 텔넷
description: Instructions on how to integrate VLC media player into Home Assistant using the telnet interface.
logo: videolan.png
ha_category:
  - Media Player
ha_release: 0.95
ha_iot_class: Local Polling
ha_codeowners:
  - '@rodripf'
---

`vlc_telnet` 플랫폼에서는 내장된 텔넷 인터페이스를 사용하여 [VLC 미디어 플레이어](https://www.videolan.org/vlc/index.html)를 제어 할 수 있습니다.

VLC 미디어 플레이어를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: vlc_telnet
    host: IP_ADDRESS
    password: PASSWORD
```

{% configuration %}
name:
  default: VLC-TELNET
  description: The name to use in the frontend.
  required: false
  type: string
pasword:
  description: The password to control the VLC through the telnet interface.
  required: true
  type: string
host:
  description: The hostname or IP address where the VLC Player is running.
  required: true
  type: string
port:
  default: 4212
  description: The port number where the VLC Player is running.
  required: false
  type: integer
{% endconfiguration %}

현재는 "음악" 미디어 유형 만 지원됩니다.

이 서비스는 텔넷 인터페이스가 활성화 된 네트워크의 VLC 플레이어 인스턴스를 제어합니다. VLC 플레이어에서 텔넷 인터페이스를 활성화하려면 [official VLC documentation](https://wiki.videolan.org/Documentation:Modules/telnet/)을 읽으십시오. 또한 VLC를 실행하는 장치에서 사용되는 포트에 대한 인바운드 연결을 허용하는 방화벽 규칙을 추가해야합니다.

## 전체 설정

VLC의 전체 설정은 다음과 같습니다.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: vlc_telnet
    name: Remote Player
    host: 192.168.1.48
    port: 4212
    password: your-secure-password
```

##### Rasperry Pi의 추가 구성

[hassio-local-vlc 애드온](https://github.com/rodripf/hassio-local-vlc)을 사용하여 Hass.io 설치 내에서 VLC 미디어 플레이어를 실행할 수 있습니다. 이를 사용하여 로컬 네트워크, 인터넷 또는 Hass.io 설치의 /share 폴더에 로컬로 저장된 파일 및 재생 목록의 파일을 재생할 수 있습니다.