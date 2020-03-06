---
title: 템플릿(Template)
description: Instructions on how to integrate Template Sensors into Home Assistant.
ha_category:
  - Sensor
ha_release: 0.12
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
ha_codeowners:
  - '@PhracturedBlue'
  - '@tetienne'
---

템플릿`template` 플랫폼은 엔티티들이 가진 값들을 별도의 센서로 만들 수 있는 방법이다

## Configuration

템플릿 센서를 설정하는 방법은 무엇을 만들고 싶은지가 중요하다. `configuration.yaml`에 다음과 같이 sun 엔티티가 갖는 값을 이용하여 태양의 고도(지평선과의 각도)와 내일 해뜨는 시간을 표시하는 두가지 센서를 추가한다고 가정하면:

{% raw %}

```yaml
# Example configuration.yaml entry
sensor:
  - platform: template
    sensors:
      solar_angle:
        friendly_name: "Sun angle"
        unit_of_measurement: 'degrees'
        value_template: "{{ state_attr('sun.sun', 'elevation') }}"

      sunrise:
        value_template: "{{ state_attr('sun.sun', 'next_rising') }}"
```

{% endraw %}

{% configuration %}
  sensors:
    description: 만들고자 하는 센서 리스트
    required: true
    type: map
    keys:
      friendly_name:
        description: 화면에 표시할 센서 가명
        required: false
        type: string
      friendly_name_template:
        description: 상태 변화에 따라 화면에 표시할 센서 가명을 바꿀 때 사용(friendly_name을 덮어씀)
        required: false
        type: template
      entity_id:
        description: 엔티티 ID 리스트. 제작한 템플릿 센서는 이들 엔티티의 변화에 따라 값이 바뀐다. 다수의 관련된 엔티티들 서로 연결되어 센서로 표현해야 한다면 이 옵션을 적용하세요.
        required: false
        type: [string, list]
      unit_of_measurement:
        description: "센서의 측정 단위. 이것은 히스토리 그래프 표현에 영향을 줍니다. `unit_of_measurement`를 설정하지 않으면 불연속적인 막대 그래프로 나타납니다."
        required: false
        type: string
        default: None
      value_template:
        description: 센서로 사용할 값을 엔티티로부터 받아오는 방법을 설정하는 밸류템플릿
        required: true
        type: template
      icon_template:
        description: 센서에 대한 아이콘을 설정하는 템플릿
        required: false
        type: template
      entity_picture_template:
        description: 센서의 엔티티 이미지를 설정하는 템플
        required: false
        type: template
      attribute_templates:
        description: 센서의 속성을 정의하는 템플
        required: false
        type: map
        keys:
          "attribute: template":
            description: 속성에 해당하는 템플릿을 작성
            required: true
            type: template        
      availability_template:
        description: 컴포넌트의 `available` 상태를 받아오는 템플릿을 정의. 템플릿이 `true`를 반환하면 기기는 `available` 상태이고 다른 값을 반환하면 `unavailable` 상태로 템플릿을 작성해야 함. `availability_template`을 작성하지 않으면 컴포넌트의 `available` 상태는 항상 'true'입니다.
        required: false
        type: template
        default: true
      device_class:
        description: 기기의 클래스를 설정. UI에 나타나는 기기의 상태와 아이콘이 바뀝니다(하단 참고). `unit_of_measurement`를 변경하진 않습니다.
        required: false
        type: device_class
        default: None
{% endconfiguration %}

## 고려사항

### 부팅시

플랫폼의 상태를 체크하는 센서를 사용한다면 부팅시 플랫폼을 로드하는 과정에서 일정 시간이 소요되며 이 과정에서 템플릿 센서는 `unknown` 상태가 됩니다. 이것을 피하려면(로그 파일에 에러를 남기지 않으려면) `is_state()` 함수를 템플릿에 적용하면 됩니다. 예를 들어 {% raw %}`{{ states.cover.source.state == 'open' }}`{% endraw %} 구문은 `unknown` 상태를 나타내기도 하는데 아래 템플릿으로 바꿔 적용하면 `true`/`false` 상태만을 잘 표현합니다:

{% raw %}`{{ is_state('switch.source', 'on') }}`{% endraw %}

### 엔티티 ID

템플릿 엔진은 어떤 엔티티들을 사용하여 센서를 업데이트 할 것인가를 늘 시도합니다. 템플릿이 트리거를 받지 못하는 상황이 생겨 센서의 업데이트가 실패할 수도 있습니다. 이 경우 `entity_id`를 작성해서 엔티티들의 ID 리스트를 입력하면 센서를 업데이트 하도록 만들 수 있습니다. 또는 `homeassistant.update_entity` 서비스를 호출하게 센서를 강제 업데이트 해줍니다.

## 사용예

아래 섹션에서 실제 적용 사례들을 살펴보겠습니다.

### 태양의 고도

화면에 태양의 고도를 표시합니다.

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      solar_angle:
        friendly_name: "Sun Angle"
        unit_of_measurement: '°'
        value_template: "{{ '%+.1f'|format(state_attr('sun.sun', 'elevation')) }}"
```

{% endraw %}

### 센서 표시를 변경하기

어떤 센서의 화면 표기가 마음에 들지 않는다면 템플릿 센서를 활용하여 변경할 수 있습니다. [Sun component](/integrations/sun/)의 출력을 간단한 표기방법으로 변경해봅시다:

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      sun_state:
        friendly_name: "Sun State"
        value_template: >-
          {% if is_state('sun.sun', 'above_horizon') %}
            up
          {% else %}
            down
          {% endif %}
```

{% endraw %}

### `if` 구문을 여러번 사용하기

비교구문 `if`를 여러번 사용하여 다양한 값을 체크하는 예제입니다. 스위치의 상태를 체크하여 화면에 `on`/`off` 또는 `standby` 등을 표시합니다:

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      kettle:
        friendly_name: "Kettle"
        value_template: >-
          {% if is_state('switch.kettle', 'off') %}
            off
          {% elif state_attr('switch.kettle', 'kwh')|float < 1000 %}
            standby
          {% elif is_state('switch.kettle', 'on') %}
            on
          {% else %}
            failed
          {% endif %}
```

{% endraw %}

### 측정 단위를 변경하기

템플릿 센서를 사용하면 측정 단위를 이해하기 쉬운 다른 표현 방법으로 손쉽게 변경 가능합니다:

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      transmission_down_speed_kbps:
        friendly_name: "Transmission Down Speed"
        unit_of_measurement: 'kB/s'
        value_template: "{{ states('sensor.transmission_down_speed')|float * 1024 }}"

      transmission_up_speed_kbps:
        friendly_name: "Transmission Up Speed"
        unit_of_measurement: 'kB/s'
        value_template: "{{ states('sensor.transmission_up_speed')|float * 1024 }}"
```

{% endraw %}

### 아이콘 변경

다음 예제는 낮/밤에 따라 아이콘을 바꾸는 `icon_template` 사용법입니다:

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      day_night:
        friendly_name: "Day/Night"
        value_template: >-
          {% if is_state('sun.sun', 'above_horizon') %}
            Day
          {% else %}
            Night
          {% endif %}
        icon_template: >-
          {% if is_state('sun.sun', 'above_horizon') %}
            mdi:weather-sunny
          {% else %}
            mdi:weather-night
          {% endif %}
```

{% endraw %}

### 엔티티 이미지 변경

다음 예제는 낮/밤에 따라 `entity_picture_template`을 사용하여 이미지를 변경하는 방법입니다:

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      day_night:
        friendly_name: "Day/Night"
        value_template: >-
          {% if is_state('sun.sun', 'above_horizon') %}
            Day
          {% else %}
            Night
          {% endif %}
        entity_picture_template: >-
          {% if is_state('sun.sun', 'above_horizon') %}
            /local/daytime.png
          {% else %}
            /local/nighttime.png
          {% endif %}
```

{% endraw %}

### Change the Friendly Name Used in the Frontend

다음 예제는 센서의 상태에 따라서 `friendly_name_template`을 사용해 화면에 표시되는 `friendly_name`을 변경하는 방법입니다.

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      net_power:
        friendly_name_template: >-
          {% if states('sensor.power_consumption')|float < 0 %}
            Power Consumption
          {% else %}
            Power Production
          {% endif %}
        value_template: "{{ states('sensor.power_consumption') }}"
        unit_of_measurement: 'kW'
```

{% endraw %}

### 커스텀 속성을 추가하기

다음 예제는 커스텀 속성을 추가하는 방법입니다:

{% raw %}
```yaml
sensor:
  - platform: template
    sensors:
      my_device:
        value_template: >-
          {% if is_state('device_tracker.my_device_nmap','home') %}
            Home
          {% else %}
            {{ states('device_tracker.my_device_gps') }}
          {% endif %}
        attribute_templates:
          latitude: >-
            {% if is_state('device_tracker.my_device_nmap','home') %}
              {{ state_attr('zone.home','latitude') }}
            {% else %}
              state_attr('device_tracker.my_device_gps','latitude')
            {% endif %}
          longitude: >-
            {% if is_state('device_tracker.my_device_nmap','home') %}
              {{ state_attr('zone.home','longitude') }}
            {% else %}
              {{ state_attr('device_tracker.my_device_gps','longitude') }}
            {% endif %}
```

{% endraw %}

### 엔티티 없는 템플릿 센서 제작

템플릿 센서는 다른 엔티티의 속성으로 제작해야만 하는 것은 아니며 [홈어시스턴트 템플릿 확장](/docs/configuration/templating/#home-assistant-template-extensions) 기능을 사용할 수도 있습니다.

이런 템플릿은 트리거를 발생시킬 엔티티가 없어서(`now()` 함수처럼) 업데이트가 원활하게 이뤄지지 않습니다. 따라서 `entity_id:`를 추가하여 강제로 업데이트가 이뤄지도록 만들어야 합니다. 다음 예제는 [date sensor](/integrations/time_date)를 엔티티로 추가해서 하루마다 업데이트를 진행합니다:

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      nonsmoker:
        value_template: "{{ (( as_timestamp(now()) - as_timestamp(strptime('06.07.2018', '%d.%m.%Y')) ) / 86400 ) | round(2) }}"
        entity_id: sensor.date
        friendly_name: 'Not smoking'
        unit_of_measurement: "Days"
```

{% endraw %}

하지만 위 예제는 엔티티 없는 구문으로 다음과 같이 변경할 수도 있습니다:

{% raw %}

````yaml
sensor:
  - platform: template
    sensors:
      nonsmoker:
        value_template: "{{ (( as_timestamp(strptime(states('sensor.date'), '%Y-%m-%d')) - as_timestamp(strptime('06.07.2018', '%d.%m.%Y')) ) / 86400 ) | round(2) }}"
        friendly_name: 'Not smoking'
        unit_of_measurement: "Days"
````

{% endraw %}
하루마다 동작시키려면 `sensor.date` 엔티티를 사용하고, 매 분마다 동작시키려면 `sensor.time` 엔티티를 사용하면 유용합니다. 템플릿은 홈어시스턴트의 state engine이 템플릿의 동작을 체크하고 변화가 있을 때마다 센서의 상태를 바꿉니다. 그러므로 `sensor.time`은 매 분마다 상태 체크를 하므로 성능에 영향을 줄 수 있어 사용에 주의해야 합니다.

대체 방안으로 자동화를 사용한 인터벌 설정이 가능한데, 엔티티 업데이트가 필요할 때마다 `homeassistant.update_entity`를 호출하면 됩니다. 매 분마다 실행하는 것을 5분마다 실행하는 자동화를 적용하면 다음과 같습니다:

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      nonsmoker:
        value_template: "{{ (( as_timestamp(now()) - as_timestamp(strptime('06.07.2018', '%d.%m.%Y')) ) / 86400 ) | round(2) }}"
        entity_id: []
        friendly_name: 'Not smoking'
        unit_of_measurement: "Days"

automation:
  - alias: 'nonsmoker_update'
    trigger:
      - platform: time_pattern
        minutes: '/5'
    action:
      - service: homeassistant.update_entity
        entity_id: sensor.nonsmoker
```

{% endraw %}
