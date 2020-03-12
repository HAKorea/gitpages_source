---
title: 쿨마스터넷(CoolMasterNet)
description: Instructions on how to integrate CoolMasterNet within Home Assistant.
logo: coolautomation.png
ha_category:
  - Climate
ha_release: 0.88
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@OnFreund'
---

The `coolmaster` climate platform lets you control HVAC through [CoolMasterNet](https://coolautomation.com/products/coolmasternet/).
`coolmaster` climate 플랫폼은 [CoolMasterNet](https://coolautomation.com/products/coolmasternet/)을 통해 HVAC를 제어할 수 있습니다.

## 프론트엔드를 통한 설정

Menu: **설정** -> **통합구성요소**.

`+` 부호를 클릭하여 통합구성요소를 추가하고 **CoolMasterNet**을 클릭하십시오.
인스턴스의 호스트 및 포트를 선택하고 HVAC 장치가 지원하는 모드의 확인란을 선택하십시오. CoolMasterNet에서 설정한 장치는 Climate entities 와 매칭되는 장치로 Home Assistant에 자동으로 추가됩니다.