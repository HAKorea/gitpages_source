---
title: Bayesian
description: Instructions on how to integrate threshold Bayesian sensors into Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.53
ha_quality_scale: internal
---

`Bayesian` 이진 센서 플랫폼은 여러 센서의 상태를 관찰하고 [Bayes' rule](https://en.wikipedia.org/wiki/Bayes%27_theorem)을 사용하여 이벤트가 발생한 상황을 예측합니다 관찰 된 센서. 추정 사후 확률이 `probability_threshold` 보다 높으면 센서가 `on` 이고, 그렇지 않으면 `off` 입니다.

이를 통해 요리, 샤워, 침대에서, 아침 루틴 시작 등과 같이 쉽게 관찰 할 수없는 복잡한 이벤트를 감지 할 수 있습니다. 또한 직접 관찰 할 수 있지만 센서가 존재하지 않는 등 신뢰할 수 없는 이벤트에 대한 신뢰도를 높이는 데 사용할 수도 있습니다.

## 설정 

베이지안 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: bayesian
    prior: 0.1
    observations:
      - entity_id: 'switch.kitchen_lights'
        prob_given_true: 0.6
        prob_given_false: 0.2
        platform: 'state'
        to_state: 'on'
```

{% configuration %}
prior:
  description: >
    이벤트의 사전 확률.
    어느 시점에서 (모든 외부 영향 무시)이 사건이 발생할 가능성은 어느 정도입니까?
  required: true
  type: float
probability_threshold:
  description: 센서가 `on` 으로 트리거해야 할 확률.
  required: false
  type: float
  default: 0.5
name:
  description: 프런트 엔드에서 사용할 센서의 이름.
  required: false
  type: string
  default: Bayesian Binary Sensor
observations:
  description: 주어진 사건이 발생했을 가능성에 영향을 미치는 관측.
  required: true
  type: list
  keys:
    platform:
      description: >
        지원 플랫폼들은 `state`, `numeric_state`, `template`.
        이들은 해당 자동화 트리거에 따라 모델링됨,
        requiring `to_state` (for `state`), `below` and/or `above` (for `numeric_state`) and `value_template` (for `template`).
      required: true
      type: string
    entity_id:
      description: 모니터링 할 엔티티의 이름. Required for `state` and `numeric_state`.
      required: false
      type: string
    value_template:
      description: 사용할 템플릿을 정의. Required for `template`.
      required: false
      type: template
    prob_given_true:
      description: 관측이 일어날 확률. `true` 이벤트가 주어졌을때.
      required: true
      type: float
    prob_given_false:
      description: 관측이 일어날 확률. `false` 이벤트가 주어졌을때.
      required: false
      type: float
      default: "`1 - prob_given_true` if `prob_given_false` is not set"
    to_state:
      description: 대상의 상태. Required (for `state`).
      required: false
      type: string
{% endconfiguration %}

## 전체 예

다음은 `state` 관측 플랫폼 의 예

```yaml
# Example configuration.yaml entry
binary_sensor:
  name: 'in_bed'
  platform: 'bayesian'
  prior: 0.25
  probability_threshold: 0.95
  observations:
    - platform: 'state'
      entity_id: 'sensor.living_room_motion'
      prob_given_true: 0.4
      prob_given_false: 0.2
      to_state: 'off'
    - platform: 'state'
      entity_id: 'sensor.basement_motion'
      prob_given_true: 0.5
      prob_given_false: 0.4
      to_state: 'off'
    - platform: 'state'
      entity_id: 'sensor.bedroom_motion'
      prob_given_true: 0.5
      to_state: 'on'
    - platform: 'state'
      entity_id: 'sun.sun'
      prob_given_true: 0.7
      to_state: 'below_horizon'
```

다음은 `numeric_state` 관측 플랫폼을 대상으로하는 예제입니다.
설정에서 보듯이 `to_state` 대신 `below` 및/혹은 `above`가 필요합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  name: 'Heat On'
  platform: 'bayesian'
  prior: 0.2
  probability_threshold: 0.9
  observations:
    - platform: 'numeric_state'
      entity_id: 'sensor.outside_air_temperature_fahrenheit'
      prob_given_true: 0.95
      below: 50
```

마지막으로 `template` 관측 플랫폼의 예가 있습니다.
설정에서 보듯이 `value_template`이 필요하고 `entity_id`를 사용하지 않습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
binary_sensor:
  name: 'Paulus Home'
  platform: 'bayesian'
  prior: 0.5
  probability_threshold: 0.9
  observations:
    - platform: template
      value_template: >
        {{is_state('device_tracker.paulus','not_home') and ((as_timestamp(now()) - as_timestamp(states.device_tracker.paulus.last_changed)) > 300)}}
      prob_given_true: 0.95
```
{% endraw %}
