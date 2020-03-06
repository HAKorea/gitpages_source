---
title: VLC 미디어 플레이어
description: Instructions on how to integrate VLC media player into Home Assistant.
logo: videolan.png
ha_category:
  - Media Player
ha_release: 0.35
ha_iot_class: Local Polling
---

`vlc` 플랫폼을 사용하면 [VLC 미디어 플레이어](https://www.videolan.org/vlc/index.html)를 제어 할 수 있습니다.

VLC 미디어 플레이어를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: vlc
```

{% configuration %}
name:
  description: The name to use in the frontend.
  required: false
  type: string
arguments:
  description: Additional arguments to be passed to VLC.
  required: false
  type: string
{% endconfiguration %}

Only the "music" media type is supported for now.
현재는 "음악" 미디어 유형 만 지원됩니다.

이 서비스는 백그라운드 VLC 인스턴스를 제어하므로 Kodi 미디어 플레이어와 달리 데스크탑에서 시작된 VLC 인스턴스를 제어하는​​데 사용할 수 없습니다.

## 전체 설정

VLC의 전체 설정은 다음과 같습니다.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: vlc
    name: speaker_1
    arguments: '--alsa-audio-device=hw:1,0'
```

##### macOS의 추가 설정

macOS에서 `python-vlc`는 Home Assistant를 실행하는 사용자의 `.bash_profile`에 추가하지 않으면 VLC 플러그인 디렉토리를 찾을 수 없습니다.

```bash
export VLC_PLUGIN_PATH=$VLC_PLUGIN_PATH:/Applications/VLC.app/Contents/MacOS/plugins
```

##### Rasperry Pi의 추가 구성

`homeassistant` 사용자를`audio` 그룹에 추가해야합니다.

```bash
sudo usermod -a -G audio homeassistant
```

##### VLC는 현재 Hass.io에서 지원되지 않습니다

포럼 주제 ["내 Hassio에 VLC를 추가하는 방법"](https://community.home-assistant.io/t/how-to-add-vlc-into-my-hassio/23000/5)에 따르면, Hass.io에는 VLC와 같은 패키지를 설치할 수 없습니다.