---
title: 소니 프로젝터(Sony Projector)
description: Instructions on how to integrate Sony Projector switches into Home Assistant.
logo: sony.png
ha_category:
  - Multimedia
ha_iot_class: Local Polling
ha_release: 0.89
---

`sony_projector` 스위치 플랫폼을 사용하면 [Sony](https://www.sony.com/)에서 SDCP 호환 네트워크 연결 프로젝터의 상태를 제어할 수 있습니다.

## 설정

Sony 프로젝터를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: sony_projector
    host: "192.168.1.47"
    name: "Projector"
```

{% configuration %}
host:
  description: 프로젝터의 호스트 이름 또는 IP 주소
  required: true
  type: string
name:
  description: 이 스위치를 표시 할 때 사용할 이름
  required: false
  type: string
{% endconfiguration %}
