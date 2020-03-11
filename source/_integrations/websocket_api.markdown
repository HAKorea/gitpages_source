---
title: 홈어시스턴트 WebSocket API
description: Instructions on how to setup the WebSocket API within Home Assistant.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.34
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`websocket_api` 통합구성요소는 WebSocket API를 설정하고 헤드리스(headless)를 실행하는 Home Assistant 인스턴스와 상호 작용할 수 있도록합니다. 이 통합구성요소는 [`http` component](/integrations/http/)에 따릅니다.

<div class='note warning'>

특히 인터넷에 설치를 공개하려는 경우에는 `api_password` 를 설정하는 것이 좋습니다.

</div>

## 설정

```yaml
# Example configuration.yaml entry
websocket_api:
```

WebSocket API 사용에 대한 자세한 내용은 [WebSocket API documentation](/developers/websocket_api/)를 참조하십시오.

## 현재 연결 추적

websocket API는 현재 연결된 클라이언트 수를 추적하는 센서를 제공합니다. 설정에 다음을 추가하여 추가 할 수 있습니다.

```yaml
# Example configuration.yaml entry
sensor:
  platform: websocket_api
```
