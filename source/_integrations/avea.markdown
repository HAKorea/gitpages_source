---
title: 엘가토 Avea
description: Instructions on how to integrate Elgato Avea with Home Assistant.
logo: avea.png
ha_category:
  - Light
ha_release: 0.97
ha_iot_class: Local Polling
ha_codeowners:
  - '@pattyland'
---

[Elgato Avea](https://www.elgato.com/en/news/elgato-avea-transform-your-home)는 제조업체에서 더 이상 지원하지 않는 Bluetooth 전구입니다. `avea` 통합구성요소를 통해 Home Assistant로 모든 Avea 전구를 제어할 수 있습니다.

### 설정

Avea를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
light:
  - platform: avea
```
