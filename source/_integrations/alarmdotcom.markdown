---
title: 알람닷컴(Alarm.com)
description: Instructions on how to integrate Alarm.com into Home Assistant.
logo: alarmdotcom.png
ha_category:
  - Alarm
ha_release: 0.11
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/J-B0eMcdEB4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`alarmdotcom` 플랫폼은 [Alarm.com](https://www.alarm.com/)에서 제공하는 정보를 사용합니다.

## 설정

이를 가능하게하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
alarm_control_panel:
  platform: alarmdotcom
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Username for the Alarm.com account.
  required: true
  type: string
password:
  description: Password for the Alarm.com account.
  required: true
  type: string
name:
  description: The name of the alarm.
  required: false
  default: Alarm.com
  type: string
code:
  description: Specifies a code to enable or disable the alarm in the frontend.
  required: false
  type: integer
{% endconfiguration %}

<div class='note warning'>
  문제를 확인하기 전에 alarm.com 언어가 영어로 설정되어 있는지 확인하십시오.
</div>
