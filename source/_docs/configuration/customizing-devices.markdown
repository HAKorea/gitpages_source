---
title: "entity의 사용자 지정"
description: "Simple customization for entities in the frontend."
redirect_from: /getting-started/customizing-devices/
---

<div class='videoWrapper'>
<iframe width="1249" height="712" src="https://www.youtube.com/embed/tk8JptISpVM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## entity_id 변경

UI를 사용하여 `entity_id` 와 지원가능한 entity의 친숙한 이름(friendly name 을 변경할 수 있습니다. : 

1. 프론트 엔드에서 혹은 개발자 도구 "states"탭 에서 entity 옆에 있는 <img src='/images/frontend/entity_box.png' />을 클릭하여 entity를 선택하십시오.  
2. 엔터티 대화상자의 오른쪽 모서리에 있는 톱니바퀴를 클릭하십시오.
3. 새 이름 또는 새 entity ID를 입력하십시오 (엔티티 앞의 부분 `.`이 나오기 전부분을 변경하지 마십시오.)
4. *Save* 를 선택하십시오. 

entity가 지원되지 않거나 이 방법을 통해 필요한 것을 사용자 정의할 수 없는 경우 추가 옵션에 대해서는 아래를 참조하십시오:

## entity 사용자 지정

기본적으로 모든 장치가 표시되며 도메인에 따라 기본 아이콘이 결정됩니다. 이러한 매개 변수 중 일부를 변경하여 프론트 페이지의 모양과 느낌을 사용자 정의할 수 있습니다. 특정 entity의 특성을 재정의하여 수행할 수 있습니다.

### UI를 사용한 사용자 정의

*Configuration* 메뉴 아래에 *Customization* 메뉴가 있습니다. 이 메뉴 항목이 보이지 않으면 먼저 [profile page](/docs/authentication/#your-account-profile)에서 고급 모드를 활성화하십시오. 사용자 정의할 entity를 선택하면 기존의 모든 속성이 나열되며 해당 속성을 사용자 정의하거나 추가 지원 속성을 선택할 수 있습니다([이하 참조](/docs/configuration/customizing-devices/#possible-values)). 홈어시스턴트 사용을 시작한 시점에 따라 `configuration.yaml` 파일에 다음을 추가해야 할 수도 있습니다.

```yaml
homeassistant:
  customize: !include customize.yaml
```

#### 가능한 값

{% configuration customize %}
friendly_name:
  description: UI에 표시되는 entity 이름입니다..
  required: false
  type: string
hidden:
  description: entity를 숨기기 위해 `true`로 설정
  required: false
  type: boolean
  default: false
emulated_hue_hidden:
  description: entity `emulated_hue`를 숨기기 위해 `true`로 설정 (이는 조만간 사용하지 않을 것이므로 [`emulated_hue`](/integrations/emulated_hue)에서 설정권장).
  required: false
  type: boolean
  default: false
entity_picture:
  description: entity의 그림파일로 사용할 URL입니다.
  required: false
  type: string
icon:
  description: "[MaterialDesignIcons.com](http://MaterialDesignIcons.com) ([Cheatsheet](https://cdn.materialdesignicons.com/4.5.95/))의 모든 아이콘. 접두어로 `mdi:`, 예: `mdi:home`. 참고: 현재 홈어시스턴트 릴리스에서는 최신 아이콘을 아직 사용하지 못할 수 있습니다. [MDI History](https://materialdesignicons.com/history)에서 MaterialDesignIcons.com에 아이콘이 추가된 시기를 확인할 수 있습니다."
  required: false
  type: string
assumed_state:
  description: 이 상태의 스위치의 경우 스위치 대신 두 개의 단추가 표시됩니다 (끄기, 켜기). `assumed_state`를 `false`로 세팅하면, 기본 switch 아이콘으로 전환.
  required: false
  type: boolean
  default: true
device_class:
  description: UI에 표시되는 장치 상태와 아이콘을 변경하여 장치 클래스를 설정합니다. (아래 참조). `unit_of_measurement`를 설정하진 않습니다.
  required: false
  type: device_class
  default: None
unit_of_measurement:
  description: 측정 단위(있는 경우)를 정의합니다. 이는 또한 History 시각화의 그래픽 표시에 지속적인 값으로 영향을 줍니다. `unit_of_measurement`가 누락된 센서는 불연속 값으로 표시됩니다.
  required: false
  type: string
  default: None
initial_state:
  description: 자동화의 초기 상태를 설정, `on` 혹은 `off`.
  required: false
  type: string
{% endconfiguration %}

#### 장치 클래스

디바이스 클래스는 현재 다음 구성요소에서 지원됩니다. :

* [Binary Sensor](/integrations/binary_sensor/)
* [Sensor](/integrations/sensor/)
* [Cover](/integrations/cover/)
* [Media Player](integrations/media_player/)

### 수동 사용자 정의

<div class='note'>

`customize`, `customize_domain`, 혹은 `customize_glob`을 구현하는 경우 `homeassistant:`에 반영되어있는지 확인해야 합니다. 그렇지 않으면 동작하지 않습니다.

</div>

```yaml
homeassistant:
  name: Home
  unit_system: metric
  # etc

  customize:
    # Add an entry for each entity that you want to overwrite.
    sensor.living_room_motion:
      hidden: true
    thermostat.family_room:
      entity_picture: https://example.com/images/nest.jpg
      friendly_name: Nest
    switch.wemo_switch_1:
      friendly_name: Toaster
      entity_picture: /local/toaster.jpg
    switch.wemo_switch_2:
      friendly_name: Kitchen kettle
      icon: mdi:kettle
    switch.rfxtrx_switch:
      assumed_state: false
  # Customize all entities in a domain
  customize_domain:
    light:
      icon: mdi:home
    automation:
      initial_state: 'on'
  # Customize entities matching a pattern
  customize_glob:
    "light.kitchen_*":
      icon: mdi:description
    "scene.month_*_colors":
      hidden: true
      emulated_hue_hidden: false
```

### 사용자정의 새로고침

홈어시스턴트는 홈어시스턴트가 실행되는 동안 핵심 설정을 다시로드하는 `homeassistant.reload_core_config` 서비스를 제공합니다. 이를 통해 사용자 정의 섹션을 변경하고 홈어시스턴트를 다시시작하지 않고도 적용되는 섹션을 볼 수 있습니다. 이 서비스를 호출하려면, 개발자 툴에 있는 "Service" 탭으로 이동하고, `homeassistant.reload_core_config` 를 선택하고 "CALL SERVICE" 버튼을 클릭하십시오. 또는 Configuration > Server Control 에서 "Reload Location & Customizations" 버튼을 누를 수 있습니다. 

<div class='note warning'>
다음에 entity 상태가 업데이트 될 때 새로운 사용자 정의 정보가 적용됩니다.
</div>
