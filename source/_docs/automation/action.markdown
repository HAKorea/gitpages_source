---
title: "자동화 액션"
description: "Automations result in action."
redirect_from: /getting-started/automation-action/
---

자동화 규칙의 액션은 규칙이 실행될 때 실행되는 것입니다. 액션 부분은 서비스나 이벤트를 통해 모든 것과 상호 작용하는데 사용할 수있는 [script syntax](/docs/scripts/)을 따릅니다. 서비스의 경우 적용해야 할 entity_id와 선택적 서비스 매개 변수를 지정할 수 있습니다. (예: 밝기 지정) 

또한 서비스를 호출하여 [씬](/integrations/scene/)을 활성화하여 장치의 작동 방식을 정의하고 홈어시스턴트가 올바른 서비스를 호출하도록 할 수 있습니다.


```yaml
automation:
  # Change the light in the kitchen and living room to 150 brightness and color red.
  trigger:
    platform: sun
    event: sunset
  action:
    service: light.turn_on
    data:
      brightness: 150
      rgb_color: [255, 0, 0]
      entity_id:
        - light.kitchen
        - light.living_room
automation 2:
  # Notify me on my mobile phone of an event
  trigger:
    platform: sun
    event: sunset
    offset: -00:30
  action:
    # Actions are scripts so can also be a list of actions
    - service: notify.notify
      data:
        message: Beautiful sunset!
    - delay: 0:35
    - service: notify.notify
      data:
        message: Oh wow you really missed something great.
```

조건은 액션의 일부일 수도 있습니다. 여러 서비스 호출과 조건을 단일 액션으로 결합할 수 있으며, 입력 한 순서대로 처리됩니다, 조건 결과가 거짓이면 액션이 중지되므로 해당 조건 이후의 모든 서비스 호출이 실행되지 않습니다. 

```yaml
automation:
- alias: 'Enciende Despacho'
  trigger:
    platform: state
    entity_id: sensor.mini_despacho
    to: 'ON'
  action:
    - service: notify.notify
      data:
        message: Testing conditional actions
    - condition: or
      conditions:
        - condition: template
          value_template: '{% raw %}{{ state_attr('sun.sun', 'elevation') < 4 }}{% endraw %}'
        - condition: template
          value_template: '{% raw %}{{ states('sensor.sensorluz_7_0') < 10 }}{% endraw %}'
    - service: scene.turn_on
      entity_id: scene.DespiertaDespacho
```
