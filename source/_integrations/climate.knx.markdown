---
title: 온습도조절기(KNX Climate)
description: "Instructions on how to integrate KNX thermostats with Home Assistant."
logo: knx.png
ha_category:
  - Climate
ha_release: 0.25
ha_iot_class: Local Push
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/1DZnTB49w64" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

<div class='note'>
  
이 통합구성요소를 사용하려면 `knx` 연동을 올바르게 설정해야합니다. [KNX Integration](/integrations/knx)을 참조하십시오.

</div>

`knx` climate 플랫폼은 KNX 온도 조절기 및 실내 컨트롤러에 대한 인터페이스로 사용됩니다.

KNX 온도 조절기를 사용하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
climate:
   - platform: knx
     name: HASS-Kitchen.Temperature
     temperature_address: '5/1/1'
     setpoint_shift_address: '5/1/2'
     setpoint_shift_state_address: '5/1/3'
     target_temperature_state_address: '5/1/4'
     operation_mode_address: '5/1/5'
     operation_mode_state_address: '5/1/6'
```

또는 장치에 frost/night/comfort 모드 전용 이진(binary) 그룹 주소가 있는 경우 :

```yaml
# Example configuration.yaml entry
climate:
  - platform: knx
    name: HASS-Kitchen.Temperature
    temperature_address: '5/1/1'
    setpoint_shift_address: '5/1/2'
    setpoint_shift_state_address: '5/1/3'
    target_temperature_state_address: '5/1/4'
    operation_mode_frost_protection_address: '5/1/5'
    operation_mode_night_address: '5/1/6'
    operation_mode_comfort_address: '5/1/7'
    operation_mode_state_address: '5/1/8'
```

장치가 setpoint_shift 계산을 지원하지 않는 경우 (즉, `setpoint_shift_address` 값을 제공하지 않는 경우) Climate 장치의 `min_temp` 및 `max_temp` 속성을 설정하여 프런트 엔드에서 유효한 온도값을 초과하는 문제를 피하십시오. 이 경우에도 `target_temperature_address`를 설정에 추가하십시오 :


```yaml
# Example configuration.yaml entry
climate:
  - platform: knx
    name: HASS-Kitchen.Temperature
    temperature_address: '5/1/2'
    target_temperature_address: '5/1/4'
    target_temperature_state_address: '5/1/1'
    operation_mode_frost_protection_address: '5/1/5'
    operation_mode_night_address: '5/1/6'
    operation_mode_comfort_address: '5/1/7'
    operation_mode_state_address: '5/1/8'
    min_temp: 7.0
    max_temp: 32.0
```

`operation_mode_frost_protection_address` / `operation_mode_night_address` / `operation_mode_comfort_address`는 `operation_mode_address`가 지정된 경우 필요하지 않습니다.
actor가 명시적 상태 통신 오브젝트(explicit state communication objects)를 지원하지 않는 경우 *_state_address는 쓰기 가능한 *_address와 동일한 그룹 주소로 설정될 수 있습니다. 초기 읽기를 지원하기 위해 *_state_address 통신 객체(communication object)에 대한 읽기플래그(Read-Flag)가 ETS에 설정되어야 합니다. 예를들어 홈어시스턴트를 시작할 때.


다음 값은 `hvac_mode` 속성에 유효합니다.

- Off (maps internally to HVAC_MODE_OFF within Home Assistant)
- Auto (maps internally to HVAC_MODE_AUTO within Home Assistant)
- Heat (maps internally to HVAC_MDOE_HEAT within Home Assistant)
- Cool (maps internally to HVAC_MDOE_COOL within Home Assistant)
- Fan only (maps internally to HVAC_MODE_FAN_ONLY within Home Assistant)
- Dry (maps internally to HVAC_MODE_DRY within Home Assistant)

다음 사전설정(presets)은 `preset_mode` 속성에 유효합니다.

- Comfort (maps internally to PRESET_COMFORT within Home Assistant)
- Standby (maps internally to PRESET_AWAY within Home Assistant)
- Night (maps internally to PRESET_SLEEP within Home Assistant)
- Frost Protection (maps internally to PRESET_ECO within Home Assistant)

{% configuration %}
name:
  description: A name for this device used within Home Assistant.
  required: false
  default: KNX Climate
  type: string
temperature_address:
  description: KNX group address for reading current room temperature from KNX bus. *DPT 9.001*
  required: true
  type: string
target_temperature_address:
  description: KNX group address for setting target temperature. *DPT 9.001*
  required: false
  type: string
target_temperature_state_address:
  description: KNX group address for reading current target temperature from KNX bus. *DPT 9.001*
  required: true
  type: string
setpoint_shift_address:
  description: KNX address for setpoint_shift. *DPT 6.010*
  required: false
  type: string
setpoint_shift_state_address:
  description: KNX address for reading setpoint_shift. *DPT 6.010*
  required: false
  type: string
setpoint_shift_step:
  description: Defines the step size in Kelvin for each step of setpoint_shift.
  required: false
  default: 0.5
  type: float
setpoint_shift_min:
  description: Minimum value of setpoint shift.
  required: false
  default: -6
  type: float
setpoint_shift_max:
  description: Maximum value of setpoint shift.
  required: false
  default: 6
  type: float
operation_mode_address:
  description: KNX address for setting operation mode (Frost protection/night/comfort). *DPT 20.102*
  required: false
  type: string
operation_mode_state_address:
  description: KNX address for reading operation mode. *DPT 20.102*
  required: false
  type: string
controller_status_address:
  description: KNX address for HVAC controller status (in accordance with KNX AN 097/07 rev 3).
  required: false
  type: string
controller_status_state_address:
  description: KNX address for reading HVAC controller status.
  required: false
  type: string
controller_mode_address:
  description: KNX address for setting HVAC controller modes. *DPT 20.105*
  required: false
  type: string
controller_mode_state_address:
  description: KNX address for reading HVAC Control Mode. *DPT 20.105*
  required: false
  type: string
operation_mode_frost_protection_address:
  description: KNX address for switching on/off frost/heat protection mode.
  required: false
  type: string
operation_mode_night_address:
  description: KNX address for switching on/off night mode.
  required: false
  type: string
operation_mode_comfort_address:
  description: KNX address for switching on/off comfort mode.
  required: false
  type: string
operation_modes:
  description: Overrides the supported operation modes.
  required: false
  type: list
on_off_address:
  description: KNX address for switching the climate device on/off.
  required: false
  type: string
on_off_invert:
  description: Value for switching the climate device on/off is inverted.
  required: false
  default: false
  type: boolean
on_off_state_address:
  description: KNX address for gathering the current state (on/off) of the climate device.
  required: false
  type: string
min_temp:
  description: Override the minimum temperature.
  required: false
  type: float
max_temp:
  description: Override the maximum temperature.
  required: false
  type: float
{% endconfiguration %}
