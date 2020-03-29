---
title: Ambient 라디오 기상 네트워크
description: Instructions on how to integrate ARWN within Home Assistant.
ha_category:
  - Sensor
ha_release: 0.31
ha_iot_class: Local Polling
---

`arwn` 센서 플랫폼은 [Ambient Radio Weather Network](https://github.com/sdague/arwn) 프로젝트의 클라이언트입니다. 이 기상 관측소는 데이터를 수집하여 MQTT 하위 트리에서 사용할 수 있게합니다.

ARWN 설정을 사용하려면 이미 [MQTT](/integrations/mqtt/) 플랫폼이 설정되어 있어야합니다. 그런 다음 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: arwn
```

현재 모든 온도, 기압계, 습도, 비 및 바람 센서가 표시됩니다.