---
title: "MQTT Birth and Last will"
description: "Instructions on how to setup MQTT birth and last will messages within Home Assistant."
logo: mqtt.png
---

MQTT는 Birth 및 LWT (Last Will and Testament) 메시지를 지원합니다. 전자는 서비스가 시작된 후 메시지를 보내는 데 사용되고 후자는 다른 클라이언트에게 비정상적으로 연결이 끊긴 클라이언트에 대해 알리는 데 사용됩니다.

MQTT Birth 및 Last Will 메시지를 Home Assistant에 연동하려면, `configuration.yaml` 파일에 다음 섹션을 추가 하십시오.:

```yaml
# Example configuration.yaml entry
mqtt:
  birth_message:
    topic: 'hass/status'
    payload: 'online'
  will_message:
    topic: 'hass/status'
    payload: 'offline'
```

{% configuration %}
birth_message:
  description: Birth Message.
  required: false
  type: list
  keys:
    topic:
      description: The MQTT topic to publish the message.
      required: true
      type: string
    payload:
      description: The message content.
      required: true
      type: string
    qos:
      description: The maximum QoS level of the topic.
      required: false
      default: 0
      type: integer
    retain:
      description: If the published message should have the retain flag on or not.
      required: false
      default: false
      type: boolean
will_message:
  description: Will Message
  required: false
  type: list
  keys:
    topic:
      description: The MQTT topic to publish the message.
      required: true
      type: string
    payload:
      description: The message content.
      required: true
      type: string
    qos:
      description: The maximum QoS level of the topic.
      required: false
      default: 0
      type: integer
    retain:
      description: If the published message should have the retain flag on or not.
      required: false
      default: false
      type: boolean
{% endconfiguration %}
