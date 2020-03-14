---
title: 하이크비전(Hikvision)
description: Instructions on how to set up Hikvision camera binary sensors within Home Assistant.
logo: hikvision.png
ha_category:
  - Binary Sensor
ha_release: 0.35
ha_iot_class: Local Push
ha_codeowners:
  - '@mezz64'
---

Hikvision 바이너리 센서는 [Hikvision IP Camera or NVR](https://www.hikvision.com/)의 이벤트 스트림을 구문 분석하고 카메라/nvr 이벤트를 "off" 또는 "on" 상태로 보여줍니다. 

플랫폼은 카메라/nvr 인터페이스 내에서 트리거로서 "Notify the surveillance center"로 설정된 ​​모든 센서를 Home Assistant에 자동으로 추가합니다.
센서 유형을 숨기려면 카메라 구성에서 "Notify the surveillance center"을 ​​선택 해제하거나 아래에 설명된 "ignored" 사용자 정의 옵션을 사용하면됩니다.

<div class='note'>
센서가 작동하려면 웹인터페이스의 사용자 관리 섹션에서 활성화할 수 있는 'Remote: Notify Surveillance Center/Trigger Alarm Output' 권한이 있어야합니다.
또한 security/authentication 섹션에서 'WEB Authentication'을 'digest/basic'으로 설정해야합니다.
</div>

예를 들어, surveillance center에 알리기 위해 모션 감지 및 선 교차(line crossing) 이벤트가 활성화된 "Front Porch"라는 이름으로 카메라를 설정하면 다음 이진 센서가 홈어시스턴트에 추가됩니다.

```text
binary_sensor.front_porch_motion
binary_sensor.front_port_line_crossing
```

NVR 장치와 함께 사용하면 센서에 나타내는 채널 번호가 센서에 추가됩니다. 예를 들어, 감시 센터에 알리기 위해 모션 감지 및 라인 교차 이벤트가 있는 카메라 2 대를 지원하는 "Home"이라는 이름으로 NVR을 구성하면 다음 이진 센서가 홈 어시스턴트에 추가됩니다.

```text
binary_sensor.home_motion_1
binary_sensor.home_motion_2
binary_sensor.home_line_crossing_1
binary_sensor.home_line_crossing_2
```

이 플랫폼은 모든 Hikvision 카메라 및 nvr에서 작동하며 다음 모델에서 작동하는 것으로 확인되었습니다.

- DS-2CD3132-I
- DS-2CD2232-I5
- DS-2CD2032-I
- DS-2CD2042WD-I
- DS-2CD2142FWD-I
- DS-2CD2155FWD-IS
- IPC-D140H(-M)

## 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 라인을 추가해야합니다.

```yaml
binary_sensor:
  - platform: hikvision
    host: IP_ADDRESS
    username: user
    password: pass
```

{% configuration %}
host:
  description: 연결하려는 카메라의 IP 주소.
  required: true
  type: string
username:
  description: 인증 할 사용자 이름.
  required: true
  type: string
password:
  description: 인증 할 비밀번호.
  required: true
  type: string
name:
  description: >
    홈어시스턴트에 카메라에 부여하려는 이름은 기본적으로 카메라에 정의된 이름입니다.
  required: false
  type: string
port:
  description: 카메라에 연결할 포트.
  required: false
  type: integer
  default: 80
ssl:
  description: "https와 연결하려면 `true`. 포트도 설정하십시오."
  required: false
  type: boolean
  default: false
customize:
  description: >
    이 속성에는 센서 별 재정의 값이 포함됩니다. 센서 이름만 정의하면 됩니다.
  required: false
  type: map
  keys:
    ignored:
      description: >
        이 센서를 완전히 무시하십시오. 웹 인터페이스에 표시되지 않으며 이벤트가 생성되지 않습니다.
      required: false
      type: boolean
      default: false
    delay:
      description: >
        센서 이벤트가 종료 된 후 대기 시간을 지정하여 Home Assistant에 초 단위로 알리십시오. 상태를 켜거나 끄지 않고 한 창에서 여러 빠른 화면 전환을 할 때 유용합니다.
      required: false
      type: integer
      default: 5
{% endconfiguration %}

### 지원되는 유형

지원되는 센서/이벤트 유형들 :

- Motion
- Line Crossing
- Field Detection
- Video Loss
- Tamper Detection
- Shelter Alarm
- Disk Full
- Disk Error
- Net Interface Broken
- IP Conflict
- Illegal Access
- Video Mismatch
- Bad Video
- PIR Alarm
- Face Detection
- Scene Change Detection

## 사례

카메라의 사용자 정의 옵션을 사용하는 `configuration.yaml` 설정의 예 :

```yaml
binary_sensor:
  - platform: hikvision
    host: 192.168.X.X
    port: 80
    ssl: false
    username: user
    password: pass
    customize:
      motion:
        delay: 30
      line_crossing:
        ignored: true
```

nvr의 사용자 정의 옵션을 사용하는 `configuration.yaml`의 설정의 예 :

```yaml
binary_sensor:
  - platform: hikvision
    host: 192.168.X.X
    port: 80
    ssl: false
    username: user
    password: pass
    customize:
      motion_1:
        delay: 30
      field_detection_2:
        ignored: true
```
