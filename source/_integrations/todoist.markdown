---
title: 투두이스트(Todoist)
description: Instructions on how to integrate Todoist into Home Assistant.
logo: todoist.png
ha_category:
  - Calendar
ha_iot_class: Cloud Polling
ha_release: 0.54
ha_codeowners:
  - '@boralyl'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/b390o1Qj-I8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 플랫폼을 사용하면 [Todoist Projects](https://todoist.com)에 연결하고 이진 센서를 생성할 수 있습니다. 각 개별 프로젝트마다 다른 센서가 생성되거나 설정한 기준과 일치하는 "custom" 프로젝트를 지정할 수 있습니다 (아래에서 자세히 설명). 이 센서는 해당 프로젝트로 인해 작업이 있는 경우 `on` 또는 프로젝트의 모든 작업이 완료되었거나 프로젝트에 전혀 작업이 없는 경우 `off`가 됩니다.

### 전제 조건

Todoist API 토큰을 결정해야합니다. 이는 매우 간단합니다. [Todoist 설정 페이지의 통합 섹션](https://todoist.com/Users/viewPrefs?page=authorizations)으로 이동하여 페이지 하단에서 "API token"이라는 섹션을 찾으십시오. 해당 토큰을 복사하여 설정 파일에서 사용하십시오.

### 기본 설정

홈어시스턴트에 Todoist를 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
calendar:
  - platform: todoist
    token: YOUR_API_TOKEN
```

{% configuration %}
token:
  description: The API token used to authorize Home Assistant to access your projects. Above you have more info about it.
  required: true
  type: string
custom_projects:
  description: Details on any "custom" binary sensor projects you want to create.
  required: false
  type: list
  keys:
    name:
      description: The name of your custom project. Only required if you specify that you want to create a custom project.
      required: true
      type: string
    due_date_days:
      description: Only include tasks due within this many days. If you don't have any tasks with a due date set, this returns nothing.
      required: false
      type: integer
    include_projects:
      description: Only include tasks in these projects. Tasks in all other projects will be ignored.
      required: false
      type: list
    labels:
      description: Only include tasks with at least one of these labels (i.e., this works as an `or` statement).
      required: false
      type: list
{% endconfiguration %}

### Custom 프로젝트

사용자 정의 프로젝트를 만드는 것은 매우 쉽고 강력합니다. 기본 Todoist 프로젝트를 실행하기 위해서는 API 토큰만 있으면 되지만 원하는 경우 더 깊이 갈 수 있습니다. 예를 들면 다음과 같습니다.

```yaml
# Example configuration.yaml entry
calendar:
  - platform: todoist
    token: YOUR_API_TOKEN
    custom_projects:
      - name: 'All Projects'
      - name: 'Due Today'
        due_date_days: 0
      - name: 'Due This Week'
        due_date_days: 7
      - name: 'Math Homework'
        labels:
          - Homework
        include_projects:
          - Mathematical Structures II
          - Calculus II
```

(`!secret`의 기능에 대한 자세한 내용은 [여기](/docs/configuration/secrets/)를 참조하십시오. -- Todoist에만 해당되는 것이 아니며 API 키와 암호를 좀 더 안전하게 유지할 수 있습니다!)

보시다시피, 여기 4 개의 커스텀 프로젝트가 있습니다 :

- 이 계정의 *모든* 작업을 포함하는 프로젝트.

- 오늘 예정된 이 계정의 *모든* 작업을 포함하는 프로젝트. 

- 다음주 내에 이 계정의 *모든* 작업을 포함하는 프로젝트 .

- 2개의 프로젝트만 고려하여 “Homework”이라는 레이블이 있는 모든 것을 포함하는 프로젝트.

이러한 속성을 혼합하여 일치시켜 모든 종류의 사용자 정의 프로젝트를 만들 수 있습니다. [IFTTT](https://ifttt.com/todoist)를 사용하여 특정 레이블이 있는 작업을 만든 다음 해당 레이블이 있는 작업이 발생할 때 홈어시스턴트가 일종의 자동화를 수행하도록 할 수도 있습니다.

홈어시스턴트는 [각 프로젝트에서 어떤 작업이 "가장 중요한" 지 결정하기 위해 최선을 다 하며](https://github.com/home-assistant/home-assistant/blob/master/homeassistant/components/todoist/calendar.py), 그 상태가 보고된 작업입니다. `all_tasks` 배열을 통해 곧 다른 작업에 액세스할 수 있습니다 (아래 참조).

### Sensor 속성

 - **offset_reached**: 사용되지 않습니다.

 - **all_day**: 보고된 작업에 기한이없는 경우 `True`. 기한이 설정되어 있으면 `False`.

 - **message**: 이 프로젝트에서 “가장 중요한” 과제의 제목.

 - **description**: Todoist 웹 사이트에서 작업을 가리키는 URL.

 - **location**: 사용되지 않습니다.

 - **start_time**: Todoist 연동이 마지막으로 업데이트된 시간입니다. 일반적으로 지난 15 분 이내

 - **end_time**: 작업 마감일.

- **all_tasks**: 이 프로젝트의 모든 작업 목록은 가장 중요한 것부터 가장 중요하지 않은 것으로 정렬됩니다.

- **priority**: 우선 순위 Todoist는 이 작업을 가지고 있다고 보고합니다. 1은 가장 낮은 우선 순위를 의미하고 4는 가장 높은 우선 순위를 의미합니다. 이는 Todoist 앱에 표시되는 방식의 **반대**입니다!

- **task_comments**: 이 작업에 추가된 의견.

- **task_labels**: 이 작업과 관련된 모든 레이블.

- **overdue**: 보고된 작업이 마감일이 지났는지 여부.

- **due_today**: 보고된 작업이 오늘 예정인지 여부.

### 서비스

Todoist에는 서비스에 대한 액세스도 제공됩니다(`todoist.new_task`). 이 서비스는 새로운 Todoist 작업을 만드는데 사용할 수 있습니다. 레이블과 프로젝트를 지정하거나 비워둘 수 있으며 작업은 "Inbox" 프로젝트로 이동합니다.

다음은 동일한 작업을 수행하는 두 개의 JSON 페이로드 예제입니다.

```json
{
    "content": "Pick up the mail",
    "project": "Errands",
    "labels":"Homework,School",
    "priority":3,
    "due_date":"2017-09-12 14:00"
}
```

```json
{
    "content": "Pick up the mail",
    "project": "Errands",
    "labels":"Homework,School",
    "priority":3,
    "due_date_string":"tomorrow at 14:00",
    "due_date_lang":"en"
}
```

- **content** (*Required*): 만들려는 작업의 이름.

- **project** (*Optional*): 작업을 넣을 프로젝트.

- **labels** (*Optional*): 작업에 추가하려는 모든 레이블을 쉼표로 구분.

- **priority** (*Optional*): 1-4의 태스크 우선 순위. 다시 말하지만 1은 가장 중요하지 않으며 4는 가장 중요합니다.

- **due_date_string** (*Optional*): [natural language](https://support.todoist.com/hc/en-us/articles/205325931-Dates-and-Times)로 과제가 예정된 시점. `due_date`와 상호배타적

- **due_date_lang** (*Optional*): `due_date_string`이 설정되면 언어를 설정할 수 있습니다. 사용가능한 언어들 : `en`, `da`, `pl`, `zh`, `ko`, `de`, `pt`, `ja`, `it`, `fr`, `sv`, `ru`, `es`, `nl`

- **due_date** (*Optional*): 작업 기한이 YYYY-MM-DD 포맷 또는 YYYY-MM-DD HH:MM 포맷이어야합니다. `due_date_string`과 상호배타적입니다.

(현재) 홈어시스턴트를 통해 수행한 작업을 표시할 수있는 방법이 없습니다. 작업 이름은 반드시 고유하지 않아도 되므로 잘못된 작업을 닫는 상황에 처할 수 있습니다.