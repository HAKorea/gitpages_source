---
title: 아기모니터링(Owlet)
description: Instructions on how to integrate Owlet baby monitor into Home Assistant.
logo: owlet.svg
ha_category:
  - Health
  - Binary Sensor
  - Sensor
ha_release: 0.89
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@oblogic7'
---

<iframe width="690" height="409" src="https://www.youtube.com/embed/TrfA6HrYajk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Owlet Care](https://owletcare.com/) 베이비 모니터는 수면 중에 아기의 산소 수준과 심박수를 확인합니다.

이 연동을 설정하면 심박수, 산소 수준, 동작 및 연결 상태를 추적할 수 있습니다. 배터리 상태는 산소 및 심박수 센서의 속성으로 제공됩니다.

본 통합구성요소는 다음 플랫폼을 자동으로 활성화합니다.

#### Binary Sensors

- Base Station Status
- Motion

#### Sensors

- Heart rate
- Oxygen level

### 설정

```yaml
# Example configuration.yaml entry
owlet:
  username: OWLET_USER
  password: OWLET_PASSWORD
```

{% configuration %}
username:
  description: Your Owlet account user ID.
  required: true
  type: string
password:
  description: Your Owlet account password.
  required: true
  type: string
name:
  description: Custom name for your Owlet device.
  required: false
  type: string
{% endconfiguration %}

<p class='warning'>
The intended purpose of this integration is to enable data logging and automations such as battery status updates and charging reminders. This integration should not replace the Owlet app nor should it be used for life-critical notifications.
</p>
