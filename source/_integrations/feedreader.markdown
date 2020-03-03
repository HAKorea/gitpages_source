---
title: Feed 읽어오기
description: Instructions on how to integrate RSS feeds into Home Assistant.
logo: rss.gif
ha_category:
  - Other
ha_release: 0.18
---

매시간 피드를 폴링하고 새로운 항목을 이벤트 버스로 보내는 RSS/Atom 피드 리더를 추가하십시오.

RSS 피드를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
feedreader:
  urls:
    - https://www.home-assistant.io/atom.xml
    - https://github.com/blog.atom
    - https://hasspodcast.io/feed/podcast
```

{% configuration %}
  urls:
    description: 피드의 URL 목록.
    required: true
    type: list
  scan_interval:
    description: 피드의 업데이트 간격을 정의.
    required: false
    default: 1 hour
    type: time
  max_entries:
    description: 각 피드에서 추출 할 최대 항목 수.
    required: false
    default: 20
    type: integer
{% endconfiguration %}

다음 설정 예는 업데이트 간격 및 최대 항목 수를 설정하는 방법을 보여줍니다.

```yaml
# Example configuration.yaml entry with optional parameters
feedreader:
  urls:
    - https://www.home-assistant.io/atom.xml
    - https://github.com/blog.atom
    - https://hasspodcast.io/feed/podcast
  scan_interval:
    minutes: 30
  max_entries: 5
```

Feedreader 이벤트를 즉시 사용하여 자동화 작업을 트리거 할 수 있습니다. 다음예를 살펴보십시오. :

```yaml
automation:
  - alias: Trigger action when new element(s) in RSS feed
    trigger:
      platform: event
      event_type: feedreader
    action:
      service: script.turn_on
      entity_id: script.my_action
```

```yaml
automation:
  - alias: Send notification of RSS feed title when updated
    trigger:
      platform: event
      event_type: feedreader
    action:
      service: persistent_notification.create
      data_template:
        title: "New HA Podcast available"
        message: {% raw %}"New Podcast available - {{ as_timestamp(now()) | timestamp_custom('%I:%M:%S %p %d%b%Y', true) }}"{% endraw %}
        notification_id: {% raw %}"{{ trigger.event.data.title }}"{% endraw %}
```

피드에서 `<entry>` 태그 아래의 모든 필드를 사용할 수 있습니다. 예를 들어 `trigger.event.data.content`는 피드 항목의 본문을 가져옵니다.

고급 사용 사례의 경우 `feedreader` 이벤트 유형에 등록된 사용자 지정 연동을 대신 사용할 수 있습니다.

```python
EVENT_FEEDREADER = "feedreader"
hass.bus.listen(EVENT_FEEDREADER, event_listener)
```

커스텀 컴포넌트 개발을 시작하려면 [developers](/developers) 문서를 참조하십시오

Feedreader의 패키지 전체 예제를 삭제하려면 [PodCast notifier](https://github.com/CCOSTAN/Home-AssistantConfig/blob/master/config/packages/hasspodcast.yaml)를 사용할 수 있습니다.