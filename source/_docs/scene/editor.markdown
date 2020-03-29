---
title: 씬 편집기(Scenes Editor)
description: "Instructions on how to use the scenes editor."
---

홈어시스턴트 0.102에서는 씬 편집기의 첫 번째 버전을 소개했습니다. 방금 홈어시스턴트를 설치하셨다면 모든 설정이 완료된 것입니다! UI로 이동하여 즐기십시오.

UI에서 사이드바에 있는 **설정**을 선택한 다음 **씬**을 클릭하여 씬 편집기로 이동 하십시오. 시작하려면 오른쪽 하단에 있는 **+** 기호를 누르십시오.

씬에 대한 적당한 이름을 기입하십시오.

<p class='img'>
  <img src='/images/docs/scenes/editor.png' />
</p>

씬에 포함시키려는 모든 장치(고급 모드인 경우 and/or entity)를 선택하십시오
장치의 상태가 저장되므로 씬 생성을 마치면 복원할 수 있습니다.
장치의 상태를 씬에서 원하는 방식으로 설정하십시오. 장치를 클릭하고 팝업에서 상태를 편집하거나 상태를 변경하는 다른 방법으로 수행할 수 있습니다. 
씬을 저장하는 순간 장치의 모든 상태가 씬에 저장됩니다. 편집기를 종료하면 장치 상태가 편집을 시작하기 전의 상태로 복원됩니다.

## 편집기를 사용하기 위한 설정 업데이트

먼저 설정 편집기를 활성화했는지 확인하십시오.

```yaml
# Activate the configuration editor
config:
```

scene 편집기는 [configuration](/docs/configuration/) 폴더의 `scenes.yaml`의 루트에 있는 파일을 읽고 씁니다 . 
현재 이 파일의 이름과 위치는 모두 고정되어 있습니다. 
씬 통합구성요소에서 저장된 씬을 잘 읽어올 수 있도록 셋업했는지 확인하십시오. 

```yaml
# Configuration.yaml example
scene: !include scenes.yaml
```

과거 씬 섹션을 계속 사용하려면 이전 항목에 다음 레이블을 추가하십시오. : 

```yaml
scene old:
  - name: ...
```

`scene:` 와 `scene old:` 섹션을 동시에 사용할 수 있습니다. :

- `scene old:` 수동으로 설계된 scene을 유지
- `scene:` 온라인 편집기로 생성한 scene을 저장

```yaml
scene: !include scenes.yaml
scene old: !include_dir_merge_list scenes
```

## scene을 `scenes.yaml`로 마이그레이션

편집기를 사용하기 위해 과거 씬을 마이그레이션하려면 해당 씬을 `scenes.yaml`에 복사해야합니다. `scenes.yaml`이 목록으로 남아있는지 확인하십시오. 복사한 각 scene마다 `id`를 추가해야합니다. 고유한 문자열이어야 합니다.

예시 :

```yaml
# Example scenes.yaml entry
- id: my_unique_id # <-- Required for editor to work.
  name: Romantic
  entities:
    light.tv_back_light: on
    light.ceiling:
      state: on
      xy_color: [0.33, 0.66]
      brightness: 200
```

<div class='note'>
편집기를 통해 씬을 업데이트하면 YAML 파일의 모든 주석이 손실되고 템플릿이 다시 포맷됩니다.
</div>
