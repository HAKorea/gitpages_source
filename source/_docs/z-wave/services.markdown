---
title: "Z-Wave Services"
description: "Services exposed by the Z-Wave component."
---

`zwave` 통합구성요소의 도움으로 여러 서비스가 네트워크를 유지 노출합니다. 이 모든 것은 Z-Wave 제어판을 통해 사용할 수 있습니다.

| Service                | Description                                                                                                                                  |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| add_node               | Z-Wave 컨트롤러를 포함 모드로 설정하십시오. Z-Wave 네트워크에 새 장치를 추가할 수 있습니다.                                           |
| add_node_secure        | Z-Wave 컨트롤러를 보안 포함 모드로 설정하십시오. Z-Wave 네트워크와 안전하게 통신할 수 있는 새 장치를 추가할 수 있습니다.         |
| cancel_command         | 실행중인 Z-Wave 명령을 취소합니다. add_node 또는 remove_node 명령을 시작하고 수행하지 않기로 결정한 경우 이를 사용하여 포함/제외 명령을 중지해야합니다. |
| change_association     | Z-Wave 네트워크에서 연결 추가 또는 제거                                                                                          |
| heal_network           | 컨트롤러가 Z-Wave 네트워크를 "heal"하도록 지시합니다. 기본적으로 노드에게 컨트롤러에게 모든 인접 항목을 알려주어 컨트롤러가 최적의 라우팅을 재구성할 수 있도록합니다.             |
| heal_node              | 네트워크의 특정 노드를 "치유"하도록 컨트롤러에 지시합니다. `node_id`필드가 필요 합니다. `return_routes` 필드를 사용하여 리턴 경로 업데이트를 강제 실행할 수도 있습니다.
| print_config_parameter | Z-Wave 노드의 설정 매개 변수값을 (콘솔) 로그에 인쇄합니다.                                                                            |
| print_node             | Z-Wave 노드의 모든 상태를 인쇄하십시오.                                                                                                             |
| refresh_entity         | 종속값을 새로 고쳐 Z-Wave 엔티티를 새로 고칩니다.                                                                                    |
| refresh_node           | Z-Wave 노드를 새로 고칩니다.                                                                                                                     |
| refresh_node_value     | Z-Wave 노드의 지정된 값을 새로 고칩니다.                                                                                                |
| remove_node            | Z-Wave 컨트롤러를 제외 모드로 설정하십시오. Z-Wave 네트워크에서 장치를 제거할 수 있습니다.                                         |
| rename_node            | 노드 이름을 설정합니다. `node_id`와 `name` 필드가 필요합니다.                                                                                  |
| rename_value           | 값의 이름을 설정합니다. `node_id`, `value_id`,`name` 필드가 필요합니다.                                                                     |
| remove_failed_node     | 네트워크에서 실패한 노드를 제거하십시오. 노드는 컨트롤러의 실패한 노드 목록에 있어야합니다. 그렇지 않으면이 명령이 실패합니다.            |
| replace_failed_node    | 실패한 장치를 다른 장치로 교체하십시오. 노드가 컨트롤러의 실패한 노드 목록에 없거나 노드가 응답하면이 명령이 실패합니다. |
| reset_node_meters      | 노드의 미터값을 재설정하십시오. 노드가 이를 지원하는 경우에만 작동합니다.                                                                           |
| set_config_parameter   | 사용자가 구성 매개 변수를 노드로 설정할 수 있습니다. NOTE: Use the parameter option's `label` string as the `value` for list parameters (e.g., `"value": "Off"`). For all other parameters use the relevant integer `value` (e.g., `"value": 1`). 참고: 매개 변수 옵션의 `label` 문자열을 목록 매개 변수의 `value`로 사용하십시오 (예: `"value": "Off"`). 다른 모든 매개 변수의 경우 관련 정수 `value`을 사용하십시오 (예: `"value": 1`).|
| set_node_value         | Z-Wave 노드의 지정된 값을 설정하십시오.                                                                                                    |
| soft_reset             | 컨트롤러에 "soft reset"을 수행하도록 지시합니다. 이것은 데이터를 잃어 버려서는 안되지만 다른 컨트롤러는 "soft reset"명령과 다르게 동작할 수 있습니다. |
| start_network          | Z-Wave 네트워크를 시작합니다.                                                                                                                   |
| stop_network           | Z-Wave 네트워크를 중지합니다.                                                                                                                   |
| test_network           | 컨트롤러가 no-op 명령을 각 노드에 보내고 응답 시간을 측정하도록 지시합니다. 이론적으로 이는 “presumed dead"를 다시 가져올 수도 있습니다.             |
| test_node              | 컨트롤러에게 no-op 명령을 특정 노드로 보내도록 지시합니다. `node_id` 필드가 필요합니다. `messages` 필드로 지정하여 보낼 test_messages의 양을 지정할 수 있습니다. 이론적으로 이것은 "presumed dead"으로 표시된 노드를 다시 가져올 수 있습니다.

`soft_reset`과 `heal_network` 명령을 사용하면 Z-Wave 네트워크를 안정적으로 실행할 수 있습니다. 이것은 `zwave` 컴포넌트의 설정 옵션입니다. 이 옵션의 기본값은 `false`이지만 `autoheal`을 true로 설정하여 활성화할 수 있습니다. 그러나 다음 조치중 하나가 수행될 때마다 `heal_network`만 수행하면 되므로 피할 수 있는 오버헤드가 발생하기 때문에 이는 나쁜 습관입니다. : 

- Adding/Removing a new node
- Moving a node around
- Moving the Controller
- Removing a Dead Node

<div class='note'>

일부 Z-Wave 컨트롤러에서 `soft_reset` 기능을 사용하면 Z-Wave 네트워크가 중단될 수 있습니다.

</div>

`heal_network`를 트리거하기 위해 위의 조치중 하나가 발생할 때마다 GUI에서 *Settings -> Z-Wave Network Management -> Heal Network*를 사용할 수 있습니다.