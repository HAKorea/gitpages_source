---
title: AdGuard 홈
description: Instructions on how to integrate AdGuard Home with Home Assistant.
logo: adguard.png
ha_category:
  - Network
  - Sensor
  - Switch
ha_release: 0.95
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@frenck'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/AIO0JKQeHuk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

AdGuard Home은 Parental Control(성인 컨텐츠 차단)이 가능하며 네트워크 전체의 광고와 추적기 차단 기능을 하는 DNS서버입니다. `adguard` 통합구성요소는 Home Assistant에서 AdGuard Home 인스턴스를 제어하고 모니터링할 수 있습니다.

[AdGuard Home]((https://github.com/hassio-addons/addon-adguard-home))은 Home Assistant Add-on에 몇번의 클릭으로 설치할 수 있도록 Add-on으로 제공합니다. 
HA에서 **Supervisor**로 이동하시고 **ADD-ON STORE**에서 **Home Assistant Community Add-ons**에서 **AdGuard Home** 을 찾아 설치하십시오. 

--------------------------------------------------------------------------
이하 adguard 번역


## 프론트 엔드를 통한 설정

Menu: **설정** -> **통합구성요소**.

`+` 를 클릭하여 통합구성요소를 추가하고 **AdGuard Home**을 클릭하십시오.
설정 단계를 완료하면 AdGuard Home 통합구성요소를 사용할 수 있습니다.

## Sensors

이 통합구성요소는 AdGuard Home의 다음 정보에 대한 센서를 제공합니다. : 

- Number of DNS queries.
- Number of blocked DNS queries.
- Ratio (%) of blocked DNS queries.
- Number of requests blocked by safe browsing.
- Number of safe searches enforced.
- Number of requests blocked by parental control.
- Total number of active filter rules loaded.
- Average response time of AdGuard's DNS server in milliseconds.

## Switches

연동이후 많은 스위치를 생성합니다 :

- AdGuard Protection (master switch).
- Filtering.
- Safe Browsing.
- Parental Control.
- Safe Search.
- Query Log.

이 스위치를 사용하면 작업(things)을 쉽게 자동화할 수 있습니다. 예를 들어, 어린이가 잠든 후 세이프 서치를 끄는 자동화를 만들 수 있습니다.

"AdGuard Protection" 스위치는 마스터 스위치입니다. 전원이 켜져 있는지 여부에 관계없이 모든 AdGuard 기능이 꺼지고 무시됩니다.

<div class="note">
쿼리 로그를 끄면 모든 센서가 더이상 업데이트를 받지 않습니다.
AdGuard는 통계를 제공하기 위해 쿼리 로그를 사용합니다.
</div>

## 서비스

이러한 서비스를 통해 AdGuard Home에서 필터 구독(filter subscriptions)을 관리할 수 ​​있습니다.
자동화에서 이러한 서비스를 사용하면 특정 시간에 특정 사이트/도메인을 차단하는데 도움이 될 수 있습니다.

예를 들어 낮에는 소셜 미디어 사이트를 차단하고 저녁에는 해제하는 사용자 지정 필터 목록을 만들 수 있습니다.

### `add_url` 서비스

AdGuard Home에 새 필터 구독(filter subscription)을 추가하십시오.

| Service data attribute | Optional | Description                                                  |
| ---------------------- | -------- | ------------------------------------------------------------ |
| `name`                 | No       | The name of the filter subscription.                         |
| `url`                  | No       | The filter URL to subscribe to, containing the filter rules. |

### `remove_url` 서비스

AdGuard Home에서 필터 구독을 제거합니다.

| Service data attribute | Optional | Description                            |
| ---------------------- | -------- | -------------------------------------- |
| `url`                  | No       | The filter subscription URL to remove. |

### `enable_url` 서비스

AdGuard Home에서 필터 구독을 활성화합니다.

| Service data attribute | Optional | Description                            |
| ---------------------- | -------- | -------------------------------------- |
| `url`                  | No       | The filter subscription URL to enable. |

### `disable_url` 서비스

AdGuard Home에서 필터 구독을 비활성화합니다.

| Service data attribute | Optional | Description                             |
| ---------------------- | -------- | --------------------------------------- |
| `url`                  | No       | The filter subscription URL to disable. |

### `refresh` 서비스

AdGuard Home에서 모든 필터 구독을 새로고칩니다.

| Service data attribute | Optional | Description                                       |
| ---------------------- | -------- | ------------------------------------------------- |
| `force`                | Yes      | Force update (bypasses AdGuard Home throttling).  |

기본적으로 `force`는 `false`로 설정되어 있습니다. 강제 업데이트는 AdGuard Home의 스로틀 로직(throttling logic)을 무시하므로 주의해서 사용하십시오.