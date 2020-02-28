---
title: "템플릿 조명"
description: "Instructions on how to integrate Template Lights into Home Assistant."
ha_category:
  - Light
ha_release: 0.46
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`template` 플랫폼은 통합구성요소들을 결합한 조명을 만들 수도 있고, 조명의 켜기, 끄기 및 밝기 명령 각각에 대해 스크립트를 실행하거나 서비스를 호출하는 기능을 제공합니다.

설치에서 템플릿 라이트를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

{% raw %}

```yaml
# Example configuration.yaml entry
light:
  - platform: template
    lights:
      theater_lights:
        friendly_name: "Theater Lights"
        level_template: "{{ sensor.theater_brightness.attributes.lux|int }}"
        value_template: "{{ sensor.theater_brightness.attributes.lux|int > 0 }}"
        turn_on:
          service: script.theater_lights_on
        turn_off:
          service: script.theater_lights_off
        set_level:
          service: script.theater_lights_level
          data_template:
            brightness: "{{ brightness }}"
```

{% endraw %}

{% configuration %}
  lights:
    description: 조명 리스트.
    required: true
    type: map
    keys:
      friendly_name:
        description: 프론트 엔드에서 사용할 이름.
        required: false
        type: string
      entity_id:
        description: 조명이 엔티티들의 상태 변경에만 반응하는 엔티티 ID 목록. 자동 분석에서 모든 관련 엔티티를 찾지 못한 경우 사용 가능.
        required: false
        type: [string, list]
      value_template:
        description: 조명의 상태를 얻기 위해 템플릿을 정의.
        required: false
        type: template
        default: optimistic
      level_template:
        description: 조명의 밝기를 얻기 위해 템플릿을 정의.
        required: false
        type: template
        default: optimistic
      icon_template:
        description: "아이콘 또는 그림의 템플릿을 정의합니다 (예 : 상태에 따라 다른 아이콘 표시)"
        required: false
        type: template
      availability_template:
        description: 컴포넌트의 `available` 상태를 가져 오도록 템플리트를 정의. 템플릿이 `true`를 반환하면 `available` 입니다. 템플릿이 다른 값을 반환하면 장치는 `unavailable`입니다. `availability_template`이 설정되어 있지 않으면 구성 요소는 항상 `available` 입니다.
        required: false
        type: template
        default: true
      turn_on:
        description: 조명이 켜질 때 실행할 동작을 정의.
        required: true
        type: action
      turn_off:
        description: 조명이 꺼질 때 실행할 동작을 정의.
        required: true
        type: action
      set_level:
        description: 조명에 밝기 명령이 제공될 때 실행할 동작을 정의.
        required: false
        type: action
{% endconfiguration %}

## 고려 사항

로드하는 데 추가시간이 더 걸리는 플랫폼의 상태를 사용하는 경우, 시작시 템플릿 표시등이 `unknown` 상태가 될 수 있습니다. 그러면 해당 플랫폼이 로드를 완료 할 때까지 로그 파일에 오류 메시지가 나타납니다. 
템플릿에서 `is_state()` 함수를 사용하면 이런 상황을 피할 수 있습니다. 
예를 들어, `true`/`false`를 반환하는 동등한 상황으로 {% raw %}`{{ states.switch.source.state == 'on' }}`{% endraw %}로 대체할 경우 절대 uknown을 나타내지 않습니다. 

result:
{% raw %}`{{ is_state('switch.source', 'on') }}`{% endraw %}

## 사례 

이 섹션에서는이 조명을 사용하는 방법에 대한 실제 예를 보여줍니다. 

### 극장 볼륨 제어 (Theater Volume Control)

This example shows a light that is actually a home theater's volume. This component gives you the flexibility to provide whatever you'd like to send as the payload to the consumer including any scale conversions you may need to make; the [Media Player component](/integrations/media_player/) needs a floating point percentage value from `0.0` to `1.0`.
이 예는 실제로 홈 시어터의 볼륨을 조명으로 보여줍니다. 이 구성 요소를 사용하면 필요한 소수점변환(scale conversion)을 포함하여 조명에 페이로드로 보내려는 모든 것을 제공 할 수 있는 유연성이 제공됩니다. [Media Player component](/integrations/media_player/) 에는`0.0`에서`1.0`의 부동 소수점 백분율 값이 필요합니다.

{% raw %}

```yaml
light:
  - platform: template
    lights:
      theater_volume:
        friendly_name: "Receiver Volume"
        value_template: >-
          {% if is_state('media_player.receiver', 'on') %}
            {% if state_attr('media_player.receiver', 'is_volume_muted') %}
              off
            {% else %}
              on
            {% endif %}
          {% else %}
            off
          {% endif %}
        turn_on:
          service: media_player.volume_mute
          data:
            entity_id: media_player.receiver
            is_volume_muted: false
        turn_off:
          service: media_player.volume_mute
          data:
            entity_id: media_player.receiver
            is_volume_muted: true
        set_level:
          service: media_player.volume_set
          data_template:
            entity_id: media_player.receiver
            volume_level: "{{ (brightness / 255 * 100)|int / 100 }}"
        level_template: >-
          {% if is_state('media_player.receiver', 'on') %}
            {{ (state_attr('media_player.receiver', 'volume_level')|float * 255)|int }}
          {% else %}
            0
          {% endif %}
```

{% endraw %}

### 아이콘 변환

이 예는 조명 상태에 따라 아이콘을 변경하는 방법을 보여줍니다.

{% raw %}

```yaml
light:
  - platform: template
    lights:
      theater_volume:
        friendly_name: "Receiver Volume"
        value_template: >-
          {% if is_state('media_player.receiver', 'on') %}
            {% if state_attr('media_player.receiver', 'is_volume_muted') %}
              off
            {% else %}
              on
            {% endif %}
          {% else %}
            off
          {% endif %}
        icon_template: >-
          {% if is_state('media_player.receiver', 'on') %}
            {% if state_attr('media_player.receiver', 'is_volume_muted') %}
              mdi:lightbulb-off
            {% else %}
              mdi:lightbulb-on
            {% endif %}
          {% else %}
            mdi:lightbulb-off
          {% endif %}
        turn_on:
          service: media_player.volume_mute
          data:
            entity_id: media_player.receiver
            is_volume_muted: false
        turn_off:
          service: media_player.volume_mute
          data:
            entity_id: media_player.receiver
            is_volume_muted: true
```

{% endraw %}

### 엔티티 사진을 변환 (Change The Entity Picture)

이 예는 조명 상태에 따라 엔티티 사진을 변경하는 방법을 보여줍니다.

{% raw %}

```yaml
light:
  - platform: template
    lights:
      theater_volume:
        friendly_name: "Receiver Volume"
        value_template: >-
          {% if is_state('media_player.receiver', 'on') %}
            {% if state_attr('media_player.receiver', 'is_volume_muted') %}
              off
            {% else %}
              on
            {% endif %}
          {% else %}
            off
          {% endif %}
        icon_template: >-
          {% if is_state('media_player.receiver', 'on') %}
            {% if state_attr('media_player.receiver', 'is_volume_muted') %}
              /local/lightbulb-off.png
            {% else %}
              /local/lightbulb-on.png
            {% endif %}
          {% else %}
            /local/lightbulb-off.png
          {% endif %}
        turn_on:
          service: media_player.volume_mute
          data:
            entity_id: media_player.receiver
            is_volume_muted: false
        turn_off:
          service: media_player.volume_mute
          data:
            entity_id: media_player.receiver
            is_volume_muted: true
```

{% endraw %}
