---
title: "자동화"
description: "A quick intro on getting your first automation going"
redirect_from:
 - /getting-started/automation-create-first/
 - /getting-started/automation-2/
---

장비들을 연결했다면 이제 자동화(Automation)라는 맛깔스런 요리를 할 차례입니다. 아래 가이드를 따라하면 **해가 지면 집안의 불을 켠다** 와 같은 자동화 규칙을 적용할 수 있습니다.

홈어시스턴트 웹페이지에서 왼쪽 메뉴의 "설정(Configuration)"을 선택하고 "자동화(Automaion)"를 클릭합니다. 이 화면을 통해 홈어시스턴트의 자동화를 관리할 수 있습니다.

<p class='img'>
<img src='/images/getting-started/automation-editor.png'>
자동화 편집 화면
</p>

우측 하단의 오렌지색 `+` 버튼을 눌러 새로운 자동화를 만듭니다. 화면에 표시된 입력란들은 모두 비어있습니다.

<p class='img'>
<img src='/images/getting-started/new-automation.png'>
새로운 자동화 생성
</p>

첫번째로 할 일은 자동화의 이름을 정하는 것입니다. 이름(Name)란에 "해가지면 불을 켠다"로 입력하세요.

다음으로 자동화를 시작할 트리거(trigger)를 정의합니다. 이 경우 해(sun)가 진다는 이벤트를 자동화의 트리거로 사용할 것입니다. 하지만 실제로 해가 지고 불을 켜면 이미 주변이 너무 어둡습니다. 그러므로 옵셋(offset)을 설정해줘야 합니다.

트리거 섹션에서 트리거 유형(trigger type)을 드롭다운 메뉴를 눌러 태양(Sun)으로 선택합니다. 이제 해돋이(sunrise)와 해넘이(sunset) 중 해넘이로 선택합니다. 앞서 이야기한대로 해가 지기전에 불을 켜고 싶으므로 옵셋 값으로 `-00:30`을 입력합니다. 이 말은 해가 실제로 지기 전 30분에 자동화 트리거를 실행한다는 뜻입니다. 완벽하죠!

<p class='img'>
<img src='/images/getting-started/new-trigger.png'>
태양으로 해넘이 트리거를 생성
</p>

트리거를 설정한 다음 화면을 아래로 스크롤 하여 동작(action) 섹션으로 이동합니다. 동작 유형(action type)이 서비스 호출(call service)인지 확인하고 서비스 메뉴를 `light.turn_on`으로 변경합니다.  우리는 모든 전등을 켤 것이므로 서비스 데이(service data)에 다음과 같이 입력합니다:

```yaml
entity_id: all
```

<p class='img'>
<img src='/images/getting-started/action.png'>
전등을 켜는 새로운 자동화 동작(action)
</p>

우측 하단에 저장 아이콘으로 바뀐 오렌지 버튼을 눌러 자동화를 저장합니다. 이제 해가지기 30분 전에 집안의 전등을 켜는 놀라운 마법이 펼쳐집니다!

자동화에 대해 더 궁금하시다면:

- [레이군님의 자동화 강좌](https://cafe.naver.com/stsmarthome/12455)
- [트리거](/docs/automation/trigger/)
- [조건](/docs/automation/condition/)
- [동작](/docs/automation/action/)

### [다음 과정: 재실 감지 &raquo;](/getting-started/presence-detection/)
