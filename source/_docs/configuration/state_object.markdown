---
title: "State Objects"
description: "Describes all there is to know about state objects in Home Assistant."
redirect_from: /topics/state_object/
---

장치는 홈어시스턴트에서 entity로 표시됩니다. entity는 다른 entity / 템플릿 / 프론트 엔드가 액세스 할 수 있도록 현재 상태를 상태 머신에 기록합니다. 상태는 현재 entity를 나타냅니다.

If you overwrite a state via the states dev tool or the API, it will not impact the actual device. If the device state is being polled, it will overwrite the state in the state machine the next polling.
dev 도구 또는 API를 통해 상태를 덮어 쓰면 실제 장치에 영향을 미치지 않습니다. 장치 상태가 폴링되는 경우 다음 폴링을 상태머신에 덮어 씁니다.

모든 상태는 항상 마지막으로 업데이트되고 마지막으로 변경되었을 때 항상 entity ID, 상태 및 타임 스탬프를 갖습니다.

Field | Description
----- | -----------
`state.state` | 엔터티의 현재 상태를 나타내는 문자열입니다. 예: `off`.
`state.entity_id` | 엔터티 ID. 형식 : `<domain>.<object_id>`. 예: `light.kitchen`.
`state.domain` | 엔터티의 도메인 예: `light`.
`state.object_id` | 엔터티의 개체 ID입니다. 예 : `kitchen`.
`state.name` | 엔터티의 이름입니다. 객체 ID로 대체되는 `friendly_name` 속성을 기반으로 합니다.  예: `Kitchen Ceiling`.
`state.last_updated` | 상태가 UTC 시간으로 상태 머신에 작성된 시간입니다. 속성을 포함하여 정확히 동일한 상태를 작성해도 이 필드가 업데이트되지는 않습니다. 예: `2017-10-28 08:13:36.715874+00:00`.
`state.last_changed` | 상태 머신에서 상태가 UTC 시간으로 변경된 시간입니다. 업데이트 된 속성 만있는 경우 업데이트되지 않습니다. 예 : `2017-10-28 08:13:36.715874+00:00`.
`state.attributes` | 현재 상태와 관련된 추가 속성이있는 상세정보입니다.

entity의 속성을 조정 선택할 수 있습니다. 특정 방식으로 entity를 표시하기 위해 홈어시스턴트가 사용하는 몇 가지 속성이 있습니다. 각 통합구성요소에는 entity에 대한 추가 상태 데이터를 나타내는 고유 한 특성도 있습니다. 예를 들어, 조명 통합에는 현재 밝기 및 조명 색상에 대한 속성이 있습니다. 속성을 사용할 수 없으면 홈어시스턴트는 해당 속성을 상태에 쓰지 않습니다.

템플릿을 사용할 때 이름별로 속성을 사용할 수 있습니다. 예: `state.attributes.sassumed_state`.

Attribute | Description
--------- | -----------
`friendly_name` | 엔터티의 이름입니다. 예 : `Kitchen Ceiling`.
`icon` | 프론트 엔드에서 entity에 사용할 아이콘입니다. 예 : `mdi:home`.
`entity_picture` | 도메인 아이콘을 표시하는 대신 사용해야하는 그림의 URL입니다. 예 : `http://example.com/picture.jpg`.
`assumed_state` | 현재 상태가 가정 인 경우 boolean입니다. [More info](/blog/2016/02/12/classifying-the-internet-of-things/#classifiers) 예: `True`.
`unit_of_measurement` | 상태를 나타내는 측정 단위입니다. 그래프를 그룹화하거나 엔터티를 이해하는 데 사용됩니다. 예 :  `°C`.
`hidden` | entity가 프론트 엔드에 표시되지 않아야하는 경우 boolean입니다. 예 : `true`. 이는 Lovelace UI에는 적용되지 않으며 이전 `states` UI 에만 관련이 있습니다.

속성에 공백이 있으면 다음과 같이 검색 할 수 있습니다: `states.sensor.livingroom.attributes["Battery numeric"]`.
