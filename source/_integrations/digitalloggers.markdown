---
title: 통합스위치솔루션(Digital Loggers)
description: Instructions on how to integrate Digital Loggers DIN III relays into Home Assistant.
logo: digitalloggers.png
ha_category:
  - Switch
ha_release: 0.35
ha_iot_class: Local Polling
---

`digitalloggers` 스위치 플랫폼을 사용하면 [Digital Loggers](https://www.digital-loggers.com/dinfaqs.html) 스위치의 상태를 제어할 수 있습니다.

## 설정

설치시 digitalloggers 스위치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: digitalloggers
    host: 192.168.1.43
```

{% configuration %}
host:
  description: The IP address or FQDN of your DIN III relay, e.g., `192.168.1.32` or `myrelay.example.com`.
  required: true
  type: string
name:
  description: The name to use when controlling this relay.
  required: false
  default: DINRelay
  type: string
username:
  description: Username for controlling this relay.
  required: false
  default: admin
  type: string
password:
  description: Password for controlling this relay.
  required: false
  default: admin
  type: string
timeout:
  description: Override the timeout in seconds if you need to, valid range is 1 to 600.
  required: false
  default: 20
  type: integer
cycletime:
  description: "This is the delay enforced by the library when you send multiple commands to the same device. Override it if you need to. Valid range is 1 to 600. A delay is a recommendation of Digital Loggers: Many loads draw more power when they are initially switched on. Sequencing prevents circuit overloads when loads devices are attached to a single circuit."
  required: false
  default: 2
  type: integer
{% endconfiguration %}

릴레이는 `switch.fantasticrelaydevice_individualrelayname` 형식으로 제공됩니다.

**Note:** `digitalloggers` 통합구성요소에서 사용되는 [dlipower 라이브러리](https://github.com/dwighthubbard/python-dlipower)에는 현재 포트 80을 통해서만 통신이 가능하다는 제한이 있습니다.
