---
title: 투야(tuya)
description: Instructions on how to setup the Tuya hub within Home Assistant.
logo: tuya.png
ha_category:
  - Hub
  - Climate
  - Cover
  - Fan
  - Light
  - Scene
  - Switch
ha_iot_class: Cloud Polling
ha_release: 0.74
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/dt5-iZc4_qU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Tuya 통합구성요소를 사용하기 전에 Tuya 서비스가 클라우드 폴링 방식을 사용함으로 인해 홈어시스턴트에서 자주 끊기거나 제품이 오동작을 하는 사례가 자주 보고가 되고 있습니다. 이런 문제점이 지속 발생하거나 클라우드보다는 로컬방식의 운영을 원하는 분들은 ESPHOME 혹은 Tasmota으로 노드를 변경시켜 운영하는 방법을 추천합니다. 

**1. ESPHOME** 

  - [ESPHOME 홈페이지](http://esphome.io)

  - [HA 네이버 카페 ESPHOME 적용 사례](https://cafe.naver.com/ArticleList.nhn?search.clubid=29860180&search.menuid=14&search.boardtype=L)
 
**2. TASMOTA**

  - [Tasmota 지원 가능 제품 사이트](https://templates.blakadder.com/) 

  - [Tasmota 공식 지원 사이트](https://tasmota.github.io/docs/#/Home)
  

`tuya` 통합구성요소는 모든 [Tuya Smart](https://www.tuya.com) 제품을 연동 할 수있는 종합 통합구성요소입니다. 계정과 관련된 장치를 검색하고 제어하려면 Tuya 계정 정보 (사용자 이름, 비밀번호 및 계정 국가 코드)가 필요합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다:

- **Climate** - 에어컨 및 히터를 지원.
- **Cover** - 커튼을 지원.
- **Fan** - 대부분의 Tuya fan(팬이 돌아가는 대부분의 제품)제품 지원.
- **Light** - 대부분의 Tuya 라이트를 지원
- **Scene** -  scene을 활성화 한 직후 프런트 엔드 패널의 장치 상태가 변경되지 않습니다.
- **Switch** - 스위치와 소켓을 지원.

## 설정

Tuya 장치를 Home Assistant 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
tuya:
  username: YOUR_TUYA_USERNAME
  password: YOUR_TUYA_PASSWORD
  country_code: YOUR_ACCOUNT_COUNTRYCODE
```

{% configuration %}
username:
  description: Tuya에 로그인하기위한 사용자 이름. 이 번호는 문자열이므로 따옴표로 묶어야하는 전화 번호 일 수 있습니다.
  required: true
  type: string
password:
  description: Tuya에 로그인하기위한 비밀번호
  required: true
  type: string
country_code:
  description: "계정 국가 코드 (예 : 미국의 경우 1, 중국의 경우 86)"
  required: true
  type: string
platform:
  description: "계정이 등록 된 앱. `tuya`는 Tuya Smart, `smart_life`는 Smart Life, `jinvoo_smart`는 Jinvoo Smart."
  required: false
  type: string
  default: tuya
{% endconfiguration %}

## 서비스

이러한 서비스는 `tuya` 구성 요소에 사용 가능합니다 .:

- force_update
- pull_devices

장치 상태 데이터와 새 장치가 자동으로 새로 고쳐집니다. 모든 장치 정보를 새로 고치거나 계정과 관련된 새 장치를 수동으로 얻으려면 `force_update` 또는 `pull_devices` 서비스 에 문의하십시오 .