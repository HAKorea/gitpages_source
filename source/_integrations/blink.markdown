---
title: Blink 보안 카메라
description: Instructions for how to integrate Blink camera/security system within Home Assistant.
logo: blink.png
ha_category:
  - Hub
  - Alarm
  - Binary Sensor
  - Camera
  - Sensor
ha_release: '0.40'
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@fronzbot'
---

`blink` 통합구성요소를 통해 [Blink](https://blinkforhome.com/) 카메라 및 보안 시스템에서 카메라 이미지 및 모션 이벤트를 볼 수 있습니다.

<iframe width="690" height="437" src="https://www.youtube.com/embed/yjSH0aJDi1Q?start=855" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## 셋업

이 모듈을 사용하려면 Blink 로그인 정보 (일반적으로 전자메일주소인 사용자 이름 및 암호)가 필요합니다.

## 설정

[Blink](https://blinkforhome.com) 계정에 연결된 장치를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
blink:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Blink 계정에 액세스하기위한 사용자 이름
  required: true
  type: string
password:
  description: Blink 계정에 액세스하기위한 비밀번호
  required: true
  type: string
scan_interval:
  description: 새 데이터를 쿼리하는 빈도. 기본값은 300 초 (5 분)입니다.
  required: false
  type: integer
binary_sensors:
  description: 이진 센서 설정 옵션.
  required: false
  type: map
  keys:
   monitored_conditions:
     description: 센서 생성 조건.
     required: false
     type: list
     default: all (`motion_enabled`, `motion_detected`)
sensors:
  description: 센서 설정 옵션.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: 센서 생성 조건.
      required: false
      type: list
      default: all (`battery`, `temperature`, `wifi_strength`)
offset:
  description: How far back in time (minutes) to look for motion. Motion is determined if a new video has been recorded between now and the last time you refreshed plus this offset. 
  required: false
  type: integer
  default: 1
mode:
  description: Set to 'legacy' to enable use of old API endpoint subdomains (APIs can differ based on region, so use this if you are having issues with the integration).
  required: false
  type: string
  default: not set
{% endconfiguration %}

Home Assistant가 시작되면 `blink` 통합구성요소는 다음 플랫폼을 만듭니다. :

- 모든 blink 시스템을 arm/disarm 하는 `alarm_control_panel`(주의 : `arm_arm_home`은 GUI의 옵션임에도 불구하고 구현되지 않았으며 실제로 아무것도하지 않습니다.)
- blink 동기화 모듈에 연결된 각 카메라의 `camera`.
- `monitored_conditions`에 나열된 모든 항목에 대한 카메라마다의 `sensor` (`configuration.yaml`에 지정된 항목이 없으면 기본적으로 모든 항목이 추가됩니다. )
- `monitored_conditions`에 나열된 각 항목에 대한 `binary_sensor` (`configuration.yaml`에 지정된 항목이 없으면 기본적으로 모든 항목이 추가됩니다.)

카메라는 배터리로 작동하므로 배터리를 너무 빨리 소모하지 않도록 API를 너무 많이 사용하지 않으면서 Blink의 서버를 혼란스럽게 하지 않도록 `scan_interval` 설정을 주의해서 수행해야합니다. `scan_interval`에 의한 조절을 무시하고 `trigger_camera` 서비스를 통해 카메라를 수동으로 업데이트 할 수 있습니다. 참고로, 모든 카메라 특정 센서는 카메라에서 새 이미지를 요청한 경우에만 폴링됩니다. 즉, 적시에 정확한 데이터를 제공하기 위해 이러한 센서를 사용하지 않는 것이 좋습니다. 

각 카메라는 서로 다른 두 가지 상태를보고합니다. : 하나는 `sensor.blink_ <camera_name> _status`이고 다른 하나는 `binary_sensor.blink_ <camera_name> _motion_enabled`입니다. `motion_enabled` 속성은 **시스템이 실제로 arm되어 있는지에 관계없이** `camera`가 모션을 감지 할 준비가되었는지 보고합니다.

아래는 가능한 모든 항목을 보여주는 예입니다.

```yaml
# Example configuration.yaml entry
blink:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
  scan_interval: 300
  binary_sensors:
    monitored_conditions:
      - motion_enabled
      - motion_detected
  sensors:
    monitored_conditions:
      - battery
      - temperature
      - wifi_strength
```

## 서비스

blink와 관련된 서비스에 대한 모든 순차적 호출은 호출이 제한되고 무시되는 것을 방지하기 위해 이들 사이에 최소 5 초의 지연이 있어야합니다.

### `blink.blink_update`

blink 시스템을 강제로 새로 고침

### `blink.trigger_camera`

카메라를 트리거하여 새로운 정지(still) 이미지를 만듭니다.

| Service Data Attribute | Optional | Description                            |
| ---------------------- | -------- | -------------------------------------- |
| `name`                 | no       | Name of camera to take new image with. |

### `blink.save_video`

카메라의 마지막 녹화 비디오를 로컬 파일에 저장하십시오. 대부분의 경우 Home Assistant는 디렉토리가 `configuration.yaml` 파일의 `whitelist_external_dirs`를 통해 쓰기 가능하다는 것을 알아야합니다 (아래 예 참조).

| Service Data Attribute | Optional | Description                              |
| ---------------------- | -------- | ---------------------------------------- |
| `name`                 | no       | Name of camera containing video to save. |
| `filename`             | no       | Location of save file.                   |


```yaml
homeassistant:
    ...
    whitelist_external_dirs:
        - '/tmp'
        - '/path/to/whitelist'
```

### 다른 서비스들

위에서 언급 한 서비스 외에도 일반적인 `camera` 및 `alarm_control_panel` 서비스도 사용할 수 있습니다. `camera.enable_motion_detection` 및 `camera.disable_motion_detection` 서비스를 통해 Blink 시스템 내에서 개별 카메라를 각각 활성화 및 비활성화 할 수 있습니다. `alarm_control_panel.alarm_arm_away` 및 `alarm_control_panel.alarm_disarm` 서비스를 통해 전체 시스템을 각각 arm 및 disarm 할 수 있습니다.

## 사례

다음은 Blink를 사용하여 서비스 호출을 올바르게 수행하는 방법을 보여주는 몇 가지 예입니다.

### 사진 찍기 및 로컬 저장

이 예제 스크립트는 Blink 앱에서 `My Camera` 라는 카메라로 사진을 찍는 방법을 보여줍니다 (
이것은 반드시 홈어시스턴트의 친숙한 이름(friendly name)은 아닙니다). 사진을 찍은 후 이미지는 `/tmp/my_image.jpg`라는 로컬 디렉토리에 저장됩니다. 이 예는 [camera integration](/integrations/camera#service-snapshot)에 있는 서비스를 사용합니다.

```yaml
alias: Blink Snap Picture
sequence:
    - service: blink.trigger_camera
      data:
          name: "My Camera"
    - delay: 00:00:05  
    - service: blink.blink_update
    - service: camera.snapshot
      data:
          entity_id: camera.blink_my_camera
          filename: /tmp/my_image.jpg
```

### 부재중 Blink를 Arm 상태로

이 예제 자동화는 blink 동기화 모듈을 활성화하여 모션 감지가 활성화 된 blink 카메라에서 움직임을 감지합니다. 기본적으로 Blink는 모든 카메라에서 모션 감지를 활성화하므로 앱에서 아무것도 변경하지 않으면 모든 설정이 완료됩니다. 개별 카메라에 대해 모션 감지를 수동으로 활성화하려면 [appropriate camera service](/integrations/camera#service-enable_motion_detection)를 사용할 수 있지만 동기화 모듈이 활성화된 경우에만 모션이 캡처됩니다.

이 예에서는 blink 모듈의 이름이 `My Sync Module`이고 재실 감지를 위해 [device trackers](/integrations/device_tracker)가 설정되어 있다고 가정합니다.

```yaml
- id: arm_blink_when_away
  alias: Arm Blink When Away
  trigger:
      platform: state
      entity_id: all
      to: 'not_home'
  action:
      service: alarm_control_panel.alarm_arm_away
      entity_id: alarm_control_panel.blink_my_sync_module 
```

### 재실시 Blink Disarm 상태로

이전 예와 마찬가지로이 자동화는 집에 도착할 때 Blink가 Arm을 해제합니다.

```yaml
- id: disarm_blink_when_home
  alias: Disarm Blink When Home
  trigger:
      platform: state
      entity_id: all
      to: 'home'
  action:
      service: alarm_control_panel.alarm_disarm
      entity_id: alarm_control_panel.blink_my_sync_module 
```

### 모션 감지시 비디오를 로컬에 저장

모션이 감지되면 Blink 홈어시스턴트 통합구성요소를 사용하여 Blink의 서버를 사용하여 데이터를 저장하지 않고 마지막으로 녹화 된 비디오를 로컬로 저장할 수 있습니다.

다시 이 예에서는 blink 앱에서 카메라 이름이 `My Camera`이고 동기화 모듈 이름이 `My Sync Module`이라고 가정합니다. 파일은 `/tmp/videos/blink_video_{YYYMMDD_HHmmSS}.mp4`에 저장됩니다. 여기서 `{YYYYMMDD_HHmmSS}`는 [templating](/docs/configuration/templating/)을 사용하여 생성된 타임 스탬프입니다.

{% raw %}
```yaml
- id: save_blink_video_on_motion
  alias: Save Blink Video on Motion
  trigger:
      platform: state
      entity_id: binary_sensor.blink_my_camera_motion_detected
      to: 'on'
  action:
      service: blink.save_video
      data_template:
          name: "My Camera"
          filename: "/tmp/videos/blink_video_{{ now().strftime('%Y%m%d_%H%M%S') }}.mp4"
      
```
{% endraw %}
