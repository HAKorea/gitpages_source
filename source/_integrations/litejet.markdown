---
title: 라이트젯(LiteJet)
description: Instructions on how to setup the LiteJet hub within Home Assistant.
logo: centralite.svg
ha_category:
  - Light
  - Scene
  - Switch
ha_iot_class: Local Push
ha_release: 0.32
---

LiteJet은 대부분의 홈오토메이션 기술 이전의 중앙 집중식 조명 시스템입니다. 모든 조명 및 벽 스위치는 중앙 패널에 연결되어 있습니다. 이 중앙 패널에는 컴퓨터가 LiteJet의 타사 프로토콜을 통해 시스템을 제어 할 수있는 직렬 포트 인터페이스가 있습니다.

Home Assistant는 LiteJet 타사 프로토콜을 연동하고 상태를 확인하고 연결된 표시등을 제어 할 수 있습니다.

LiteJet의 RS232-2 포트를 컴퓨터에 연결 한 후 `configuration.yaml`에 다음을 추가하십시오.

```yaml
litejet:
  port: /dev/serial/by-id/THE-PATH-OF-YOUR-SERIAL-PORT
```

LiteJet MCP는 19.2 K 보드, 8 데이터 비트, 1 정지 비트, 패리티 없음으로 구성되고 각 응답 후 'CR'을 전송해야합니다. 이 설정은 [LiteJet programming software](https://www.centralite.com/helpdesk/knowledgebase.php?article=735)를 사용하여 설정할 수 있습니다.

You can also configure the Home Assistant to ignore lights, scenes, and switches via their name. This is highly recommended since LiteJet has a fixed number of each of these and with most systems many will be unused.
조명을 통해 조명, 장면 및 스위치 이름을 무시하도록 홈어시스턴트를 설정 할 수도 있습니다. LiteJet에는 각각 고정된 수가 있고 대부분의 시스템에서는 사용하지 않기 때문에 이 방법을 사용하는 것이 좋습니다.

{% configuration %}
port:
  description: The path to the serial port connected to the LiteJet.
  required: true
  type: string
exclude_names:
  description: A list of light or switch names that should be ignored.
  required: false
  type: [list, string]
include_switches:
  description: Cause entities to be created for all the LiteJet switches. This can be useful when debugging your lighting as you can press/release switches remotely.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

```yaml
litejet:
  exclude_names:
  - 'Button #'
  - 'Scene #'
  - 'Timed Scene #'
  - 'Timed Scene#'
  - 'LV Rel #'
  - 'Fan #'
```

### 트리거(Trigger)

LiteJet 스위치를 트리거로 사용하여 해당 버튼이 보류 시간에 따라 다르게 작동할 수 있습니다. 예를 들어, 자동화는 quick tap과 long hold를 구별할 수 있습니다.

- **platform** (*Required*): Must be 'litejet'.
- **number** (*Required*): The switch number to be monitored.
- **held_more_than** (*Optional*): The minimum time the switch must be held before the trigger can activate.
- **held_less_than** (*Optional*): The maximum time the switch can be held for the trigger to activate.

트리거는 `held_more_than` 및 `held_less_than`이 모두 만족되는 것으로 알려진 가장 빠른 순간에 활성화됩니다. 어느 것도 지정하지 않으면 스위치를 누르는 순간 트리거가 활성화됩니다. `held_more_than` 만 지정하면 스위치는 최소한 그 시간 동안 스위치를 누른 순간부터 활성화됩니다. `held_less_than`이 지정되면 스위치를 놓을 때만 트리거가 활성화 될 수 있습니다.

```yaml
automation:
- trigger:
    platform: litejet
    number: 55
    held_more_than:
      milliseconds: 1000
    held_less_than:
      milliseconds: 2000
```
