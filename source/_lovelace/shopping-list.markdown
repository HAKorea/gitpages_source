---
title: "Shopping List Card"
sidebar_label: Shopping List
description: "The Shopping List Card allows you to add, edit, check-off, and clear items from your shopping list"
---

쇼핑 목록 카드를 사용하면 쇼핑 목록에서 항목을 추가, 편집, 확인 및 삭제할 수 있습니다.

[Shopping List Intent](/integrations/shopping_list/) 셋업이 미리 되어있어야 합니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_shopping_list_card.gif' alt='Screenshot of the shopping list card'>
쇼핑리스트 카드의 스크린 샷.
</p>

```yaml
type: shopping-list
```

{% configuration %}
type:
  required: true
  description: shopping-list
  type: string
title:
  required: false
  description: 쇼핑리스트의 제목
  type: string
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
{% endconfiguration %}

## 사례

제목 예시:

```yaml
type: shopping-list
title: Shopping List
```
