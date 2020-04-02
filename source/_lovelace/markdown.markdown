---
title: "Markdown 카드"
sidebar_label: Markdown
description: "Markdown card is used to render markdown"
---

Markdown 카드는 [Markdown](https://commonmark.org/help/) 렌더링을 사용합니다. 

렌더러는 [Marked.js](https://marked.js.org)를 사용하며, CommonMark, GitHub Flavored Markdown(GFM)과 `markdown.pl`을 포함한 [Markdown의 여러 스펙](https://marked.js.org/#/README.md#specifications) 을 지원합니다.
 	 

<p class='img'>
<img src='/images/lovelace/lovelace_markdown.png' alt='Screenshot of the markdown card'>
Markdown 카드의 스크린 샷.
</p>

{% configuration %}
type:
  required: true
  description: markdown
  type: string
content:
  required: true
  description: "[Markdown](https://commonmark.org/help/) 렌더링을 할 컨텐츠. [templates](/docs/configuration/templating/)을 포함할 수 있습니다."
  type: string
title:
  required: false
  description: 카드 제목.
  type: string
  default: none
card_size:
  required: false
  type: integer
  default: none
  description: "템플릿을 포함하는 경우 보기좋게 카드를 Lovelace에 배치하는 알고리즘에 Markdown 카드에 문제가 있을 수 있습니다. 이 값을 사용하여 카드 높이를 50 픽셀 단위 (기본 크기의 경우 대략 3 줄의 텍스트)로 추정할 수 있습니다. (예: `4`)."
entity_id:
  required: false
  type: [string, list]
  default: none
  description: "`content:`의 템플릿이 이러한 엔티티의 상태 변경에만 반응하는 엔티티 ID 목록입니다. 자동 분석에서 모든 관련 엔티티를 찾지 못하면 사용할 수 있습니다."
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
{% endconfiguration %}

## 사례

```yaml
type: markdown
content: >
  ## Lovelace

  Starting with Home Assistant 0.72, we're experimenting with a new way of defining your interface. We're calling it the **Lovelace UI**.
```

## 템플릿 변수

특별한 템플릿 변수 - `config`는 카드의 `content`에 대해 설정합니다. 여기에 카드 설정이 포함되어 있습니다.

예시 : 
{% raw %}
```yaml
type: entity-filter
entities:
  - light.bed_light
  - light.ceiling_lights
  - light.kitchen_lights
state_filter:
  - 'on'
card:
  type: markdown
  content: |
    The lights that are on are:
    {% for l in config.entities %}
      - {{ l.entity }}
    {%- endfor %}

    And the door is {% if is_state('binary_sensor.door', 'on') %} open {% else %} closed {% endif %}.
```
{% endraw %}
