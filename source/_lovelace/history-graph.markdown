---
title: "History Graph 카드"
sidebar_label: History Graph
description: "History graph is a basic card, allowing you to display a graph for each of the entities in the list specified as config."
---

History Graph는 기본 카드이며, 설정에 지정된 목록의 각 엔티티에 대한 그래프를 표시할 수 있습니다.

<p class='img'>
<img src='/images/lovelace/lovelace_history_graph.png' alt='Screenshot of the history graph card for entities without a unit_of_measurement'>
센서에 'unit_of_measurement'가 정의되어 있지 않은 경우 History Graph 카드의 스크린샷.
</p>

<p class='img'>
<img src='/images/lovelace/lovelace_history_graph_lines.png' alt='Screenshot of the history graph card for entities with a unit_of_measurement'>
센서에 'unit_of_measurement'가 정의된 경우 History Graph 카드의 스크린샷.
</p>

{% configuration %}
type:
  required: true
  description: history-graph
  type: string
entities:
  required: true
  description: "엔터티 ID 또는 `entity` 개체 목록은 아래를 참조."
  type: list
hours_to_show:
  required: false
  description: 보여줄 시간. 최소값은 1 시간, 최대 80 시간.
  type: integer
  default: 24
refresh_interval:
  required: false
  description: 초 단위의 새로 고침 간격.
  type: integer
  default: 0
title:
  required: false
  description: 카드 제목.
  type: string
{% endconfiguration %}

## 엔티티 옵션 (Options For Entities)

엔티티를 문자열 대신 객체로 정의하면 사용자 정의와 설정을 더 추가할 수 있습니다. :

{% configuration %}
entity:
  required: true
  description: Home Assistant 엔티티 ID.
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어씁니다.
  type: string
{% endconfiguration %}

## 예시 

```yaml
type: history-graph
title: 'My Graph'
entities:
  - sensor.outside_temperature
  - entity: media_player.lounge_room
    name: Main player
```
