---
title: "MQTT Logging"
description: "Instructions on how to setup MQTT Logging within Home Assistant."
logo: mqtt.png
---

[logger](/integrations/logger/) 통합구성요소로 수신 MQTT 메시지의 로깅을 할 수 있습니다.

```yaml
# Example configuration.yaml entry
logger:
  default: warning
  logs:
    homeassistant.components.mqtt: debug
```

