---
title: 전열교환기(Danfoss Air)
description: How to integrate Danfoss Air HRV in Home Assistant.
ha_category:
  - Climate
  - Binary Sensor
  - Sensor
  - Switch
ha_release: 0.87
logo: danfoss_air.png
ha_iot_class: Local Polling
---

`danfoss_air` 통합구성요소를 통해 Danfoss Air HRV 장치의 정보에 액세스 할 수 있습니다.

*Note* : Danfoss Air CCM은 한 번에 하나의 TCP 연결만 허용합니다. 이 연동으로 인해 HRV PC-Tool을 연 상태에서는 작동하지 않습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary sensor](#binary-sensor)
- [Sensor](#sensor)
- [Switch](#switch)

```yaml
# Example configuration.yaml entry
danfoss_air:
  host: IP_ADDRESS_OF_CCM
```

{% configuration %}
host:
  description: Danfoss Air CCM IP.
  required: true
  type: string
{% endconfiguration %}

## Binary sensor

다음과 같은 이진 센서가 지원됩니다.

- **Bypass active:** 열 회수(heat recovery)가 현재 우회(bypass)된 경우 표시기.

## Sensor

다음과 같은 센서가 지원됩니다.

- **Outdoor temperature:** 실외 기온.
- **Supply temperature:** 집에 공급되는 공기의 온도.
- **Extract temperature:** 집에서 추출한 공기의 온도.
- **Exhaust temperature:** 배기 온도.
- **Remaining filter lifetime:** 남은 필터 수명은 백분율로 측정됩니다.

## Switch

다음 스위치가 지원됩니다.

- **Boost:** 수동으로 부스트를 활성화하도록 전환합니다.
- **Bypass:** 바이 패스 를 수동으로 활성화하도록 전환합니다.
- **Automatic bypass:** 자동 바이 패스 를 활성화하도록 전환합니다.
