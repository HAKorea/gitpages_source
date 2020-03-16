---
title: 전력측정기(Sense)
description: Instructions on how to integrate Sense within Home Assistant.
logo: sense.png
ha_category:
  - Energy
  - Binary Sensor
  - Sensor
ha_iot_class: Cloud Polling
ha_release: 0.82
ha_codeowners:
  - '@kbickar'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/5RyDxZLA8b8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Sense](https://sense.com) 미터 정보를 Home Assistant에 연동하십시오.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Binary Sensor
- Sensor

## 설정

설치시 이 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sense:
  email: CLIENT_ID
  password: CLIENT_SECRET
```

{% configuration %}
email:
  description: The email associated with your Sense account/application.
  required: true
  type: string
password:
  description: The password for your Sense account/application.
  required: true
  type: string
timeout:
  description: Seconds for timeout of API requests.
  required: false
  type: integer
{% endconfiguration %}

다음 이름으로 사용량 및 생산량용 센서가 추가됩니다.

- **Active Usage/Production**: 와트단위의 현재 유효 전력사용량/생산량. 60 초마다 업데이트됩니다.
- **Daily/Weekly/Monthly Usage/Production**: kWh 단위의 일일/주간/월간 전력사용량 및 생산량. 5분마다 업데이트됩니다.

Sense 모니터에서 감지된 각 장치에 대해 이진 센서가 만들어져 전원 상태를 표시합니다.