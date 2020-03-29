---
title: 우주도전정보(Launch Library)
description: Instructions on how to integrate space launch information within Home Assistant.
logo: rocket.png
ha_category:
  - Sensor
ha_iot_class: Cloud Polling
ha_release: 0.83
ha_codeowners:
  - '@ludeeus'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/vMoOdgGJv4I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`launch_library` 센서는 다음 계획된 우주 발사에 대한 정보를 제공합니다.

## 설정

예제와 같이 `configuration.yaml` 파일에 데이터를 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: launch_library
```

{% configuration %}
name:
  description: Name of the sensor.
  required: false
  type: string
{% endconfiguration %}

이 플랫폼이 제공하는 데이터는 [launchlibrary.net][launchlibrary]에서 제공됩니다.

[launchlibrary]: https://launchlibrary.net/
