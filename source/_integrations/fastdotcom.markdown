---
title: Fast.com(인터넷속도측정)
description: How to integrate Fast.com within Home Assistant.
logo: fastdotcom.png
ha_category:
  - System Monitor
  - Sensor
ha_release: 0.88
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@rohankapoorcom'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/qtNoo4W5dSc?list=PLWlpiQXaMerTyzl_Pe1PEloZTj9MoU5cl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`fastdotcom` 통합구성요소는 [Fast.com](https://fast.com/) 웹서비스를 사용하여 네트워크 대역폭 성능을 측정합니다.

<div class='note'>

현재 fast.com은 다운로드 대역폭 측정 만 지원합니다. Ping 및 업로드와 같은 다른 대역폭 메트릭(Metric)을 측정하려면 [speedtest](/integrations/speedtestdotnet) 구성 요소를 사용하십시오.

</div>

이 통합구성요소를 활성화하면 Fast.com 센서가 자동으로 생성됩니다.

기본적으로 속도 테스트는 1 시간마다 실행됩니다. 사용자는 속도 테스트를 실행하기 위해 `scan_interval`을 정의하여 구성에서 업데이트 빈도를 변경할 수 있습니다

## 설정

설치에 Fast.com을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

시간당 한 번, 시간 (기본값) :

```yaml
fastdotcom:
```

매일 30 분마다 :

```yaml
fastdotcom:
  scan_interval:
      minutes: 30
```

{% configuration %}
scan_interval:
  description: "업데이트 사이의 최소 시간 간격. 지원되는 형식 :`scan_interval: 'HH:MM:SS'`, `scan_interval: 'HH:MM'` 및 기간 사전(dictionary) (아래 예 참조)"
  required: false
  default: 60 minutes
  type: time
manual:
  description: 수동 모드를 켜거나 끕니다. 수동 모드는 예약된 속도 테스트를 비활성화합니다.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

#### Time period dictionary 사례

```yaml
scan_interval:
  # At least one of these must be specified:
  days: 0
  hours: 0
  minutes: 3
  seconds: 30
  milliseconds: 0
```

### 서비스

`fastdotcom` 통합구성요소는 일단 로드되면 요청시 Fast.com 속도 테스트를 실행하기 위해 호출할 수있는 서비스 (`fastfastcom.speedtest`)를 노출합니다. 이 서비스에는 매개 변수가 없습니다. 수동 모드를 활성화 한 경우 유용할 수 있습니다.

```yaml
action:
  service: fastdotcom.speedtest
```

## Notes

- Raspberry Pi 3 이상에서 실행하는 경우 최대 속도는 100Mbit/s LAN 어댑터에 의해 제한됩니다.
- 센서는 15 초 테스트 동안 최대 측정 속도를 반환합니다.
- 속도 테스트는 인터넷 속도에 따라 데이터를 소비하므로 인터넷 연결의 대역폭이 제한적인 경우 이를 고려해야합니다.