---
title: 로봇청소기(Vacuum)
description: Instructions on how to setup and use vacuum's in Home Assistant.
ha_release: 0.51
---

`vacuum` 통합구성요소로 Home Assistant 내에서 가정용 로봇 청소기를 제어할 수 있습니다.

## 설정

설치시 이 통합구성요소를 사용하려면 [Xiaomi](/integrations/vacuum.xiaomi_miio/)와 같이 `vacuum` 플랫폼을 `configuration.yaml` 파일에 추가하십시오.

```yaml
# Example configuration.yaml entry
vacuum:
  - platform: xiaomi_miio
    name: Living room
    host: 192.168.1.2
```

### 구성요소 서비스

사용가능한 서비스 : `turn_on`, `turn_off`, `start_pause`, `start`, `pause`, `stop`, `return_to_base`, `locate`, `clean_spot`, `set_fanspeed`, `send_command`.

이러한 서비스 중 하나를 호출하기 전에 vacuum 플랫폼이 이를 지원하는지 확인하십시오.

#### `vacuum.turn_on` 서비스

새로운 청소 작업을 시작하십시오. Xiaomi Vacuum과 Neato의 경우 `vacuum.start`를 대신 사용하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.turn_off` 서비스

현재 청소 작업을 중지하고 dock으로 돌아갑니다. Xiaomi Vacuum과 Neato의 경우 `vacuum.stop`을 대신 사용하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.start_pause` 서비스

청소 작업을 시작, 일시중지 또는 다시시작하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.start` 서비스

청소 작업을 시작하거나 다시시작하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.pause` 서비스

청소 작업을 일시중지하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.stop` 서비스

vacuum의 현재 활동을 중지하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.return_to_base` 서비스

vacuum을 집으로 돌아가라고합니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.locate` 서비스

vacuum(로봇청소기)을 찾으십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.clean_spot` 서비스

vacuum에 특정 장소를 청소하도록 지시하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |

#### `vacuum.set_fan_speed` 서비스

vacuum의 팬 속도를 설정하십시오. `fanspeed`는 `balanced` 또는 `turbo`와 같은 레이블이거나 숫자일 수 있습니다. `vacuum` 플랫폼에 따라 다릅니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |
| `fan_speed`               |       no | Platform dependent vacuum cleaner fan speed, with speed steps, like 'medium', or by percentage, between 0 and 100. |

#### `vacuum.send_command` 서비스

플랫폼별 명령을 vacuum으로 보냅니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |      yes | Only act on specific vacuum. Else targets all.        |
| `command`                 |       no | Command to execute.                                   |
| `params`                  |      yes | Parameters for the command.                           |
