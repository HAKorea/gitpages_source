---
title: Habitica(생활을 게임처럼)
description: Instructions on enabling Habitica support for your Home Assistant
logo: habitica.png
ha_category:
  - Hub
  - Sensor
ha_release: 0.78
ha_iot_class: Cloud Polling
---

이 통합구성요소를 통해 Habitica 프로필을 모니터링하고 관리 할 수 ​​있습니다. 이 통합구성요소는 [Habitica 's API](https://habitica.com/apidoc/)를 홈어시스턴트 서비스로 노출시킵니다. 여러 사용자를 지원하며 홈어시스턴트를 사용하여 습관 및 일상적인 작업을 확인하거나 마법을 캐스팅 할 수 있습니다.

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Sensor - 홈어시스턴트의 [Habitica](https://habitica.com/)에서 플레이어 데이터를 보고 모니터링 할 수 있습니다.

Habitica 구성 요소를 설정하면 센서가 자동으로 나타납니다.

통합구성요소를 사용하려면 다음 예제 설정을 사용해야합니다.

```yaml
# Minimum viable configuration.yaml entry
habitica:
  - api_user: YOUR_USER_ID
    api_key: YOUR_API_KEY
```

각 사용자에 대해 `api_user` 및 `api_key`를 제공하여 여러 사용자를 지정할 수 있습니다.
런타임에 각 사용자에 대해 Habitica의 사용자 이름으로 API를 사용할 수 있습니다.
`name` 키를 전달하여 이를 덮어쓸 수 있습니다. 이 값은 사용자 이름 대신 사용됩니다.
고유한 Habitica 인스턴스를 호스팅하는 경우 `url` 키로 URL을 지정할 수 있습니다.

{% configuration %}
api_user:
  description: "Habitica의 API 사용자 ID. 이 값은 [계정 설정](https://habitica.com/user/settings/api)에서 가져올 수 있습니다."
  required: true
  type: string
api_key:
  description: "Habitica의 API 비밀번호 (토큰). 'Show API Token'을 눌러 [계정 설정](https://habitica.com/user/settings/api)에서 이 값을 가져올 수 있습니다."
  required: true
  type: string
name:
  description: "Habitica의 사용자 이름을 재정의합니다. 서비스 요청에 사용됩니다"
  required: false
  type: string
  default: Deduced at startup
url:
  description: "직접 호스팅하는 경우 Habitica 인스턴스의 URL"
  required: false
  type: string
  default: https://habitica.com
sensors:
  description: 이 사용자를 위해 생성할 센서 목록. 이 항목을 지정하지 않으면 기본값(모든 센서)이 생성됩니다. 이 항목을 비워두면 센서가 생성되지 않습니다
  required: false
  type: list
  default: all (`name`, `hp`, `maxHealth`, `mp`, `maxMP`, `exp`, `toNextLevel`, `lvl`, `gp`, `class`)
{% endconfiguration %}

### API 서비스 매개 변수

API는 `habitica.api_call`이라는 서비스로 Home Assistant에 노출됩니다. 이를 호출하려면 서비스 데이터에서 이 키를 지정해야합니다.

| Service data attribute | Required | Type     |    Description  |
|----------------------|--------|--------|----------------|
|  `name`                |  yes     | string   |  Habitica's username as per `configuration.yaml` entry. |
| `path` | yes | [string] | Items from API URL in form of an array with method attached at the end. See the example below. |
| `args` | no | map | Any additional json or url parameter arguments. See the example below and [apidoc](https://habitica.com/apidoc/). |

이 서비스를 성공적으로 호출하면 'habitica_api_call_success'이벤트가 발생합니다.

| Event data attribute |  Type     |    Description  |
|----------------------|--------|----------------|
|  `name`                |   string   |  Copied from service data attribute. |
| `path` | [string] | Copied from service data attribute. |
| `data` | map | Deserialized `data` field of JSON object Habitica's server returned in response to api call. For more info see [docs](https://habitica.com/apidoc/). |

#### 서비스 호출 방법에 대한 몇 가지 예를 살펴 보겠습니다.

예를 들어, 사용자 `xxxNotAValidNickxxx`에 대해 각각 `api_user` 및 `api_key`로 구성된 `habitica` 플랫폼이 있다고 가정 해 봅시다.
Home Assistant를 통해 이 사용자에 대한 새 작업 (할 일)을 만들어 봅시다. 이를 위해 [API 호출](https://habitica.com/apidoc/#api-Task-CreateUserTasks)을 합니다.
새 작업을 만들려면 작업 속성이있는 json 객체로 POST 요청으로 `https://habitica.com/api/v3/tasks/user` 끝점(endpoint)에 도달해야합니다.
`habitica.api_call`에서 API를 호출해 봅시다.

* The `name` key becomes `xxxNotAValidNickxxx`.
* The `path` key is trickier.
  * Remove `https://habitica.com/api/v3/` at the beginning of the endpoint URL.
  * Split the remaining on slashes (/) and **append the lowercase method** at the end.
  * You should get `["tasks", "user", "post"]`. To get a better idea of the API you are recommended to try all of the API calls in IPython console [using this package](https://github.com/ASMfreaK/habitipy/blob/master/README.md).
* The `args` key is more or less described in the [docs](https://habitica.com/apidoc/).

Combining all together:
call `habitica.api_call` with data

```json
{
  "name": "xxxNotAValidNickxxx",
  "path": ["tasks", "user", "post"],
  "args": {"text": "Use API from Home Assistant", "type": "todo"}
}
```

이 호출은 `xxxNotAValidNickxxx`의 계정에 다음과 같이 `Use API from Home Assistant`이라는 텍스트로 새로운 할 일을 만듭니다.

![example task created](/images/screenshots/habitica_new_task.png)

또한 `habitica_api_call_success` 이벤트는 다음 데이터와 함께 시작됩니다.

```json
{
  "name": "xxxNotAValidNickxxx",
  "path": ["tasks", "user", "post"],
  "data": {
    "challenge": {},
    "group": {"approval": {"required": false,
     "approved": false,
     "requested": false},
    "assignedUsers": [],
    "sharedCompletion": "recurringCompletion"},
    "completed": false,
    "collapseChecklist": false,
    "type": "todo",
    "notes": "",
    "tags": [],
    "value": 0,
    "priority": 1,
    "attribute": "str",
    "text": "Use API from Home Assistant",
    "checklist": [],
    "reminders": [],
    "_id": "NEW_TASK_UUID",
    "createdAt": "2018-08-09T18:03:27.759Z",
    "updatedAt": "2018-08-09T18:03:27.759Z",
    "userId": "xxxNotAValidNickxxx's ID",
    "id": "NEW_TASK_UUID"}
}
```
