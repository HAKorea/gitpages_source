---
title: Mopar(FCA그룹 차량유지보수)
description: Instructions on how to integrate Mopar vehicles into Home Assistant.
logo: mopar.png
ha_category:
  - Car
  - Sensor
  - Switch
  - Lock
ha_release: 0.53
ha_iot_class: Cloud Polling
---

`mopar` 통합구성요소는 uConnect 가입을 통해 FCA 차량 소유자에게 다음을 제공합니다.

- 차량 상태 보고서 및 기타 메타 데이터가 있는 차량 당 센서
- 차량 당 잠금 장치로 차량 잠금/잠금 해제
- 엔진을 켜고 끄는 차량 당 스위치
- 경적 및 조명 실행 서비스

## 셋업

VIN에 등록된 차량에 [mopar.com](http://mopar.com) 계정이 있는지 확인하십시오. 또한 현재 uConnect 구독이 있어야 합니다

## 설정

이 구성 요소를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오. 모든 플랫폼이 자동으로 로드됩니다.

```yaml
# Example configuration.yaml entry
mopar:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
  pin: YOUR_UCONNECT_PIN
```

{% configuration %}
username:
  description: Your mopar.com username.
  required: true
  type: string
password:
  description: Your mopar.com password.
  required: true
  type: string
pin:
  description: The pin for your account.
  required: true
  type: string
{% endconfiguration %}

## 서비스

`mopar.sound_horn` 서비스를 호출하여 경적을 울리고 차량의 표시등을 깜박입니다.

| Service data attribute | Description |
| `vehicle_index`        | The index of the vehicle to trigger. This is exposed in the sensor's device attributes. |

Example data:

```json
{
  "vehicle_index": 0
}
```
