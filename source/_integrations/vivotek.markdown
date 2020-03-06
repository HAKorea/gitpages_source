---
title: 비보텍(Vivotek)
description: Instructions on how to integrate Vivotek cameras within Home Assistant.
ha_category:
  - Camera
logo: vivotek.jpg
ha_release: 0.99
ha_iot_class: Local Polling
ha_codeowners:
  - '@HarlemSquirrel'
---

`vivotek` 카메라 플랫폼을 사용하면 Vivotek IP 카메라를 Home Assistant에 통합할 수 있습니다.

홈어시스턴트는 서버를 통해 이미지를 제공하므로 네트워크 외부에있는 동안 IP 카메라를 볼 수 있습니다. 
엔드 포인트는 `/api/camera_proxy/camera.[name]`입니다.

## 설정

설치시 이 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: vivotek
    ip_address: IP_ADDRESS
    username: USERNAME
    password: PASSWORD
```

{% configuration %}
ip_address:
  description: "The IP address of your camera, e.g., `192.168.1.2`."
  required: true
  type: string
name:
  description: This parameter allows you to override the name of your camera.
  required: false
  default: Vivotek Camera
  type: string
username:
  description: The username for accessing your camera.
  required: true
  type: string
password:
  description: The password for accessing your camera.
  required: true
  type: string
authentication:
  description: "Type for authenticating the requests `basic` or `digest`."
  required: false
  default: basic
  type: string
security_level:
  description: The security level of the user accessing your camera. This could be `admin` or `viewer`.
  required: false
  default: admin
  type: string
ssl:
  description: Enable or disable SSL. Set to false to use an HTTP-only camera.
  required: false
  default: false
  type: boolean
verify_ssl:
  description: Enable or disable SSL certificate verification. Set to false to use an HTTP-only camera, or you have a self-signed SSL certificate and haven't installed the CA certificate to enable verification.
  required: false
  default: true
  type: boolean
framerate:
  description: The number of frames-per-second (FPS) of the stream. Can cause heavy traffic on the network and/or heavy load on the camera.
  required: false
  default: 2
  type: integer
stream_path:
  description: This parameter allows you to override the stream path.
  required: false
  default: live.sdp
  type: string
{% endconfiguration %}

### 고급 설정

```yaml
# Example configuration.yaml entry
camera:
  - platform: vivotek
    name: Front door camera
    ip_address: 192.168.1.2
    ssl: true
    username: !secret fd_camera_username
    password: !secret fd_camera_pwd
    authentication: digest
    security_level: admin
    verify_ssl: false
    framerate: 5
    stream_path: live2.sdp
```

### 서비스

`camera` 플랫폼은 일단 로드되면 다양한 작업을 수행하기 위해 호출할 수 있는 서비스를 노출합니다.

사용가능한 서비스 : `enable_motion_detection`, `disable_motion_detection`, `snapshot`, `play_stream`.

#### `play_stream` 서비스

카메라에서 선택한 미디어 플레이어로 라이브 스트림을 재생합니다. [`stream`](/integrations/stream) 통합구성요소를 설정해야합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | Name of entity to fetch stream from, e.g., `camera.front_door_camera`. |
| `media_player`         |      no  | Name of media player to play stream on, e.g., `media_player.living_room_tv`. |
| `format`               |      yes | Stream format supported by `stream` integration and selected `media_player`. Default: `hls` |

For example, the following action in an automation would send an `hls` live stream to your chromecast.

```yaml
action:
  service: camera.play_stream
  data:
    entity_id: camera.yourcamera
    media_player: media_player.chromecast
```

#### `enable_motion_detection` 서비스

카메라에서 움직임 감지를 활성화합니다. 현재 이는 카메라에 설정된 첫 번째 이벤트를 활성화합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |     yes  | Name(s) of entities to enable motion detection, e.g., `camera.front_door_camera`. |

#### `disable_motion_detection` 서비스

카메라에서 동작 감지를 비활성화합니다. 현재 카메라에 설정된 첫 번째 이벤트가 비활성화됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |     yes  | Name(s) of entities to disable motion detection, e.g., `camera.front_door_camera`. |

#### `snapshot` 서비스

카메라에서 스냅샷을 찍습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | Name(s) of entities to create a snapshot from, e.g., `camera.front_door_camera`. |
| `filename`             |      no  | Template of a file name. Variable is `entity_id`, e.g., {% raw %}`/tmp/snapshot_{{ entity_id }}`{% endraw %}. |

`filename`의 경로 부분은 `configuration.yaml` 파일의 [`homeassistant :`](/docs/configuration/basic/) 섹션에있는 `whitelist_external_dirs`의 항목이어야합니다.

예를 들어 다음 작업은 "front_door_camera"에서 스냅샷을 찍어 타임 스탬프가 지정된 파일 이름으로 /tmp에 저장하는 자동화입니다.

{% raw %}
```yaml
action:
  service: camera.snapshot
  data:
    entity_id: camera.front_door_camera
    filename: '/tmp/yourcamera_{{ now().strftime("%Y%m%d-%H%M%S") }}.jpg'
```
{% endraw %}
