---
title: Mill(히터)
description: Instructions on how to integrate Mill heater into Home Assistant.
logo: mill.png
ha_category:
  - Climate
ha_release: 0.81
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@danielhiversen'
---

Mill 히터를 Home Assistant에 통합합니다.

## 설정

이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
climate:
  - platform: mill
    username: YOUR_EMAIL_ADDRESS
    password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: 등록된 Mill 이메일
  required: true
  type: string
password:
  description: Mill 비밀번호.
  required: true
  type: string
{% endconfiguration %}

## Component 서비스

이 플랫폼은 Mill 앱에서 히터에 연결된 방의 온도를 설정하는 서비스를 지원합니다.

`mill.set_room_temperature`


| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `room_name` | no | String with room name.
| `away_temp` | yes | Integer with temperature
| `comfort_temp` | yes | Integer with temperature
| `sleep_temp` | yes | Integer with temperature
