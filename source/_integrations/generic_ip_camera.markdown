---
title: "일반 IP Camera"
description: "Instructions on how to integrate IP cameras within Home Assistant."
ha_category:
  - Camera
logo: home-assistant.png
ha_release: pre 0.7
ha_iot_class: Configurable
---

`generic` 카메라 플랫폼은 홈어시스턴트로 모든 IP 카메라 또는 다른 URL을 연동할 수 있습니다. 템플릿을 사용하여 URL을 즉석에서 생성 할 수 있습니다.

홈어시스턴트는 서버를 통해 이미지를 제공하므로 네트워크 외부에있는 동안 IP 카메라를 볼 수 있습니다. endpoint는 `/api/camera_proxy/camera.[name]` 입니다.

## 설정 

설치시 이 카메라를 활성화하려면 `configuration.yaml`파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: generic
    still_image_url: http://194.218.96.92/jpg/image.jpg
```

{% configuration %}
still_image_url:
  description: "카메라 정지화면을 제공하는 URL, 예: `http://192.168.1.21:2112/`. [template](/topics/templating/)도 가능."
  required: true
  type: string
stream_source:
  description: "실시간 스트림을 제공하는 URL, 예: `rtsp://192.168.1.21:554/`."
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
  description: "요청을 인증하기위한 타입 `basic` 혹은 `digest`."
  required: false
  default: basic
  type: string
limit_refetch_to_url_change:
  description: URL이 변경될 때 원격이미지를 다시 가져 오는 것을 제한. 템플릿을 사용하여 원격 이미지를 가져 오는 경우에만 해당.
  required: false
  default: false
  type: boolean
content_type:
  description: IP 카메라가 jpg 파일이 아닌 경우 IP 카메라의 컨텐츠 유형을 설정. `image/svg+xml` 사용시 동적 SVG 파일을 추가 가능
  required: false
  default: image/jpeg
  type: string
framerate:
  description: "스트림의 초당 프레임 수 (FPS)입니다. 네트워크에 트래픽이 많거나 카메라에 과부하가 발생 가능."
  required: false
  type: integer
verify_ssl:
  description: SSL 인증서 확인을 활성화 또는 비활성화합니다. http 전용 카메라를 사용하거나 자체 서명 된 SSL 인증서가 있고 활성화하기 위해 CA 인증서를 설치하지 않은 경우 false로 설정.
  required: false
  default: true
  type: boolean
{% endconfiguration %}

<p class='img'>
  <a href='/cookbook/google_maps_card/'>
    <img src='/images/integrations/camera/generic-google-maps.png' alt='Screenshot showing Google Maps integration in Home Assistant front end.'>
    동적 Google 지도 이미지를 가리키는 일반 카메라 플랫폼을 보여주는 예.
  </a>
</p>

## 사례 

이 섹션에서는이 카메라 플랫폼을 사용하는 방법에 대한 실제 예를 제공합니다.

### yr.no의 날씨 그래프

```yaml
camera:
  - platform: generic
    name: Weather
    still_image_url: https://www.yr.no/place/Norway/Oslo/Oslo/Oslo/meteogram.svg
    content_type: 'image/svg+xml'
```

### Hass.io에서의 로컬 이미지

이 플랫폼으로 정적 이미지를 표시 할 수 있습니다. 여기에 이미지를 넣으십시오. `/config/www/your_image.png`

```yaml
camera:
  - platform: generic
    name: Some Image
    still_image_url: https://127.0.0.1:8123/local/your_image.png
    verify_ssl: false
```

### 한 홈어시스턴트 인스턴스에서 다른 홈어시스턴트 인스턴스로 카메라 피드 공유

둘 이상의 홈 어시스턴트 인스턴스를 실행중인 경우 ( '호스트' 및 '수신자' 인스턴스라고 함) 수신자 인스턴스의 호스트 인스턴스에서 카메라 피드를 표시 할 수 있습니다.  [REST API](/developer/rest_api/#get-apicamera_proxycameraltentity_id)를 사용하여 다음과 같이 수신기를 구성하여 호스트의 카메라 피드 (IP 주소 127.0.0.5)에 액세스하고 수신기 인스턴스에 표시 할 수 있습니다. :

```yaml
camera:
  - platform: generic
    name: Host instance camera feed
    still_image_url: https://127.0.0.5:8123/api/camera_proxy/camera.live_view
```
### HTTP 전용 카메라에서의 이미지

HTTP를 통해서만 사용할 수있는 카메라에 액세스하려면 SSL 검증(verification)을 해제해야합니다.

```yaml
camera:
  - platform: generic
    name: Some Image
    still_image_url: http://example.org/your_image.png
    verify_ssl: false
```

### 라이브 스트림

[stream](/integrations/stream/) 구성 요소를 사용하여 스냅 샷 및 라이브 스트림 URL이 모두있는 카메라에 액세스합니다 .

```yaml
camera:
  - platform: generic
    name: Streaming Enabled
    still_image_url: http://194.218.96.92/jpg/image.jpg
    stream_source: rtsp://194.218.96.92:554
```
