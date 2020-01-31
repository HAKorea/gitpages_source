---
title: ESPHome
description: Support for ESPHome devices using the native ESPHome API.
featured: true
logo: esphome.png
ha_category:
  - DIY
ha_release: 0.85
ha_iot_class: Local Push
ha_config_flow: true
ha_codeowners:
  - '@OttoWinter'
---

[ESPHome](https://esphome.io) 장치를 통합구성요소로 사용할 시에는 [native ESPHome API](https://esphome.io/components/api.html)로 완벽하게 직접 연결됩니다. 

## 통합 구성요소(Integrations)를 통한 기기 추가 방법 

Menu: *설정* > *통합 구성요소*

**ESPHome**을 클릭하시고 통합 구성요소 설정:

* 해당 기기의 포트와 주소를 넣으세요. 예를 들어 노트이름이 `livingroom`이면, 해당 주소는 `livingroom.local` 이 되고, 포트번호는 `6053` (default)이 됩니다.

홈어시스턴트는 기기에 접속을 시도할 겁니다. 만일 API 비밀번호를 설정하셨다면 홈어시스턴트는 비밀번호를 요청할것입니다. 그 이후에, 설정한 ESPHOME기기의 모든 entity들이 자동으로 홈어시스턴트에 나타나게 됩니다. 
