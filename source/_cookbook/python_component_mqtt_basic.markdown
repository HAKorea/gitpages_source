---
title: "Basic MQTT Example"
description: ""
ha_category: Custom Python Component Examples
---

<div class='note'>

이 예에서는 [MQTT 통합구성요소](/integrations/mqtt/)이 시작되어 실행중 이어야합니다.

</div>

이는 사용자 정의 통합구성요소에서 MQTT 사용의 기초를 보여주는 간단한 hello world 예제입니다.
이 예제를 사용하려면 `<config dir>/custom_components/hello_mqtt.py` 파일을 작성하고 아래 예제 코드를 복사하십시오.

이 예는 MQTT의 topic을 따르고 엔티티의 상태를 해당 topic에서 수신된 마지막 메시지로 업데이트합니다. 또한 수신중인 MQTT topic에 메시지를 공개하는 'set_state' 서비스를 등록합니다.

```python
import homeassistant.loader as loader

# The domain of your component. Should be equal to the name of your component.
DOMAIN = "hello_mqtt"

# List of integration names (string) your integration depends upon.
DEPENDENCIES = ["mqtt"]


CONF_TOPIC = "topic"
DEFAULT_TOPIC = "home-assistant/hello_mqtt"


def setup(hass, config):
    """Set up the Hello MQTT component."""
    mqtt = hass.components.mqtt
    topic = config[DOMAIN].get(CONF_TOPIC, DEFAULT_TOPIC)
    entity_id = "hello_mqtt.last_message"

    # Listener to be called when we receive a message.
    # The msg parameter is a Message object with the following members:
    # - topic, payload, qos, retain
    def message_received(msg):
        """Handle new MQTT messages."""
        hass.states.set(entity_id, msg.payload)

    # Subscribe our listener to a topic.
    mqtt.subscribe(topic, message_received)

    # Set the initial state.
    hass.states.set(entity_id, "No messages")

    # Service to publish a message on MQTT.
    def set_state_service(call):
        """Service to send a message."""
        mqtt.publish(topic, call.data.get("new_state"))

    # Register our service with Home Assistant.
    hass.services.register(DOMAIN, "set_state", set_state_service)

    # Return boolean to indicate that initialization was successfully.
    return True
```

`configuration.yaml`에 다음을 추가하여 통합구성요소를 로드하십시오. 통합구성요소가 로드되면 새 엔티티가 팝업되고 호출할 수있는 새 서비스가 있어야합니다.

```yaml
# configuration.yaml entry
hello_mqtt:
  topic: some_mqtt/topic/here
```

페이로드를 예로 들어 서비스를 호출할 수 있습니다. : 

```json
{
  "new_state": "some new state"
}
```
