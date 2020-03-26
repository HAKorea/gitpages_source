---
title: 세이프 모드
description: Allows Home Assistant to start up in safe mode.
ha_category: []
ha_release: 0.105
logo: home-assistant.png
ha_codeowners:
  - '@home-assistant/core'
---

`safe_mode` 통합구성요소는 Home Assistant Core에서 내부적으로 사용되는 통합구성요소입니다.

홈어시스턴트가 필요할 때 항상 자동으로 사용 가능하므로 어떤 방식으로도 설정할 필요가 없습니다.

시작하는 동안 Home Assistant가 설정을 읽는데 문제가 있는 경우에도 마지막으로 시작한 설정의 비트와 조각들을 계속 사용합니다.

이 경우 Home Assistant는이 통합구성요소를 사용하여 "안전 모드"에서 시작합니다. 이 모드에서는 아무것도 로드되지 않지만 홈어시스턴트 프론트 엔드, 설정 및 애드온에 액세스할 수 있습니다.

그러면 문제를 해결하고 홈어시스턴트를 다시시작하여 다시시도 할 수 있습니다.