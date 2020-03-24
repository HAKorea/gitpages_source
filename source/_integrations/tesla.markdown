---
title: 테슬라(Tesla)
description: Instructions on how to integrate Tesla car into Home Assistant.
logo: tesla.png
ha_category:
  - Car
  - Binary Sensor
  - Climate
  - Presence Detection
  - Lock
  - Sensor
  - Switch
ha_release: 0.53
ha_iot_class: Cloud Polling
ha_config_flow: true
ha_codeowners:
  - '@zabuldon'
  - '@alandtse'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/l1YROYQUS5s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Tesla` 통합구성요소는 [Tesla](https://auth.tesla.com/login) 클라우드 서비스와의 연동을 제공하고 재실 상태 감지와 충전기 상태 및 온도와 같은 센서를 제공합니다.

이 통합구성요소는 다음 플랫폼을 제공합니다:

- Binary sensors - 주차 및 충전기 연결.
- Sensors - 배터리 수준, 내부 / 외부 온도, 주행 거리계, 예상 범위 및 충전 속도 및 기타.
- Device tracker - 자동차의 위치 ​​추적
- Lock - 도어 잠금. 테슬라의 도어락을 제어
- Climate - HVAC 제어.  Tesla의 HVAC 시스템을 제어 (켜기/끄기, 목표 온도 설정) 할 수 있습니다.
- Switch -  충전기를 시작/중지하고 최대 범위 충전을 설정할 수 있는 충전기 및 최대 범위 스위치. 배터리를 절약하기 위해 차량 폴링을 비활성화 할 수있는 업데이트 스위치

## 설정

Home Assistant는 **설정** -> **통합구성요소** -> **Tesla**를 통해 Tesla 통합구성요소를 제공합니다.

사용자 이름과 비밀번호를 입력 한 다음 계속하십시오.

또는 홈어시스턴트는 `configuration.yaml`을 통해 테슬라를 로드합니다. `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
tesla:
  username: YOUR_EMAIL_ADDRESS
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Tesla 계정과 연결된 이메일 주소.
  required: true
  type: string
password:
  description: Tesla 계정과 관련된 비밀번호.
  required: true
  type: string
scan_interval:
  description: API 폴링 간격 (초)입니다. 최소값은 300 (5 분)보다 작을 수 없습니다. 매우 빈번한 폴링은 배터리를 소모할 수 있습니다.
  required: false
  type: integer
  default: 300
{% endconfiguration %}
