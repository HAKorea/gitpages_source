---
title: Config
description: Instructions on how to setup the configuration panel for Home Assistant.
logo: home-assistant.png
ha_category:
  - Front End
ha_release: 0.39
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`config` 통합구성요소는 홈 지원의 일부를 구성하는 프론트 엔드에서 패널을 표시하고 관리 할 수 있도록 설계되었습니다.

[`default_config:`](https://www.home-assistant.io/integrations/default_config/) 설정을 configuration.yaml에서 비활성화하거나 제거하지 않은 경우 통합구성요소에서 기본으로 동작하게 되어있습니다. 이런 경우 다음 예는 통합구성요소를 수동으로 활성화하는 방법입니다. :

```yaml
# Example configuration.yaml entry
config:
```

### 통합구성요소

이 섹션에서는 Home Assistant 내에서 Philips Hue 및 Sonos와 같은 장치의 통합을 관리 할 수 ​​있습니다.

### 사용자

이 섹션에서는 Home Assistant 사용자를 관리 할 수 ​​있습니다.

### 일반

이 섹션에서는 Home Assistant 설치의 이름, 위치 및 단위 시스템을 관리 할 수 ​​있습니다.

### 서버 제어

이 섹션에서는 Home Assistant 내에서 Home Assistant를 제어 할 수 있습니다. 마우스 클릭 한 번으로 설정을 확인하고 the core, groups, scripts, automations 및 홈어시스턴트 프로세스를 다시로드 할 수 있습니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/server-management.png' />
</p>

### Persons

이 섹션에서는 person component를 사용하여 사용자를 device tracker 엔티티와 연관시킬 수 있습니다.

### Entity Registry

이 섹션에서는 이름을 덮어씌워 entitiy ID를 변경하거나 Home Assistant에서 entity를 비활성화 할 수 있습니다.

### Area Registry

이 섹션에서는 entity를 집안의 실제 영역으로 구성 할 수 있습니다.

### Automation

이 섹션에서는 yaml 코드를 작성할 필요없이 Home Assistant 내에서 자동화를 작성하고 수정할 수 있습니다.

### Script

자동화 편집기와 마찬가지로이 섹션을 사용하면 yaml 코드를 작성하지 않고도 Home Assistant 내에서 스크립트를 작성하고 수정할 수 있습니다.

### Z-Wave

이 섹션에서는 Home Assistant 내에서 Z-Wave 네트워크 및 장치를 제어 할 수 있습니다. 장치 별 구성 변수를 변경하고 장치를 추가 및 제거 할 수 있습니다.

### Customization

이 섹션에서는 Home Assistant 내에서 entity를 사용자 정의 할 수 있습니다. 친숙한 이름을 설정하고 아이콘을 변경하며 엔터티를 숨기고 다른 속성을 수정하려면이 옵션을 사용하십시오.