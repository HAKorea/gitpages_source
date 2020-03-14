---
title: 로그북(logbook)
description: Instructions on how to enable the logbook integration for Home Assistant.
logo: logbook.png
ha_category:
  - History
ha_release: 0.7
---

<img src='/images/screenshots/logbook.png' style='margin-left:10px; float: right;' height="100" />

로그북 통합구성요소는 집에 발생한 모든 변경 사항을 역순으로 표시하여 집의 History에 대한 다른 관점을 제공합니다.
데이터 저장은 `recorder` 통합구성요소가 담당합니다. 즉, [`recorder`](/integrations/recorder/) 통합구성요소가 MySQL 또는 PostgreSQL을 데이터 저장소로 사용하도록 설정된 경우, `logbook` 통합구성요소는 기본 SQLite 데이터베이스를 사용하여 데이터를 저장하지 않습니다.

설정에서 [`default_config :`](https://www.home-assistant.io/integrations/default_config/)행을 비활성화하거나 제거하지 않는 한 이 통합구성요소는 기본적으로 활성화됩니다. 이 경우 다음 예는 이 통합구성요소를 수동으로 활성화하는 방법을 보여줍니다. :

```yaml
# Example configuration.yaml entry
logbook:
```

{% configuration %}
exclude:
  description: "로그북 항목을 생성하지 **않아야** 하는 연동을 설정"
  required: false
  type: map
  keys:
    entities:
      description: 로그북 항목 작성에서 제외할 엔티티 ID 목록.
      required: false
      type: list
    domains:
      description: 로그북 항목 작성에서 제외 할 도메인 목록.
      required: false
      type: list
include:
  description: 로그북 항목을 작성해야하는 연동 설정.
  required: false
  type: map
  keys:
    entities:
      description: 로그북 항목 작성에 포함될 엔티티 ID 목록.
      required: false
      type: list
    domains:
      description: 로그북 항목 작성에 포함될 도메인 목록.
      required: false
      type: list
{% endconfiguration %}

로그북에서 일부 엔티티 또는 도메인의 메시지를 제외하려는 경우
다음과 같이`exclude` 매개 변수를 추가하십시오. :


```yaml
# Example of excluding domains and entities from the logbook
logbook:
  exclude:
    entities:
      - sensor.last_boot
      - sensor.date
    domains:
      - sun
      - weblink
```

특정 엔티티 또는 도메인의 메시지를 보려는 경우 `include` 설정 :

```yaml
# Example to show how to include only the listed domains and entities in the logbook
logbook:
  include:
    domains:
      - sensor
      - switch
      - media_player
```

`include` 목록을 사용하고 `exclude` 목록으로 일부 엔티티 또는 도메인을 필터링 할 수도 있습니다. 
일반적으로 포함(include) 구문에서 도메인을 정의하고 특정 엔티티를 필터링하는 경우 이 방법이 적합합니다.

```yaml
# Example of combining include and exclude configurations
logbook:
  include:
    domains:
      - sensor
      - switch
      - media_player
  exclude:
    entities:
      - sensor.last_boot
      - sensor.date
```

### 제외 이벤트 (Exclude Events)

숨겨진 사용자 정의 엔티티는 기본적으로 로그북에서 제외됩니다. 
그러나 때로는 로그북이 아닌 UI에 엔티티를 표시하고자 할 때가 있을 것입니다. 
예를 들어`sensor.date`를 사용하여 UI에 현재 날짜를 표시합니다.
하지만 매일 해당 센서에 대한 로그북 항목을 원하지 않습니다.
이러한 엔티티를 제외하려면 로그북 설정의 `exclude` > `entities`목록에 해당 엔티티를 추가하십시오 .

전체 도메인에서 모든 이벤트를 제외하려면 `exclude` > `domain` 목록에 해당 이벤트를 추가 하십시오.
예를 들어 `azimuth`(방위각) 도메인 속성에서 자동화를 트리거하기 위해 `sun` 도메인만 사용하면 sun rise 및 sun set에 대한 로그 항목에 관심이 없을 수 있습니다.

### 사용자 정의 항목 (Custom Entries)

스크립트 구성 요소를 사용하여 이벤트를 발생 시켜서 로그북에 사용자 정의 항목을 추가 할 수 있습니다.

```yaml
# Example configuration.yaml entry
script:
  add_logbook_entry:
    alias: Add Logbook
    sequence:
      - service: logbook.log
        data_template:
          name: Kitchen
          message: is being used
          # Optional
          entity_id: light.kitchen
          domain: light
```
