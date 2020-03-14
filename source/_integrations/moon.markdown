---
title: 달(Moon)
description: Instructions on how to integrate the moon sensor into Home Assistant.
logo: home-assistant.png
ha_category:
  - Environment
ha_iot_class: Local Polling
ha_release: 0.38
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`moon` 통합구성요소는 달의 위치와 상태를 추적합니다.

## 설정 

Moon 센서를 `configuration.yaml`에 활성화하려면 다음 줄을 추가하십시오

```yaml
# Example configuration.yaml entry
sensor:
  - platform: moon
```

이 센서는 다음의 값 중 하나를 반환합니다. :
`new_moon`, `waxing_crescent`, `first_quarter`, `waxing_gibbous`, `full_moon`, `waning_gibbous`, `last_quarter` 혹은 `waning_crescent` .

<p class='img'>
<img src='/images/screenshots/more-info-dialog-moon.png' />
</p>
