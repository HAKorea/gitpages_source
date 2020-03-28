---
title: 서비스 호출(Service Calls)
description: "Instructions on how to call services in Home Assistant."
redirect_from: /getting-started/scripts-service-calls/
---

특정 이벤트가 발생할 때 다양한 통합구성요소를 통해 서비스 호출이 가능합니다. 가장 일반적인 것은 자동화 트리거가 발생할 때 서비스를 호출하는 것입니다. 그러나 스크립트 또는 Amazon Echo를 통해 서비스를 호출할 수도 있습니다.

config를 호출하는 설정 옵션은 모든 통합구성요소 간에 동일하며 이 페이지에 설명되어 있습니다.

이 페이지의 예는 자동화 연동 설정의 일부로 제공되지만 다른 연동에도 다른 접근방식을 사용할 수 있습니다. 

<div class='note'>
사용 가능한 서비스를 찾으려면 개발자 도구 아래의 "서비스"탭을 사용하십시오.
</div>

### 기본 (The basics)

`group.living_room` entity에서 `homeassistant.turn_on` 서비스를 호출하십시오. 모든 `group.living_room`이 켜집니다. `entity_id: all`를 사용할 수 있으며 이 또한 모든 해당 entity를 켭니다.

```yaml
service: homeassistant.turn_on
entity_id: group.living_room
```

### 서비스 요청에 데이터 전달

대상으로 지정할 엔티티 옆에 다른 매개 변수를 지정할 수도 있습니다. 예를 들어, 라이트 켜기 서비스를 통해 밝기를 지정할 수 있습니다.

```yaml
service: light.turn_on
entity_id: group.living_room
data:
  brightness: 120
  rgb_color: [255, 0, 0]
```

서비스에 대한 전체 매개 변수 목록은 각 구성요소의 설명서 페이지에서 찾을 수 있습니다, 동일한 방식으로  `light.turn_on` [서비스](/integrations/light/#service-lightturn_on)로 같은 방법을 쓸 수 있습니다. 

### 템플릿을 사용한 서비스 호출 방법

[templating] 지원을 사용하여 호출할 서비스를 동적으로 선택할 수 있습니다 . 예를 들어 조명이 켜져 있는지에 따라 특정 서비스를 호출할 수 있습니다.

```yaml
service_template: >
  {% raw %}{% if states('sensor.temperature') | float > 15 %}
    switch.turn_on
  {% else %}
    switch.turn_off
  {% endif %}{% endraw %}
entity_id: switch.ac
```

### 서비스 개발자 도구 사용

서비스 개발자 도구를 사용하여 서비스 요청에 전달할 데이터를 테스트할 수 있습니다. 예를 들어 'group'을 켜거나 끄는 테스트를 할 수 있습니다 (자세한 내용은 [group] 참조).

그룹을 켜거나 끄려면 다음 정보를 전달하십시오.:
- Domain: `homeassistant`
- Service: `turn_on`
- Service Data: `{ "entity_id": "group.kitchen" }`

### 템플릿을 사용하여 속성 결정

서비스 호출에 전달하는 데이터에 템플릿을 사용할 수도 있습니다.

```yaml
service: thermostat.set_temperature
data_template:
  entity_id: >
    {% raw %}{% if is_state('device_tracker.paulus', 'home') %}
      thermostat.upstairs
    {% else %}
      thermostat.downstairs
    {% endif %}{% endraw %}
  temperature: {% raw %}{{ 22 - distance(states.device_tracker.paulus) }}{% endraw %}
```

`data`와 `data_template`를 동시에 사용할 수도 있지만 `data_template`이 두 가지 모두에 제공되는 속성을 덮어쓰게됩니다.

```yaml
service: thermostat.set_temperature
data:
  entity_id: thermostat.upstairs
data_template:
  temperature: {% raw %}{{ 22 - distance(states.device_tracker.paulus) }}{% endraw %}
```

### 홈어시스턴트 서비스

단일 도메인에 연결되지 않은 `homeassistant`의 4 가지 서비스는 다음과 같습니다.:

* `homeassistant.turn_on` - entity를 켜라 (켜기를 지원할 경우) 예: `automation`, `switch`, 등
* `homeassistant.turn_off` - - entity를 꺼라 (끄기를 지원할 경우) 예: `automation`, `switch`, 등
* `homeassistant.toggle` - 켜져있는 entity를 끄거나 꺼진 entity를 켜거나 끕니다. (ON/OFF 지원)
* `homeassistant.update_entity` - [google travel time] 센서, [template sensor], 혹은 [light]와 같이 다음 예약 업데이트를 기다리지 않고 entity 업데이트를 바로 요청합니다. 

전체 서비스 세부 사항과 예시는 [homeassistant-integration-services] 에서 찾을 수 있습니다.

[templating]: /topics/templating/
[google travel time]: /integrations/google_travel_time/
[template sensor]: /integrations/template/
[light]: /integrations/light/
[homeassistant-integration-services]: /integrations/homeassistant#services
