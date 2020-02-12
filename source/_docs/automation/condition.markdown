---
title: "자동화 조건"
description: "Automations can test conditions when invoked."
redirect_from: /getting-started/automation-condition/
---

조건은 자동화 규칙의 선택적 부분이며 트리거 될 때 액션이 발생하지 않도록 하는 데 사용할 수 있습니다. 조건이 true를 반환하지 않으면 자동화가 실행을 중지합니다. 조건은 트리거와 매우 유사하지만 매우 다릅니다. 트리거는 시스템에서 발생하는 이벤트를 보고 조건은 시스템이 현재 보이는 방식 만 봅니다. 트리거는 스위치가 켜져 있음을 관찰 할 수 있습니다. 조건은 스위치가 현재 켜져 있는지 여부 만 확인할 수 있습니다.

자동화에 사용 가능한 조건은 스크립트 구문과 동일하므로 [full list of available conditions](/docs/scripts/conditions/)은 해당 페이지를 참조하십시오.

Example of using condition:

```yaml
automation:
- alias: 'Enciende Despacho'
  trigger:
    platform: state
    entity_id: sensor.mini_despacho
    to: 'on'
  condition:
    condition: or
    conditions:
      - condition: template
        value_template: "{% raw %}{{ state_attr('sun.sun', 'elevation') < 4 }}{% endraw %}"
      - condition: template
        value_template: "{% raw %}{{ states('sensor.sensorluz_7_0') < 10 }}{% endraw %}"
  action:
    - service: scene.turn_on
      entity_id: scene.DespiertaDespacho
```

