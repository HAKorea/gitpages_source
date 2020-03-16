---
title: 슬립아이큐(SleepIQ)
description: Instructions for how to integrate SleepIQ beds within Home Assistant.
logo: sleepiq.png
ha_category:
  - Health
  - Sensor
  - Binary Sensor
ha_release: 0.29
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/RzPSe61o3Bc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

SleepIQ 구현을 통해 [SleepIQ by SleepNumber](https://www.sleepnumber.com/sleepiq-sleep-tracker)의 센서 데이터를 볼 수 있습니다

## 셋업

이 구성 요소를 사용하려면 [SleepIQ] (https://sleepiq.sleepnumber.com/)에 계정이 필요합니다.

## 설정

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
sleepiq:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Your SleepIQ username (usually an e-mail address).
  required: true
  type: string
password:
  description: Your SleepIQ password.
  required: true
  type: string
{% endconfiguration %}
