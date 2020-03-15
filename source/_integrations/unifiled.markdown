---
title: 유비쿼티 LED(Ubiquiti UniFi LED)
description: Instructions on how to configure the UniFi LED integration with UniFi LED Controller by Ubiquiti.
logo: ubiquiti.png
ha_category:
  - Light
ha_release: 0.102
ha_iot_class: Local Polling
ha_codeowners:
  - '@florisvdk'
---

[Ubiquiti Networks, Inc.](https://www.ubnt.com/)의 [UniFi LED](https://unifi-led.ui.com/)는 LED 조명 패널과 디머에 의해 제어되는 컨트롤러 시스템입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Light](#light)

## 설정

```yaml
# Example configuration.yaml entry
light:
  - platform: unifiled
    host: IP_ADDRESS
    username: USERNAME
    password: PASSWORD
```

{% configuration %}
host:
  description: Ip address or hostname used to connect to the Unifi LED controller.
  type: string
  required: true
  default: None
port:
  description: Port used to connect to the Unifi LED controller.
  type: string
  required: false
  default: 20443
username:
  description: Username used to log into the Unifi LED controller.
  type: string
  required: true
  default: None
password:
  description: Password used to log into the Unifi LED controller.
  type: string
  required: true
  default: None
{% endconfiguration %}

## Light

조명 패널 출력 상태와 밝기는 홈어시스턴트와 동기화됩니다.