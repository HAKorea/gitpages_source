---
title: BMW 컨넥티드 드라이브
description: Instructions on how to setup your BMW Connected Drive account with Home Assistant.
logo: bmw.png
ha_category:
  - Car
  - Binary Sensor
  - Presence Detection
  - Lock
  - Sensor
ha_release: 0.64
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@gerard33'
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/BrZT2hkKgLo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`bmw_connected_drive` 통합구성요소를 통해 BMW 커넥티드 드라이브 포털에서 BMW 차량의 데이터를 검색 할 수 있습니다. 작동하려면 BMW Connected Drive 계정과 Connected Drive 지원 차량이 있어야합니다.

`bmw_connected_drive` 통합구성요소는 (최근) 미니 차량과도 작동합니다. 작동하려면 Mini Connected 계정과 Mini Connected 지원 차량이 있어야 작동합니다.

BMW 차량과의 호환성을 위해 GitHub의 [bimmer_connected page](https://github.com/bimmerconnected/bimmer_connected)를 확인하십시오.

이 통합구성요소는 다음 플랫폼을 제공합니다

- 이진 센서 : 도어, 창문, 상태 기반 서비스, 점검 제어 메시지, 주차 등, 도어록 상태, 충전 상태 (전기 자동차) 및 연결 상태 (전기 자동차).
- 장치 추적기 : 차량 위치.
- 잠금 : 자동차 잠금을 제어합니다.
- 센서 : 마일리지, 잔여 범위, 잔여 연료, 잔여 충전 시간 (전기 자동차), 충전 상태 (전기 자동차), 잔여 범위 전기 (전기 자동차).
- 서비스 : 에어컨을 켜고 경적을 울리며 표시등을 깜박이고 상태를 업데이트하십시오. 자세한 내용은 [here](/integrations/bmw_connected_drive/#services)를 참조 하십시오 .

## 설정

설치에서 이 통합구성요소를 사용 가능하게 하려면 `configuration.yaml`파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
bmw_connected_drive:
  name:
    username: USERNAME_BMW_CONNECTED_DRIVE
    password: PASSWORD_BMW_CONNECTED_DRIVE
    region: one of "north_america", "china", "rest_of_world"
```

{% configuration %}
bmw_connected_drive:
  description: configuration
  required: true
  type: map
  keys:
    name:
      description: 홈어시스턴트의 계정 이름
      required: true
      type: string
    username:
      description: BMW 커넥 티드 드라이브 사용자 이름.
      required: true
      type: string
    password:
      description: BMW 커넥 티드 드라이브 비밀번호.
      required: true
      type: string
    region:
      description: "연결된 드라이브 계정의 지역 다음 값 중 하나를 사용: `north_america`, `china`, `rest_of_world`"
      required: true
      type: string
    read_only:
      description: 읽기 전용 모드에서는 차량 잠금을 포함한 모든 서비스가 비활성화.
      required: false
      type: boolean
      default: false
{% endconfiguration %}

## 서비스

`bmw_connected_drive` 통합구성요소는 여러 가지 서비스를 제공합니다. 차량 식별 번호 (VIN)를 매개 변수로 제공해야하는 경우 차량의 장치 추적기 속성에서 VIN을 볼 수 있습니다. VIN은 17 자리 영숫자 문자열입니다 (예: WBANXXXXXX1234567.) 

이 서비스를 사용하면 차량 상태에 영향을 미칩니다. 따라서 이 서비스를 주의해서 사용하십시오!

### 잠금 및 잠금해제

각 차량에 대해 자동으로 생성된 잠금 연동을 통해 차량을 잠금 및 잠금 해제 할 수 있습니다. 이러한 서비스를 호출하기 전에 현재 상황에서 차량을 잠그거나 잠금 해제하는 것이 안전한지 확인하십시오.

### 에어컨

`bmw_connected_drive.activate_air_conditioning` 서비스를 통해 차량의 에어컨을 활성화 할 수 있습니다.

여기서 정확히 시작되는 것은 차량 유형에 따라 다릅니다. 보조 난방을 통한 환기에서부터 실제 에어컨에 이르기까지 다양합니다. 차량에 보조 난방 장치가 장착된 경우 차량을 안전한 장소 (예 : 지하 주차장 또는 폐쇄 차고가 아닌)에 주차 한 경우에만 이 서비스를 시작하십시오.

차량 매개 변수는 `vin`를 통해 식별됩니다. 

### 경적 소리

`bmw_connected_drive.sound_horn` 서비스는 차량의 경적을 울립니다. 일부 국가 (영국 등)에서는이 옵션을 사용할 수 없습니다. 이웃을 귀찮게 할 수 있으므로이 기능을 책임감있게 사용하십시오. 차량 매개 변수는 `vin`를 통해 식별됩니다. 

### 전조등 켜기

`bmw_connected_drive.light_flash` 서비스는 차량의 전조등을 켜고 끌 수 있습니다. 차량 매개 변수는 `vin`를 통해 식별됩니다. 

### 상태 업데이트

서비스 `bmw_connected_drive.update_state`는 BMW 서버에서 모든 계정의 차량의 마지막 상태를 가져옵니다. 이는 차량으로부터의 업데이트를 트리거하지 *않습니다*. BMW 서버에서 데이터를 가져옵니다. 따라서 이 서비스는 차량과 상호 작용하지 않습니다.

이 서비스에는 속성이 필요하지 않습니다.

## Disclaimer

이 소프트웨어는 BMW 그룹과 제휴하거나 보증하지 않습니다.
