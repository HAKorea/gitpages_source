---
title: 라즈베리파이 Camera
description: Instructions on how to integrate Raspberry Pi within Home Assistant.
logo: raspberry-pi.png
ha_category:
  - DIY
ha_iot_class: Local Polling
ha_release: 0.17
---

`rpi_camera` 플랫폼을 사용하면 Raspberry Pi 카메라를 Home Assistant에 연동할 수 있습니다. 이 통합구성요소는 애플리케이션 [`raspistill`](https://www.raspberrypi.org/documentation/usage/camera/raspicam/raspistill.md)을 사용하여 카메라의 이미지를 저장합니다.

## 설정

설치시 이 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: rpi_camera
```

{% configuration %}
image_width:
  description: Set the image width.
  required: false
  type: integer
  default: 640
name:
  description: Name of the camera.
  required: false
  type: string
  default: Raspberry Pi Camera
image_height:
  description: Set the image height.
  required: false
  type: integer
  default: 480
image_quality:
  description: Set the image quality (from 0 to 100).
  required: false
  type: integer
  default: 7
image_rotation:
  description: Set image rotation (0-359).
  required: false
  type: integer
  default: 0
horizontal_flip:
  description: Set horizontal flip (0 to disable, 1 to enable).
  required: false
  type: integer
  default: 0
vertical_flip:
  description: Set vertical flip (0 to disable, 1 to enable).
  required: false
  type: integer
  default: 0
timelapse:
  description: Takes a picture every this many milliseconds (thousands of a second) - the default means one picture a second.
  required: false
  type: integer
  default: 1000
file_path:
  description: Save the picture in a custom file path.
  required: false
  type: string
  default: A temporary file is used.
{% endconfiguration %}

카메라 플랫폼 설정에서 쓰기 가능한 검사를 수행하므로 지정된 **file_path**는 기존 파일이어야합니다. 또한 경로는 [whitelisted](/docs/configuration/basic/)이어야합니다.