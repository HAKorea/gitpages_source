---
title: 멜노어 레인클라우드(Melnor RainCloud)
description: Instructions on how to integrate your Melnor Raincloud sprinkler system within Home Assistant.
logo: raincloud.jpg
ha_category:
  - Irrigation
  - Binary Sensor
  - Sensor
  - Switch
ha_release: 0.55
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@vanstinator'
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/zPHy5okxnTk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`raincloud` 통합구성요소를 통해 [Melnor RainCloud](https://wifiaquatimer.com) 스프링클러 시스템을 Home Assistant에 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. : 

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)
- [Switch](#switch)

## 설정

이를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
raincloud:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The username for accessing your Melnor RainCloud account.
  required: true
  type: string
password:
  description: The password for accessing your Melnor RainCloud account.
  required: true
  type: string
{% endconfiguration %}

## Binary Sensor

[Raincloud component](#configuration)를 활성화하고 난 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: raincloud
```

{% configuration %}
monitored_conditions:
  description: Conditions to display in the frontend. The following conditions can be monitored.
  required: false
  type: list
  default: If not specified, all conditions below will be enabled.
  keys:
    is_watering:
      description: Return if is currently watering per zone.
    status:
      description: Return status from the Melnor RainCloud Controller and Melnor RainCloud Faucet.
{% endconfiguration %}

## Sensor

[Raincloud component](#configuration)를 활성화하고 난 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: raincloud
```

{% configuration %}
monitored_conditions:
  description: Conditions to display in the frontend. The following conditions can be monitored.
  required: false
  default: If not specified, all conditions below will be enabled.
  type: list
  keys:
    battery:
      description: Return the battery level the Melnor RainCloud faucet.
    next_cycle:
      description: Return the next schedulle watering cycle per zone.
    rain_delay:
      description: Return the number of days the automatic watering will be delayed due to raining per zone.
    watering_time:
      description: Return the watering remaining minutes per zone.
{% endconfiguration %}

## Switch

[Raincloud component](#configuration)를 활성화하고 난 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: raincloud
```

{% configuration %}
watering_minutes:
  description: "Value in minutes to watering your garden via frontend. The values allowed are: 5, 10, 15, 30, 45, 60."
  required: false
  default: 15
  type: integer
monitored_conditions:
  description: Conditions to display in the frontend. If not specified, all conditions below will be enabled by default.
  required: false
  type: list
  keys:
    auto_watering:
      description: Toggle the watering scheduled per zone.
    manual_watering:
      description: Toggle manually the watering per zone. It will inherent the value in minutes specified on the RainCloud hub component.
{% endconfiguration %}
