---
title: 업클라우드(UpCloud)
description: Instructions on how to integrate UpCloud within Home Assistant.
ha_category:
  - System Monitor
  - Binary Sensor
  - Switch
ha_release: 0.65
logo: upcloud.png
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@scop'
---

`upcloud` 통합구성요소를 통해 Home Assistant에서 [UpCloud](https://upcloud.com/) 서버에 대한 정보에 액세스 할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Switch](#switch)

## 셋업

[UpCloud control panel](https://hub.upcloud.com/)에서 API 자격 증명을 설정하십시오.

## 설정

UpCloud 서버를 Home Assistant와 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
upcloud:
  username: YOUR_API_USERNAME
  password: YOUR_API_PASSWORD
```

{% configuration %}
username:
  description: Your UpCloud API username.
  required: true
  type: string
password:
  description: Your UpCloud API user password.
  required: true
  type: string
scan_interval:
  description: Update interval in seconds.
  required: false
  type: integer
  default: 60
{% endconfiguration %}

## Binary Sensor

`upcloud` 바이너리 센서 플랫폼을 사용하면 UpCloud 서버를 모니터링 할 수 있습니다.

UpCloud 서버를 사용하려면 먼저 [UpCloud hub](#configuration)를 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: upcloud
    servers:
      - 002167b7-4cb1-44b7-869f-e0900ddeeae1
      - 00886296-6137-4074-afe3-068e16d89d00
```

{% configuration %}
servers:
  description: List of servers you want to monitor.
  required: true
  type: list
{% endconfiguration %}

## Switch

`upcloud` 스위치 플랫폼을 사용하면 UpCloud 서버를 제어 (start/stop) 할 수 있습니다.

UpCloud 서버를 사용하려면 먼저 [UpCloud hub](#configuration)를 설정 한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
switch:
  - platform: upcloud
    servers:
      - 002167b7-4cb1-44b7-869f-e0900ddeeae1
      - 00886296-6137-4074-afe3-068e16d89d00
```

{% configuration %}
servers:
  description: List of servers you want to control.
  required: true
  type: list
{% endconfiguration %}
