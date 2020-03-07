---
title: 에이서 프로젝터(Acer Projector)
description: Instructions on how to integrate Acer Projector switches into Home Assistant.
logo: acer.png
ha_category:
  - Multimedia
ha_iot_class: Local Polling
ha_release: 0.19
---

`acer_projector` 스위치 플랫폼을 사용하면 [Acer](https://www.acer.com/)에서 RS232 연결된 프로젝터의 상태를 제어할 수 있습니다.

## 설정

설치에서 Acer 프로젝터를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: acer_projector
    filename: /dev/ttyUSB0
```

{% configuration %}
filename:
  description: The pipe where the projector is connected to.
  required: true
  type: string
name:
  description: The name to use when displaying this switch.
  required: false
  type: string
timeout:
  description: Timeout for the connection in seconds.
  required: false
  type: integer
write_timeout:
  description: Write timeout in seconds.
  required: false
  type: integer
{% endconfiguration %}
