---
title: "Script Editor"
description: "Instructions on how to use the new script editor."
redirect_from: /docs/script/editor/
---

Home Assistant 0.52에서 첫 번째 버전의 스크립트 편집기를 소개했습니다. 방금 홈어시스턴트로 새로 설치하셨다면 모두 설정되었습니다! UI로 이동하여 즐기십시오.

<div class='videoWrapper'>
<iframe src="https://www.youtube.com/embed/_Rntpcj1CGA" frameborder="0" allowfullscreen></iframe>
</div>

## 편집기를 사용하도록 설정 업데이트

스크립트 편집기를 읽고 쓰도록 scripts.yaml는 [configuration](/docs/configuration/)폴더에 있습니다. 스크립트 통합구성요소를 읽고 설정해 보십시오.

```yaml
# Configuration.yaml example
script: !include scripts.yaml
```

`script:`는 `scripts.yaml`로 편집 가능 하도록 이동해야 합니다.
