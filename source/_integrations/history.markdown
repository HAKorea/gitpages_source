---
title: 히스토리(History)
description: Instructions on how to enable history support for Home Assistant.
logo: home-assistant.png
ha_category:
  - History
ha_release: pre 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`history` 통합구성요소는 홈어시스턴트 내에서 동작하고 있는 모든 것을 추적하고 사용자들이 이를 통해 탐색할 수 있습니다. 
데이터를 저장하는 `recorder` component에 따라 다르며 동일한 데이터베이스 세팅을 사용합니다.
만일 기록에서 제외된 항목이 있으면 해당 항목에 대한 기록을 사용할 수 없습니다.

설정에서 [`default_config:`](https://www.home-assistant.io/integrations/default_config/)를 비활성화하거나 제거하지 않은 경우 본 통합구성요소는 기본적으로 활성화됩니다. 
이럴 경우 다음 예는 통합구성요소를 수동으로 활성화하는 방법입니다.:

```yaml
# Basic configuration.yaml entry
history:
```

<p class='img'>
  <a href='{{site_root}}/images/screenshots/component_history_24h.png'>
    <img src='{{site_root}}/images/screenshots/component_history_24h.png' />
  </a>
</p>

<div class='note'>
이벤트는 로컬 데이터베이스에 저장됩니다. 구글 그래프는 그래프를 그리는데 사용됩니다.
브라우저에서 그래프가 로컬로 100 % 생성된 것이며, 데이터는 언제든지 누구에게도 전송되지 않습니다. 
</div>

{% configuration %}
exclude:
  description: 노출되지 **않을** 장치
  required: false
  type: map
  keys:
    entities:
      description: History에서 제외할 엔티티 ID 목록.
      required: false
      type: list
    domains:
      description: History에서 제외할 도메인 목록.
      required: false
      type: list
include:
  description: 나타낼 장치를 설정.
  required: false
  type: map
  keys:
    entities:
      description: History에서 포함할 엔티티 ID 목록.
      required: false
      type: list
    domains:
      description: History에 포함될 도메인 목록.
      required: false
      type: list
{% endconfiguration %}

`include` 또는 `exclude`이 설정에 없으면 해당 날짜에 History의 모든 엔티티 (`hidden` entity들 혹은 `scenes`은 절대 나타나지 않습니다.)에 대한 그래프가 표시됩니다. 일부 엔티티들만 나타내게 하고싶다면 엔티티의 몇 가지 옵션이 있습니다. :
도메인과 엔티티를 `exclude`(소위 블랙리스트)로 정의하십시오. 이는 기본적으로 표시된 정보에 만족한다면 그냥 써도 되지만, 일부 엔티티 또는 도메인을 제거하려는 경우에 편리합니다. 보통은 (`weblink` 같은) 혹은 거의 변화가 없는 (`updater` 혹은 `automation`) 경우에 해당 합니다.

```yaml
# Example configuration.yaml entry with exclude
history:
  exclude:
    domains:
      - automation
      - weblink
      - updater
    entities:
      - sensor.last_boot
      - sensor.date
```

`include` 설정(소위 whitelist)을 사용하여 도메인과 엔티티들을 정의하십시오. 만일 시스템에 많은 엔티티들이 있고 `exclude` 리스트가 점점 더 커지면, 도메인이나 엔티티들을 `include`로 정의하는 것이 좋습니다. 

```yaml
# Example configuration.yaml entry with include
history:
  include:
    domains:
      - sensor
      - switch
      - media_player
```

`include` 목록을 사용하여 표시할 엔티티/도메인들을 정의하고 목록에서 일부를 `exclude` 목록을 써서 제외시키십시오. 
예를 들어 `sensor` 도메인을 포함시키지만 특정 센서를 제외하려는 경우 이 방법이 적합합니다. 
모든 센서 엔터티를 `include` `entities` 목록에 추가하는 대신 센서 도메인을 포함시키고 관심없는 센서 엔터티를 제외시키면 됩니다. 설정에서 `include` `entities` 설정된 순서대로 표시합니다. 그렇지 않으면 표시 순서는 임의대로 나타납니다.

```yaml
# Example configuration.yaml entry with include and exclude
history:
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

센서 표시 순서가 포함된 엔티티 목록에 나열된 방식을 따르도록하려면,
`use_include_order` flag를 true 로 설정할 수 있습니다.

```yaml
# Example configuration.yaml entry using specified entity display order
history:
  use_include_order: true
  include:
    entities:
      - sun.sun
      - light.front_porch
```

#### 구현 세부 사항

`recoder` 통합구성요소가 다르게 설정되지 않는 한, history는 설정 디렉토리 내의 `home-assistant_v2.db`로 SQLite 데이터베이스에 저장됩니다

 - events 테이블은 record 통합구성요소가 실행되는 동안 발생한 `time_changed`를 제외한 모든 event들 입니다.
 - states 테이블은 `state_changed` 이벤트의 값의 모든 `new_state`를 포함합니다. 
 - states 테이블 안에는 다음 내용이 있습니다. :
   - `entity_id`: 엔티티의 entity_id
   - `state`: 엔티티의 상태
   - `attributes`: state attributes의 JSON
   - `last_changed`: state가 마지막으로 변경된 timestamp. 속성이 변경되면 state_changed 이벤트가 발생할 수 있습니다.
   - `last_updated`: 변경사항 timestamp (state, attributes)
   - `created`: 해당 항목이 데이터베이스에 삽입된 timestamp.

`history` 통합구성요소가 states 테이블을 쿼리할 때, 해당 쿼리는 상태가 변경된 states만을 선택합니다. : `WHERE last_changed=last_updated`

#### On dates

SQLite 데이터베이스는 native 날짜를 지원하지 않습니다. 그렇기 때문에 유닉스 시대 이후 모든 날짜가 초 단위로 저장됩니다. 
[this site](https://www.epochconverter.com/) 혹은 Python을 사용하여 수동으로 변경하십시오. :

```python
from datetime import datetime

datetime.fromtimestamp(1422830502)
```

#### API

History 정보는 [RESTful API](/developers/rest_api/#get-apihistory)를 통해서 사용할 수도 있습니다. 
