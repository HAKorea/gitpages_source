---
title: "Media Control Card"
sidebar_label: Media Control
description: "The media controller card is used to display Media Player entities on an interface with easy to use controls. "
---

미디어 컨트롤 카드는 사용하기 쉬운 컨트롤이 있는 인터페이스에 [Media Player](/integrations/#search/media-player) 엔티티를 표시하는 데 사용됩니다 .

<p class='img'>
<img src='/images/lovelace/lovelace_mediaplayer.png' alt='Screenshot of the media player control card'>
미디어 플레이어 제어 카드의 스크린 샷.
</p>

{% configuration %}
type:
  required: true
  description: media-control
  type: string
entity:
  required: true
  description: "미디어 플레이어 `entity_id`."
  type: string
{% endconfiguration %}

## 예시

```yaml
type: media-control
entity: media_player.lounge_room
```
