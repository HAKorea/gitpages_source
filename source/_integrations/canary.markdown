---
title: 보안카메라(Canary)
description: Instructions on how to integrate your Canary devices into Home Assistant.
logo: canary.png
ha_category:
  - Alarm
  - Camera
  - Sensor
ha_release: '0.60'
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/zt837RPaWNw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`canary` 통합구성요소를 사용하면 [Canary](https://canary.is) 장치를 Home Assistant에 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Alarm
- [Camera](#camera)
- [Sensor](#sensor)

## 설정

이 모듈을 사용하려면 Canary 로그인 정보 (사용자 이름, 일반적으로 이메일 주소 및 비밀번호)가 필요합니다.

설정하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
canary:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The username for accessing your Canary account.
  required: true
  type: string
password:
  description: The password for accessing your Canary account.
  required: true
  type: string
timeout:
  description: Timeout to wait for connections.
  required: false
  type: integer
  default: 10
{% endconfiguration %}

일단 로드되면 프론트 엔드는 다음과 같이 연동됩니다.

- A camera image triggered by motion for each camera.
- An alarm control panel for each location.
- A sensor per camera that reports temperature.
- A sensor per camera that reports humidity.
- A sensor per camera that reports air quality.

## 카메라

`canary` 카메라 플랫폼을 사용하면 Home Assistant에서 [Canary](https://canary.is) 카메라의 라이브 스트림을 볼 수 있습니다. 이를 위해서는 [`ffmpeg` integration](/integrations/ffmpeg/)이 이미 설정되어 있어야합니다.

[Canary integration](/integrations/canary/) 설정이 완료되면 [Canary](https://canary.is) 카메라가 자동으로 표시됩니다.

## 설정

`configuration.yaml` 파일에 다음을 추가하여 옵션 설정으로 `canary` 카메라를 설정할 수 있습니다.

```yaml
camera:
  - platform: canary
```

{% configuration %}
ffmpeg_arguments:
  description: Extra options to pass to `ffmpeg`, e.g., image quality or video filter options. More details in [FFmpeg integration](/integrations/ffmpeg).
  required: false
  type: string
{% endconfiguration %}

## Sensor

`canary` 센서 플랫폼을 사용하면 [Canary](https://canary.is) 장치의 센서를 Home Assistant에 연동할 수 있습니다.

`canary` 센서를 추가하려면 위의 지침을 따르십시오.

로드되면 다음 센서가 표시됩니다.

- A sensor per camera that reports temperature.
- A sensor per camera that reports humidity.
- A sensor per camera that reports air quality.
