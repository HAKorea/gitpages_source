---
title: "Iframe Card"
sidebar_label: Iframe
description: "Embed data from other webservices in your dashboard."
---

대시 보드에 다른 웹 서비스의 데이터를 임베드합니다. `<config-directory>/www` 폴더에 저장된 파일을 임베드하고 `/local/<file>`를 사용하여 참조 할 수도 있습니다.

<div class='note warning'>
홈 어시스턴트에 HTTPS를 사용하는 경우 HTTP를 사용하여 사이트를 임베드할 수 없습니다.
</div>

<p class='img'>
  <img width="500" src='/images/lovelace/lovelace_iframe.png' alt='Windy weather radar as iframe'>
  iframe으로 Windy Weather 레이더.
</p>

{% configuration %}
type:
  required: true
  description: iframe
  type: string
url:
  required: true
  description: 웹 사이트 주소.
  type: string
aspect_ratio:
  required: false
  description: 높이 너비 비율.
  type: string
  default: "50%"
title:
  required: false
  description: 카드 제목.
  type: string
{% endconfiguration %}

### 사례

```yaml
type: iframe
url: https://grafana.localhost/d/000000027/worldping-endpoint-summary?var-probe=All&panelId=2&fullscreen&orgId=3&theme=light
aspect_ratio: 75%
```
