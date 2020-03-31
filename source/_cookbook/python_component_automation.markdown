---
title: "파이선 코드로 자동화 사례"
description: "A sample to do automations in Python Code."
ha_category: Automation in Python Examples
---

`entity_id` 를 대상으로 하는 연동 사례 : 

 - 아침에 오전 7시에 켜십시오
 - 누군가 집에 와서 끄면 켜십시오
 - 모든 표시등이 꺼지면 끄십시오
 - 모든 사람들이 집을 떠나면 끄십시오
 - 10 초 동안 켜는 서비스 제공

설정하려면 `configuration.yaml` 파일에 다음 줄을 추가 하십시오.

```yaml
# Example configuration.yaml entry
example:
  target: TARGET_ENTITY
```

{% configuration %}
target:
  description: "TARGET_ENTITY는 켜거나 끌 수 있는 장치중 하나여야 합니다 (예: 조명 또는 스위치). 예제값은 light.Ceiling 또는 switch.AC 일 수 있습니다 (해당 이름의 장치가 있는 경우)."
  required: true
  type: string
{% endconfiguration %}

`<config dir>/custom_components/example.py` 파일을 만들고 아래 내용을 복사하여 붙여 넣습니다.

```python
"""
Example of a custom component.
"""
import logging
import time

import voluptuous as vol

import homeassistant.components as core
import homeassistant.helpers.config_validation as cv
from homeassistant.components import device_tracker, light
from homeassistant.const import (
    ATTR_ENTITY_ID,
    SERVICE_TURN_OFF,
    SERVICE_TURN_ON,
    STATE_HOME,
    STATE_NOT_HOME,
    STATE_OFF,
    STATE_ON,
)
from homeassistant.core import split_entity_id
from homeassistant.helpers.event import (
    async_track_state_change,
    async_track_time_change,
)

# The domain of your component. Should be equal to the name of your component.
DOMAIN = "example"

# List of integration names (string) your integration depends upon.
# We depend on group because group will be loaded after all the integrations that
# initialize devices have been setup.
DEPENDENCIES = ["group", "device_tracker", "light"]

# Configuration key for the entity id we are targeting.
CONF_TARGET = "target"

# Variable for storing configuration parameters.
TARGET_ID = None

# Name of the service that we expose.
SERVICE_FLASH = "flash"

# Shortcut for the logger
_LOGGER = logging.getLogger(__name__)

# Validate that all required config options are given.
CONFIG_SCHEMA = vol.Schema(
    {DOMAIN: vol.Schema({vol.Optional(CONF_TARGET): cv.entity_id})},
    extra=vol.ALLOW_EXTRA,
)


async def async_setup(hass, config):
    """Setup example component."""
    TARGET_ID = config[DOMAIN][CONF_TARGET]

    domain = split_entity_id(TARGET_ID)[0]
    data = {ATTR_ENTITY_ID: TARGET_ID}

    # Validate that the target entity id exists.
    if hass.states.get(TARGET_ID) is None:
        _LOGGER.error("Target entity id %s does not exist", TARGET_ID)

        # Tell the bootstrapper that we failed to initialize and clear the
        # stored target id so our functions don't run.
        TARGET_ID = None
        return False

    async def async_switch_on(entity_id, old_state, new_state):
        """Callback to turn on our target entity"""
        # If the target id is not set, return
        if not TARGET_ID:
            return

        if not core.is_on(hass, TARGET_ID):
            await hass.services.async_call(domain, SERVICE_TURN_ON, data)

    async def async_switch_off(entity_id, old_state, new_state):
        """Callback to turn off our target entity"""
        # If the target id is not set, return
        if not TARGET_ID:
            return

        if core.is_on(hass, TARGET_ID):
            await hass.services.async_call(domain, SERVICE_TURN_OFF, data)

    async def async_wake_up(service):
        """Turn light on in the morning.

        Turn the light on when called, but only if there are people home
        and it is not already on.
        """
        if not TARGET_ID:
            return

        if device_tracker.is_on(hass) and not core.is_on(hass, TARGET_ID):
            _LOGGER.info("People home at 7AM, turning target on")
            await hass.services.async_call(domain, SERVICE_TURN_ON, data)

    async def async_flash_service(service):
        """Service callback that will toggle the target.

        Set the light to off for 10 seconds if on and vice versa.
        """
        if not TARGET_ID:
            return

        if core.is_on(hass, TARGET_ID):
            # We need this call to run blocking, as we want to wait 10s after it finished
            await hass.services.async_call(
                domain, SERVICE_TURN_OFF, data, blocking=True
            )
            time.sleep(10)
            await hass.services.async_call(domain, SERVICE_TURN_ON, data)
        else:
            await hass.services.async_call(domain, SERVICE_TURN_ON, data, blocking=True)
            time.sleep(10)
            await hass.services.async_call(domain, SERVICE_TURN_OFF, data)

    # register the example.flash service
    hass.services.async_register(DOMAIN, SERVICE_FLASH, async_flash_service)

    # If all lights turn off, turn off.
    async_track_state_change(
        hass, light.ENTITY_ID_ALL_LIGHTS, async_switch_off, STATE_ON, STATE_OFF
    )

    # If all people leave the house and the entity is on, turn it off.
    async_track_state_change(
        hass,
        device_tracker.ENTITY_ID_ALL_DEVICES,
        async_switch_off,
        STATE_HOME,
        STATE_NOT_HOME,
    )

    # If anyone comes home and the entity is not on, turn it on.
    async_track_state_change(
        hass,
        device_tracker.ENTITY_ID_ALL_DEVICES,
        async_switch_on,
        STATE_NOT_HOME,
        STATE_HOME,
    )

    # Call wakeup callback at 7 AM
    async_track_time_change(hass, async_wake_up, hour=7, minute=00, second=00)

    # Tell the bootstrapper that we initialized successfully.
    return True
```
