---
title: 카메라 프록시
description: Instructions on how to integrate a camera proxy within Home Assistant.
ha_category:
  - Camera
ha_release: 0.65
---

`proxy` 카메라 플랫폼을 사용하면 사후처리 루틴을 통해 다른 카메라의 출력을 전달하고 사후처리된 출력으로 새 카메라를 생성 할 수 있습니다.

현재 사후처리는 이미지/MJPEG의 크기조정 및 혹은 자르기를 지원할 뿐만아니라 최대 화면 주사율을 제한합니다.

현재 프록시 기능은 느린 인터넷 연결을 위해 카메라 대역폭을 줄이기 위한 것입니다.

## 설정

설치시이 카메라를 활성화하려면 먼저 홈어시스턴트에 기존 작동 카메라가 구성되어 있어야합니다. 다음으로 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
camera:
  - platform: proxy
    entity_id: camera.<existingcamera>
    max_stream_width: 360
    max_image_width: 720
```

{% configuration %}
entity_id:
  description: 후 처리 할 다른 홈 어시스턴트 카메라의 ID.
  required: true
  type: string
name:
  description: 이 매개 변수를 사용하면 카메라 이름을 무시할 수 있습니다
  required: false
  type: string
mode:
  description: 작동 모드. `resize` 혹은 `crop`.
  required: false
  type: string
  default: resize
max_image_width:
  description: 카메라에서 촬영한 단일 이미지의 최대 너비 (가로 세로 크기 조정시 가로 세로 비율이 유지됨)
  required: false
  type: integer
max_image_height:
  description: 카메라에서 촬영한 단일 이미지의 최대 높이는 자르기 작업에만 사용됩니다. 제공하지 않으면 기본적으로 원래 높이로 적용합니다.
  required: false
  type: integer
max_stream_width:
  description: 카메라에서 MJPEG 스트림의 최대 너비입니다 (화면 크기 조정시 가로 세로 비율이 유지됨).
  required: false
  type: integer
max_stream_height:
  description: 카메라에서 MJPEG 스트림의 최대 높이는 자르기 작업에만 사용됩니다. 제공하지 않으면 기본적으로 원래 높이로 적용합니다
  required: false
  type: integer
image_top:
  description: 자르기 작업의 시작점으로 사용되는 상단 (y) 좌표입니다.
  required: false
  type: integer
  default: 0
image_left:
  description: 자르기 작업의 시작점으로 사용되는 왼쪽 (x) ​​좌표입니다.
  required: false
  type: integer
  default: 0
image_quality:
  description: 스냅샷의 JPEG 결과값에 사용되는 품질 수준.
  required: false
  type: integer
  default: 75
stream_quality:
  description: MJPEG 스트림의 결과값에 사용되는 품질 수준.
  required: false
  type: integer
  default: 75
image_refresh_rate:
  description: 연속 이미지 스냅샷 생성 사이의 최소 시간 (초)입니다.
  required: false
  type: float
force_resize:
  description: 결과 이미지가 원본보다 더 많은 대역폭을 차지하더라도 이미지 크기를 조정하십시오.
  required: false
  type: boolean
  default: false
cache_images:
  description: 마지막 이미지를 유지하고 카메라가 응답하지 않는 경우 다시 전송하십시오.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

## 사례

Foscam 카메라와 함께 두 개의 카메라 프록시를 사용하는 예 :


```yaml
camera:
  - platform: foscam
    ip: 192.168.1.10
    username: foscam_camera
    password: camera_password
    name: mycamera
  - platform: proxy
    entity_id: camera.mycamera
    max_stream_width: 360
    max_image_width: 480
    image_refresh_rate: 5.0
  - platform: proxy
    entity_id: camera.mycamera
    name: My cropped camera
    mode: crop
    max_image_width: 480
    max_image_height: 320
    image_left: 100
```
