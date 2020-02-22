---
title: "Wemo Switch가 감지 안되면 홈어시스턴트 재시작."
description: "Restart Home Assistant if Wemo Switch is not detected."
ha_category: Automation Examples
---

### 홈어시스턴트 재시작 

이 설정 예는 [WeMo](/integrations/wemo) 스위치가 감지되지 않으면 홈어시스턴트를 재시작합니다. 홈어시스턴트 중지를 위한 추가 MQTT 스위치가 있으며 [IFTTT](/integrations/ifttt/)에 의해 트리거 될 수 있습니다. 프로세스가 더 이상 발견되지 않으면 실행중인 배치 스크립트가 홈어시스턴트를 자동으로 재시작합니다.

```yaml
mqtt:
  broker: 127.0.0.1
  port: 1883
  client_id: home-assistant-1
  keepalive: 60
  
device_tracker:
  - platform: nmap_tracker
    hosts: 192.168.0.1-255
    home_interval: 1
    interval_seconds: 30
    consider_home: 900
    
ifttt:
  key: ***
  
notify: 
  - platform: pushbullet
    api_key: ***
    name: pushbullet

wemo:
  discovery: true

switch:
  - platform: mqtt
    state_topic: "home/killhass"
    command_topic: "home/killhass"
    name: "KillHass"
    qos: 0
    payload_on: "ON"
    payload_of: "OFF"
    optimistic: false

script:
  restarthawemo:
    alias: "Restart HA if WeMo isn't found after 15 minutes"
    sequence:
      - delay:
          minutes: 15
      - service: notify.pushbullet
        data:
          message: 'WeMo not found, restarting HA'
      - service: switch.turn_on
        data:
          entity_id: switch.killhass
  
automation:
- alias: "Restart HA if WeMo switch isn't found after 15 minutes"
  trigger:
    platform: state
    entity_id: device_tracker.wemo
    from: 'not_home'
    to: 'home'
  condition:
    - condition: template
      value_template: {% raw %}'{% if states.switch.wemo %}false{% else %}true{% endif %}'{% endraw %}
    - condition: state
      entity_id: script.restarthawemo
      state: 'off'
  action:
    service: homeassistant.turn_on
    entity_id: script.restarthawemo
- alias: 'Stop HA'
  trigger:
    - platform: state
      entity_id: switch.KillHass
      to: 'on'
  action:
    service: homeassistant.stop
  - alias: 'Stop restarting HA is WeMo is found'
  trigger:
    platform: template
    value_template: {% raw %}'{% if states.switch.wemo %}true{% else %}false{% endif %}'{% endraw %}
  condition:
    condition: state
    entity_id: script.restarthawemo
    state: 'on'
  action:
    service: homeassistant.turn_off
    entity_id: script.restarthawemo
```

