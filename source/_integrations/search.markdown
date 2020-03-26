---
title: 서치(Search)
description: Internal search module for Home Assistant.
ha_category: []
ha_release: 0.105
logo: home-assistant.png
ha_codeowners:
  - '@home-assistant/core'
---

`search` 통합구성요소는 Home Assistant Core에서 내부적으로 사용되는 통합구성요소입니다.

Home Assistant에 저장된 모든 데이터는 상호 연결되어 그래프로 만들어집니다.
즉, 그래프로 검색 할 수 있습니다.

이러한 통합을 통해 Home Assistant 내부에서 영역, 장치, 엔터티, 설정 항목, 장면, 스크립트 및 자동화와 같은 관계를 검색할 수 있습니다.

검색 통합구성요소는 Home Assistant 프론트 엔드와 함께 자동으로 로드되며 별도로 설정할 필요가 없습니다.