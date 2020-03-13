---
title: MQTT eventstream
description: Instructions on how to setup MQTT eventstream within Home Assistant.
logo: mqtt.png
ha_category:
  - Other
ha_release: 0.11
ha_iot_class: Configurable
---

`mqtt_eventstream` 통합구성요소는 MQTT를 통해서 두 대의 홈어시스턴트를 연결합니다(홈어시스턴트를 2개 설치해서 사용).

## 설정

홈어시스턴트에 MQTT Eventstream 통합 설정하는 방법은 `configuration.yaml` 파일에 아래와 같이 작성합니다:

```yaml
# Example configuration.yaml entry
mqtt_eventstream:
  publish_topic: MyServerName
  subscribe_topic: OtherHaServerName
```

{% configuration %}
publish_topic:
  description: 로컬 서버의 이벤트를 발행하기 위한 토픽.
  required: false
  type: string
subscribe_topic:
  description: 리모트 서버로부터 수신할 이벤트의 토픽.
  required: false
  type: string
ignore_event:
  description: MQTT를 통해 전송할 때 무시할 [이벤트](/docs/configuration/events/).
  required: false
  type: list
{% endconfiguration %}

## Multiple Instances

여러대의 홈어시스턴트(slave)로 부터 이벤트들을 한대의 홈어시스턴트(master)에서 모두 취합하기 위해서는 와일드카드 토픽(#)으로 수신하면 됩니다.

```yaml
# Example master instance configuration.yaml entry
mqtt_eventstream:
  publish_topic: master/topic
  subscribe_topic: slaves/#
  ignore_event:
    - call_service
    - state_changed
```

다른 여러대의 홈어시스턴트 설정은 발행하는 주제 토픽은 동일하고 나머지 서브 토픽은 다르게 작성합니다. 

```yaml
# Example slave instance configuration.yaml entry
mqtt_eventstream:
  publish_topic: slaves/upstairs
  subscribe_topic: master/topic
```

```yaml
# Example slave instance configuration.yaml entry
mqtt_eventstream:
  publish_topic: slaves/downstairs
  subscribe_topic: master/topic
```
