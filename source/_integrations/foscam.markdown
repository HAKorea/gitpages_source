---
title: 포스캠(foscam)
description: Instructions on how to integrate Foscam IP cameras within Home Assistant.
logo: foscam.png
ha_category:
  - Camera
ha_iot_class: Local Polling
ha_release: 0.7.3
ha_codeowners:
  - '@skgsergio'
---

`foscam` 플랫폼을 사용하면 홈어시스턴트에서 [Foscam](https://www.foscam.com) IP 카메라의 라이브 스트림을 볼 수 있습니다.

## 설정

Foscam IP 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: foscam
    ip: IP_ADDRESS
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
ip:
  description: 카메라의 IP 주소
  required: true
  type: string
port:
  description: 카메라가 실행되는 포트
  required: false
  default: 88
  type: integer
rtsp_port:
  description: 카메라가 RTSP에 사용하는 포트.  이는 일반적으로 자동 검색되지만 R2 및 R2C와 같은 일부 모델에는 이 세트가 필요할 수 있습니다.
  required: false
  default: None
  type: integer
username:
  description: 카메라에 액세스하기위한 사용자 이름
  required: true
  type: string
password:
  description: 카메라에 액세스하기위한 비밀번호
  required: true
  type: string
name:
  description: 이 매개 변수를 사용하면 카메라 이름을 무시할 수 있습니다
  required: false
  type: string
{% endconfiguration %}

<div class='note'>
Foscam 내에서 암호가 길고 특정 기호가 포함된 암호에 문제가 있는것 같습니다. 카메라 설명서를 확인하십시오.
</div>

### `foscam.ptz` 서비스

Foscam 카메라가 PTZ를 지원하는 경우 카메라를 이동하거나 기울일 수 있습니다.

| Service data attribute | Description |
| -----------------------| ----------- |
| `entity_id` | String or list of strings that point at `entity_id`s of cameras. Else targets all. |
| `movement` | 	Direction of the movement. Allowed values: `up`, `down`, `left`, `right`, `top_left`, `top_right`, `bottom_left`, `bottom_right` |
| `travel_time` | (Optional) Travel time in seconds. Allowed values: float from 0 to 1. Default: 0.125 |

### 컨트롤이 가능한 예제 카드

<p class='img'>
  <img src='/images/integrations/foscam/example-card.png' alt='Screenshot showing a foscam camera using a picture-elements with PTZ controls.'>
  팬 및 틸트 컨트롤이있는 Foscam 카메라를 보여주는 예.
</p>


다음 카드 코드를 사용하면 Foscam 카메라의 라이브 비디오 피드를 표시하는 카드를 오른쪽 하단 모서리에서 카메라를 움직일 수 있는 컨트롤과 함께 얻을 수 있습니다.

```yaml
type: picture-elements
entity: camera.bedroom
camera_image: camera.bedroom
camera_view: live
elements:
  - type: icon
    icon: 'mdi:arrow-up'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 25px
      bottom: 50px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: up
  - type: icon
    icon: 'mdi:arrow-down'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 25px
      bottom: 0px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: down
  - type: icon
    icon: 'mdi:arrow-left'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 50px
      bottom: 25px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: left
  - type: icon
    icon: 'mdi:arrow-right'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 0px
      bottom: 25px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: right
  - type: icon
    icon: 'mdi:arrow-top-left'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 50px
      bottom: 50px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: top_left
  - type: icon
    icon: 'mdi:arrow-top-right'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 0px
      bottom: 50px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: top_right
  - type: icon
    icon: 'mdi:arrow-bottom-left'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 50px
      bottom: 0px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: bottom_left
  - type: icon
    icon: 'mdi:arrow-bottom-right'
    style:
      background: 'rgba(255, 255, 255, 0.5)'
      right: 0px
      bottom: 0px
    tap_action:
      action: call-service
      service: foscam.ptz
      service_data:
        entity_id: camera.bedroom
        movement: bottom_right
```

### 추가 CGI 명령

CGI 명령을 지원하는 oscam 웹캠은 홈어시스턴트 ([Source](http://www.ipcamcontrol.net/files/Foscam%20IPCamera%20CGI%20User%20Guide-V1.0.4.pdf)에서 제어 할 수 있습니다). 이 작업을 수행하는 방법에 대한 예는 [Foscam IP Camera Pan, Tilt, Zoom Control](/cookbook/foscam_away_mode_PTZ/) Cookbook 항목을 참조하십시오.