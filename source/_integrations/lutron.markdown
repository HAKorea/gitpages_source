---
title: 루트론(Lutron)
description: Instructions on how to use Lutron devices with Home Assistant.
logo: lutron.png
ha_category:
  - Hub
  - Cover
  - Light
  - Scene
  - Switch
ha_release: 0.37
ha_iot_class: Local Polling
ha_codeowners:
  - '@JonGilmore'
---

[Lutron](http://www.lutron.com/)은 미국 조명 제어 회사입니다. 여기에는 전등 switches/dimmers, occupancy 센서, HVAC 제어 등을 관리하는 여러 홈자동화 장치 라인이 있습니다. 홈어시스턴트의 `lutron` 통합구성요소는 이러한 시스템의 기본 허브와 통신하는 역할을합니다.

현재 [RadioRA 2](http://www.lutron.com/en-US/Products/Pages/WholeHomeSystems/RadioRA2/Overview.aspx)와의 통신에 대한 지원만 있으며 light switch, dimmers, seeTouch keypad scenes을 참조하십시오.

## 설정

`lutron` 통합구성요소는 Lutron의 RadioRA 2 소프트웨어로 구성된 룸 및 관련 switches/dimmers를 자동으로 검색합니다. 각 room은 별도의 그룹으로 취급됩니다.

설치시 Lutron RadioRA 2 장치를 사용하려면 RadioRA 2 메인 리피터의 IP 주소를 사용하여 `configuration.yaml` 파일에 다음을 추가하십시오.

``` yaml
# Example configuration.yaml entry
lutron:
  host: IP_ADDRESS
  username: lutron
  password: integration
```

{% configuration %}
host:
  description: The IP address of the Main Repeater.
  required: true
  type: string
username:
  description: The login name of the user. The user `lutron` always exists, but other users can be added via RadioRA 2 software.
  required: true
  type: string
password:
  description: The password for the user specified above. `integration` is the password for the always-present `lutron` user.
  required: true
  type: string
{% endconfiguration %}

<div class='note'>

기본 리피터에 고정 IP 주소를 할당하는 것이 좋습니다. 이렇게하면 IP 주소가 변경되지 않으므로 호스트가 재부팅되고 다른 IP 주소가 나오는 경우 호스트를 변경할 필요가 없습니다.

</div>

## 키패드 버튼

키패드의 개별 버튼은 엔티티로 표시되지 않습니다. 대신, 페이로드에 `id` 및 `action` 속성이 포함 된 `lutron_event`라는 이벤트를 발생시킵니다.

`id` 속성은 엔터티 이름과 같은 방식으로 표준화된 키패드 이름과 버튼 이름을 포함합니다. 예를 들어, 키패드의 이름이 "Kitchen Keypad"이고 버튼의 이름이 "Dinner"인 경우 이벤트의 `id`는 `kitchen_keypad_dinner`입니다.

`action` 속성은 버튼 유형에 따라 다릅니다.

raise/lower 버튼 (dimmer buttons, shade controls 등)의 경우에는 버튼을 press했을 때와 release했을 때 각각 `pressed` 및 `released`의 두 값이 있습니다.

단일 동작 버튼(scene 선택 등)의 경우 `action`은 `single`이며 이벤트는 한 번만 발생합니다. 이는 단일 동작 버튼이 release 될때 홈어시스턴트가 알 수 없는 Lutron 컨트롤러의 제한 사항입니다.

## 장면(Scene)

이 통합구성요소는 키패드 프로그래밍을 사용하여 장면을 식별합니다. 현재 seeTouch, hybrid seeTouch, main repeater, homeowner, Pico, seeTouch RF tabletop keypads에서 작동합니다.
Lutron scene 플랫폼을 사용하면 SeeTouch keypad에 프로그래밍 된 장면을 제어 할 수 있습니다.

설정 후에는 영역(area), keypad 및 button 이름을 사용하여 장면이 홈어시스턴트에 나타납니다.

## 재실 센서(Occupancy Sensors)

설정된 Powr Savr 재실 센서는 재실 바이너리 센서로 추가됩니다. Lutron은 개별 센서를 보고하지 않고 영역에 대한 재실여부를 보고합니다. 감도 및 타임 아웃은 소프트웨어가 아닌 센서 자체에서 제어됩니다.

## 자동화 사례

``` yaml
- alias: "keypad button pressed notification"
  trigger:
    - platform: event
      event_type: lutron_event
      event_data:
        id: office_pico_on
        action: single
  action:
    - service: notify.telegram
      data:
        message: "pico just turned on!"
```
