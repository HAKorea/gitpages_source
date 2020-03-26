---
title: 지스트리머(GStreamer)
description: Instructions on how to integrate Gstreamer into Home Assistant.
ha_category:
  - Media Player
logo: gstreamer.png
ha_release: 0.39
ha_iot_class: Local Push
---

`gstreamer` 플랫폼을 사용하면 [gstreamer](https://gstreamer.freedesktop.org/) 파이프 라인을 통해 오디오를 재생할 수 있습니다. 실제로 이는 홈어시스턴트를 실행하는 컴퓨터에서 직접 오디오를 재생할 수 있음을 의미합니다. 특히 TTS 재생에 적합합니다. 고급 사용자는 파이프 라인을 지정하여 오디오 스트림을 변환하거나 다른 곳으로 리디렉션할 수 있습니다.

`gstreamer` 미디어 플레이어를 추가하려면 configuration.yaml 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
media_player:
  - platform: gstreamer
```

{% configuration %}
name:
  description: Name of the media player.
  required: false
  type: string
pipeline:
  description: A `gst` pipeline description.
  required: false
  type: string
{% endconfiguration %}

`music` 미디어 유형만 지원됩니다.

## 셋업

그런 후, 다음의 시스템 종속성을 설치하십시오.

Debian/Ubuntu/Rasbian:

```bash
sudo apt-get install python3-gst-1.0 \
    gir1.2-gstreamer-1.0 gir1.2-gst-plugins-base-1.0 \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly \
    gstreamer1.0-tools
```

Red Hat/Centos/Fedora:

```bash
sudo yum install -y python-gstreamer1 gstreamer1-plugins-good \
    gstreamer1-plugins-ugly
```

Fedora에선 `yum` 를 `dnf`로 바꿉니다.

가상 환경에서 Home Assistant를 실행중인 경우 시스템 Python의 `gi` 모듈을 가상 환경에 심볼릭 링크해야합니다. 

```bash
ln -s /path/to/your/installation/of/gi /path/to/your/venv/lib/python3.4/site-packages
```

라즈베리 파이에서 홈어시스턴트 사용자를 `audio` 그룹에 추가해야 할 수도 있습니다 :

```bash
sudo usermod -a -G audio <ha_user>
```

## 사용법 예제

### TTS 사용하기

로컬 컴퓨터에서 TTS를 재생하려면 (예: Raspberry Pi에 스피커가 연결된 경우)

```yaml
media_player:
  - platform: gstreamer

script:
  tts:
    sequence:
      - service: tts.google_say # or amazon_polly, voicerss, etc
        data:
          entity_id: media_player.gstreamer
          message: "example text-to-speech message"
```

### Snapcast 사용하기

Snapcast가 소비할 명명된 파이프를 재생하려면 :

```yaml
media_player:
  - platform: gstreamer
    pipeline: "audioresample ! audioconvert ! audio/x-raw,rate=48000,channels=2,format=S16LE ! wavenc ! filesink location=/tmp/snapcast_gstreamer"
```
