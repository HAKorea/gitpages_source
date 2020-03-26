---
title: 파이홀(Pi-hole)
description: Instructions on how to integrate Pi-hole with Home Assistant.
ha_category:
  - System Monitor
ha_iot_class: Local Polling
logo: pi_hole.png
ha_release: 0.28
ha_codeowners:
  - '@fabaff'
  - '@johnluetke'
---

<div class='videoWrapper'>
<iframe width="690" height="399" src="https://www.youtube.com/embed/I3des9ver1o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`pi_hole` 통합구성요소를 통해 통계를 검색하고 [Pi-hole](https://pi-hole.net/) 시스템과 상호 작용할 수 있습니다.

## 설정

이 설정을 기본 설정과 통합하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
pi_hole:
  - host: IP_ADDRESS
```

{% configuration %}
host:
  description: >
    "호스트 이름(및 포트) (예: Pi-hole이 실행중인 호스트의 '192.168.0.3:4865') Hass.io 애드온 사용자는 반드시 `4865` 포트를 지정해야합니다."
  required: true
  type: string
name:
  description: >
    "Pi-hole의 이름. 이 이름은 생성된 센서의 일부입니다 (예: `name: My Awesome Pi-hole`은 센서 이름이 `sensor.my_awesome_pi_hole_`로 시작합니다.)"

    **Note:** 여러 Pi-Holes를 설정하는 경우 각각의 고유한 이름이 *있어야합니다.*
  required: false
  type: string
  default: Pi-hole
location:
  description: Pi-hole API의 설치 위치.
  required: false
  type: string
  default: admin
ssl:
  description: "`true`인 경우, SSL/TLS를 사용하여 Pi-Hole 시스템에 연결하십시오"
  required: false
  type: boolean
  default: false
verify_ssl:
  description: >
    시스템의 SSL/TLS 인증서를 확인하십시오. Pi-Hole 인스턴스가 자체 서명 인증서를 사용하는 경우 `false`를 지정해야합니다.
  required: false
  type: boolean
  default: true
api_key:
  description: Pi-hole과 상호 작용하기위한 API 키. 사용 통계를 위해 Pi-hole을 쿼리하려는 경우에는 필요하지 않습니다.
  required: false
  type: string
  default: None
{% endconfiguration %}

### 전체 예

Hass.io 애드온을 통한 단일 Pi-hole 실행 :

```yaml
pi_hole:
  - host: 'localhost:4865'
```

멀티 Pi-holes:

```yaml
pi_hole:
  - host: '192.168.0.2'
  - host: '192.168.0.3'
    name: 'Secondary Pi-Hole'
```

자체 서명 인증서가 있는 Pi-hole :

```yaml
pi_hole:
  - host: 'pi.hole'
    ssl: true
    verify_ssl: false
```

활성화 또는 비활성화할 수 있는 `api_key`가 있는 Pi-hole:

```yaml
pi_hole:
  - host: 'pi.hole'
    api_key: !secret pi_hole_api_key
```

## 서비스

이 플랫폼은 Pi-hole과 상호 작용하기 위해 다음 서비스를 제공합니다.


### `pi_hole.disable` 서비스

지정된 시간 동안 설정된 Pi-hole을 비활성화합니다.

| Service data attribute | Required | Type | Description |
| ---------------------- | -------- | -------- | ----------- |
| `duration` | `True` | timedelta | Time for which Pi-hole should be disabled | 
| `name` | `False` | string | If preset, disables the named Pi-hole, otherwise, disables all configured Pi-holes |

_Note: 이 서비스는 설정에 `api_key`를 지정해야합니다._

### `pi_hole.enable` 서비스

설정된 Pi-holes을 활성화합니다.

| Service data attribute | Required | Type | Description |
| ---------------------- | -------- | -------- | ----------- |
| `name` | `False` | string | If preset, enables the named Pi-hole, otherwise, enables all configured Pi-holes |

_Note: 이 서비스는 설정에 `api_key`를 지정해야합니다._

이 통합구성요소는 Pi-hole LLC 또는 Pi-hole 커뮤니티가 수행하지 않았습니다. 그들은 창조, 지원, 피드백, 테스트 또는 다른 도움을 제공하지 않았습니다. Pi-hole이 이후 릴리스에서 API를 변경하면 중단될 수 있는 타사 플랫폼입니다. 공식적이거나 개발되지 않았으며 지원되지 않으며 Pi-hole LLC 또는 Pi-hole 커뮤니티를 보증하지 않습니다. 플랫폼 `Pi-hole`과 로고는 여기에서 플랫폼을 설명하는데 사용됩니다. `Pi-hole`은 Pi-hole LLC의 등록 상표입니다.