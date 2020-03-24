---
title: 오픈소스 CCTV허브(ZoneMinder)
description: How to integrate ZoneMinder into Home Assistant.
logo: zoneminder.png
ha_category:
  - Hub
  - Binary Sensor
  - Camera
  - Sensor
  - Switch
ha_release: 0.31
ha_iot_class: Local Polling
ha_codeowners:
  - '@rohankapoorcom'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/D3pjZKO5eIE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`zoneminder` 통합구성요소는 [ZoneMinder](https://www.zoneminder.com) 인스턴스와 홈어시스턴트를 셋업합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Camera](#camera)
- [Sensor](#sensor)
- [Switch](#switch)

## 설정

```yaml
# Example configuration.yaml entry
zoneminder:
  - host: ZM_HOST
```

{% configuration %}
host:
  description: Your ZoneMinder server's host (and optional port), not including the scheme.
  required: true
  type: string
path:
  description: Path to your ZoneMinder install.
  required: false
  type: string
  default: "`/zm/`"
path_zms:
  description: Path to the CGI script for streaming. This should match `PATH_ZMS` in ZM's "Paths" settings.
  required: false
  type: string
  default: "`/zm/cgi-bin/nph-zms`"
ssl:
  description: Set to `true` if your ZoneMinder installation is using SSL.
  required: false
  type: boolean
  default: false
verify_ssl:
  description: Verify the certification of the endpoint.
  required: false
  type: boolean
  default: true
username:
  description: Your ZoneMinder username.
  required: false
  type: string
password:
  description: Your ZoneMinder password. Required if `OPT_USE_AUTH` is enabled in ZM.
  required: false
  type: string
{% endconfiguration %}

### 전체 설정

```yaml
# Example configuration.yaml entry
zoneminder:
  - host: ZM_HOST
    path: ZM_PATH
    path_zms: ZM_PATH_ZMS
    ssl: true
    verify_ssl: true
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

### 서비스

일단 `zoneminder` 플랫폼은 ZoneMinder의 현재 실행 상태를 변경하는데 사용할 수 있는 서비스 (`set_run_state`)를 보여줍니다.

| Service data attribute | Optional | Description                       |
|:-----------------------|:---------|:----------------------------------|
| `id`                   | no       | Host of the ZoneMinder instance.  |
| `name`                 | no       | Name of the new run state to set. |

예를 들어, ZoneMinder 인스턴스가 "Home"이라는 실행 상태로 설정된 경우 이어지는 [action](/getting-started/automation-action/)을 포함하여 ZoneMinder를 "Home"실행 상태로 변경하는 [automation](/getting-started/automation/)을 작성할 수 있습니다. 

 ```yaml
action:
  service: zoneminder.set_run_state
  data:
    id: ZM_HOST
    name: Home
```

## Binary Sensor

`zoneminder` 바이너리 센서 플랫폼을 사용하면 [ZoneMinder](https://www.zoneminder.com) 설치의 가용성을 모니터링 할 수 있습니다.

생성된 각 binary_sensor는 [ZoneMinder component](/integrations/zoneminder/)를 설정할 때 사용된 호스트 이름을 따라 이름이 지정됩니다.

## Camera

`zoneminder` 카메라 플랫폼을 사용하면 [ZoneMinder](https://www.zoneminder.com) 카메라의 현재 스트림을 모니터링 할 수 있습니다.

### 설정

셋업하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
camera:
  - platform: zoneminder
```

## Sensor

`zoneminder` 센서 플랫폼을 사용하면 이벤트 수, 카메라의 현재 상태 및 ZoneMinder의 현재 실행 상태를 포함하여 [ZoneMinder](https://www.zoneminder.com) 설치의 현재 상태를 모니터링 할 수 있습니다.

셋업하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: zoneminder
    include_archived: false
```

{% configuration %}
include_archived:
  description: Whether to include archived ZoneMinder events in event counts.
  required: false
  default: false
  type: boolean
monitored_conditions:
  description: Event count sensors to display in the frontend.
  required: false
  type: list
  keys:
    all:
      description: All events.
    month:
      description: Events in the last month.
    week:
      description: Events in the last week.
    day:
      description: Events in the last day.
    hour:
      description: Events in the last hour.
{% endconfiguration %}

## Switch

`zoneminder` 스위치 플랫폼을 사용하면 [ZoneMinder](https://www.zoneminder.com) 인스턴스에 연결된 모든 카메라의 현재 기능을 토글 할 수 있습니다.

<div class='note'>

이를 사용하도록 [ZoneMinder component](/integrations/zoneminder/)가 설정되어 있어야하며 ZoneMinder 인증이 활성화 된 경우 연동 설정에 지정된 계정에는 "System"에 대한 "Edit" 권한이 있어야합니다.

</div>

이 스위치를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: zoneminder
    command_on: Modect
    command_off: Monitor
```

{% configuration %}
command_on:
  description: The function you want the camera to run when turned on.
  required: true
  type: string
command_off:
  description: The function you want the camera to run when turned off.
  required: true
  type: string
{% endconfiguration %}

<div class='note'>
ZoneMinder에 의해 설치되는 기본 기능은 None, Monitor, Modect, Record, Mocord, Nodect입니다.
</div>
