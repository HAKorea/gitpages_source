---
title: 템플릿 이진 센서(Template Binary Sensor)
description: "Instructions on how to integrate Template Binary Sensors into Home Assistant."
ha_category:
  - Binary Sensor
ha_release: 0.12
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`template` 플랫폼은 다른 엔터티에서 값을 얻는 binary sensors를 지원합니다. 템플릿 바이너리 센서(Template Binary Sensor)의 상태는 '켜기' 또는 '끄기'만 될 수 있습니다.

## 설정 

다음은 템플릿 바이너리 센서를 `configuration.yaml` 파일 에 추가하는 예입니다.

{% raw %}

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: template
    sensors:
      sun_up:
        friendly_name: "Sun is up"
        value_template: >-
          {{ state_attr('sun.sun', 'elevation')|float > 0 }}
```

{% endraw %}

{% configuration %}
sensors:
  description: 센서 리스트.
  required: true
  type: map
  keys:
    sensor_name:
      description: 센서의 슬러그(slug).
      required: true
      type: map
      keys:
        friendly_name:
          description: 프론트 엔드에서 사용할 이름.
          required: false
          type: string
        entity_id:
          description: 센서가 이러한 엔티티의 상태 변경에만 반응하도록 엔티티 ID 목록. 자동 분석에서 모든 관련 엔티티를 찾지 못하면 사용할 수 있습니다. 
          required: false
          type: [string, list]
        device_class:
          description: 프런트 엔드에 표시되는 장치 상태 및 아이콘을 변경하여 [class of the device](/integrations/binary_sensor/)를 설정합니다.
          required: false
          type: device_class
          default: None
        value_template:
          description: 템플릿이 `True` 로 평가되면 센서가 `on`이고, 그렇지 않으면 `off`입니다. 프런트 엔드의 실제 모양 (`Open`/`Closed`,`Detected`/`Clear` 등)은 센서의 device_class에 따라 다릅니다.
          required: true
          type: template
        availability_template:
          description: 컴포넌트의 `available` 상태를 가져 오도록 템플리트를 정의합니다. 템플릿이 `true`를 반환하면 장치는 `available` 입니다. 템플릿이 다른 값을 반환하면 장치는 `unavailable`입니다. `availability_template`이 설정되어 있지 않으면 컴포넌트를 항상 사용할 수 있습니다`
          required: false
          type: template
          default: true
        icon_template:
          description: 센서 아이콘의 템플릿을 정의.
          required: false
          type: template
        entity_picture_template:
          description: 센서의 엔티티 이미지에 대한 템플릿을 정의.
          required: false
          type: template
        attribute_templates:
          description: 센서 속성에 대한 템플릿을 정의.
          required: false
          type: map
          keys:
            "attribute: template":
              description: 속성과 해당 템플릿.
              required: true
              type: template
        delay_on:
          description: 이 센서가 `on`으로 전환되기 전에 템플릿 상태가 ***충족되어야*** 합니다.
          required: false
          type: time
        delay_off:
          description: 이 센서가 `off`로 전환되기 전에 템플릿 상태가 ***충족되지않아야*** 합니다. 
          required: false
          type: time
{% endconfiguration %}

## 고려사항 

### Startup

로드하는데 시간이 더 걸리는 플랫폼의 상태를 사용하는 경우 시작시 템플릿 바이너리 센서가 `unknown` 상태가 될 수 있습니다. 그러면 해당 플랫폼이로드를 완료 할 때까지 로그 파일에 오류 메시지가 나타납니다.
템플릿에서 `is_state ()`함수를 사용하면 이런 상황을 피할 수 있습니다.
예를 들어, {% raw %}`{{ states.switch.source.state == 'on' }}`{% endraw %}가 `true` /`false`를 반환하고 알 수 없는 결과 값을 절대 반환하지 않게 하는 것으로 대체합니다 : {% raw %}`{{ is_state('switch.source', 'on') }}`{% endraw %}

### Entity IDs

템플릿 엔진은 센서 업데이트를 트리거 할 엔티티를 처리하려고 시도합니다. 예를 들어 템플릿이 그룹의 내용을 반복하는 경우 실패 할 수 있습니다. 이 경우`entity_id`를 사용하여 센서가 업데이트되도록 하는 엔티티 ID 목록 또는 서비스 `homeassistant.update_entity`를 실행하여 원하는대로 센서를 업데이트 할 수 있습니다.

## 사례 

이 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 센서 임계값 (Sensor Threshold)

이 예는 센서가 지정된 임계 값을 초과하면 `true`를 나타냅니다. 팬 모터에 전류 판독 값을 제공하는 `furnace` 센서를 가정하면 furnace(난방용기계)가 일부 임계값을 초과하는지 확인하여 furnace(난방용기계)가 실행 중인지 확인할 수 있습니다.

{% raw %}

```yaml
binary_sensor:
  - platform: template
    sensors:
      furnace_on:
        friendly_name: "Furnace Running"
        device_class: heat
        value_template: "{{ states('sensor.furnace')|float > 2.5 }}"
```

{% endraw %}

### 센서 스위치 (Switch as Sensor)

일부 이동 센서 및 도어/창 센서가 스위치로 나타납니다. 템플릿 바이너리 센서를 사용하면 스위치를 바이너리 센서로 표시할 수 있습니다. 그런 다음 [customizing](/getting-started/customizing-devices/)으로 원래 스위치를 숨길 수 있습니다.

{% raw %}

```yaml
binary_sensor:
  - platform: template
    sensors:
      movement:
        device_class: motion
        value_template: "{{ is_state('switch.movement', 'on') }}"
      door:
        device_class: opening
        value_template: "{{ is_state('switch.door', 'on') }}"
```

{% endraw %}

### 여러 센서 결합 (Combining Multiple Sensors)

이 예는 여러 CO 센서를 단일 전체 상태로 결합합니다. binary sensors 템플릿을 사용하는 경우 명시 적으로 `true` 또는`false`를 반환해야합니다.

{% raw %}

```yaml
binary_sensor:
  - platform: template
    sensors:
      co:
        friendly_name: "CO"
        device_class: gas
        value_template: >-
          {{ is_state('sensor.bedroom_co_status', 'Ok')
             and is_state('sensor.kitchen_co_status', 'Ok')
             and is_state('sensor.wardrobe_co_status', 'Ok') }}
```

{% endraw %}

### 세탁기 실행 (Washing Machine Running)

이 예에서는 세탁기에 연결된 에너지 미터를 모니터링하여 세탁기 "load running" 센서를 만듭니다. 세탁기가 작동하는 동안 에너지 미터가 급격히 변동하여 부하가 완료되기 전에도 자주 0을 기록합니다. `delay_off`를 사용하여 5 분 동안 세탁기 작동이 없는 경우에만 이 센서를 끌 수 있습니다.

{% raw %}

```yaml
# Determine when the washing machine has a load running.
binary_sensor:
  - platform: template
    sensors:
      washing_machine:
        friendly_name: "Washing Machine"
        delay_off:
          minutes: 5
        value_template: >-
          {{ states('sensor.washing_machine_power')|float > 0 }}
```

{% endraw %}

### 재실 확인 (Is Anyone Home)

이 예는 장치 추적 및 모션 센서의 조합을 기반으로 집에 사람이 있는지 확인하는 것입니다. 홈어시스턴트에서 추적 가능한 장치로 표시되지 않는 집에 있을 수 있는 어린이/베이비 시터/할머니할아버지가 있는 경우 매우 유용합니다. 이것은 WiFi 기반 장치 추적 및 Z-Wave 센서와의 다중 재실 센서의 합성(composite)을 제공합니다.

{% raw %}

```yaml
binary_sensor:
  - platform: template
    sensors:
      people_home:
        value_template: >-
          {{ is_state('device_tracker.sean', 'home')
             or is_state('device_tracker.susan', 'home')
             or is_state('binary_sensor.office_124', 'on')
             or is_state('binary_sensor.hallway_134', 'on')
             or is_state('binary_sensor.living_room_139', 'on')
             or is_state('binary_sensor.porch_ms6_1_129', 'on')
             or is_state('binary_sensor.family_room_144', 'on') }}
```

{% endraw %}

### 위도 및 경도 속성이있는 장치 추적 센서 

이 예는 위도 및 경도 속성을 계속 포함하면서 non-GPS (예 : NMAP) 및 GPS 장치 추적기를 결합(composite)하는 방법을 보여줍니다.

{% raw %}
```yaml
binary_sensor:
  - platform: template
    sensors:
      my_device:
        value_template: >-
          {{ is_state('device_tracker.my_device_nmap','home') or is_state('device_tracker.my_device_gps','home') }}
        device_class: 'presence'
        attribute_templates:
          latitude: >-
            {% if is_state('device_tracker.my_device_nmap','home') %}
              {{ state_attr('zone.home','latitude') }}
            {% else %}
              {{ state_attr('device_tracker.my_device_gps','latitude') }}
            {% endif %}
          longitude: >-
            {% if is_state('device_tracker.my_device_nmap','home') %}
              {{ state_attr('zone.home','longitude') }}
            {% else %}
              {{ state_attr('device_tracker.my_device_gps','longitude') }}
            {% endif %}
```
{% endraw %}

### 상태가 변경시 아이콘 변경

이 예제는 `icon_template`을 사용하여 상태 변화에 따라 엔티티 아이콘을 변경하고 자체 센서의 상태를 평가하고 조건문을 사용하여 적절한 아이콘을 출력하는 방법을 보여줍니다.

{% raw %}

```yaml
sun:
binary_sensor:
  - platform: template
    sensors:
      sun_up:
        entity_id:
          - sun.sun
        value_template: >-
          {{ is_state("sun.sun", "above_horizon") }}
        icon_template: >-
          {% if is_state("binary_sensor.sun_up", "on") %}
            mdi:weather-sunset-up
          {% else %}
            mdi:weather-sunset-down
          {% endif %}
```

{% endraw %}
