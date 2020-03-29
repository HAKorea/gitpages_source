---
title: "KNX Switch"
description: "Instructions on how to integrate KNX switches with Home Assistant."
logo: knx.png
ha_category:
  - Switch
ha_release: 0.24
ha_iot_class: Local Push
---

<div class='note'>
  
이 통합구성요소를 사용하려면 `knx` 연동을 올바르게 설정해야합니다. [KNX Integration](/integrations/knx)을 참조하십시오.

</div>

`knx` 스위치 플랫폼은 스위칭 액츄에이터(switching actuators)의 인터페이스로 사용됩니다.

## 설정

설치시 KNX 스위치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
switch:
  - platform: knx
    name: Kitchen.Coffee
    address: '1/1/6'
```

{% configuration %}
address:
  description: KNX group address for switching the switch on/off.
  required: true
  type: string
name:
  description: A name for this device used within Home Assistant.
  required: false
  default: KNX Switch
  type: string
state_address:
  description: Separate KNX group address for retrieving the switch state.
  required: false
  type: string
{% endconfiguration %}

일부 KNX 장치는 KNX 버스에서 메시지없이 내부적으로 상태를 변경할 수 있습니다 (예: 채널에서 타이머를 설정하는 경우). 선택적 상태인 `state_address`는 이러한 상태 변경에 대해 홈어시스턴트에게 알리는데 사용될 수 있습니다. 주어진 상태 주소(state address)로 주소가 지정된 버스에서 KNX 메시지가 표시되면 스위치 객체(switch object)의 상태를 덮어 씁니다. 단일 그룹 주소로만 제어되고 내부적으로 상태를 변경할 수 없는 액추에이터(actuators)를 전환하는 경우 상태 주소를 설정할 필요가 없습니다.