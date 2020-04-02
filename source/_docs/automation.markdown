---
title: "홈어시스턴트 자동화 만들기"
description: "Steps to help you get automation setup in Home Assistant."
---

Home Assistant는 광범위한 자동화 설정을 제공합니다. 이 섹션에서는 다양한 가능성과 옵션을 모두 안내합니다. 이 문서 외에도 자동화를 [공개적으로 제공](/cookbook/#example-configurationyaml)한 사람들도 있습니다 .

### 자동화 기초 (Automation basics)

계속해서 자신만의 자동화를 만들려면 기본사항을 익히는 것이 중요합니다. 이에 대해 알아보려면 다음 홈자동화 규칙의 예를 살펴 보겠습니다. :


```text
(trigger)    When Paulus arrives home
(condition)  and it is after sunset:
(action)     Turn the lights in the living room on
```

이 예제는 [trigger](/docs/automation/trigger/), [condition](/docs/automation/condition/), [action](/docs/automation/action/)의 세 부분으로 구성됩니다 .

첫 번째 줄은 자동화 규칙의 **trigger** 입니다. trigger는 자동화 규칙을 trigger해야하는 이벤트를 나타냅니다. 이 경우, 집에 도착한 사람으로, Home state가 'not_home'에서 'home'으로 바뀌는 Paulus의 상태를 확인하여 Home Assistant에서 관찰할 수 있습니다.

두 번째 줄은 **condition** 입니다. condition은 특정 사용사례에서만 작동하도록 자동화 규칙을 제한할 수 있는 선택적 테스트입니다. condition은 시스템의 현재 상태에 대해 테스트합니다. 여기에는 현재시간, 장치, 사람, 태양과 같은 다른 것들이 포함됩니다. 예를들어 해가 졌을 ​​때만 동작하게 하고 싶을 때입니다. 

세 번째 부분은 **action** 이며, 규칙이 트리거되고 모든 조건이 충족될 때 수행됩니다. 예를 들어 조명을 켜거나 온도조절장치의 온도를 설정하거나 씬(scene)을 활성화할 수 있습니다.

<div class='note'>
조건과 트리거의 차이점은 매우 유사하므로 혼동될 수 있습니다. 트리거는 액션을 보고 조건은 결과를 봅니다. : 조명을 켠 액션 vs 조명을 켠 결과.
</div>

### 내부 상태 탐색 (Exploring the internal state)

자동화 규칙은 Home Assistant의 내부 상태와 직접 상호 작용하므로 이에 익숙해져야합니다. Home Assistant는 개발자 도구를 통해 현재 상태를 표시합니다. 프런트엔드의 사이드 바 하단에 있습니다. <img src='/images/screenshots/developer-tool-states-icon.png' class='no-shadow' height='38' /> 아이콘은 현재 사용가능한 모든 상태를 표시합니다. 엔터티는 무엇이든 될 수 있습니다. 빛, 스위치, 사람, 심지어 태양. 상태는 다음과 같은 부분으로 구성됩니다.

| Name | Description | Example |
| ---- | ----- | ---- |
| Entity ID | 엔티티의 고유 식별자입니다. | `light.kitchen`
| State | 장치의 현재 상태입니다. | `home`
| Attributes | 장치 및/또는 현재 상태와 관련된 추가 데이터. | `brightness`

상태 변경은 trigger 소스로 사용될 수 있으며 현재 상태는 condition에서 사용될 수 있습니다.

Action은 서비스 호출에 관한 것입니다. 사용 가능한 서비스를 탐색하려면 <img src='/images/screenshots/developer-tool-services-icon.png' class='no-shadow' height='38' /> 서비스 개발자 도구를 여십시오. 서비스는 무엇이든 변경할 수 있습니다. 예를 들어 조명을 켜거나 스크립트를 실행하거나 씬을 활성화합니다. 각 서비스에는 도메인과 이름이 있습니다. 예를 들어 서비스 `light.turn_on`는 시스템의 모든 조명을 켤 수 있습니다. 예를들어 어떤 장치를 켜거나 어떤 색을 사용할지 알려주는 서비스를 매개변수로 전달할 수 있습니다.

### 자동화 초기 상태 (Automation initial state)

새 자동화를 만들 때 `initial_state: false`를 설정하지 않으면, UI/다른 자동화/개발자 도구를 통해 명시적으로 추가하거나 수동으로 끄지 않는 한 활성화 됩니다. Home Assistant가 시작될 때 자동화를 항상 활성화 혹은 비활성화해야 하는 경우 자동화에서 `initial_state`를 설정할 수 있습니다. 그렇지 않으면 이전 상태가 복원됩니다.

참고: 어떤 이유로 Home Assistant가 이전 상태를 복원할 수 없는 경우 자동화가 활성화됩니다. 

```text
automation:
- alias: Automation Name
  initial_state: false
  trigger:
  ...
```
