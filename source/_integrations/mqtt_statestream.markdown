---
title: MQTT Statestream
description: Instructions on how to setup MQTT Statestream within Home Assistant.
logo: mqtt.png
ha_category:
  - Other
ha_release: 0.54
ha_iot_class: Configurable
---

`mqtt_statestream` 통합구성요소는 홈어시스턴트의 state 변경 사항을 개별 MQTT topic에 publish합니다.

## 설정

홈어시스턴트에서 MQTT Statestream을 사용하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
mqtt_statestream:
  base_topic: homeassistant
  publish_attributes: true
  publish_timestamps: true
```

{% configuration %}
base_topic:
  description: Base topic used to generate the actual topic used to publish.
  required: true
  type: string
publish_attributes:
  description: Publish attributes of the entity as well as the state.
  required: false
  default: false
  type: boolean
publish_timestamps:
  description: Publish the last_changed and last_updated timestamps for the entity.
  required: false
  default: false
  type: boolean
exclude:
  description: Configure which integrations should be excluded from recordings. See *Include/Exclude* section below for details.
  required: false
  type: list
  keys:
    entities:
      description: The list of entity ids to be excluded from recordings.
      required: false
      type: list
    domains:
      description: The list of domains to be excluded from recordings.
      required: false
      type: list
include:
  description: Configure which integrations should be included in recordings. If set, all other entities will not be recorded.
  required: false
  type: list
  keys:
    entities:
      description: The list of entity ids to be included from recordings.
      required: false
      type: list
    domains:
      description: The list of domains to be included from recordings.
      required: false
      type: list
{% endconfiguration %}

## Operation

홈어시스턴트 엔티티가 변경되면 이 통합구성요소는 해당 변경사항을 MQTT에 publish합니다.

각 엔티티에 대한 topic이 다르므로 관심있는 엔티티에만 다른 시스템을 쉽게 subscribe할 수 있습니다.
topic은 `base_topic/domain/entity/state` 형식입니다.

예를 들어 위 설정 사례에서 'light.master_bedroom_dimmer'라는 엔티티가 켜져 있으면 이 통합구성요소는 `on`을 `homeassistant/light/master_bedroom_dimmer/state`에 publish합니다.

해당 엔티티도 `brightness`라는 속성이 있는 경우, 통합구성요소는 해당 속성의 값도 `homeassistant/light/master_bedroom_dimmer/brightness`에 publish합니다.

모든 상태와 속성은 publishing 하기 전에 JSON 직렬화(serialization)를 통해 전달됩니다. 이로 인해 문자열이 인용된다는 것을 **참고하세요**(예를 들어 문자열 'on'은 '"on"'으로 publish됩니다). `value` 대신 `value_json`을 사용하여 여러 위치에서 JSON 역직렬화된(deserialized) 값(인용되지 않은 문자열)에 액세스할 수 있습니다.

엔터티의 last_updated과 last_changed 값은 각각 `homeassistant/light/master_bedroom_dimmer/last_updated`과 `homeassistant/light/master_bedroom_dimmer/last_changed`에 publish됩니다. 타임 스탬프는 ISO 8601 형식입니다 - 예: `2017-10-01T23:20:30.920969+00:00`

## Include/exclude

**exclude**와 **include** 설정변수를 사용하여 MQTT에 publish된 항목을 필터링할 수 있습니다.

1\. **exclude** 혹은 **include**를 지정하지 않으면 모든 엔터티가 publish됩니다.

2\. **exclude**만 지정하면 나열된 항목을 제외한 모든 항목이 publish됩니다.

```yaml
# Example of excluding entities
mqtt_statestream:
  base_topic: homeassistant
  exclude:
    domains:
      - switch
    entities:
      - sensor.nopublish
```
위 예에서 *switch.x*와 *sensor.nopublish*를 제외한 모든 엔티티가 MQTT에 publish됩니다.

3\. **include** 만 지정하면 지정된 항목만 publish됩니다.

```yaml
# Example of excluding entities
mqtt_statestream:
  base_topic: homeassistant
  include:
    domains:
      - sensor
    entities:
      - lock.important
```
이 예에서는 *sensor.x*와 *lock.important*만 publish됩니다.

4\. **include**와 **exclude**가 모두 지정된 경우 **exclude**로 지정된 엔티티를 제외하고 **include**로 지정된 모든 엔티티가 publish됩니다.

```yaml
# Example of excluding entities
mqtt_statestream:
  base_topic: homeassistant
  include:
    domains:
      - sensor
  exclude:
    entities:
      - sensor.noshow
```
이 예에서는 *sensor.noshow*를 제외한 모든 센서가 publish됩니다.