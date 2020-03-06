---
title: ONVIF(표준네트워크비디오)
description: Instructions on how to integrate a ONVIF camera within Home Assistant.
logo: onvif.png
ha_category:
  - Camera
ha_release: 0.47
---

`onvif` 카메라 플랫폼을 사용하면 Home Assistant에서 [ONVIF](https://www.onvif.org/) 카메라를 사용할 수 있습니다. 이를 위해서는 [`ffmpeg` component](/integrations/ffmpeg/)가 이미 설정되어 있어야합니다. 

## 설정

설치시 ONVIF 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: onvif
    host: 192.168.1.111
```

{% configuration %}
host:
  description: 카메라의 IP 주소 또는 호스트 이름
  required: true
  type: string
name:
  description: 카메라 이름을 덮어씁니다. 
  required: false
  type: string
  default: ONVIF Camera
username:
  description: 카메라의 사용자 이름.
  required: false
  type: string
  default: admin
password:
  description: 카메라의 비밀번호.
  required: false
  type: string
  default: 888888
port:
  description: 카메라의 (HTTP) 포트.
  required: false
  type: integer
  default: 5000
profile:
  description: 스트림을 얻는 데 사용되는 비디오 프로필, 자세한 내용은 아래를 참조.
  required: false
  type: integer
  default: 0
extra_arguments:
  description: "이미지 품질 또는 비디오 필터 옵션과 같은 `ffmpeg`에 전달할 추가 옵션. [`ffmpeg` component](/integrations/ffmpeg)에 자세한 내용이 있습니다."
  required: false
  type: string
  default: -q:v 2
{% endconfiguration %}

대부분의 ONVIF 카메라는 둘 이상의 오디오 / 비디오 프로파일을 지원합니다. 각 프로파일은 서로 다른 이미지 품질을 제공합니다. 일반적으로 첫 번째 프로필의 품질이 가장 높으며 기본적으로 사용되는 프로필입니다. 그러나 저품질 이미지를 사용하고 싶을 수도 있습니다. 그 이유 중 하나는 하드웨어가 특히 Raspberry Pi에서 실행될 때 실시간으로 최고 품질의 이미지를 렌더링 할 수 없기 때문일 수 있습니다. 따라서 설정에서 `profile` 변수를 세팅하여 사용하려는 프로파일을 선택할 수 있습니다.

### `camera.onvif_ptz` 서비스

ONVIF 카메라가 PTZ를 지원하면 카메라를 패닝, 틸트 또는 줌할 수 있습니다. 

| Service data attribute | Description |
| -----------------------| ----------- |
| `entity_id` | String or list of strings that point at `entity_id`s of cameras. Else targets all.
| `tilt` | Tilt direction. Allowed values: `UP`, `DOWN`, `NONE`
| `pan` | Pan direction. Allowed values: `RIGHT`, `LEFT`, `NONE`
| `zoom` | Zoom. Allowed values: `ZOOM_IN`, `ZOOM_OUT`, `NONE`

이 센서에 문제가 발생하면 [Troubleshooting section](/integrations/ffmpeg/#troubleshooting)을 참조하십시오.