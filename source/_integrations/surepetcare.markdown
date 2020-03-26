---
title: 슈어 펫케어(Sure Petcare)
description: Instructions on how to integrate the Sure Petcare cat and pet flaps into Home Assistant.
logo: sure_petcare.png
ha_category:
  - Binary Sensor
  - Sensor
ha_release: 0.104
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@benleb'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/jjOqzXCwDec" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`surepetcare` 구성 요소를 사용하면 Sure Petcare Connect Pet 또는 Cat Flap에 대한 정보를 얻을 수 있습니다.

## 설정

Flap 과 pet을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
surepetcare:
  username: x@y.com
  password: v3rys3cr3t!
  household_id: 1337
  flaps: [{id: 2337, name: Flap}]
  pets: [{id: 3337, name: Pet}]
```

{% configuration %}
  username:
    description: The Sure Petcare Username/Email
    required: true
    type: string
  password:
    description: The Sure Petcare Password
    required: true
    type: string
  household_id:
    description: The Sure Petcare household_id
    required: true
    type: integer
  flaps:
    description: The Sure Petcare flaps
    required: true
    type: map
    keys:
      id:
        description: The Sure Petcare id of a flap
        required: true
        type: integer
      name:
        description: A name for the flap
        required: true
        type: string
  pets:
    description: Pets managed by Sure Petcare flap(s)
    required: true
    type: map
    keys:
      id:
        description: The Sure Petcare id of a pet
        required: true
        type: integer
      name:
        description: The name of the pet
        required: true
        type: string
  icon:
    description: "Icon to display (e.g., `mdi:cat`)"
    required: false
    default: "mdi:cat"
    type: string
  scan_interval:
    description: "Minimum time interval between updates. Supported formats: `scan_interval: 'HH:MM:SS'`, `scan_interval: 'HH:MM'` and Time period dictionary (see example below)."
    required: false
    default: 3 minutes
    type: time
  device_class:
    description: The type/class of the sensor to set the icon in the frontend.
    required: false
    default: lock
    type: device_class
{% endconfiguration %}

## flaps 와 pets의 집안 ID 얻어내기

지금은 [@rcastberg](https://github.com/rcastberg)의 [sp_cli.py](https://github.com/rcastberg/sure_petcare/blob/master/sp_cli.py)를 사용하여 가져 오십시오. Sure Petcare API의 ID 기본 설정에서 ID는 JSON으로 `~/.surepet.cache`에 기록됩니다.