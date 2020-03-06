---
title: Neato Botvac(로봇청소기)
description: Instructions on how to integrate your Neato within Home Assistant.
logo: neato.png
ha_category:
  - Camera
  - Sensor
  - Switch
  - Vacuum
ha_iot_class: Cloud Polling
ha_release: 0.33
ha_config_flow: true
ha_codeowners:
  - '@dshokouhi'
  - '@Santobert'
---

`neato` 통합구성요소로 [Neato Botvac Connected Robots](https://www.neatorobotics.com/robot-vacuum/botvac-connected-series/)를 제어할 수 있습니다.

설치에서 `neato`를 활성화하려면 통합 화면에서 설정하거나 `configuration.yaml` 파일에 추가하십시오.

## 통합구성요소 화면을 통해 연동 설정

Menu: *설정* -> *통합구성요소*

목록에서 **Neato**를 검색하거나 선택하고 연동을 설정하십시오. Neato 또는 Vorwerk 장치를 사용하는지 여부와 함께 사용자 이름과 비밀번호를 입력해야합니다.
그 후 모든 엔티티가 홈어시스턴트에 자동으로 나타납니다.

## configuration.yaml을 통한 연동 설정 

configuration.yaml에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
neato:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Neato 계정의 사용자 이름.
  required: true
  type: string
password:
  description: Neato 계정의 비밀번호
  required: true
  type: string
vendor:
  description: 추가 공급 업체를 지원합니다. Vorwerk 로봇의 경우 `vorwerk`로 설정하십시오.
  required: false
  type: string
  default: neato
{% endconfiguration %}

<div class='note'>

펌웨어 4.0으로 업데이트 한 후 (클리닝 맵 추가) Botvac D3 Connected 및 Botvac D5 Connected 로봇의 맵표시도 지원됩니다. 업데이트 방법에 대한 자세한 내용은 [here](https://support.neatorobotics.com/hc/en-us/articles/115004320694-Software-Update-4-0-for-Neato-Botvac-Connected-D3-D5-)를 참조하십시오.

</div>

## Vacuum

`neato` Vacuum 플랫폼을 사용하면 [Neato Botvac Connected](https://www.neatorobotics.com/robot-vacuum/botvac-connected-series/)를 제어 할 수 있습니다. 상태에는 로봇청소기의 마지막 청소 세션의 속성이 포함됩니다.

<div class='note'>
로봇이 명령에 응답하지 않는 경우 로봇이 "unavailable" 상태인지 확인하십시오. "unavailable"이 표시되면 먼저 로봇 청소기를 다시 시작하고 더 이상 "unavailable" 장치가 아닌지 5 분 정도 기다리십시오. 여전히 문제가 발생하면 Neato 앱을 확인하고 로봇이 연결되어 작동하는지 확인하십시오. 그렇지 않은 경우 앱의 단계에 따라 로봇을 재설정하고 이전과 동일한 이름을 지정한 다음 Home Assistant를 다시 시작하십시오.
</div>

### 서비스

현재 지원되는 서비스는 다음과 같습니다.

- `start`
- `pause`
- `stop`
- `return_to_base`
- `locate`
- `clean_spot`

그리고 특정 플랫폼 서비스 :

- `neato.custom_cleaning`

### 플랫폼 서비스

#### `neato.custom_cleaning` 서비스

집 청소를 시작합니다. 모바일 애플리케이션과 같은 다양한 옵션 (모드, 지도 사용법, 탐색 모드, 구역)을 설정할 수 있습니다.

<div class='note'>

모든 Botvac 모델이 모든 속성을 지원하는 것은 아닙니다. Neato Botvac D7만이 `zone` 속성을 지원합니다.
기능에 대한 일부 정보는 [Neato Developer Portal](https://developers.neatorobotics.com/api/robot-remote-protocol/housecleaning)에 있습니다.

</div>

| Service data attribute | Optional | Description                                                                                                                                                                   |
| ---------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `entity_id`            | no       | Only act on a specific robot                                                                                                                                                  |
| `mode`                 | yes      | Set the cleaning mode: 1 for eco and 2 for turbo. Defaults to turbo if not set.                                                                                               |
| `navigation`           | yes      | Set the navigation mode: 1 for normal, 2 for extra care, 3 for deep. Defaults to normal if not set. Deep cleaning is only supported on the Botvac D7.                                                                           |
| `category`             | yes      | Whether to use a persistent map or not for cleaning (i.e. No go lines): 2 for no map, 4 for map. Default to using map if not set (and fallback to no map if no map is found). |
| `zone`                 | yes      | Only supported on the Botvac D7. Name of the zone to clean from the Neato app. Use unique names for the zones to avoid the wrong zone from running. Defaults to no zone i.e. complete house cleanup.                                                                  |


## 카메라

`neato` 카메라 플랫폼을 사용하면 [Neato Botvac Connected](https://www.neatorobotics.com/robot-vacuum/botvac-connected-series/botvac-connected/)의 최신 클리닝 맵을 볼 수 있습니다 

## 센서

`neato` 센서 플랫폼을 사용하면 [Neato Botvac Connected](https://www.neatorobotics.com/robot-vacuum/botvac-connected-series/botvac-connected/)의 배터리 잔량을 볼 수 있습니다

## 스위치

`neato` 스위치 플랫폼을 사용하면 [Neato Botvac Connected](https://www.neatorobotics.com/robot-vacuum/botvac-connected-series/botvac-connected/)의 스케줄을 활성화 또는 비활성화 할 수 있습니다

설치시 `neato` 스위치, 카메라 및 vacuum을 추가하려면 위의 지침을 따르십시오.