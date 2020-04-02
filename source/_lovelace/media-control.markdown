---
title: "Media Control 카드"
sidebar_label: Media Control
description: "The media controller card is used to display Media Player entities on an interface with easy to use controls. "
---

Media Control 카드는 사용하기 편리한 제어 화면으로 [Media Player](/integrations/#search/media-player) 엔티티를 표시하는데 사용됩니다.

<p class='img'>
<img src='/images/lovelace/lovelace_mediaplayer.png' alt='Screenshot of the media player control card'>
Media Control 카드의 스크린샷.
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
