---
title: 솜피 MyLink
description: Instructions on how to integrate Somfy MyLink devices with Home Assistant.
logo: tahoma.png
ha_category:
  - Hub
  - Cover
ha_release: 0.92
ha_iot_class: Assumed State
---

`Somfy MyLink` 통합구성요소는 `Synergy` API를 사용하는 호환 가능한 Somfy MyLink 허브에 대한 인터페이스로 사용됩니다. Somfy MyLink 플랫폼에서 홈 어시스턴트로 Cover를 추가 할 수 있습니다.

설치시 호환되는 `Somfy MyLink` 장치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
somfy_mylink:
  host: IP_ADDRESS
  system_id: SYSTEM_ID
```

{% configuration %}
host:
  description: Somfy MyLink 허브 장치의 IP 주소.
  required: true
  type: string
system_id:
  description: Somfy MyLink 허브의 `System ID`. 이는 모바일앱의 `Integration` 메뉴에서 찾을 수 있습니다.
  required: true
  type: string
default_reverse:
  description: Cover의 기본 reverse 상태를 설정합니다. 가능한 값은 `true` 또는 `false`입니다. 이 값은 Cover 단위로 적용 할 수 있습니다 (아래 `entity_config` 참조).
  required: false
  type: boolean
  default: false
entity_config:
  description: "특정 Cover 엔터티에 대한 설정. 모든 하위 키들은 도메인에 해당하는 엔티티 ID입니다 (예 :`cover.bedroom_blinds`)."
  required: false
  type: map
  keys:
    '`<ENTITY_ID>`':
      description: 특정 엔티티에 대한 추가 옵션.
      required: false
      type: map
      keys:
        reverse:
          description: Cover 방향을 반대로 바꿉니다. 가능한 값은 `true` 혹은 `false`.
          required: false
          type: boolean
          default: false
{% endconfiguration %}

```yaml
# Advanced configuration.yaml entry setting specific options on a per-cover basis
somfy_mylink:
  host: IP_ADDRESS
  system_id: SYSTEM_ID
  default_reverse: true
  entity_config:
    cover.outdoor_awning:
        reverse: false
```
