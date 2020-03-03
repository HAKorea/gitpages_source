---
title: 데이터도그(Datadog)
description: Send data and events to Datadog.
logo: datadog.png
ha_category:
  - History
ha_release: 0.45
---

`datadog` 통합구성요소는 [Datadog Agent](https://docs.datadoghq.com/guides/basic_agent_usage/)를 사용하여 모든 상태 변경을 [Datadog](https://www.datadoghq.com/)로 보냅니다.

Datadog을 사용하면 데이터를 분석, 모니터링, 상호 참조 및 경고 할 수 있습니다. 통계 이상을 탐지하고 실시간으로 여러 소스에 걸친 그래프를 보고 [Slack](https://slack.com/intl/en-kr/)에 중요한 경고를 보내는 등의 작업을 수행 할 수 있습니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/datadog-board-example.png' />
</p>

통합구성요소는 또한 로그북의 이벤트를 Datadog으로 전송하여 이러한 이벤트를 데이터와 상관시킬 수 있습니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/datadog-event-stream.png' />
</p>

`datadog` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
datadog:
```

{% configuration %}
host:
  description: "Datadog 호스트의 IP 주소 또는 호스트 이름 (예 : 192.168.1.23)"
  required: false
  default: localhost
  type: string
port:
  description: 사용할 포트.
  required: false
  default: 8125
  type: integer
prefix:
  description: 사용할 접두사.
  required: false
  default: hass
  type: string
rate:
  description: Datadog으로 전송된 UDP 패킷의 샘플 속도.
  required: false
  default: 1
  type: integer
{% endconfiguration %}
