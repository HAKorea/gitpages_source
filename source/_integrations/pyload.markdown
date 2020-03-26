---
title: 파이선모니터링(pyLoad)
description: Instructions on how to integrate pyLoad download sensor within Home Assistant.
logo: pyload.png
ha_category:
  - Downloading
ha_release: 0.58
ha_iot_class: Local Polling
---

`pyload` 플랫폼을 사용하면 Home Assistant 내에서 [pyLoad](https://pyload.net/)로 다운로드를 모니터링하고 정보를 기반으로 자동화를 설정할 수 있습니다.

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: pyload
```

{% configuration %}
host:
  description: This is the IP address of your pyLoad download manager.
  required: false
  type: string
  default: localhost
port:
  description: The port your pyLoad interface uses.
  required: false
  type: integer
  default: 8000
name:
  description: The name to use when displaying this pyLoad instance.
  required: false
  type: string
  default: 20
username:
  description: Your pyLoad username.
  required: false
  type: string
password:
  description: Your pyLoad password.
  required: false
  type: string
ssl:
  description: Enable SSL/TLS for the host.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

모든 것이 올바르게 설정되면 다운로드 속도가 프론트 엔드에 나타납니다.

<p class='img'>
  <img src='{{site_root}}/images/integrations/pyload/pyload_speed.png' />
</p>
