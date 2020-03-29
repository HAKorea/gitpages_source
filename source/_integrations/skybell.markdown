---
title: 스카이벨(SkyBell)
description: Instructions on how to integrate your Skybell HD devices within Home Assistant.
logo: skybell.png
ha_category:
  - Doorbell
  - Binary Sensor
  - Camera
  - Light
  - Sensor
  - Switch
ha_release: 0.56
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="692" height="388" src="https://www.youtube.com/embed/ARQsMkjUYgs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`skybell` 구현을 통해 [Skybell.com](http://www.skybell.com/) 초인종을 Home Assistant에 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](/integrations/skybell/#binary-sensor)
- [Camera](/integrations/skybell/#camera)
- [Light](/integrations/skybell/#light)
- [Sensor](/integrations/skybell/#sensor)
- [Switch](/integrations/skybell/#switch)

현재 이 플랫폼에서는 Skybell HD만 지원합니다.

## 설정

[Skybell.com](http://www.skybell.com/) 계정으로 설정한 장치를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
skybell:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The username for accessing your Skybell account.
  required: true
  type: string
password:
  description: The password for accessing your Skybell account.
  required: true
  type: string
{% endconfiguration %}

### Binary Sensor

Skybell 컴포넌트를 활성화한 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: skybell
    monitored_conditions:
      - button
      - motion
```

{% configuration %}
monitored_conditions:
  description: Conditions to display in the frontend. The following conditions can be monitored.
  required: true
  type: list
  keys:
    button:
      description: Returns whether the doorbell button was pressed.
    motion:
      description: Returns whether movement was detected by the Skybell doorbell.
{% endconfiguration %}

### Camera

Skybell 컴포넌트를 활성화한 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: skybell
```

{% configuration %}
monitored_conditions:
  description: The camera images to display. Default is `avatar`. The full list is `avatar`, `activity`.
  required: false
  type: list
avatar_name:
  description: Name to append to the device name for the avatar image. Default is empty string.
  required: false
  type: string
activity_name:
  description: Name to append to the device name for the last activity image. Default is empty string.
  required: false
  type: string
{% endconfiguration %}

#### Camera 타입

스카이벨 아바타 이미지를 표시하는 두 가지 카메라 유형이 있는데, "Avatar"가 기본값입니다.
정기적으로 새로운 이미지로 업데이트됩니다. 다른 유형은 "Activity"으로, 카메라가 캡처한 최신 이벤트 (동작, 벨 또는 주문형)의 스냅샷을 표시합니다. monitor_condtions에 이름을 지정하여 카메라 혹은 둘 다 표시할 수 있습니다.
avatar_name 또는 activity_name을 설정하는 것이 좋지만 필수는 아닙니다.
두 대의 카메라를 모두 보여주는 경우 구별할 수 있습니다. 이름은 skybell 장치 이름에 추가됩니다.

```yaml
# Example configuration.yaml with both images
camera:
  - platform: skybell
    monitored_conditions:
    - avatar
    - activity
    activity_name: "Last Activity"
```

```yaml
# Example configuration.yaml with just last activity image
camera:
  - platform: skybell
    monitored_conditions:
    - activity
```

### Light

Skybell 컴포넌트를 활성화한 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: skybell
```

### Sensor

Skybell 컴포넌트를 활성화한 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: skybell
    monitored_conditions:
      - chime_level
```

{% configuration %}
monitored_conditions:
  type: list
  required: true
  description: Conditions to display in the frontend. The following conditions can be monitored.
  keys:
    chime_level:
      description: Return a value between 0-3, indicating no chime, low, medium, and high respectively.
{% endconfiguration %}

### Switch

Skybell 컴포넌트를 활성화한 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: skybell
    monitored_conditions:
      - do_not_disturb
      - motion_sensor
```

{% configuration %}
monitored_conditions:
  description: Conditions to display in the frontend.
  required: true
  type: list
  keys:
    do_not_disturb:
      description: Control the state of your doorbells indoor chime.
    motion_sensor:
      description: Control the state of your doorbells motion sensor.
{% endconfiguration %}
