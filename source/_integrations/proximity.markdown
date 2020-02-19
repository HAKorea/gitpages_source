---
title: Proximity
description: Instructions on how to setup Proximity monitoring within Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.13
ha_quality_scale: internal
---

`proximity` 통합구성요소를 통해 특정 [zone](/integrations/zone/)에 대한 장치의 근접성과 이동 방향을 모니터링 할 수 있습니다. 결과는 근접 데이터를 유지 보수하는 홈어시스턴트에서 작성된 엔티티입니다.

이 통합구성요소는 특정 영역(zone) 외부의 위치를 ​​기반으로 자동화를 수행하려는 경우 필요한 자동화 규칙 수를 줄이는 데 유용합니다.[zone](/getting-started/automation-trigger/#zone-trigger) 및 [state](/getting-started/automation-trigger/#state-trigger) 기반 트리거는 유사한 제어를 허용하지만 규칙 수가 기하 급수적으로 증가합니다. 특히 여행 방향과 같은 요소를 고려해야 할 때.

사용예는 다음과 같습니다. :

- 집 근처에서 온도 조절기 온도를 높이십시오
- 여행하는 집에서 멀어 질수록 온도를 낮추십시오

작성된 근접 엔티티의 값은 다음과 같습니다. :

- `state`: 모니터링 영역(zone)으로부터의 거리 (km)
- `dir_of_travel`: 모니터링되는 영역(zone)에 가장 가까운 장치의 방향. 값은 다음과 같습니다. :
  - 'not set'
  - 'arrived'
  - 'towards'
  - 'away_from'
  - 'unknown'
  - 'stationary'
- `dist_to_zone`: 모니터링 영역(zone)으로부터의 거리 (km)
- `unit_of_measurement`: 거리 측정. 값은 다음과 같습니다. :
  - 'km'
  - 'm'
  - 'mi'
  - 'ft'
- `nearest`: 구역(Zone)에 가장 가까운 장치

설치에서 이 통합구성요소를 사용 가능하게 하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
proximity:
  home: 
    ignored_zones:
      - twork
    devices:
      - device_tracker.car1
    tolerance: 50
    unit_of_measurement: mi
```

{% configuration %}
zone:
  description: 이 연동이 거리를 측정하는 영역(zone)입니다. 기본 영역은 홈 영역입니다.
  required: false
  type: map
  keys:
    ignored_zones:
      description: 장치에 대해 근접성이 계산되지 않는 경우 (모니터링되는 장치 또는 비교되는 장치 (예를들어 직장 또는 학교))
      required: false
      type: list
    devices:
      description: 구성된 영역(zone)과의 근접성을 확인하기 위해 위치를 비교할 장치 목록입니다.
      required: false
      type: list
    tolerance:
      description: 작은 GPS 좌표 변화를 걸러 내기 위해 이동 방향을 미터 (m) 단위로 계산하는 데 사용되는 오차입니다.
      required: false
      type: integer
    unit_of_measurement:
      description: 거리 측정 단위입니다. 유효한 값은 (km, m, mi, ft) [각각 킬로미터, 미터, 마일 및 피트]입니다.
      required: false
      type: string
      default: km
{% endconfiguration %}

근접 구성 요소를 여러개 추가하려면 `configuration.yaml` 파일 에서 목록을 사용하십시오.

```yaml
# Example configuration.yaml entry
proximity:
  home:
    ignored_zones:
      - work
      - school
    devices:
      - device_tracker.car1
      - device_tracker.iphone1
      - device_tracker.iphone2
    tolerance: 50
    unit_of_measurement: mi
  home3:
    zone: home3
    devices:
      - device_tracker.iphone1
    tolerance: 50
  work:
    zone: work
    devices:
      - device_tracker.iphone2
    tolerance: 10
```
