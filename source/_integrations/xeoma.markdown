---
title: 오픈소스 CCTV솔루션(Xeoma)
description: Instructions on how to integrate camera video feeds from a Xeoma server in Home Assistant
logo: xeoma.png
ha_category:
  - Camera
ha_iot_class: Local Polling
ha_release: 0.62
---

`Xeoma` 카메라 플랫폼을 사용하면 [Xeoma](https://felenasoft.com/xeoma) 비디오 감시 서버에서 비디오 피드를 볼 수 있습니다.

## 설정

Xeoma 카메라 피드를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: xeoma
    host: http://localhost:10090
```

{% configuration %}
host:
  description: The URL of the Xeoma server's web interface.
  required: true
  type: string
username:
  description: The username used to access the Xeoma server's web interface.
  required: false
  type: string
password:
  description: The password used to access the Xeoma server's web interface.
  required: false
  type: string
new_version:
  description: Set to false if the Xeoma server version is 17.5 or earlier.
  required: false
  type: boolean
  default: true
cameras:
  description: List of customizations for individual Xeoma cameras.
  required: false
  type: list
  keys:
    image_name:
      description: The name of the JPEG image for this camera as configured in Xeoma (without .jpg extension).
      required: true
      type: string
    name:
      description: The name to display in the frontend for this camera.
      required: false
      type: string
      default: The `image_name` for this camera.
    hide:
      description: Don't show this camera in Home Assistant.
      required: false
      type: boolean
      default: false
{% endconfiguration %}

## 전체 사례

```yaml
# Example configuration.yaml entry
camera:
  - platform: xeoma
    host: http://localhost:10090
    username: user
    password: secretpassword
    new_version: false
    cameras:
      - image_name: front_porch
        name: Front Porch
      - image_name: back_patio
        hide: true
```

이 플랫폼을 사용하려면 하나 이상의 카메라 체인에서 Xeoma 웹서버 모듈을 활성화해야합니다.

이 플랫폼은 Xeoma 웹 인터페이스를 분석하여 활성화 된 모든 카메라를 찾아 Home Assistant에 추가합니다. 플랫폼 설정을 사용하여 개별 카메라를 숨길 수 있습니다.

각 카메라의 `image_name` 설정값은 _.jpg_ 확장자가 제거된 Xeoma 웹서버 설정 (_path to access images_)에서 제공한 이름과 일치해야합니다.