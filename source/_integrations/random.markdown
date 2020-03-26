---
title: 랜덤(Random)
description: Instructions on how to integrate random numbers into Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
  - Sensor
  - Binary Sensor
ha_iot_class: Local Polling
ha_release: 0.32
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`random` 통합구성요소는 단순히 임의의 값이나 상태를 만듭니다. 자동화 규칙을 테스트하거나 대화식 데모를 실행하려는 경우 유용할 수 있습니다. 폴링될 때마다 새 상태를 생성합니다.

## Binary Sensor

`random` 이진 센서 플랫폼은 임의의 상태 (`true`, 1, `on` 혹은 `false`, 0, `off`)를 만듭니다.

### 설정

랜덤 바이너리 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: random
```

{% configuration %}
name:
  description: 프론트 엔드에서 사용할 이름.
  required: false
  type: string
  default: Random Binary Sensor
{% endconfiguration %}

## Sensor

`random` 센서 플랫폼은 주어진 범위에서 임의의 센서값 (정수)을 생성합니다. 반환된 값은 [이산 균일 분포](https://terms.naver.com/entry.nhn?docId=5669133&cid=60207&categoryId=60207)를 형성합니다. 즉, 설정된 범위의 각 정수 값이 똑같이 그려질 수 있습니다.

### 설정

랜덤 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: random
```

{% configuration %}
name:
  description: 프론트 엔드에서 사용할 이름.
  required: false
  type: string
  default: Random Sensor
minimum:
  description: 하한값.
  required: false
  type: string
  default: 0
maximum:
  description: 상한값.
  required: false
  type: integer
  default: 20
unit_of_measurement:
  description: 센서의 측정 단위를 정의합니다 (있는 경우).
  required: false
  type: string
{% endconfiguration %}
