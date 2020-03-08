---
title: 자동화(automation)
description: Instructions on how to setup automation within Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

자세한 내용은 [docs 섹션] (/ docs / automation /)을 참조하십시오
자동화 통합 사용 방법에 대한 설명서.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/automation-switches.png' />
</p>

자동화 사용시 `initial_state : 'false'`를 사용할 수 있습니다
홈 어시스턴트 재부팅 후 자동으로 켜지지 않습니다.

```yaml
automation:
  - alias: Door alarm
    initial_state: true
    trigger:
      - platform: state
  ...
```

## Configuration

설정에서 default_config : 행을 비활성화하거나 제거하지 않은 경우 통합구성요소는 기본적으로 활성화됩니다. 
이럴 경우 다음 예는 통합구성요소를 수동으로 활성화하는 방법입니다. 

```yaml
# Example configuration.yaml entry
automation:
```
