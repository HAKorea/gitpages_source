---
title: MQTT
description: Instructions on how to setup MQTT within Home Assistant.
logo: mqtt.png
ha_category:
  - Hub
featured: true
ha_release: pre 0.7
ha_iot_class: Local Push
ha_config_flow: true
ha_codeowners:
  - '@home-assistant/core'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/NjKK5ab0-Kk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

MQTT (일명 MQ Telemetry Transport)는 TCP / IP 외에 머신 대 머신 또는 "Internet of Things" 연결 프로토콜입니다. 초경량 publish/subscribe 전송을 허용합니다.

MQTT 및 Home Assistant를 작동시키기위한 첫 번째 단계는 [broker](/docs/mqtt/broker)를 선택하는 것 입니다.

MQTT를 Home Assistant에 설치하려면, `configuration.yaml` 파일에 다음 섹션을 추가 하십시오.

[own MQTT broker](/docs/mqtt/broker#run-your-own)연결하기:

```yaml
# Example configuration.yaml entry
mqtt:
  broker: IP_ADDRESS_BROKER
```

[embedded MQTT broker](/docs/mqtt/broker#embedded-broker)를 사용할 수 있습니다. 안정성을 높이려면 별도의 브로커가 권장됩니다.

<div class='note warning'>
0.92 릴리스부터 임베디드 브로커는 더 이상 사용되지 않습니다. 이는 버그가 수정되지 않았으며 브로커 기능이 향후 릴리스에서 제거 될 것임을 의미합니다.
</div>

```yaml
# Example configuration.yaml entry
mqtt:
  password: hello
```

이를 통해 사용자 `homeassistant` 비밀번호 `hello` 로 MQTT브로커에 연결할 수 있습니다.

## 추가 기능

- [Certificate](/docs/mqtt/certificate/)
- [Discovery](/docs/mqtt/discovery/)
- [Publish service](/docs/mqtt/service/)
- [Birth and last will messages](/docs/mqtt/birth_will/)
- [Testing your setup](/docs/mqtt/testing/)
- [Logging](/docs/mqtt/logging/)
- [Processing JSON](/docs/mqtt/processing_json/)
