---
title: "Events"
description: "Describes all there is to know about events in Home Assistant."
redirect_from: /topics/events/
---

홈어시스턴트의 핵심구성은 Event bus입니다. Event bus를 통해 모든 통합구성요소가 Event를 발생시키거나 대기 할 수 있습니다. 이는 모든 것들의 핵심구성입니다. 예를 들어, 어떠한 상태 변경은 entity의 이전 상태 및 새로운 상태를 포함 하는 `state_changed`로서 event bus에 알립니다.

홈어시스턴트에는 다양한 구성요소(component) 사이를 조정하는 데 사용되는 몇 가지 기본제공 Event가 있습니다.

### Event `homeassistant_start`
설정에서 모든 통합구성요소가 초기화되면 `homeassistant_start` Event가 시작됩니다. 이는 `time_changed` Event들을 발생시키는 타이머를 시작하는 Event입니다.

<div class='note warning'>

  0.42부터는 더 이상 `homeassistant_start` Event를 들을 수 없습니다. 대신 'homeassistant' [platform](/docs/automation/trigger)을 사용하십시오.   

</div>

### Event `homeassistant_stop`
홈어시스턴트가 종료되면 `homeassistant_stop` Event가 시작됩니다. 연결을 닫거나 리소스를 줄이는 데 사용해야합니다.


### Event `state_changed`
상태가 변경되면 `state_changed` Event가 시작됩니다.  `old_state`와 `new_state` 모두 state object 입니다. [Documentation about state objects.](/topics/state_object/)

Field | Description
----- | -----------
`entity_id` | 변경된 entity의 entity ID입니다. 예: `light.kitchen`
`old_state` | entity가 변경되기 전, 이전 상태입니다. entity가 새로운 경우 필드는 생략됩니다.
`new_state` | entity의 새로운 상태. entity가 state 기기에서 제거되면이 필드는 생략됩니다..


### Event `time_changed`
`time_changed` Event는 타이머에 의해 1 초마다 발생하며 현재 시간을 포함합니다.

Field | Description
----- | -----------
`now` | UTC로 현재 시간을 포함 하는 [datetime object](https://docs.python.org/3.4/library/datetime.html#datetime.datetime) 입니다. 


### Event `service_registered`
`service_registered` Event는 홈어시스턴트에 새로운 서비스가 등록되면 이벤트가 시작됩니다

Field | Description
----- | -----------
`domain` | 서비스 도메인. 예 : `light`.
`service` | 호출 할 서비스입니다. 예: `turn_on`


### Event `call_service`
`call_service` Event 서비스 호출을 위해 이벤트 가 시작됩니다.

Field | Description
----- | -----------
`domain` | 서비스 도메인. 예 : `light`.
`service` | 호출 할 서비스입니다. 예: `turn_on`
`service_data` | 서비스 호출 매개 변수가있는 상세내용 예 :  `{ 'brightness': 120 }`.
`service_call_id` | unique 호출 ID를 가진 문자열입니다. 예 : `23123-4`.

### Event `service_executed`
`service_executed` Event 서비스가 처리되었음을 나타내기 위해 서비스 핸들러가 이벤트 를 발생시킵니다.

Field | Description
----- | -----------
`service_call_id` | 실행 된 서비스 호출의 unique 호출 ID가있는 문자열 예 :`23123-4`.

<div class='note warning'>

  0.84부터는 더 이상 `service_executed` 이벤트를 들을 수 없습니다 

</div>

### Event `platform_discovered`

[`discovery`](/integrations/discovery/)가 새 플랫폼을 발견하면 `platform_discovered`  Event 가 시작됩니다.  

Field | Description
----- | -----------
`service` | 발견된 플랫폼. 예 : `zwave`.
`discovered` |  발견된 정보를 포함하는 상세내용. 예 : `{ "host": "192.168.1.10", "port": 8889}`.


### Event `component_loaded`
통합구성요소가 로드되고 초기화되면 `component_loaded` Event가 시작됩니다.

Field | Description
----- | -----------
`component` | 방금 초기화 된 통합구성요소의 도메인. 예: `light`.