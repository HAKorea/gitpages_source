---
title: 유비쿼티(Ubiquiti Unifi)
description: Instructions on how to configure UniFi integration with UniFi Controller by Ubiquiti.
logo: ubiquiti.png
ha_category:
  - Hub
  - Presence Detection
  - Switch
ha_release: 0.81
ha_iot_class: Local Polling
ha_config_flow: true
ha_quality_scale: platinum
ha_codeowners:
  - '@kane610'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/dqjH8SUkfFQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Ubiquiti Networks, Inc.](https://www.ubnt.com/)의 [UniFi](https://unifi-sdn.ubnt.com/)는 게이트웨이, 스위치 및 무선 액세스 포인트를 하나의 그래픽 프론트 엔드와 결합하는 소프트웨어입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Presence Detection](#presence-detection)
- [Switch](#switch)

## 설정

Home Assistant는 **설정** -> **통합구성요소** -> **UniFi 컨트롤러**를 통해 UniFi 연동을 제공합니다.

`host address`, `user name`, `password`를 입력한 다음 홈어시스턴트에 연결할 사이트를 계속 선택하십시오. POE 스위치를 제어하려면 사용자에게 관리자 권한이 필요합니다.

### 장치 추적기의 추가 설정

다음을 추가하여 UniFi 장치 추적기의 동작을 보강할 수 있습니다

```yaml
# Example configuration.yaml entry
unifi:
  controllers:
    - host: unifi
      site: My site
      ssid_filter:
        - 'HomeSSID'
        - 'IoTSSID'
```

{% configuration %}
host:
  description: Same address as relevant config entry, needed to identify config entry.
  type: string
  required: true
  default: None
site:
  description: Same site as relevant config entry, needed to identify config entry.
  type: string
  required: true
  default: None
block_client:
  description: A list of Clients MAC Addresses that can be blocked from the network.
  type: list
  required: false
  default: None
detection_time:
  description: How long since the last seen time before the device is marked away, specified in seconds.
  type: integer
  required: false
  default: 300
dont_track_clients:
  description: enable to not allow device tracker to track clients.
  type: boolean
  required: false
  default: false
dont_track_devices:
  description: enable to not allow device tracker to track devices.
  type: boolean
  required: false
  default: false
dont_track_wired_clients:
  description: enable to not allow device tracker to track wired clients.
  type: boolean
  required: false
  default: false
ssid_filter:
  description: Filter the SSIDs that tracking will occur on.
  type: list
  required: false
  default: None
{% endconfiguration %}

### 사용자들 설정하기

UniFi 컨트롤러를 사용하면 기본 관리자 외에 여러 사용자를 만들 수 있습니다. 장치 추적기만 사용하려면 Unifi 장치 추적기에 대해 `read-only` 권한(permissions)이 있는 제한된 사용자를 만드는 것이 좋습니다. 네트워크 액세스 또는 POE 제어를 차단하려면 'admin' 권한이 있어야합니다.

### MQTT와의 충돌

Unifi 컨트롤러는 전용 하드웨어 장치 (UniFi's cloud key)이거나 어떤 Linux 시스템의 소프트웨어 일 수 있습니다. Home Assistant와 동일한 운영 체제에서 Unifi 컨트롤러를 실행하는 경우 MQTT 연동이 있는 경우 포트에서 충돌이 발생할 수 있습니다.

이러한 상황을 피하려면 전용 가상 머신에서 Unifi 컨트롤러를 실행하는 것이 좋습니다.

## 재실 감지

이 플랫폼을 사용하면 [Ubiquiti](https://ubnt.com/) [UniFi](https://www.ubnt.com/enterprise/#unifi) 컨트롤러에 연결된 장치를 보고 재실을 감지할 수 있습니다.

### 문제 해결 및 시간 동기화

재실 감지는 Home Assistant와 UniFi 컨트롤러 간의 정확한 시간 설정에 따라 다릅니다.

홈어시스턴트와 UniFi 컨트롤러가 별도의 시스템 또는 VM에서 실행중인 경우 모든 시계가 동기화되었는지 확인하십시오. 시계를 동기화하지 못하면 홈어시스턴트가 장치를 Home으로 표시하지 못하게됩니다.

[관련 이슈](https://github.com/home-assistant/home-assistant/issues/10507)

## Switch

### 클라이언트의 네트워크 액세스 차단

MAC 주소 목록을 추가하여 `configuration.yaml` 파일에 설정된 클라이언트에 대한 네트워크 액세스를 제어할 수 있습니다. 이 목록의 항목에는 Unifi 장치 이름을 사용하여 차단 및 차단해제를 할 수 있는 Home Assistant 스위치가 있습니다.

### POE가 제공하는 클라이언트 제어

연결된 각 POE 클라이언트에 대해 엔티티가 자동으로 나타납니다. POE 클라이언트 장치가 작동하지 않으면 엔티티가 표시되지 않습니다. 참고: 액세스 포인트 및 기타 스위치와 같은 Unifi 인프라 장치는 이더넷 자체에서 전원이 공급되더라도 (아직) 지원되지 않습니다.

POE 제어는 실제로 클라이언트가 연결된 스위치의 네트워크 포트를 설정합니다.

## 연동 디버깅

UniFi 또는 연동에 문제가 있는 경우 로그에 디버그 출력을 추가할 수 있습니다.

```yaml
logger:
  default: info
  logs:
    aiounifi: debug
    homeassistant.components.unifi: debug
    homeassistant.components.device_tracker.unifi: debug
    homeassistant.components.switch.unifi: debug
```
