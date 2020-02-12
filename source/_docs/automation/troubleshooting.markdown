---
title: "자동화 문제 해결"
description: "Tips on how to troubleshoot your automations."
redirect_from: /getting-started/automation-troubleshooting/
---

(설정 디렉토리 내의 `homeassistant.log`)와 [Logbook](/integrations/logbook/)을 모두 보고 자동화 규칙이 올바르게 초기화되고 있는지 확인할 수 있습니다. 실시간 로그에는 초기화되는 규칙이 표시됩니다. (각 트리거마다 한 번씩). 예 :

```text
INFO [homeassistant.components.automation] Initialized rule Rainy Day
INFO [homeassistant.components.automation] Initialized rule Rainy Day
INFO [homeassistant.components.automation] Initialized rule Rainy Day
INFO [homeassistant.components.automation] Initialized rule Rain is over
```

자동화가 트리거되면 logbook 통합구성요소에 라인 항목이 표시됩니다. 이전 항목을 보고 규칙에서 어떤 트리거가 이벤트를 트리거했는지 확인할 수 있습니다.

![Logbook example](/images/integrations/automation/logbook.png)

[template]: /topics/templating/

### 자동화 테스트

자동화를 테스트하는 것은 일반적으로 어려운 작업이며, 특히 여러 트리거와 일부 조건이 포함 된 경우에 특히 그러합니다.

프론트 엔드에서 자동화 **트리거** 를 클릭하면 홈어시스턴트 가 해당 **`action` 파트 만 실행** 합니다. 즉 , 트리거 또는 조건 부분을 그런 식으로 테스트 **할 수 없습니다**.  자동화에서 트리거의 일부 데이터를 사용하는 t경우, 이 시나리오에서 `trigger`가 정의되지 않았기 때문에 제대로 작동하지 않는다는 것을 의미합니다. 

이로 인해 트리거 기능이 디버깅 목적으로 매우 제한적이고 거의 쓸모가 없으므로 다른 방법을 찾아야합니다. 
자동화 트리거, 조건 및 액션에서 적절한 예를 확인하고 상황에 맞게 조정하십시오.

홈어시스턴트를 재시작하기 전에 **Configuration** -> **Server Control** 로 가서 **Check Config** 버튼을 클릭하여 문법상 에러가 없을을 확인하는 것 또한 유용합니다. **Check Config**가 보여지게 하기 위해선, **Advanced Mode**를 유저 프로파일에서 활성화시켜야 합니다. 

자동화가 어느 부분에서든 템플릿을 사용하는 경우 다음을 수행하여 예상대로 작동하는지 확인할 수 있습니다. : 

1. **Developer tools** 이동 -> **Template** 탭.
2. [this](https://www.home-assistant.io/docs/configuration/templating/#processing-incoming-data) 단락의 끝에 설명 된대로 템플리트에 필요한 모든 변수 (소스)를 작성하십시오
3. 템플릿 코드를 복사하여 변수 바로 다음에 템플릿 편집기에 붙여 넣습니다.
4. 필요한 경우 소스 값을 변경하고 템플릿이 원하는대로 작동하고 오류가 발생하지 않는지 확인하십시오.
