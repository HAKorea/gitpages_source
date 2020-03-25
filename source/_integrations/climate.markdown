---
title: 온습도조절기(Climate)
description: Instructions on how to setup climate control devices within Home Assistant.
logo: home-assistant.png
ha_category:
  - Climate
ha_release: 0.19
ha_quality_scale: internal
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/beSIUfOL7io" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Climate 통합구성요소를 통해 HVAC (가열, 환기 및 공기조절) 장치 및 온도조절기를 제어하고 모니터링할 수 있습니다.

## 서비스

### Climate 제어 서비스

제공 서비스: `climate.set_aux_heat`, `climate.set_preset_mode`, `climate.set_temperature`, `climate.set_humidity`, `climate.set_fan_mode`, `climate.set_hvac_mode`, `climate.set_swing_mode`, `climate.turn_on`, `climate.turn_off`

<div class='note'>

플랫폼에 따라 모든 Climate 서비스가 제공되는 것은 아닙니다. 홈어시스턴트의 <img src='/images/screenshots/developer-tool-services-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> **Services**에서 체크해서 사용할 수 있는 서비스를 확인해야합니다 

</div>

### `climate.set_aux_heat` 서비스

climate 장치용 보조 히터 켜기 / 끄기

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록입니다. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
| `aux_heat` | no | 	보조 히터의 새로운 값.

#### 자동화 예

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_aux_heat
      data:
        entity_id: climate.kitchen
        aux_heat: true
```

### `climate.set_preset_mode` 서비스

Climate 장치에 대한 사전설정 모드를 설정하십시오. Away mode는 Climate 장치가 에너지를 절약하도록 설정된 상황을 반영하는 온도로 목표 온도를 변경합니다. 이는 "vacation mode" 를 에뮬레이션하는 데 사용할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
| `preset_mode` | no | 사전 설정 모드의 새로운 값.

#### 자동화 예

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_preset_mode
      data:
        entity_id: climate.kitchen
        preset_mode: 'eco'
```

### `climate.set_temperature` 서비스

Climate 장치의 목표온도 설정

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
| `temperature` | no | Climate 장치의 새로운 목표 온도 (일반적으로 *setpoint*이라 함). `hvac_mode`가 `heat_cool`일 경우 사용하지마십시오.
| `target_temp_high` | yes | Climate 장치가 허용하는 최고온도입니다. `hvac_mode`가 `heat_cool`인 경우 반드시 필요.
| `target_temp_low` | yes | Climate 장치가 허용하는 최저온도입니다. `hvac_mode` 가 `heat_cool`인 경우 반드시 필요.
| `hvac_mode` | yes | Climate 장치를 설정하는 HVAC 모드. 설정하지 않았거나 잘못 설정한 경우 현재 HVAC 모드로 기본 설정됩니다.

#### 자동화 예

```yaml
### Set temperature to 24 in heat mode
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_temperature
      data:
        entity_id: climate.kitchen
        temperature: 24
        hvac_mode: heat
```

```yaml
### Set temperature range to 20 to 24 in heat_cool mode
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_temperature
      data:
        entity_id: climate.kitchen
        target_temp_high: 24
        target_temp_low: 20
        hvac_mode: heat_cool
```

### `climate.set_humidity` 서비스

Climate 장치의 목표습도 설정

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록입니다. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
| `humidity` | no | Climate 장치의 새로운 목표 습도

#### 자동화 예

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_humidity
      data:
        entity_id: climate.kitchen
        humidity: 60
```

### `climate.set_fan_mode` 서비스

Climate 장치의 팬 작동 설정

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
| `fan_mode` | no | fan mode의 새로운 값

#### 자동화 예

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_fan_mode
      data:
        entity_id: climate.kitchen
        fan_mode: 'On Low'
```

### `climate.set_hvac_mode` 서비스

Climate 장치의 HVAC 모드 설정

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
| `hvac_mode` | no | HVAC mode의 새로운 값.

#### 자동화 예

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_hvac_mode
      data:
        entity_id: climate.kitchen
        hvac_mode: heat
```

### `climate.set_swing_mode` 서비스

Climate 장치의 스윙 작동 모드 설정

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록입니다. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
| `swing_mode` | no | 스윙 모드의 새로운 값.

#### 자동화 예

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    - service: climate.set_swing_mode
      data:
        entity_id: climate.kitchen
        swing_mode: 1
```

### `climate.turn_on` 서비스

Climate 장치를 켭니다. Climate 장치가 꺼져있는 경우에만 지원됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록입니다. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.

### `climate.turn_off` 서비스

Climate 장치를 끕니다. Climate 장치에 hvac 모드가 off인 경우만 지원됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 제어할 climate 장치의 entity ID를 정의하는 문자열 또는 문자열 목록입니다. 모든 Climate 장치를 대상으로 하려면, `all`을 사용하십시오.
