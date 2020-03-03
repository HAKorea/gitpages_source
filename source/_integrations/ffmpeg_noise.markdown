---
title: FFmpeg 노이즈
description: Instructions on how to integrate an FFmpeg-based noise binary sensor
logo: ffmpeg.png
ha_category:
  - Image Processing
ha_release: 0.27
---

이 `ffmpeg` 플랫폼을 사용하면 Home Assistant의 다양한 센서에 [FFmpeg](https://www.ffmpeg.org/)가 포함된 모든 비디오 또는 오디오 피드를 사용할 수 있습니다

<div class='note'>

`ffmpeg` 프로세스가 중단되면 센서를 사용할 수 없습니다. 센서의 ffmpeg 프로세스를 제어하려면 *ffmpeg.start*, *ffmpeg.stop*, *ffmpeg.restart* 서비스를 사용하십시오.

</div>

## 설정

소음 감지 기능이있는 FFmpeg를 설치에 추가하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: ffmpeg_noise
    input: FFMPEG_SUPPORTED_INPUT
```

{% configuration %}
input:
  description: FFmpeg 호환 입력 파일, 스트림 또는 피드.
  required: true
  type: string
name:
  description: 카메라 이름을 덮어씁니다.
  required: false
  type: string
initial_state:
  description: 홈어시스턴트로 ffmpeg를 시작
  required: false
  type: boolean
  default: true
peak:
  description: 노이즈 감지 임계값 (dB) 0은 매우큼 -100은 낮음.
  required: false
  type: integer
  default: -30
duration:
  description: How long the noise needs to be over the peak to trigger the state. 
  required: false
  type: integer
  default: 1
reset:
  description: The time to reset the state after no new noise is over the peak.
  required: false
  type: integer
  default: 20
extra_arguments:
  description: 오디오 주파수 필터링과 같이 `ffmpeg`에 전달할 추가 옵션.
  required: false
  type: string
output:
  description: "이 센서의 오디오 출력을 Icecast 서버 또는 다른 FFmpeg 지원 출력 (예: 상태가 트리거 된 후 Sonos로 스트리밍)으로 보낼 수 있습니다."
  required: false
  type: string
{% endconfiguration %}

값을 실험하려면 :

```bash
$ ffmpeg -i YOUR_INPUT -vn -filter:a silencedetect=n=-30dB:d=1 -f null -
```
