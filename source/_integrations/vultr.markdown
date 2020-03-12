---
title: Vultr 서버
description: Instructions on how to integrate Vultr within Home Assistant.
ha_category:
  - System Monitor
  - Binary Sensor
  - Sensor
  - Switch
ha_release: 0.58
logo: vultr.png
ha_iot_class: Cloud Polling
---

`vultr` 통합구성요소를 통해 Home Assistant에서 [Vultr](https://www.vultr.com) 구독 (Virtual Private Servers)에 대한 정보에 액세스하고 상호 작용할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)
- [Switch](#switch)

## 설정

[Vultr 계정](https://my.vultr.com/settings/#settingsapi)에서 API 키를 얻습니다.

<div class='note'>
액세스 제어 표제(heading) 아래에서 홈어시스턴트의 공용 IP를 허용하십시오.
</div>

Vultr 구독을 Home Assistant와 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
vultr:
  api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your Vultr API key.
  required: true
  type: string
{% endconfiguration %}

## Binary sensor

`vultr` 이진 센서 플랫폼을 사용하면 [Vultr](https://www.vultr.com/) 구독을 모니터링하여 전원이 켜져 있는지 여부를 확인할 수 있습니다.

### 설정

이 바이너리 센서를 사용하려면 먼저 Vultr 허브를 설정해야합니다.

<div class='note'>

다음 예는 ID가 `123456`이고 레이블이 `Web Server`인 구독을 가정합니다.

</div>

최소 `configuration.yaml` (`binary_sensor.vultr_web_server` 생성) :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: vultr
    subscription: 123456
```

{% configuration %}
subscription:
  description: The subscription you want to monitor, this can be found in the URL when viewing a server.
  required: true
  type: string
name:
  description: The name you want to give this binary sensor.
  required: false
  default: "Vultr {subscription label}"
  type: string
{% endconfiguration %}

### 전체 사례

전체 `configuration.yaml` (`binary_sensor.totally_awesome_server` 생성):

```yaml
binary_sensor:
  - platform: vultr
    name: totally_awesome_server
    subscription: 12345
```

## Sensor

`vultr` 센서 플랫폼을 사용하면 [Vultr](https://www.vultr.com/) 구독에 대한 현재 대역폭 사용량 및  요금을 볼 수 있습니다.

이 센서를 사용하려면 Vultr 허브를 설정해야합니다.

<div class='note'>

다음 예는 ID가 `123456`이고 레이블이 `Web Server`인 구독을 가정합니다.

</div>

최소 `configuration.yaml` (`sensor.vultr_web_server_current_bandwidth_used` 및 `sensor.vultr_web_server_pending_charges` 생성):

```yaml
sensor:
  - platform: vultr
    subscription: 123456
```

{% configuration %}
subscription:
  description: The Vultr subscription to monitor, this can be found in the URL when viewing a subscription.
  required: true
  type: string
name:
  description: The name to give this sensor.
  required: false
  default: "Vultr {Vultr subscription label} {monitored condition name}"
  type: string
monitored_conditions:
  description: List of items you want to monitor for each subscription.
  required: false
  detault: All conditions
  type: list
  keys:
    current_bandwidth_used:
      description: The current (invoice period) bandwidth usage in Gigabytes (GB).
    pending_charges:
      description: The current (invoice period) charges that have built up for this subscription. Value is in US Dollars (US$).
{% endconfiguration %}

Full `configuration.yaml` using `{}` to format condition name (produces `sensor.server_current_bandwidth_used` and `sensor.server_pending_charges`):

```yaml
sensor:
  - platform: vultr
    name: Server {}
    subscription: 123456
    monitored_conditions:
      - current_bandwidth_used
      - pending_charges
```

사용자정의 `configuration.yaml` 단 한개의 조건만 모니터 가능 (`sensor.web_server_bandwidth` 생성):

```yaml
sensor:
  - platform: vultr
    name: Web Server Bandwidth
    subscription: 123456
    monitored_conditions:
      - current_bandwidth_used
```

## Switch

`vultr` 스위치 플랫폼을 사용하면 [Vultr](https://www.vultr.com/) 가입을 제어 (시작/중지) 할 수 있습니다.

Vultr 구독을 제어하려면 먼저 Vultr 허브를 설정해야합니다.

### 설정

최소 `configuration.yaml` (`switch.vultr_web_server` 생성):

```yaml
# Example configuration.yaml entry
switch:
  - platform: vultr
    subscription: YOUR_SUBSCRIPTION_ID
```

{% configuration %}
subscription:
  description: List of droplets you want to control.
  required: true
  type: string
name:
  description: The name you want to give this switch.
  required: false
  default: "Vultr {subscription label}"
  type: string
{% endconfiguration %}

### 추가 사례

ID가 `123456`이고 레이블이 `Web Server` 인 구독을 가정한 `switch.amazing_server`를 생성하는 전체 예제 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: vultr
    name: Amazing Server
    subscription: 123456
```
