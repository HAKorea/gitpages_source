---
title: 수도관리(flume)
description: Documentation about the flume sensor.
logo: flume.jpg
ha_category:
  - Sensor
ha_iot_class: Cloud Polling
ha_release: 0.103
ha_codeowners:
  - '@ChrisMandich'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/tXsxCLkJD_o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`flume` 센서는 주어진 장치 ID에 대한 현재 [flume](https://portal.flumetech.com/) 상태를 보여줍니다.

Flume은 가정용 수도 미터기의 실시간 상태를 모니터링합니다. 사용자가 작은 누수를 감지하고 가정의 물 소비량에 대한 실시간 정보를 얻고, 물의 사용 목표 및 예산을 설정하고, 의심스러운 물의 활동이 발생하면 푸시 알림을 받을 수 있습니다.

## 설정

[settings page](https://portal.flumetech.com/#settings)의 "API Access"에서 Client ID와 Client 비밀정보를 확인할 수 있습니다.

flume 센서를 활성화하려면 `configuration.yaml` 파일에 다음 라인을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  # Flume
  - platform: flume
    username: YOUR_FLUME_USERNAME
    password: YOUR_FLUME_PASSWORD
    client_id: YOUR_FLUME_CLIENT_ID
    client_secret: YOUR_FLUME_CLIENT_SECRET
```

{% configuration %}
username:
  description: Your flume user id.
  required: true
  type: string
password:
  description: Your flume password.
  required: true
  type: string
client_id:
  description: Your flume Client ID.
  required: true
  type: string
client_secret:
  description: Your flume Client Secret.
  required: true
  type: string
name:
  description: A name to display on the sensor.
  required: false
  default: Flume Sensor
  type: string
{% endconfiguration %}

# Binary Sensor 설정

다음 YAML은 Binary Sensor를 만듭니다. 기본 센서를 성공적으로 설정해야합니다.

{% raw %}

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: template
    sensors:
      flume_status:
        friendly_name: "Flume Flow Status"
        value_template: >-
          {{ states.sensor.flume_sensor.state != "0" }}
```

{% endraw %}
