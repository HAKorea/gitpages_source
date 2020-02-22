---
title: "침입자 감지시 플래시 조명켜기"
description: "Detect intruders by checking if the light is turning on while no one is home."
ha_category: Automation in Python Examples
---

이 예제는 침입자를 탐지합니다. 집에 사람이 없을 때 조명이 켜져 있는지 확인하면됩니다. 이 경우 표시등이 빨간색으로 바뀌고 30 초 동안 깜박 인 다음 [the notify integration](/integrations/notify/)을 통해 메시지를 보냅니다 . 알려진 사람이 집으로 돌아오면 특정 표시등이 깜박입니다. 

이 연동방식은 [device_tracker](/integrations/device_tracker/) 및 [light](/integrations/light/) 통합구성요소에 따라 다릅니다.

설정하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :


```yaml
# Example configuration.yaml entry
simple_alarm:
  known_light: light.Bowl
  unknown_light: group.living_room
```

{% configuration %}
known_light:
  description: 알려진 장치가 집으로 돌아 왔을 때 깜박이는 조명/조명그룹.
  required: false
  type: string
unknown_light:
  description: 집에 없을 때 조명이 켜지면 어떤 조명/조명 그룹이 빨간색으로 깜박 여야합니까?
  required: false
  type: string
{% endconfiguration %}

`<config dir>/custom_components/simple_alarm.py`파일을 만들고 아래 내용을 복사하여 붙여 넣습니다.

```python
"""Simple alarm component."""
import logging

import homeassistant.loader as loader
from homeassistant.components import device_tracker, light, notify
from homeassistant.helpers.event import track_state_change
from homeassistant.const import STATE_ON, STATE_OFF, STATE_HOME, STATE_NOT_HOME

_LOGGER = logging.getLogger(__name__)

DOMAIN = 'simple_alarm"'

DEPENDENCIES = ["group", "device_tracker", "light"]

# Attribute to tell which light has to flash when a known person comes home
# If omitted will flash all.
CONF_KNOWN_LIGHT = "known_light"

# Attribute to tell which light has to flash when an unknown person comes home
# If omitted will flash all.
CONF_UNKNOWN_LIGHT = "unknown_light"

# Services to test the alarms
SERVICE_TEST_KNOWN_ALARM = "test_known"
SERVICE_TEST_UNKNOWN_ALARM = "test_unknown"


def setup(hass, config):
    """Set up the simple alarms."""
    light_ids = []

    for conf_key in (CONF_KNOWN_LIGHT, CONF_UNKNOWN_LIGHT):
        light_id = config[DOMAIN].get(conf_key, light.ENTITY_ID_ALL_LIGHTS)

        if hass.states.get(light_id) is None:
            _LOGGER.error("Light id %s could not be found in state machine", light_id)

            return False

        light_ids.append(light_id)

    # pylint: disable=unbalanced-tuple-unpacking
    known_light_id, unknown_light_id = light_ids

    if hass.states.get(device_tracker.ENTITY_ID_ALL_DEVICES) is None:
        _LOGGER.error("No devices are being tracked, cannot setup alarm")

        return False

    def known_alarm():
        """ Fire an alarm if a known person arrives home. """
        light.turn_on(hass, known_light_id, flash=light.FLASH_SHORT)

    def unknown_alarm():
        """ Fire an alarm if the light turns on while no one is home. """
        light.turn_on(
            hass, unknown_light_id, flash=light.FLASH_LONG, rgb_color=[255, 0, 0]
        )

        # Send a message to the user
        notify.send_message(
            hass, "The lights just got turned on while no one was home."
        )

    # Setup services to test the effect
    hass.services.register(DOMAIN, SERVICE_TEST_KNOWN_ALARM, lambda call: known_alarm())
    hass.services.register(
        DOMAIN, SERVICE_TEST_UNKNOWN_ALARM, lambda call: unknown_alarm()
    )

    def unknown_alarm_if_lights_on(entity_id, old_state, new_state):
        """Called when a light has been turned on."""
        if not device_tracker.is_on(hass):
            unknown_alarm()

    track_state_change(
        hass,
        light.ENTITY_ID_ALL_LIGHTS,
        unknown_alarm_if_lights_on,
        STATE_OFF,
        STATE_ON,
    )

    def ring_known_alarm(entity_id, old_state, new_state):
        """Called when a known person comes home."""
        if light.is_on(hass, known_light_id):
            known_alarm()

    # Track home coming of each device
    track_state_change(
        hass,
        hass.states.entity_ids(device_tracker.DOMAIN),
        ring_known_alarm,
        STATE_NOT_HOME,
        STATE_HOME,
    )

    return True
```
