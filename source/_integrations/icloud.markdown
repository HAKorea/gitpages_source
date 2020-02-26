---
title: Apple iCloud
description: Instructions on how to use iCloud to track devices in Home Assistant.
logo: icloud.png
ha_category:
  - Presence Detection
  - Sensor
ha_iot_class: Cloud Polling
ha_release: '0.10'
ha_config_flow: true
ha_codeowners:
  - '@Quentame'
---

`icloud` 통합구성요소를 통해 [iCloud] (https://www.icloud.com/) 서비스를 사용하여 재실 감지를 쓸 수 있습니다. 
iCloud를 통해 사용자는 iOS 장비에서 자신의 위치를 ​​추적 할 수 있습니다.

현재 홈어시스턴트 내에서 다음 플랫폼을 지원합니다

- [Device Tracker](#device-tracker)
- [Sensor](#sensor)

장치가 [Find My](https://www.apple.com/uk/icloud/find-my/) 서비스에 등록되어 있어야 합니다.

## 연동 셋업 (Setup the integration)

Home Assistant에서 iCloud를 통합하는 두 가지 방법이 있습니다

### 프론트엔드를 경유하는 방법

메뉴: *설정* -> *통합구성요소*. "iCloud" 검색, 개인계정정보 추가한 후 제출 클릭.

계정에 처음으로 통합구성요소를 추가하는 경우:
1. 목록에서 신뢰할 수있는 장치를 선택하고 제출하십시오. 
2. 신뢰할 수있는 장치에 문자 메시지를 보내고 수신 된 코드를 다음 양식에 추가하고 제출합니다 (올바른 코드를 놓친 경우 이전 단계로 돌아가서 다시 시도합니다).
3. 끝 !

이미 통합을 추가한 경우 완료된 것입니다!

### configuration 파일에 등록하는 방법

`configuration.yaml` 파일에 다음 섹션을 추가 하십시오. :


```yaml
# Example configuration.yaml entry
icloud:
  - username: USERNAME
    password: PASSWORD
```

{% configuration %}
username:
  description: iCloud 계정 이메일.
  required: true
  type: string
password:
  description: iCloud 계정 비밀번호.
  required: true
  type: string
max_interval:
  description: 위치 업데이트 사이의 최대간격(분)입니다. 이 추적기는 동적 간격을 사용하여 위치 업데이트를 요청합니다. iPhone이 정지 상태이면 배터리를 절약하기 위해 간격이 `max_interval`로 설정됩니다. iPhone이 다시 움직이기 시작하면 간격이 1분으로 동적으로 업데이트됩니다. 1분 업데이트 간격은 최대 `max_interval` 분만큼 지연될 수 있습니다. 최소값은 1 분입니다.
  required: false
  default: 30
  type: integer
gps_accuracy_threshold:
  description: iCloud 위치 업데이트는 10에서 5000미터까지 다양한 gps_accuracy와 함께 제공됩니다. 이 설정은 위치 업데이트에 대한 정확도 임계값을 미터 단위로 정의합니다. 이 추적기는 정확도가 떨어지는 업데이트를 삭제합니다. 이를 통해 보다 정확한 위치 모니터링이 가능하고 오탐지 영역의 변화가 줄어 듭니다.
  required: false
  default: 500
  type: integer
{% endconfiguration %}

<div class='note warning'>
'max_interval'이 낮으면 장치가 자주 반응하여 현재 위치를 얻을 때 배터리 소모가 발생할 수 있습니다.
</div>

<div class='note warning'>
다른 사람이 귀하의 계정에 로그인했다는 이메일과 알림을 Apple로부터 받을 수 있습니다.

알림을 받으려면 "허용"을 누른 다음 "확인"을 누르십시오.
</div>

iCloud 계정에 2단계 인증이 활성화 된 경우 홈어시스턴트가 시작된 후 어느시점에 통합구성요소는 홈어시스턴트 UI의 알림을 통해 신뢰할 수 있는 장치로 사용할지 묻습니다. 이 과정에서 Home Assistant에 입력 할 인증코드와 함께 SMS 프롬프트를 해당 장치에 보냅니다. 이 인증 기간은 Apple에서 결정하지만 현재 2개월이므로 2개월마다 계정을 확인하면됩니다.

2단계 인증은 2단계 인증의 개선된 버전이며 여전히 pyicloud 라이브러리에서 지원되지 않습니다. 따라서 아직 device_tracker와 함께 사용할 수 없습니다. 

과도한 배터리 소모를 방지하기 위해 하나의 계정에 연결된 모든 장치에 대해 고정간격 대신 각 개별 장치에 동적간격이 사용됩니다. 동적 간격은 장치의 현재 영역, 집까지의 거리 및 장치의 배터리 수준을 기준으로합니다.

## 문제 해결의 경우 

홈어시스턴트 설정 `.storage` 폴더로 이동하여 "icloud" 폴더를 삭제한 후 다시 시도하십시오.

## 플랫폼

### 장치 추적기 (Device Tracker)

iCloud 통합구성요소는 iCloud 계정에서 사용 가능한 기기를 추적합니다.

### 센서 

iCloud 통합구성요소는 iCloud 계정에서 사용 가능한 각 iCloud 장비에 배터리 센서를 추가합니다.

## 서비스

4가지 서비스를 이용할 수 있습니다 :

### `icloud.update` 서비스

이 서비스는 특정 iDevice 또는 iCloud 계정에 연결된 모든 장치의 업데이트를 요청하는 데 사용할 수 있습니다. 요청시 현재 iPhone 위치를 설명하는 새로운 홈어시스턴트 [state_changed](/docs/configuration/events/#event-state_changed) 이벤트 가 발생 합니다. 예를 들어 문을 열었을때 집에 있는지 확인하기 위해 수동 위치 업데이트가 필요할 때 자동화에 사용할 수 있습니다.

### `icloud.play_sound` 서비스

이 서비스는 iDevice에서 iPhone 분실 사운드를 재생합니다. "Mute" 또는 "Do not disturb"모드 인 경우에도 계속 울립니다.


### `icloud.display_message` 서비스

이 서비스는 iDevice에 메시지를 표시합니다. 장치의 벨이 울릴 수도 있습니다.

### `icloud.lost_device` 서비스

This service will put your iDevice on "lost" mode (compatible devices only). You have to provide a phone number with a suffixed [country code](https://en.wikipedia.org/wiki/List_of_country_calling_codes) and a message.
이 서비스는 iDevice를 "lost"모드로 전환합니다 (호환되는 장비만). 접미사 [country code](https://en.wikipedia.org/wiki/List_of_country_calling_codes) 와 메시지가 포함된 전화번호를 제공해야 합니다.