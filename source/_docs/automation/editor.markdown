---
title: "자동화 편집기"
description: "Instructions on how to use the automation editor."
---

홈어시스턴트 0.45 부터 자동화 편집기의 첫 번째 버전을 소개했습니다. 방금 홈어시스턴트를 설치했다면 모든 설정이 완료된 것입니다!, UI로 이동하여 즐기십시오.

UI 에서 사이드 바에있는 **설정**을 선택한 다음, **자동화** 를 클릭한 후 자동화 편집기로 이동하십시오. 우측 아래 **+** 기호를 누르면 시작이 됩니다. 이 예는 [`random` sensor](/integrations/random#sensor)를 활용한 [Getting started section](/getting-started/automation/)에 써둔 수동 설정 단계에 기초한 샘플입니다. 

자동화 규칙에 의미있는 이름을 선택하십시오.

<p class='img'>
  <img src='{{site_root}}/images/docs/automation-editor/new-automation.png' />
</p>

센서 값이 10보다 크면 자동화 규칙이 적용됩니다.

<p class='img'>
  <img src='{{site_root}}/images/docs/automation-editor/new-trigger.png' />
</p>

[persistent notification](/integrations/persistent_notification/) 이 실행되는 결과를 가져옵니다. 

<p class='img'>
  <img src='{{site_root}}/images/docs/automation-editor/new-action.png' />
</p>

"Service Data"로서 알림을 표시하게 하고자하는 간단한 텍스트를 출력시킵니다.

```json
{ 
  "message": "Sensor value greater than 10"
}
```

새로운 자동화 규칙을 저장하는 것을 잊지 마십시오. 저장된 자동화 규칙을 적용하려면 **설정** 페이지 로 이동하여 **Reload Automation** 를 클릭 해야합니다. 

## 편집기를 사용하도록 설정 업데이트

먼저 구성 편집기를 활성화했는지 확인하십시오.

```yaml
# Activate the configuration editor
config:
```

자동화 편집기는 구성 폴더 [configuration](/docs/configuration/)의 root에 있는 `automations.yaml`을 파일을 읽고 씁니다.  
현재 이 파일의 이름과 위치는 모두 고정되어 있습니다.
자동화 통합구성요소를 읽을 수 았도록 설정했는지 확인하십시오. :

```yaml
# Configuration.yaml example
automation: !include automations.yaml
```

이전 자동화 섹션을 계속 사용하려면 이전 항목에 레이블을 추가하십시오. :

```yaml
automation old:
- trigger:
    platform: ...
```

`automation:` 및 `automation old:` 섹션을 동시에 사용할 수 있습니다 . :
 - `automation old:` 수동 설계 자동화 유지
 - `automation:`  온라인 편집기로 생성 된 자동화를 저장

```yaml
automation: !include automations.yaml
automation old: !include_dir_merge_list automations
```


## 자동화를 `automations.yaml`로 마이그레이션

편집기를 사용하기 위해 이전 자동화를 마이그레이션하려면 해당 자동화를 `automations.yaml` 에 복사해야합니다. `automations.yaml` 이 목록으로 남아 있는지 확인하십시오 ! 복사하는 각 자동화 에 대해 `id` 를 추가해야합니다. 이는 고유한 문자열이어야 합니다.

예를 들어, 태양이 수평선 아래에서 수평선 위로 갈 때 아래 자동화가 트리거됩니다. 그런 다음 온도가 17도에서 25도 사이이면 표시등이 켜집니다.

```yaml
# Example automations.yaml entry
- id: my_unique_id  # <-- Required for editor to work, for automations created with the editor the id will be automatically generated.
  alias: Hello world
  trigger:
  - platform: state 
    entity_id: sun.sun
    from: below_horizon
    to: above_horizon
  condition:
  - condition: numeric_state
    entity_id: sensor.temperature
    above: 17
    below: 25
    value_template: '{% raw %}{{ float(state.state) + 2 }}{% endraw %}'
  action:
  - service: light.turn_on
```

<div class='note'>
편집기를 통해 자동화를 업데이트하면 YAML 파일의 모든 주석이 손실되고 템플릿이 다시 포맷됩니다.
</div>
