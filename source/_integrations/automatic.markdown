---
title: 차량관리서비스(Automatic)
description: Instructions for how to integrate Automatic ODB readers into Home Assistant.
logo: automatic.png
ha_category:
  - Car
ha_release: 0.28
ha_iot_class: Cloud Push
ha_codeowners:
  - '@armills'
---

`automatic` 장치 추적기 플랫폼은 [Automatic](https://automatic.com/) 클라우드 서비스에서 차량 정보를 검색하여 현재 상태를 감지합니다.

## 셋업

홈어시스턴트에서 Automatic을 사용하려면 먼저 [create a free development account](https://developer.automatic.com/)을 수행해야합니다. Automatic은 홈어시스턴트 설정에 사용할 클라이언트 ID 및 비밀정보를 생성합니다. 홈어시스턴트가 업데이트를 수신할 수 있도록 이벤트 전달 환경 설정을 업데이트해야합니다. 개발자 페이지의 App Settings / Event Delivery,에서 이벤트 전달 환경 설정으로 "Websocket"을 선택하십시오.

홈어시스턴트는 사용 가능한 경우 `scope:current_location`을 활용할 수도 있습니다. 이렇게하면 홈어시스턴트가 여행중에 주기적으로 위치 업데이트를 받을 수 있습니다. 이 기능을 사용하려면 자동으로 응용 프로그램 범위(scope)를 요청해야합니다. `scope:current_location`을 사용할 수 있게되면 configuration.yaml에서 `current_location`을 `true`로 변경하십시오.

## 설정

개발자 계정이 생성되면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: automatic
    client_id: 1234567
    secret: 0987654321
    devices:
      - 2007 Honda Element
      - 2004 Subaru Impreza
```

{% configuration %}
client_id:
  description: "The OAuth client id (get from https://developer.automatic.com/)."
  required: true
  type: string
secret:
  description: "The OAuth client secret (get from https://developer.automatic.com/)."
  required: true
  type: string
current_location:
  description: "Set to `true` if you have requested `scope:current_location` for your account. Home Assistant will then be able to receive periodic location updates during trips."
  required: false
  default: false
  type: boolean
devices:
  description: The list of vehicle display names you wish to track. If not provided, all vehicles will be tracked.
  required: false
  type: list
{% endconfiguration %}

<div class='note'>
  
장치 이름은 Automatic로 자동으로 지정된 이름이어야합니다. 이것은 일반적으로 모델 연도, 제조업체 및 모델입니다. 이것은 앱설정의 `vehicles` 섹션에서 차량에 부여해야하는 닉네임이 아닙니다.
  
</div>  

홈어시스턴트는 Automatic에서 업데이트를 받으면 이벤트를 발생시킵니다. 아래 예와 같이 자동화를 트리거하는데 사용할 수 있습니다. 사용 가능한 이벤트 유형 목록은 [Automatic Real-Time Events documentation](https://developer.automatic.com/api-reference/#real-time-events)에서 확인할 수 있습니다.

```yaml
# Example automatic event automation
automation:
  - trigger:
      - platform: event
        event_type: automatic_update
        event_data:
          type: "ignition:on"
          vehicle:
            id: "C_1234567890abcdefc"
    action:
      - service: light.turn_off
```

<div class='note'>
known_devices.yaml 파일에서 차량의 정확한 ID를 얻을 수 있습니다. 자동화 트리거에서 vehicle ID를 사용할 때 vehicle ID에 포함 된 문자를 모두 소문자로 입력하십시오.
</div>

차량을 추적하도록 구성하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.