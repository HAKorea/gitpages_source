---
title: "MQTT"
description: "Details about the MQTT support of Home Assistant."
---

MQTT (일명 MQ Telemetry Transport)  TCP/IP 외에 머신to머신 또는 "Internet of Things" 연결 프로토콜입니다.  초경량 publish/subscribe 메시징 전송을 쓸 수 있게 해줍니다.

MQTT를 홈어시스턴트에 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가 하십시오.

```yaml
# Example configuration.yaml entry
mqtt:
  broker: IP_ADDRESS
```

자세한 설정 지시 사항은, [MQTT broker](/docs/mqtt/broker) 문서를 참조하십시오.

## 추가 기능

- [Certificate](/docs/mqtt/certificate/)
- [Discovery](/docs/mqtt/discovery/)
- [Publish service](/docs/mqtt/service/)
- [Birth and last will messages](/docs/mqtt/birth_will/)
- [Testing your setup](/docs/mqtt/testing/)
- [Logging](/docs/mqtt/logging/)
- [Processing JSON](/docs/mqtt/processing_json/)

[MQTT example component](/cookbook/python_component_mqtt_basic/)를 참조하여 자신의 component를 어떻게 연동하는지 확인하십시오. 