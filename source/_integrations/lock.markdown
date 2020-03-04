---
title: Lock(락)
description: Instructions on how to setup your locks with Home Assistant.
logo: home-assistant.png
ha_category:
  - Lock
ha_release: 0.9
ha_quality_scale: internal
---

현재 환경에서 Lock 상태와 상태를 추적하고 제어할 수 있습니다.

 * Lock에 하나씩의 상태와 결합된 상태 `all_locks`를 유지합니다.
 * Lock을 제어하기 위해 서비스 `lock.lock`, `lock.unlock`, `lock.open`(열림) 을 등록합니다.

### 서비스

Lock 통합구성요소는 다음 서비스를 제공합니다.

#### `lock.lock` 서비스

문을 잠그십시오. 속성은 서비스의 'data' 속성이 아래에 나타납니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 해당 Lock 엔티티.                          |

##### 사례

```yaml
action:
  service: lock.lock
  data:
    entity_id: lock.my_place
```

#### `lock.unlock` 서비스

도어를 잠금 해제하면 속성이 서비스의 'data' 속성이 아래에 나타납니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 해당 Lock 엔티티.                           |

##### 사례

```yaml
action:
  service: lock.unlock
  data:
    entity_id: lock.my_place
```

### 서비스들의 사용법

**개발자 도구** 로 이동한 다음 프론트 엔드에서 **Call Service**로 이동하여 사용 가능한 서비스 목록에서 `lock.lock`, `lock.unlock` 또는 `lock.open`을 선택하십시오 (왼쪽 **Services:** ).

```json
{"entity_id":"lock.front_door"}
```

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      yes | 특정 Lock 에서만 작동합니다. 그렇지 않으면 모두를 대상으로 합니다.
