---
title: Huawei LTE(LTE 라우터)
description: Instructions on how to integrate Huawei LTE router and modem devices with Home Assistant.
logo: huawei.svg
ha_category:
  - Network
  - Presence Detection
  - Notifications
  - Sensor
  - Switch
  - Binary Sensor
ha_release: 0.79
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@scop'
---

Home Assistant 용 Huawei LTE 라우터 및 모뎀 통합구성요소를 통해 [Huawei LTE devices](https://consumer.huawei.com/en/smart-home/) 를 관찰하고 제어 할 수 있습니다 

현재 홈어시스턴트에는 다음 플랫폼이 지원됩니다.

- Presence detection - 연결된 장치의 장치 추적기 
- Notifications - SMS를 통해
- Sensors - 장치, 신호 및 트레픽 정보
- Switch - 모바일 데이터 켜기/끄기
- Binary sensor - 모바일 연결 상태

## 설정

프론트 엔드 또는 YAML을 사용하여 두 가지 방법으로 통합구성요소를 사용할 수 있습니다. 또한 홈어시스턴트에서 [SSDP integration](../ssdp/)이 활성화 된 경우 프런트 엔드에서 추가적인 옵션 설정을 위해 UPnP를 지원하고 활성화 한 Huawei LTE 장치를 자동으로 검색 할 수 있습니다. 

인증을 사용하거나 사용하지 않고도 통합구성요소를 실행할 수 있습니다. 인증 모드는 사용 가능한 모든 연동 기능 및 엔터티를 활성화하지만 통합구성요소가 활성화된 동안 혹은 브라우저와 같은 다른 소스에서 장치 웹인터페이스에 액세스하는 것을 방해 할 수 있습니다. 인증이 필요한 정확한 기능 목록은 장치 및 펌웨어 버전에 따라 다릅니다. 인증되지 않은 모드에서 인증이 필요한 것을 탐지 한 경우 통합구성요소는 설정된 모든 것을 사용하려고 시도하다가 결국 실패합니다

기본적으로 대상 장치가 제공한 엔티티의 서브 세트만 :

- WAN IP 주소 센서
- LTE 신호 센서 RSRQ, RSRP, RSSI 및 SINR
- 모바일 데이터 스위치
- 모바일 연결 이진 센서
- 장치 추적기 항목

나머지는 엔티티 레지스트리에 추가되지만 기본적으로 사용되지 않습니다.

다양한 범주의 정보 및 사용 가능한 엔티티에 대한 지원은 장치 모델 및 펌웨어 버전에 따라 다릅니다.

### 프론트 엔드를 통한 설정

Menu: **설정** -> **통합구성요소**.

`+` 부호를 클릭하여 통합구성요소를 추가하고 **Huawei LTE**를 클릭하고 설정 단계를 따르십시오. 완료되면 Huawei LTE 연동이 가능합니다.

인증되지 않은 모드를 사용하려면 사용자 이름과 비밀번호를 비워 두십시오. 그런 다음 통합구성요소는 먼저 빈 문자열을 사용하여 인증을 시도하고 실패할 경우 인증되지 않은 모드로 돌아갑니다. 이 프로세스로 원하는 결과를 얻지 못하면 YAML 구성 (아래 참조)을 사용하여보다 세밀한 제어를 수행 할 수 있습니다.

알림 수신자 전화 번호의 기본 목록은 통합구성요소 설정 옵션을 사용하여 설정할 수 있습니다.

### YAML에서의 설정

컴포넌트를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
huawei_lte:
  - url: http://192.168.100.1/
```
UI를 통해 설정된 라우터의 경우 YAML에서 동일한 라우터에 대한 각 설정 항목은 YAML 설정 값이 반영되거나 업데이트 될 때마다 UI에 설정된 값을 무시하고 업데이트합니다.

{% configuration %}
url:
  description: 장치 웹인터페이스의 URL입니다. 일반적으로 http://192.168.100.1/ 또는 http://192.168.1.1/ 입니다.
  required: true
  type: string
username:
  description: 인증 모드에서 장치 웹 인터페이스에 사용되는 사용자 이름입니다. USB 스틱 모뎀의 경우 일반적으로 `admin` 또는 빈 문자열 (`""`)입니다. 인증되지 않은 모드를 사용하려면 이 변수를 모두 그대로 두십시오.
  required: false
  type: string
password:
  description: 인증 모드에서 장치 웹 인터페이스에 사용되는 비밀번호입니다. USB 스틱 모뎀의 경우 일반적으로 빈 문자열 (` ""`)입니다. 인증되지 않은 모드를 사용하려면이 변수를 모두 그대로 두십시오
  required: false
  type: string
notify:
  description: SMS 메시지를 사용하여 알림을 활성화합니다. 알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.
  required: false
  type: map
  keys:
    name:
      description: 알림 서비스의 이름.
      default: "`huawei_lte`"
      required: false
      type: string
    recipient:
      description: 기본 수신자의 전화 번호 또는 수신자가 여러 명인 목록.
      required: false
      type: [string, list]
{% endconfiguration %}

## 서비스

다음과 같은 라우터 동작 서비스가 제공됩니다. 사용자가 호출하면 관리자 액세스가 필요합니다.


### `huawei_lte.clear_traffic_statistics` 서비스

트레픽 통계 삭제

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `url`                  | yes, if only one router configured | Router URL. |

### Service `huawei_lte.reboot`

라우터 재부팅.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `url`                  | yes, if only one router configured | Router URL. |

### `huawei_lte.suspend_integration` 서비스

연동을 중단합니다. 일시 중단은 라우터에서 연동을 로그 아웃하고 액세스를 중지합니다.
유용한 예로는 웹 브라우저와 같은 다른 소스에서 라우터 웹 인터페이스에 액세스해야하는 경우
`huawei_lte.resume_integration` 서비스를 호출하여 재개하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `url`                  | yes, if only one router configured | Router URL. |

### `huawei_lte.resume_integration` 서비스

일시중단 된 연동을 재개합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `url`                  | yes, if only one router configured | Router URL. |

## 테스트된 장치

[documentation of used libraries](https://github.com/Salamek/huawei-lte-api/#huawei-lte-api) 및 사용자의 보고서를 기반으로 이 연동 작업이 가능한 것으로 알려져 있는 장치 :

- Huawei B310s-22
- Huawei B525s-23a
- Huawei E5186s-22a
- Huawei B618

이것은 완전한 목록이 아닙니다. 연동은 아마도 유사한 펌웨어를 실행하는 다른 Huawei LTE 장치에 연결될 수 있습니다.