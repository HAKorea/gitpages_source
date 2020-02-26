---
title: "Light 카드"
sidebar_label: Light
description: "The Light card allows you to change the brightness of the light."
---

Light 카드를 사용하면 라이트의 밝기를 변경할 수 있습니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_light_card.png' alt='Screenshot of the Light card'>
Light 카드의 스크린 샷.
</p>

```yaml
type: light
entity: light.bedroom
```

{% configuration %}
type:
  required: true
  description: light
  type: string
entity:
  required: true
  description: 홈어시스턴트 Light 도메인 엔티티 ID.
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어 씁니다.
  type: string
  default: 엔터티 이름
theme:
  required: false
  description: 내 테마로 설정 `themes.yaml`.
  type: string
{% endconfiguration %}

## 사례

이름 덮어 쓰기 예 :

```yaml
type: light
entity: light.bedroom
name: Kids Bedroom
```

```yaml
type: light
entity: light.office
name: My Office
```

<p class='img'>
<img src='/images/lovelace/lovelace_light_complex_card.png' alt='Screenshot of the Light card'>
Light 카드 이름의 스크린 샷..
</p>
