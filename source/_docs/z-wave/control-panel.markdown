---
title: "Z-Wave 제어판"
description: "How to use the Z-Wave control panel."
redirect_from: /getting-started/z-wave-panel/
---

<div class='note'>

  메뉴바에 **설정** 메뉴가 표시되지 않으면 Z-Wave 메뉴를 찾을 수 있습니다 ([여기 참조](/integrations/config/)).

</div>

Z-Wave 엔티티의 이름 바꾸기는 이제 다른 엔티티와 동일한 [사용자 정의 옵션](/docs/configuration/customizing-devices/)을 사용하여 수행됩니다.

## Z-Wave 네트워크 관리

네트워크에서 Z-Wave 장치를 [포함하기와 제외하기](/docs/z-wave/adding/)위한 곳입니다.

* **Add Node** 컨트롤러를 포함 모드로 전환하여 장치를 Z-Wave 네트워크에 포함(추가)할 수 있습니다
* **Add Node Secure** 컨트롤러를 보안 포함 모드로 전환합니다 ([보안 키](/docs/z-wave/adding#sdding-security-devices)를 생성해야합니다)
* **Remove Node** 컨트롤러를 제외 모드로 전환하므로 장치를 제외(제거)할 수 있습니다. 다른 네트워크에 추가된 비보안 장치를 제외할 수 있습니다.
* **Cancel Command** 위의 중 하나를 취소

* **Heal Network** 컨트롤러가 Z-Wave 네트워크를 "heal"하도록 지시합니다. 기본적으로 노드에게 컨트롤러에게 모든 인접 항목을 알려주도록하여 컨트롤러가 최적의 라우팅을 재계산할 수 있도록합니다.
* **Start Network** Z-Wave 네트워크를 시작합니다.
* **Stop Network** Z-Wave 네트워크를 중지합니다.
* **Soft Reset** "soft reset"을 컨트롤러에 지시합니다. 데이터가 손실되지는 않지만 다른 컨트롤러는 "soft reset" 명령과 다르게 동작할 수 있으며 Z-Wave 네트워크가 중단될 수 있습니다.
* **Test Network** 컨트롤러가 no-op 명령을 각 노드에 보내고 응답 시간을 측정하도록 지시합니다. 이론적으로 이는 "사망한 것으로 추정된" 노드를 다시 가져올 수도 있습니다.
* **Save Config** 네트워크의 현재 캐시를 zwcfg_[home_id].xml에 저장합니다.

## Z-Wave 노드 관리

* **Refresh Node** 노드와 해당 엔티티에 대한 정보를 새로 고칩니다. 배터리 구동 장치에서 사용하는 경우 장치가 작동하려면 먼저 깨워야합니다.
* **Remove Failed Node** 이는 네트워크에서 실패한 노드를 제거합니다. 노드는 컨트롤러의 Failed Node List ( `is_failed: true`로 표시)에 있어야합니다. 그렇지 않으면이 명령이 실패합니다. *개발자 도구* 아래 *상태* 메뉴에서 `zwave` 엔티티를 선택하고 `"is_failed": false,`를 `"is_failed": true,`로 변경하여 OpenZWave가 노드가 실패했다고 생각하도록 속일 수 있습니다. *상태 설정*을 선택하십시오.
* **Replace Failed Node** 이는 고장난 장치를 다른 장치로 교체합니다. 노드가 컨트롤러의 실패한 노드 목록에 없거나 노드가 응답하면 이 명령이 실패합니다.
* **Print Node** Z-Wave 노드의 모든 상태를 콘솔 로그에 출력합니다

* **Heal Node** 노드 복구 시작. (인접 목록 업데이트와 반환 경로 업데이트)

* **Test Node** no_op 테스트 메시지를 노드로 보냅니다. 이는 이론적으로 죽은 노드를 다시 가져올 수 있습니다.

* **Node Information** 이는 노드에 대한 정보가 있는 Z-Wave 엔티티 카드가 표시됩니다. :

*  **averageRequestRTT** 노드로 전송된 요청의 평균 왕복시간(RTT)(밀리 초)입니다. 예를들어 250의 값은 1/4입니다.
*  **averageResponseRTT** 요청에 대한 응답의 평균 왕복시간
*  **battery_level** *Battery powered devices only* - 배터리 잔량 (가장 가까운 10 자리로 반올림될 수 있음)
*  **capabilities** 장치 기능의 쉼표로 구분된 목록
*  **friendly_name** 표시하도록 지정한 이름
*  **is_awake** 장치가 깨어 있는지 여부
*  **is_failed** 장치가 실패한 것으로 표시되어 있는지 여부. 컨트롤러는 고장난 장치에 연결을 시도하지 않습니다.
*  **is_info_received** 컨트롤러가 노드로부터 노드 정보를 수신하면 True입니다.
*  **is_ready** 네트워크(또는 홈 어시스턴트)를 시작하면 모든 장치가 준비되기까지 약간의 시간이 걸리며 아직 준비되지 않은 장치가 표시됩니다.
*  **is_zwave_plus** 모든 Z-Wave Plus 장치에 해당 (컨트롤러는 Plus 장치인지 여부에 상관없이 항상 *false*를 보고함)
*  **lastRequestRTT** 마지막 요청의 왕복 시간
*  **lastResponseRTT** 마지막 요청에 대한 응답의 왕복 시간
*  **manufacturer_name** OpenZWave에서 제공한 제조업체 이름
*  **max_baud_rate** 장치가 지원하는 최대 대역폭, 대부분의 최신 장치는 40,000 이상을 지원합니다
*  **node_id** 이 노드의 고유 노드 ID
*  **node_name** 이 노드의 기본 이름으로, 이 노드의 모든 엔티티의 엔티티 ID를 빌드하는데 사용됩니다.
*  **product_name** OpenZWave에서 제공한 장치의 제품 이름
*  **query_stage** 이 장치의 쿼리 단계 (자세한 내용은 [여기](/docs/z-wave/query-stage/) 참조)
*  **receivedCnt** 장치에서 받은 메시지 수
*  **receivedDups** 장치에서 받은 중복 메시지 수
*  **receivedTS** 장치에서 마지막 메시지를 받은 날짜와 시간
*  **receivedUnsolicited** 요청하지 않은 메시지 수
*  **retries** 이 노드로 메시지를 보내려고 재시도한 횟수
*  **sentCnt** 노드로 전송된 메시지 수
*  **sentFailed** 전송되지 않은 메시지 수
*  **sentTS** 마지막 메시지가 노드로 전송된 날짜와 시간
*  **wake_up_interval** *Battery powered devices only* - 장치의 웨이크업 간격 (초)

<div class='note'>
Z-Wave 제어판을 사용하여 설정을 업데이트하려면 배터리로 작동하는 장치를 깨워야합니다. 장치를 깨우는 방법은 장치마다 다르며 일부 장치는 몇 초 동안만 깨어 있습니다. 자세한 내용은 장치 설명서를 참조하십시오.
</div>

#### 노드의 엔티티들

이 노드의 모든 엔티티를 선택할 수 있는 드롭 다운입니다. 선택하면 다음을 사용할 수 있습니다.

* **Refresh Entity** 해당 엔티티의 값만 새로 고침
* **Entity Information** 해당 엔티티의 속성(예: 이름, 노드의 ID 등)을 표시.

여기서 장치가 업데이트 자체를 보내지 않기 때문에 컨트롤러가 변경 사항을 인식하도록 장치를 폴링이 필요한 것으로 표시할 수 있습니다. 과도한 폴링은 Z-Wave 네트워크를 손상시킬 수 있으므로 [polling](/docs/z-wave/devices/#polling)에 대한 정보를 참조하십시오.

**Polling intensity**는 이 장치가 폴링되는 폴링 간격수를 나타냅니다. 예를 들어, 2를 설정하면 매 2 초 간격으로 폴링됩니다.

Home Assistant에서 Z-Wave 장치를 제외할 수도 있습니다. Z-Wave 네트워크에 있어야하는 장치가 있지만 Home Assistant에 표시하지 않으려는 경우 이를 수행 할 수 있습니다. 혹은 실패한 장치가 있으면 이를 제외할 수 없습니다.

### 노드 값들

선택한 노드의 사용 가능한 값 목록과 인스턴스를 포함합니다.

### 노드 그룹 연결 (Node group associations)

장치가 *Association* 명령 클래스를 지원하는 경우 장치를 다른 장치와 연결할 수 있습니다. OpenZWave는 장치가 컨트롤러와 자동으로 연결되어 장치가 *Hail* 명령 클래스를 지원하지 않을 때 즉시 업데이트를 제공합니다. 

이를 사용하여 한 장치가 다른 장치를 직접 제어할 수 있습니다. 이 기능은 주로 조명이나 스위치를 작동 시키거나 여러 장치를 하나로 작동시키려는 리모컨에 유용합니다.

다른 목적으로 사용되는 여러 그룹이 있을 수 있습니다. 장치 설명서에 각 그룹의 용도가 설명되어 있습니다.

#### 방송 그룹 (Broadcast group)

일부 Z-Wave 장치는 방송 노드 (노드 255)와 연결될 수 있습니다. 도어를 열거나 (또는 ​​모션 센서를 트리거하여) 조명이 켜지고 도어를 닫거나 (또는 ​​모션 센서가 깨끗해지면) 조명이 꺼지는 경우 이러한 상황이 발생했는지 알 수 있습니다. 대상 노드를 선택하여 이를 제거할 수 있습니다. 그룹에 노드 255가 있으면 *Remove broadcast* 단추가 나타납니다. `zwave.change_association` 서비스를 사용할 수도 있습니다 :

```json
{"association": "remove", "node_id": 3, "group": 1, "target_node_id": 255}
```

그러면 node_id 3과 장치의 연결 그룹 1에서 브로드 캐스트 그룹이 제거됩니다.

### 노드 설정 옵션 (Node config options)

장치의 *wakeup* 간격 (초)을 설정할 수 있습니다. 이는 현재 주 전원이 공급 되더라도 배터리로 작동할 수 있는 모든 장치에 대해 표시됩니다. 웨이크업 간격은 해당 장치에 배터리 전원이 공급되는 경우에만 적용됩니다. 

<div class='note'>
웨이크업 간격은 장치의 센서 변경보고 기능에 영향을 미치지 않습니다. 이는 Z-Wave 칩이 컨트롤러와 얼마나 자주 체크인 하는지를 나타냅니다. 이 활동은 센서 변경보고와 비교할 때 많은 배터리 전력을 소비하며,이를 줄이면 장치의 배터리 수명이 단축됩니다.
</div>

그 아래에서 현재 설정을 확인하기 위해 지원되는 설정 매개 변수를 선택할 수 있습니다. 그런 다음 이를 변경하고 **Set Config Parameter**을 선택하여 업데이트하십시오. 배터리 전원 장치는 다음에 깨어날 때 업데이트됩니다.

### 노드 보호 (Node protection)

노드에 보호 명령 클래스가 있는 경우 노드의 보호 수준을 변경할 수 있습니다.
이 설정의 사용 방법은 제조업체마다 다르므로 장치 설명서를 확인하십시오.
**Set Protection** 버튼을 눌러 새로운 선택을 설정하십시오.

## 노드 사용자 코드 (Node user codes)

노드에 사용자 코드가 있는 경우 이를 설정하고 삭제할 수 있습니다. 형식은 raw 16 진 ASCII 코드입니다. 입력 아래에 실제 코드가 표시됩니다. 일반 노드의 경우 다음과 같습니다.
```yaml
\x30 = 0
\x31 = 1
\x32 = 2
\x33 = 3
\x34 = 4
\x35 = 5
\x36 = 6
\x37 = 7
\x38 = 8
\x39 = 9
```
태그 리더와 같은 일부 비호환 장치는 원시 16 진 코드를 사용하도록 구현되었습니다.
16 진수 ASCII 표를 참조하여 코드를 설정하십시오. 예: http://www.asciitable.com/

다음은 command line에서 숫자를 취하는 것보다 작은 Python 프로그램입니다. 그리고 호환 장치에 맞는 올바른 순서를 출력합니다. : 

```python
#! /usr/bin/python3
import sys

translations = {}

for x in range(0, 10):
    translations["%s" % x] = "\\x3%s" % x

for c in sys.argv[1]:
    print(translations[c], end="")
```

## OZW Log

로그 끝에서 일부 행만 검색하려는 경우 선택 필드를 사용하여 해당 행을 지정할 수 있습니다. 최대값은 마지막 1000 줄이고 최소값은 0이며 전체 로그와 같습니다. 이를 지정하지 않으면 전체 로그를 검색합니다. 
정적 로그가 있는 새 창을 열려면 **Load**를 선택하십시오.
새 창을 열려면 로그의 마지막 지정된 행이있는 테일링 로그와 함께 **tail**를 선택하십시오. 이는 자체 업데이트 창입니다.