---
title: MJPEG IP Camera
description: Instructions on how to integrate IP cameras within Home Assistant.
logo: home-assistant.png
ha_category:
  - Camera
ha_release: pre 0.7
ha_iot_class: Configurable
---

`mjpeg` 카메라 플랫폼은 홈어시스턴트로 MJPEG과의 비디오를 스트리밍 할 수있는 IP 카메라를 통합 할 수 있습니다.

## 설정 

설치시 이 카메라를 활성화하려면 `configuration.yaml`파일에 다음을 추가 하십시오

```yaml
# Example configuration.yaml entry
camera:
  - platform: mjpeg
    mjpeg_url: http://192.168.1.92/mjpeg
```

{% configuration %}
mjpeg_url:
  description: 카메라에서 동영상을 제공하는 URL. 예들들면 `http://192.168.1.21:2112/`
  required: true
  type: string
still_image_url:
  description: 카메라가 지원하는 경우 썸네일 사진의 URL.
  required: false
  type: string
name:
  description: 이 매개 변수를 사용하면 카메라 이름을 무시 가능.
  required: false
  type: string
username:
  description: 카메라에 액세스하기위한 사용자 이름.
  required: false
  type: string
password:
  description: 카메라에 액세스하기위한 비밀번호.
  required: false
  type: string
authentication:
  description: "`basic` 또는 `digest` 요청에 대한 인증."
  required: false
  type: string
  default: basic
verify_ssl:
  description: 이 카메라의 SSL 인증서를 확인. 
  required: false
  type: boolean
  default: true
{% endconfiguration %}

## 예시  

D-Link의 DCS-930L Wireless N 네트워크 카메라 사용 예 : 

```yaml
camera:
  - platform: mjpeg
    name: Livingroom Camera
    still_image_url: http://IP/image.jpg
    mjpeg_url: http://IP/video/mjpg.cgi
```

Blue Iris 서버에서 Blue Iris 카메라를 연동하는 예

```yaml
camera:
  - platform: mjpeg
    name: Livingroom Camera
    mjpeg_url: http://IP:PORT/mjpg/CAMERASHORTNAME/video.mjpeg
    username: BLUE_IRIS_USERNAME
    password: BLUE_IRIS_PASSWORD
    authentication: basic
```
