---
title: Device Automation
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

Device Automations는 자동화 통합구성요소를 위한 플러그인으로 다른 통합구성요소에서 장치 별 트리거, 조건 및 작업으로 동작하는 방법을 제공 합니다.

딱히 특정 설정이 자동화라는 기능은 없습니다. 대신 일반 자동화의 일부로 설정합니다.

최근의 장치 자동화는 UI를 통해 구성됩니다.

사용예 :

```yaml
- id: "123456789"
  alias: Light turns off
  trigger:
    - platform: device
      device_id: 7a92d5ee74014a0b86903fc669b0bcd6
      domain: light
      type: turn_off
      entity_id: light.bowl
  action:
    - service: camera.turn_off
```
