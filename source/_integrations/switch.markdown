---
title: 스위치(Switch)
description: Instructions on how to set up your switches with Home Assistant.
logo: home-assistant.png
ha_category:
  - Switch
ha_release: 0.7
ha_quality_scale: internal
---

사용자의 환경에 있는 스위치와 해당 상태를 추적하여 제어할 수 있습니다.

- 각 스위치 상태와 결합된 상태를 `all_switches`로 제어가능합니다.  
- `switch.turn_on`, `switch.turn_off` , `switch.toggle` 서비스를 스위치를 제어하기 위해 등록합니다. 

## 서비스 사용하기

프론트 엔드에서 사이드 바 를여십시오. 하단의 **개발자 도구**에서 **Services**를 클릭합니다. 서비스 드롭 다운 메뉴에서 사용 가능한 서비스 목록에서 `switch.turn_on` 또는 `switch.turn_off`를 선택하십시오. 엔티티 드롭 다운 메뉴에서 작업하려는 엔티티 ID를 선택하거나 입력하십시오. **Service Data** 필드에 아래 샘플과 같은 내용이 입력됩니다. 이제 **CALL SERVICE**를 누르십시오.

```json
{"entity_id":"switch.livingroom_pin2"}
```

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | The entity ID of the switch to control. To target all switches, set the entity ID to `all`|
