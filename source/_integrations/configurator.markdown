---
title: Configurator
description: Instructions on how to integrate the configurator in your components.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

<div class='note'>
이 통합구성요소는 개발자를 위한 것입니다. 
(한편 최근들어 개발자가 아니어도 세팅이 가능한 수준에 이르렀으며 Hass.io의 최근 버전에서는 따라 UI로 설정으로 통합되어가고 있습니다.)
</div>

configurator를 통해 통합구성요소를 사용자가 직접 작성하여 넣을 수 있습니다. 

- 사용자에게 텍스트, 이미지 및 버튼 표시를 지원합니다. 
- 입력 필드는 설명 및 선택적 유형으로 정의 할 수 있습니다
- 버튼을 누르면 콜백이 트리거됩니다

[the demo](/demo) 및 Plex 의 Hue 통합구성요소는 configurator를 사용하여 구현됩니다.  [the source of the demo integration](https://github.com/home-assistant/home-assistant/tree/dev/homeassistant/components/demo) 를 참조하십시오. 

[the source](https://github.com/home-assistant/home-assistant/tree/dev/homeassistant/components/configurator) configurator 통합을 사용하는 방법에 대한 자세한 내용들. 
