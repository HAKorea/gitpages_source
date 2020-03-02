---
title: 브라우저
description: Instructions on how to setup the browser integration with Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_release: pre 0.7
ha_quality_scale: internal
---

`browser` 통합구성요소는 호스트 컴퓨터의 기본 브라우저에서 열고 URL에 대한 서비스를 제공합니다.

## 설정

이 컴포넌트를 불러 오려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
browser:
```

#### `browser/browse_url` 서비스

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `url`                  |       no | The URL to open.


### 사용법

이 서비스를 사용하려면 **개발자 도구**에서 **Call Service**를 선택하십시오. **Available services:** 목록에서 *browser/browse_url* 서비스를 선택하고 **Service Data** 필드에 URL을 입력하고 **CALL SERVICE**를 누르십시오.

```json
{"url": "http://www.google.com"}
```

호스트 시스템에서 지정된 URL이 열립니다.
