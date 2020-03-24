---
title: 레인 버드(Rain Bird)
description: Instructions on how to integrate your Rain Bird LNK WiFi Module within Home Assistant.
logo: rainbird.png
ha_category:
  - Irrigation
  - Sensor
  - Switch
ha_release: 0.61
ha_iot_class: Local Polling
ha_codeowners:
  - '@konikvranik'
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/ZUBykEJOpeE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`rainbird` 통합구성요소를 통해 Home Assistant의 Rain Bird 관개 시스템의 [LNK WiFi](https://www.rainbird.com/products/lnk-wifi-module) 모듈과 상호 작용할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :

- [Sensor](#sensor)
- [Switch](#switch)

## 설정

이를 활성화하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
rainbird:
  host: IP_ADDRESS_OF_MODULE
  password: YOUR_PASSWORD
  trigger_time: 360

```

{% configuration %}
host:
  description: IP Address of the Module
  required: true
  type: string
password:
  description: The password for accessing the module.
  required: true
  type: string
trigger_time:
  description: Irrigation time. The time will be rounded down to whole minutes.
  required: true
  type: time
zones:
  description: Dictionary of zone configurations
  required: false
  type: map
  keys:
    ZONE_NUMBER:
      description: Zone ID
      type: map
      keys:
        friendly_name:
          description: Friendly name to see in GUI
          required: false
          type: string
        trigger_time:
          description: Irrigation time. Seconds are ignored.
          required: false
          type: time
{% endconfiguration %}


가능한 모든 기능을 사용하는 보다 복잡한 설정은 다음 예와 같습니다.
```yaml
# Example configuration.yaml entry
rainbird:
  - host: IP_ADDRESS_OF_MODULE
    password: YOUR_PASSWORD
    trigger_time: 6
    zones:
      1:
        friendly_name: My zone 1
        trigger_time:
          minutes: 6
      2:
        friendly_name: My zone 2
        trigger_time: 2
  - host: IP_ADDRESS_OF_ANOTHER_MODULE
    password: YOUR_ANOTHER_PASSWORD
    trigger_time: 0:06
    zones:
      1:
        friendly_name: My zone 1
        trigger_time: 0:06
      3:
        friendly_name: My zone 3
        trigger_time: 0:05
```
<div class='note'>
LNK 모듈 내에서 API를 구현하기 때문에 동시성 문제가 있습니다. 예를 들어 Rain Bird 앱은 연결 문제(예: 이미 연결이 활성화 된 상태)를 나타낼 수 있습니다.
</div>

## Sensor

이 `rainbird` 센서는 Home Assistant의 Rain Bird 관개 시스템의 [LNK WiFi](https://www.rainbird.com/products/lnk-wifi-module) 모듈과 상호 작용할 수 있습니다.

The integration adds `rainsensor` and `raindelay` sensors and their `binary_sensor` alternatives.

## Switch

이 `rainbird` 스위치 플랫폼은 Home Assistant의 Rain Bird 관개 시스템의 [LNK WiFi](https://www.rainbird.com/products/lnk-wifi-module) 모듈과 상호 작용할 수 있습니다.

설정된 컨트롤러의 모든 가용 영역에 스위치가 자동으로 추가됩니다.

## 서비스

Rain Bird 스위치 플랫폼은 지정된 기간 동안 단일(single) 관개를 시작하는 서비스를 제공합니다.

| Service | Description |
| ------- | ----------- |
| rainbird.start_irrigation | Set a duration state attribute for a switch and turn the irrigation on.|

이 서비스는 자동화 스크립트의 일부로 사용할 수 있습니다. 예를 들면 다음과 같습니다.

```yaml
# Example configuration.yaml automation entry
automation:
  - alias: Turn irrigation on
    trigger:
      platform: time
      at: '5:30:00'
    action:
      service: rainbird.start_irrigation
      entity_id: switch.sprinkler_1
      data:
        duration: 5
```
