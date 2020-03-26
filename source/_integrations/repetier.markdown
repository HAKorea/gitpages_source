---
title: 3D프린터 관리(Repetier-Server)
description: Instructions how to add Repetier-Server sensors to Home Assistant.
logo: repetier.png
ha_category:
  - Hub
  - Sensor
ha_release: 0.94
ha_iot_class: Local Polling
ha_codeowners:
  - '@MTrab'
---

[Repetier-Server](https://www.repetier-server.com/)는 동일한 서버에서 여러 장치를 제어할 수 있는 3D 프린터/CNC 서버입니다.
이 통합구성요소는 서버에 대한 기본 연동을 처리합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Sensor

## 설정

```yaml
repetier:
  - host: REPETIER_HOST
    api_key: YOUR_API_KEY
```

{% configuration %}
repetier:
  description: Repetier integration
  type: list
  required: true
  keys:
    host:
      description: The host IP or hostname of your Repetier-Server.
      required: true
      type: string
    api_key:
      description: API-key for the user used to connect to Repetier-Server
      required: true
      type: string
    port:
      description: The port used to connect to the host
      required: false
      type: integer
      default: 3344
    sensors:
      description: Configuration for the sensors.
      required: false
      type: map
      keys:
        monitored_conditions:
          description: The sensors to activate.
          type: list
          default: all
          keys:
            "current_state":
              description: Text of current state.
            "extruder_temperature":
              description: Temperatures of all available extruders. These will be displayed as `printer_name_extruder_N`.
            "bed_temperature":
              description: Temperatures of all available heated beds. These will be displayed as `printer_name_bed_N`.
            "chamber_temperature":
              description: Temperatures of all available heated chambers. These will be displayed as `printer_name_chamber_N`.
            "current_job":
              description: Returns percentage done of current job in state, and current job information as attributes.
            "job_start":
              description: Start timestamp of job start.
            "job_end":
              description: Estimated job end timestamp.
{% endconfiguration %}

여러 Repetier 서버가 있는 예 :

```yaml
repetier:
  - host: REPETIER_HOST
    api_key: YOUR_API_KEY
    sensors:
      monitored_conditions:
        - 'current_state'
        - 'current_job'
  - host: REPETIER_HOST
    api_key: YOUR_API_KEY
    port: 3344
```

Repetier 서버 호스트에 웹카메라가 장착되어 있으면 이를 추가할 수 도 있습니다.

```yaml
camera:
  - platform: mjpeg
    name: Repetier
    still_image_url: http://YOUR_REPETIER_HOST_IP:8080/?action=snapshot
    mjpeg_url: http://YOUR_REPETIER_HOST_IP:8080/?action=stream
```

### API 키 구하기

필요한 API 키를 생성하려면 다음을 수행하십시오.

* Go to your Repetier Server web-console
* Push the settings icon (the gear icon)
* Select User Profiles.
* Create a new user, deselect all options and click Create User.
* Edit the newly created user and take note of the API-key for this user, that's the one to use in the Home Assistant Settings
