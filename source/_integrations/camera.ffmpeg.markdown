---
title: FFmpeg 카메라(FFmpeg Camera)
description: "Instructions on how to integrate a video feed via FFmpeg as a camera within Home Assistant."
logo: ffmpeg.png
ha_category:
  - Camera
ha_release: 0.26
ha_iot_class: Local Polling
---

`ffmpeg` 플랫폼을 사용하면 [FFmpeg](https://www.ffmpeg.org/)를 통해 모든 비디오 피드를 Home Assistant에서 카메라로 사용할 수 있습니다. 모든 동시접속 홈어시스턴트 사용자의 경우 10초마다 소스에 연결되므로 이 비디오 소스는 여러 동시 읽기를 지원해야합니다. 일반적으로 이것은 문제가 되지 않습니다.

## 설정

설치에서 FFmpeg 피드를 사용하려면 먼저 [ffmpeg integration](/integrations/ffmpeg/)을 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
camera:
  - platform: ffmpeg
    input: FFMPEG_SUPPORTED_INPUT
```

{% configuration %}
input:
  description: FFmpeg 호환 입력 파일, 스트림 또는 피드.
  required: true
  type: string
name:
  description: 카메라 이름을 무시.
  required: false
  type: string
extra_arguments:
  description: "`ffmpeg` 이미지 품질 또는 비디오 필터 옵션과 같은 추가 옵션."
  required: false
  type: string
  default: "-pred 1"
{% endconfiguration %}

### 화질

[`extra_arguments`](https://www.ffmpeg.org/ffmpeg-codecs.html#jpeg2000)로 `-q : v 2-32` 또는 무손실 옵션 `-pred 1` 등을 사용하여 이미지 품질을 제어할 수 있습니다. 기본값은 무손실입니다.

이 센서에 문제가 발생하면 [Troubleshooting section](/integrations/ffmpeg/#troubleshooting)을 참조하십시오 .