---
title: 안드로이드 IP Webcam
description: Connect Android devices as an IP webcam to Home Assistant
logo: android_ip_webcam.png
ha_category:
  - Hub
  - Binary Sensor
  - Camera
  - Sensor
  - Switch
ha_release: '0.40'
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/eo55kn64C6M" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`android_ip_webcam` 통합구성요소는 모든 Android 폰 또는 태블릿을 여러 보기 옵션이있는 네트워크 카메라로 쓸 수 있습니다.

MJPEG 카메라로 설정되고 모든 설정은 Home Assistant 내부의 스위치로 설정됩니다. 센서를 노출시킬 수도 있습니다. 스마트폰이 여러 개인 경우 목록 내 모든 옵션을 사용할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :

- Binary Sensor
- Camera
- Sensor
- Switch


## 셋업 (Setup)

[the IP Webcam app](https://play.google.com/store/apps/details?id=com.pas.webcam)을 다운로드하고 앱을 시작하십시오. 'Start Server'을 누르면 전화기에서 비디오 스트리밍이 시작되고 장치의 IP 주소가 화면에 표시됩니다. 

## 설정 (Configuration)

컴포넌트를 설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
android_ip_webcam:
  - host: 192.168.1.10
```

{% configuration %}
host:
  description: 네트워크에서 전화의 IP 주소.
  required: true
  type: string
port:
  description: IP 웹캠이 수신하는 포트.
  required: false
  default: 8080
  type: integer
name:
  description: 전화 이름을 무시함.
  required: false
  default: IP Webcam
  type: string
username:
  description: 전화에 액세스하기위한 사용자 이름.
  required: inclusive
  type: string
password:
  description: 전화에 액세스하기위한 비밀번호.
  required: inclusive
  type: string
scan_interval:
  description: 전화의 업데이트 간격을 정의.
  required: false
  default: 10
  type: integer
sensors:
  description: 프런트 엔드에 센서를 표시하기위한 조건입니다. 지원되는 센서 목록을 참조하십시오.
  required: false
  type: list
  keys:
    audio_connections:
      description: 오디오 연결
    battery_level:
      description: 배터리 잔량
    battery_temp:
      description: 배터리 온도
    battery_voltage:
      description: 배터리 전압
    light:
      description: 빛의 밝기
    motion:
      description: 모션 감지
    pressure:
      description: 현재 압력
    proximity:
      description: 근접
    sound:
      description: 소리 감지
    video_connections:
      description: 비디오 연결
switches:
  description: 프런트 엔드에 설정을 표시하기위한 조건입니다. 지원되는 스위치 목록을 참조하십시오.
  required: false
  type: list
  keys:
    exposure_lock:
      description: 노출 잠금 제어
    ffc:
      description: 전면 카메라를 제어
    focus:
      description: 초점을 조절.
    gps_active:
      description: GPS를 제어.
    night_vision:
      description: 나이트 비전을 제어
    overlay:
      description: 오버레이를 제어.
    torch:
      description: 토치를 제어.
    whitebalance_lock:
      description: 화이트 밸런스 잠금 장치를 제어.
    video_recording:
      description: 비디오 녹화를 제어.
motion_sensor:
  description: 만일 `auto_discovery`가 비활성화 된 경우 모션 센서 활성화
  required: false
  type: boolean
  default: false
{% endconfiguration %}

<div class='note'>

Home Assistant에서 센서 상태를 보려면 Android 앱에서 로깅을 활성화해야합니다 (`Data logging` > `Enable data logging`). 센서 상태는 활성화 될 때까지 `unknown`으로 유지됩니다.

</div>

## Full example

```yaml
# Example configuration.yaml entry
android_ip_webcam:
  - host: 192.168.1.202
    port: 8000
    sensors:
      - audio_connections
      - battery_level
      - battery_temp
      - battery_voltage
      - light
      - motion
      - pressure
      - proximity
      - sound
      - video_connections
    switches:
      - exposure_lock
      - ffc
      - focus
      - gps_active
      - night_vision
      - overlay
      - torch
      - whitebalance_lock
      - video_recording
  - host: 192.168.1.203
    port: 8000
    sensors:
      - light
    switches:
      - torch
```

## Binary Sensor

`android_ip_webcam` 바이너리 센서 플랫폼을 사용하면 Home Assistant를 통해 [Android IP webcam](https://play.google.com/store/apps/details?id=com.pas.webcam) 센서의 모션 상태를 관찰 할 수 있습니다. 장치가 자동으로 설정됩니다.

## Examples

다음 스크립트를 사용하여 binary 모션 센서를 설정할 수도 있습니다. :

{% raw %}

```yaml
binary_sensor:
  - platform: rest
    name: Kitchen Motion
    sensor_class: motion
    resource: http://IP:8080/sensors.json?sense=motion_active
    value_template: '{{ value_json.motion_active.data[0][1][0] | round(0) }}'
```

{% endraw %}

## 카메라 

`android_ip_webcam` 통합구성요소는 연동을 사용하지 않고 여전히 비디오 피드를 보려는 경우 [`mjpeg` camera](/integrations/mjpeg) 플랫폼을 사용해서 기본적인 카메라로 추가 가능합니다.

## 설정

설치시 카메라 만 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: mjpeg
    mjpeg_url: http://IP_ADDRESS:8080/video
```

## 센서 

`android_ip_webcam` 센서 플랫폼을 사용하면 Home Assistant를 통해 [Android IP webcam](https://play.google.com/store/apps/details?id=com.pas.webcam) 센서의 상태를 관찰 할 수 있습니다. 

웹캠 서버에서 JSON 파일을 검사하여 자체 센서를 설정할 수 있습니다 : `http://IP:8080/sensors.json`
