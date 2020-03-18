---
title: 웹소켓 센서(Websocket Connection Sensor) 
description: "Instructions on how to count connected clients within Home Assistant."
logo: home-assistant.png
ha_category:
  - Utility
ha_release: 0.33
ha_iot_class: Local Push
ha_quality_scale: internal
---

`websocket_api` 센서 플랫폼은 stream API에 연결된 클라이언트 수를 보여줍니다.

## 설정

연결된 클라이언트를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: websocket_api
```

### 참고

이는 이전의 `api_streams` 센서를 대체합니다.