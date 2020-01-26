---
title: "서드파티 애드온 설치"
description: "Instructions on how to get started using third-party add-ons."
---

Hass.io는 해쇼용 애드온들을 공유하기 위한 저장소를 제공할 수 있습니다. 이것을 사용하기 위해서 예제로 준비한 애드온 저장소를 추가해볼 수 있습니다.

```text
https://github.com/home-assistant/hassio-addons-example
```

<div class='note warning'>
홈어시스턴트는 서드파티 애드온에 대해 보안 사항을 보증하지 않습니다. 서드파티 애드온은 본인이 위험을 감수하고 사용해야 합니다.
</div>

<p class='img'>
<img src='/images/hassio/screenshots/main_panel_addon_store.png' />
Hass.io 메인 패널에서 애드온 스토어를 선택합니다.
</p>

<p class='img'>
<img src='/images/hassio/screenshots/adding_repositories.png' />
저장소의 URL을 입력하고 "Add" 버튼을 누르면 저장소에서 배포중인 애드온들이 신규 카드로 나타납니다.
</p>

### 도움말: 저장소가 보이지 않아요

저장소를 추가해도 화면에 아무것도 보이지 않는 경우가 있습니다. 이것은 저장소에서 설정 파일이 잘못된 경우입니다. Hass.io 패널에서 시스템(System) 탭을 선택하여 시스템 로그를 살펴봅니다. 로그를 통해 무엇이 잘못됐는지 힌트를 얻을 수 있습니다. 오류가 있다면 저장소 관리자에게 알려주세요. 
