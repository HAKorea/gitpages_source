---
title: Arlo 보안 카메라 
description: Instructions on how to integrate your Netgear Arlo cameras within Home Assistant.
logo: arlo.png
ha_category:
  - Hub
  - Alarm
  - Camera
  - Sensor
ha_release: 0.46
ha_iot_class: Cloud Polling
---
<iframe width="690" height="437" src="https://www.youtube.com/embed/aUbv1wHOxzU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

이 `arlo` 구현을 통해 [Arlo](https://arlo.netgear.com/) 장치를 Home Assistant에 연동할 수 있습니다 .

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :


- [Alarm](#alarm)
- [Camera](#camera)
- [Sensor](#sensor)

## 설정

[Arlo](https://arlo.netgear.com/)계정에 연결된 장치를 활성화하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.


```yaml
# Example configuration.yaml entry
arlo:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Arlo 계정에 액세스하기위한 사용자 이름
  required: true
  type: string
password:
  description: Arlo 계정에 액세스하기위한 비밀번호
  required: true
  type: string
scan_interval:
  description: 새 데이터를 쿼리하는 빈도. 기본값은 60 초.
  required: false
  type: integer
{% endconfiguration %}

Arlo 웹사이트에서 Home Assistant 내에서 사용할 전용사용자를 만든 다음 Arlo 카메라를 공유하는 것이 좋습니다

[Arlo sensor page](/integrations/arlo#sensor) 또는 [Arlo camera page](/integrations/arlo#camera) 또는  [Arlo control panel page](/integrations/arlo)를 방문하여 설정을 완료하십시오. Arlo에는 정기적인 예약 간격 업데이트 이외에도 업데이트를 강제로 수동으로 호출할 수 있는 `arlo.update` Service Call도 있습니다.

Arlo 통합구성요소는 모션 감지 센서를 활성화/비활성화하는 카메라 서비스도 제공합니다. 아래 예는 홈어시스턴트 서비스가 시작될 때마다 모션 감지를 활성화합니다.

```yaml
#automation.yaml
- alias: Enable Arlo upon HA start'
  initial_state: 'on'
  trigger:
    platform: homeassistant
    event: start
  action:
    service: camera.enable_motion_detection
    entity_id: camera.arlo_frontdoor
```

## 알람

### 설정

[Arlo component](/integrations/arlo)를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.


```yaml
# Example configuration.yaml entry
alarm_control_panel:
  - platform: arlo
```

{% configuration %}
home_mode_name:
  description: "Arlo base station에는 내장 홈모드(home mode)가 없습니다. 이 설정 변수에서 사용자 정의 모드의 이름을 세팅하여 사용자 정의 모드 중 하나를 홈어시스턴트의 홈모드(home mode)에 맵핑할 수 있습니다. 사용자 정의 모드의 이름은 Arlo 앱에서 설정한 것과 정확히 일치해야합니다."
  required: false
  type: string
away_mode_name:
  description: "Arlo base station에는 내장된 부재중모드(away mode)가 없습니다. 이 설정 변수에서 사용자 정의 모드의 이름을 세팅하여 사용자 정의 모드 중 하나를 홈어시스턴트의 부재중모드(away mode)에 맵핑 할 수 있습니다. 사용자 정의 모드의 이름은 Arlo 앱에서 설정한 것과 정확히 일치해야합니다."
  required: false
  type: string
  default: "`Armed` mode in Arlo"
night_mode_name:
  description: "Arlo base station에는 내장 야간모드(night mode)가 없습니다. 이 설정 변수에서 사용자 정의 모드의 이름을 세팅하여 사용자 정의 모드 중 하나를 홈어시스턴트의 야간 모드(night mode)에 맵핑 할 수 있습니다. 사용자 정의 모드의 이름은 Arlo 앱에서 설정한 것과 정확히 일치해야합니다." 
  required: false
  type: string
  default: "`Armed` mode in Arlo"
{% endconfiguration %}

### 사례

이 예제는 `my_arlo_base_station` 이라는 Arlo base station을 기반으로합니다. 이를 base station의 `entity_id` 이름으로 바꾸십시오.

집을 떠날 때 Arlo Base Station arm(집안 지킴이) 모드 전환하기 .

```yaml
- id: arm_arlo_when_leaving
  alias: Arm Arlo cameras when leaving
  trigger:
    platform: state
    entity_id: group.family
    from: home
    to: not_home
  action:
    service: alarm_control_panel.alarm_arm_away
    entity_id: alarm_control_panel.my_arlo_base_station
```

집에 도착시 Arlo를 커스텀 모드(`configuration.yaml`의 `home_mode_name`에 매핑) 로 설정합니다.

```yaml
- id: disarm_arlo_when_arriving
  alias: Set Arlo cameras to Home mode when arriving
  trigger:
    platform: state
    entity_id: group.family
    from: not_home
    to: home
  action:
    service: alarm_control_panel.alarm_arm_home
    entity_id: alarm_control_panel.my_arlo_base_station
```

`alarm_control_panel.alarm_disarm` 서비스를 호출하여 Arlo base station을 완전히 해제(disarm)하고 `alarm_control_panel.alarm_trigger` 서비스를 호출하여 알람을 트리거 할 수도 있습니다.

더 많은 예제와 설정 옵션은 [Manual Alarm Control page](/integrations/manual#examples)에서 찾을 수 있습니다.

## 카메라

이 통합구성요소는 아직 Arlo 카메라에서 라이브 스트리밍을 할 수 없지만 마지막 비디오 캡처를 재생할 수 있습니다.

### 설정

[Arlo component](/integrations/arlo)를 활성화하면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: arlo
    ffmpeg_arguments: '-pred 1 -q:v 2'
```

{% configuration %}
ffmpeg_arguments:
  description: 이미지 품질 또는 비디오 필터 옵션과 같이 ffmpeg에 전달할 추가 옵션.
  required: false
  type: string
{% endconfiguration %}

**참고:** 마지막 캡처를 재생하려면 `ffmpeg` 구성 요소를 설치해야합니다. [FFMPEG](/integrations/ffmpeg/) 문서에 언급된 단계를 따르십시오.

## 센서

Home Assistant 내에서 [Arlo](https://arlo.netgear.com/) 센서를 작동시키려면 일반 [Arlo component](/integrations/arlo)에 대한 지침을 따르십시오.

This platform does not support Arlo Q.
이 플랫폼은 Arlo Q를 지원하지 않습니다.

### 설정

[Arlo component](/integrations/arlo)를 활성화하면 `configuration.yaml` 파일에 다음을 추가하십시오. : 

```yaml
# Example configuration.yaml entry
sensor:
  - platform: arlo
    monitored_conditions:
      - captured_today
      - last_capture
      - total_cameras
      - battery_level
      - signal_strength
```

또한 추가 센서가 있는 Arlo Baby 카메라의 경우 `monitored_conditions` 컬렉션에 추가 할 수 있습니다.

```yaml
# Additional sensors available for Arlo Baby cameras
sensor:
  - platform: arlo
    monitored_conditions:
      # ...
      - temperature
      - humidity
      - air_quality
```

{% configuration %}
monitored_conditions:
  description: 프론트 엔드에 표시 할 조건. 다음과 같은 조건을 모니터링 할 수 있습니다. 
  required: false
  type: list
  keys:
    captured_today:
      description: 현재 날짜에 캡처 한 비디오 수를 반환.
    last_capture:
      description: Arlo 카메라에서 마지막으로 캡처 한 비디오의 타임 스탬프를 반환
    total_cameras:
      description: Arlo 계정에 연결된 인식 및 활성화 된 카메라 수를 반환
    battery_level:
      description: Arlo 카메라의 배터리 잔량을 반환
    signal_strength:
      description: Arlo 카메라의 무선 신호 강도를 반환.
    temperature:
      description: Arlo Baby 카메라가 감지한 주변 온도를 반환
    humidity:
      description: Arlo Baby 카메라가 감지한 주변 상대 습도를 반환
    air_quality:
      description: Arlo Baby 카메라가 감지 한 주변 대기질 (백만분의 1의 휘발성 유기 화합물(VOC) 판독값)을 반환.
{% endconfiguration %}

**monitor_conditions**를 지정하지 않으면 위의 모든 항목이 기본적으로 사용됩니다.