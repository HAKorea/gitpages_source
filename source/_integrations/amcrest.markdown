---
title: Amcrest 카메라
description: Instructions on how to integrate Amcrest IP cameras within Home Assistant.
logo: amcrest.png
ha_category:
  - Hub
  - Binary Sensor
  - Camera
  - Sensor
ha_iot_class: Local Polling
ha_release: 0.49
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/DHH0S2j6uBU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`amcrest` 카메라 플랫폼을 사용하면 [Amcrest](https://amcrest.com/) IP 카메라를 Home Assistant에 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Binary Sensor
- Camera
- Sensor


## 설정

설치시 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
amcrest:
  - host: IP_ADDRESS_CAMERA
    username: YOUR_USERNAME
    password: YOUR_PASSWORD

```

{% configuration %}
host:
  description: >
    카메라의 IP 주소 또는 호스트 이름. 호스트 이름을 사용하는 경우 DNS가 예상대로 작동하는지 확인하십시오.
  required: true
  type: string
username:
  description: 카메라에 액세스하기위한 사용자 이름.
  required: true
  type: string
password:
  description: 카메라에 액세스하기위한 비밀번호.
  required: true
  type: string
name:
  description: >
    이 매개 변수를 사용하면 카메라 이름을 무시할 수 있습니다. 다중 카메라 설정의 경우 이름이 할당되지 않은 경우 재부팅 할 때마다 카메라 ID 번호가 임의로 변경되므로 이름을 정하길 권장합니다.
  required: false
  type: string
  default: Amcrest Camera
port:
  description: 카메라가 실행되는 포트.
  required: false
  type: integer
  default: 80
resolution:
  description: >
    이 매개 변수를 사용하면 카메라 해상도를 지정할 수 있습니다.
    고해상도 (1080/720p)의 경우, `high` 옵션 지정.
    VGA해상도 (640x480p)의 경우, `low` 옵션 지정.
  required: false
  type: string
  default: high
stream_source:
  description: >
    라이브 스트림의 데이터 소스. `mjpeg`는 카메라의 기본 MJPEG 스트림을 사용하고 `snapshot`은 카메라의 스냅샷 API를 사용하여 스틸 이미지에서 스트림을 만듭니다. RTSP 프로토콜을 통해 스트리밍을 생성하도록 `rtsp` 옵션을 설정할 수도 있습니다.
  required: false
  type: string
  default: snapshot
ffmpeg_arguments:
  description: >
    이미지 품질 또는 비디오 필터 옵션과 같이 ffmpeg로 전달할 수 있는 추가 옵션.
  required: false
  type: string
  default: -pred 1
authentication:
  description: >
    **stream_source**가 **mjpeg**인 경우에만 사용할 인증 방법을 정의. 현재 *aiohttp*는 *basic* 만 지원.
  required: false
  type: string
  default: basic
scan_interval:
  description: 센서의 업데이트 간격을 초 단위로 정의
  required: false
  type: integer
  default: 10
binary_sensors:
  description: >
    프론트 엔드에 표시할 조건.
    다음과 같은 조건을 모니터링 할 수 있습니다.:
  required: false
  type: list
  default: None
  keys:
    motion_detected:
      description: "모션이 감지되었을 때, `on` 반환, 그렇지 않을 경우 `off` 반환."
    online:
      description: "카메라를 사용할 수 있으면(즉, 명령에 응답하면) `on`, 그렇지 않으면 `off` 반환."
sensors:
  description: >
    프론트 엔드에 표시 할 조건.
    다음과 같은 조건을 모니터링 할 수 있습니다. : 
  required: false
  type: list
  default: None
  keys:
    sdcard:
      description: 총용량과 사용된 용량을 보고하여 SD카드 사용량을 반환.
    ptz_preset:
      description: >
        주어진 카메라에 설정된 PTZ 프리셋 위치 숫자를 반환합니다.
control_light:
  description: >
     오디오 또는 비디오 스트림이 활성화된 경우 카메라의 라이트를 자동으로 제어하고 두 스트림 모두 비활성화된 경우 끄십시오.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

최신 펌웨어의 Amcrest 카메라는 더 이상 MJPEG 인코딩으로 고화질(`high`) 비디오를 스트리밍 할 수 없습니다. 대신 저해상도(`low`) 스트림 또는 `snapshot` 스트림 소스를 사용해야 할 수도 있습니다. 품질이 너무 좋지 않으면 카메라 관리자에서 카메라의 `Frame Rate (FPS)`를 낮추고 `Bit Rate` 설정을 최대로 설정하십시오. *stream_source*를 **mjpeg**로 정의한 경우 카메라가 *Basic* HTTP 인증을 지원하는지 확인하십시오. 최신 Amcrest 펌웨어가 작동하지 않을 수 있으며 대신 **rtsp**가 권장됩니다.

**Note:** `stream_source` 옵션을 `rtsp`로 설정한 경우, [ffMPEG](/integrations/ffmpeg/) 문서에 언급된 단계를 따라 `ffmpeg`를 설치하십시오.

## 서비스

`amcrest` 통합구성요소는 일단 로드되면 다양한 작업을 수행하기 위해 호출할 수있는 서비스를 노출합니다. `entity_id` 서비스 속성은 하나 이상의 특정 카메라를 지정하거나 `all`을 사용하여 설정된 모든 Amcrest 카메라를 지정할 수 있습니다.

사용가능한 서비스:
`enable_audio`, `disable_audio`,
`enable_motion_recording`, `disable_motion_recording`,
`enable_recording`, `disable_recording`,
`goto_preset`, `set_color_bw`,
`start_tour`, `stop_tour`

#### `enable_audio`/`disable_audio` 서비스

이 서비스는 카메라의 오디오 스트림을 활성화 또는 비활성화합니다.

Service data attribute | Optional | Description
-|-|-
`entity_id` | no | 엔티티의 이름, 예: `camera.living_room_camera`

#### `enable_motion_recording`/`disable_motion_recording` 서비스

이러한 서비스는 움직임이 감지될 때 카메라가 설정된 저장 위치에 클립을 기록할 수 있도록합니다.

Service data attribute | Optional | Description
-|-|-
`entity_id` | no | 엔티티의 이름, 예: `camera.living_room_camera`.

#### `enable_recording`/`disable_recording` 서비스

이러한 서비스를 통해 카메라가 설정된 저장 위치에 지속적으로 녹화할 수 있습니다.

Service data attribute | Optional | Description
-|-|-
`entity_id` | no | 엔티티의 이름, 예: `camera.living_room_camera`.

#### `goto_preset` 서비스

이 서비스는 카메라를 카메라 내에 설정된 PTZ 위치 중 하나로 이동시킵니다.

Service data attribute | Optional | Description
-|-|-
`entity_id` | no | 엔티티의 이름, 예: `camera.living_room_camera`.
`preset` | no | 1부터 시작하는 사전 설정 번호

#### `set_color_bw` 서비스

이 서비스는 카메라의 컬러 모드를 설정합니다.

Service data attribute | Optional | Description
-|-|-
`entity_id` | no | 엔티티의 이름, 예: `camera.living_room_camera`.
`color_bw` | no | `auto`, `bw` 혹은 `color` 중 하나.

#### `start_tour`/`stop_tour` 서비스

이 서비스는 카메라의 PTZ 투어 기능을 시작하거나 중지합니다.

Service data attribute | Optional | Description
-|-|-
`entity_id` | no | 엔티티의 이름, 예 :`camera.living_room_camera`.

## 고급 설정

이 고급 설정 예를 사용할 수도 있습니다. : 

```yaml
# Example configuration.yaml entry
amcrest:
  - host: IP_ADDRESS_CAMERA_1
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    binary_sensors:
      - motion_detected
      - online
    sensors:
      - sdcard

  # Add second camera
  - host: IP_ADDRESS_CAMERA_2
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    name: Amcrest Camera 2
    resolution: low
    stream_source: snapshot
    sensors:
      - ptz_preset
```

Amcrest 카메라가 지원/테스트되었는지 확인하려면 `python-amcrest` 프로젝트의 [supportability matrix](https://github.com/tchellomello/python-amcrest#supportability-matrix) 링크를 방문하십시오.