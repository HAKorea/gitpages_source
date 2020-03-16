---
title: 트랙카(Traccar)
description: Instructions how to use Traccar GPS tracker to track devices in Home Assistant.
logo: traccar.png
ha_release: 0.83
ha_category:
  - Presence Detection
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@ludeeus'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/F6EPwLjFdcA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`Traccar`는 추적시 GPS를 사용하며 1500 가지가 넘는 다양한 유형의 장치를 지원합니다. 하나의 옵션은 `webhook`을 통해 스마트폰에서 [Traccar Client](https://www.traccar.org/client/) 앱을 추적하는 것입니다. 다른 옵션은 Hass.io addon으로도 제공되는 기존 [Traccar Server](https://www.traccar.org/server/) 설치에 연결하는 것입니다.

## Traccar 클라이언트

Traccar 클라이언트를 설정하려면 설정 화면의 통합구성요소 패널을 통해 Traccar 클라이언트를 설정해야합니다. 그러면 모바일 장치 구성 중에 사용할 웹 후크 URL이 제공됩니다. 이 URL은 Traccar 앱에서 설정해야합니다. 

## Traccar 서버

홈어시스턴트에 Traccar 서버를 통합하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: traccar
    host: IP_ADDRESS
    username: USERNAME
    password: PASSWORD
```

{% configuration %}
host:
  description: The DNS name or IP Address of the server running Traccar.
  required: true
  type: string
username:
  description: The username for the Traccar server.
  required: true
  type: string
password:
  description: The password for your given account on the Traccar server.
  required: true
  type: string
host:
  description: The DNS name or IP Address of the server running Traccar.
  required: true
  type: string
port:
  description: The port of your Traccar server.
  required: false
  default: 8082
  type: integer
ssl:
  description: Use HTTPS to connect to Traccar server. *NOTE* A host *cannot* be an IP address when this option is enabled.
  required: false
  default: false
  type: boolean
verify_ssl:
  description: Verify the certification of the system.
  required: false
  type: boolean
  default: true
max_accuracy:
  description: Filter positions with higher accuracy than specified.
  required: false
  type: integer
  default: 0
skip_accuracy_filter_on:
  description: Skip filter position by "max_accuracy filter" if any of specified attributes are pressent on the traccar message.
  required: false
  type: list
monitored_conditions:
  description: Additional traccar computed attributes or device-related attributes to include in the scan.
  required: false
  type: list
event:
  description: "Traccar events to include in the scan and fire within Home Assistant. *NOTE* For more info regarding Traccar events please refer to Traccar's documentation: https://www.traccar.org/documentation/events/."
  required: false
  type: list
  keys:
    device_moving:
      description: "**deviceMoving** event."
      required: false
      type: string
    command_result:
      description: "**commandResult** event."
      required: false
      type: string
    device_fuel_drop:
      description: "**deviceFuelDrop** event."
      required: false
      type: string
    geofence_enter:
      description: "**geofenceEnter** event."
      required: false
      type: string
    device_offline:
      description: "**deviceOffline** event."
      required: false
      type: string
    driver_changed:
      description: "**driverChanged** event."
      required: false
      type: string
    geofence_exit:
      description: "**geofenceExit** event."
      required: false
      type: string
    device_overspeed:
      description: "**deviceOverspeed** event."
      required: false
      type: string
    device_online:
      description: "**deviceOnline** event."
      required: false
      type: string
    device_stopped:
      description: "**deviceStopped** event"
      required: false
      type: string
    maintenance:
      description: "**maintenance** event."
      required: false
      type: string
    alarm:
      description: "**alarm** event."
      required: false
      type: string
    text_message:
      description: "**textMessage** event."
      required: false
      type: string
    device_unknown:
      description: "**deviceUnknown** event."
      required: false
      type: string
    ignition_off:
      description: "**ignitionOff** event."
      required: false
      type: string
    ignition_on:
      description: "**ignitionOff** event."
      required: false
      type: string
    all_events:
      description: "**allEvents** catchall for all event types."
      required: false
      type: string
{% endconfiguration %}

`monitored_conditions` 매개 변수를 사용하면 traccar 플랫폼에서 비표준 속성을 추적하고 홈어시스턴트에서 사용할 수 있습니다. 예를 들어, 비표준 속성 `alarm`과 사용자 정의 계산 속성 `mycomputedattribute`의 상태를 모니터링해야하는 경우 설정을 다음과 같이 채우십시오.

```yaml
device_tracker:
  - platform: traccar
    ...
    monitored_conditions: ['alarm', 'mycomputedattribute']
```

`event` 매개 변수를 사용하면 traccar 플랫폼 (https://www.traccar.org/documentation/events/)에서 이벤트를 가져와 홈어시스턴트에서 실행할 수 있습니다. 모니터하고 가져 오는 이벤트 목록을 승인하며 각 이벤트는 소문자 공백없는 문자로 나열해야합니다. 이벤트는 위에 언급 된 목록에 정의 된 것과 동일한 이벤트 이름으로 시작되며 앞에는 `traccar_` 접두사가 붙습니다. 예를 들어, 홈어시스턴트에서 Traccar 이벤트 `deviceOverspeed` 및 `deviceFuelDrop`을 가져와야하는 경우 `event` 매개 변수를 다음과 같이 채워야합니다. :

```yaml
device_tracker:
  - platform: traccar
    ...
    event: ['device_overspeed', 'device_fuel_drop']
```
홈어시스턴트는 플랫폼에서 해당 이벤트를 수신하면 바로 `traccar_device_overspeed` 및 `traccar_device_fuel_drop` 으로 시작됩니다.
*참고* 모든 이벤트를 가져 오려면 `all_events`를 지정하십시오.