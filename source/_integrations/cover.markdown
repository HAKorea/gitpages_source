---
title: Cover
description: Instructions on how to integrate covers into Home Assistant.
logo: home-assistant.png
ha_category:
  - Cover
ha_release: 0.27
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

홈어시스턴트는 롤러 셔터, 블라인드 및 차고 문과 같은 개폐형 장치를 제어하기위한 인터페이스를 제공 할 수 있습니다.

## Device Class

프런트 엔드에 이러한 센서가 표시되는 방식은 [customize section](/docs/configuration/customizing-devices/). 에서 수정할 수 있습니다 . 다음 장치 클래스가 지원됩니다. :

- **None**: 일반 장치. 기본값이며 설정할 필요가 없습니다.
- **awning**: 외부 개폐식 창문, 문 또는 천막과 같은 장치를 제어합니다.
- **blind**: 블라인드 제어, 블라인드의 올림 내림과 같은 기능 이외에 닫힘 열림 등과 같은 기능을 제어합니다. 
- **curtain**: 커튼 계열 제품을 제어 할 수 있습니다, 커튼 계열 제품은 종종 창문이나 문 위에 매달아 열 수 있습니다.
- **damper**: 공기 흐름, 소리 또는 빛을 감소시키는 기계식 댐퍼 제어.
- **door**: 특정 구역에 출입 할 수 있는 문 또는 문을 제어합니다.
- **garage**: 차고에 접근 할 수있는 차고문 제어.
- **shade**: 가림막 제어, 창가림막같이 특정 재질이나 부품들로 이어진 연속된 장치들이 펼쳐지거나 합쳐지는 종류의 개폐기능 장치.
- **shutter**: 셔터의 제어, 실내 혹은 실외의 창문셔터처럼 가림막이 열림 닫힘도 되지만, 빛을 가리기 위한 일부 틸트 기능도 하는 장치. 
- **window**: 열리고 닫히거나 기울어 질 수있는 실제 창의 제어.

## Services

### Cover control services

Available services: `cover.open_cover`, `cover.close_cover`, `cover.stop_cover`, `cover.toggle`, `cover.open_cover_tilt`, `cover.close_cover_tilt`, `cover.stop_cover_tilt`, `cover.toggle_tilt`

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | `entity_id`'를 나타내는  문자열 또는 문자열 목록입니다. 이외에 모든 개폐장치를 대상으로 합니다. 

### Service `cover.set_cover_position`

Set cover position of one or multiple covers.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | `entity_id`'를 나타내는  문자열 또는 문자열 목록입니다. 이외에 모든 개폐장치를 대상으로 합니다. 
| `position` | no | 0에서 100 사이의 정수

#### Automation example 

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: cover.set_cover_position
      data:
        entity_id: cover.demo
        position: 50
```

### Service `cover.set_cover_tilt_position`

하나 또는 여러 개의 덮개의 기울기 위치를 설정하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | `entity_id`'를 나타내는  문자열 또는 문자열 목록입니다. 이외에 모든 개폐장치를 대상으로 합니다. 
| `tilt_position` | no | 0에서 100 사이의 정수

#### 자동화 예시 

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: cover.set_cover_tilt_position
      data:
        entity_id: cover.demo
        tilt_position: 50
```
