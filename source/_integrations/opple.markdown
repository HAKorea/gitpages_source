---
title: 오플(Opple)
description: Instructions on how to integrate Opple lights into Home Assistant.
logo: opple.png
ha_category:
  - Light
ha_release: '0.80'
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/npWKc7gzgdo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`opple` light 플랫폼을 사용하면 Opple 스마트 조명의 상태를 제어할 수 있습니다.

해당 플랫폼은 와이파이 지원 혹은 앱에서 제어되는 모든 opple 조명을 지원합니다. 

설치에서 Opple 조명을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: opple
    name: LIGHT_NAME
    host: IP_ADDRESS
```

{% configuration %}
name:
  description: The name to use when displaying this light.
  required: false
  type: string
  default: opple light
host:
  description: "The IP address of your Opple light, e.g., `192.168.0.21`."
  required: true
  type: string
{% endconfiguration %}
