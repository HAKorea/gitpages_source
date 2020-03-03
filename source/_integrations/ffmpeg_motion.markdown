---
title: FFmpeg 모션
description: Instructions on how to integrate an FFmpeg-based motion binary sensor
logo: ffmpeg.png
ha_category:
  - Image Processing
ha_release: 0.27
---

`ffmpeg` 플랫폼을 사용하면 Home Assistant의 모션 센서에 [FFmpeg](https://www.ffmpeg.org/)가 포함된 모든 비디오 피드를 사용할 수 있습니다.

<div class='note'>

`ffmpeg` 프로세스가 중단되면 센서를 사용할 수 없습니다. 센서의 ffmpeg 프로세스를 제어하려면 *ffmpeg.start*, *ffmpeg.stop*, *ffmpeg.restart* 서비스를 사용하십시오.

</div>

## 모션 (Motion)

FFmpeg에는 동작 감지 필터가 없지만 장면 필터를 사용하여 scene/motion을 감지 할 수 있습니다. 프레임 간 변화의 백분율 값인 'changes' 옵션을 사용하여 움직임을 감지하기 위해 얼마나 많이 변경해야 하는지 설정할 수 있습니다. 'changes'에 대해 실제로 작은값을 원한다면 노이즈 제거 필터를 추가할 수도 있습니다.

## 설정

모션 감지 기능이있는 FFmpeg를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: ffmpeg_motion
    input: FFMPEG_SUPPORTED_INPUT
```

{% configuration %}
input:
  description: FFmpeg 호환 입력 파일. 스트림 또는 피드.
  required: true
  type: string
name:
  description: 프론트 엔드의 카메라 이름을 대체.
  required: false
  type: string
initial_state:
  description: 홈어시스턴트로 `ffmpeg`를 시작.
  required: false
  type: boolean
  default: true
changes:
  description: 모션으로 감지하기 위해 두 프레임 사이에서 얼마나 많이 변경해야하는지 백분율로 표시합니다 (값이 낮을수록 더 민감합니다).
  required: false
  type: integer
  default: 10
reset:
  description: 새로운 움직임이 감지되지 않은 후 상태를 재설정하는 시간
  required: false
  type: integer
  default: 20
repeat:
  description: 모션을 트리거하기 위해 *repeat_time* 에서 감지해야하는 이벤트, 0번 반복은 비활성화됨을 의미합니다.
  required: false
  type: integer
  default: 0
repeat_time:
  description: 모션을 트리거하기 전에 *repeat* 이벤트 기간이 필요합니다. 0 초는 비활성화됨을 의미합니다.
  required: false
  type: integer
  default: 0
extra_arguments:
  description: 비디오 노이즈 필터링과 같은 `ffmpeg` 에 전달할 수 있는 추가 옵션.
  required: false
  type: string
{% endconfiguration %}

값을 실험하려면 (changes/100은 `ffmpeg`의 scene 값입니다) :

```bash
$ ffmpeg -i YOUR_INPUT -an -filter:v select=gt(scene\,0.1) -f framemd5 -
```

이 센서에 문제가있는 경우 [troubleshooting section](/integrations/ffmpeg/#troubleshooting)를 참조하십시오.

#### Tips

- [crop filter](https://ffmpeg.org/ffmpeg-filters.html#crop)가 있는 사용자 정의 영역에서만 모션을 사용하십시오.

```yaml
extra_arguments: -filter:v "crop=100:100:12:34"
```
