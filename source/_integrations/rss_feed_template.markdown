---
title: RSS 피드 템플릿
description: Use this integration to generate RSS feeds showing your latest data.
logo: home-assistant.png
ha_category:
  - Front End
ha_release: 0.44
ha_quality_scale: internal
---

`rss_feed_template` 통합구성요소는 Home Assistant의 모든 정보를 정적 RSS 피드로 내보낼 수 있습니다. RSS 리더를 사용하여 여러 유형의 장치에 해당 정보를 표시하는데 사용할 수 있습니다. 홈어시스턴트용 기본앱은 널리 사용되지 않지만 기본 RSS 리더는 거의 모든 플랫폼에 존재합니다. 

예를 들어, Android에서는 "Simple RSS Widget"앱을 사용하여 홈화면에 온도를 표시할 수 있습니다.

```yaml
# Example configuration.yaml entry
rss_feed_template:
  # Accessible on <Home Assistant url>/api/rss_template/garden
  # Example: https://localhost:8123/api/rss_template/garden
  garden:
    requires_api_password: false
    title: "Garden {% raw %}{{ as_timestamp(now())|timestamp_custom('%H:%M', True) }}{% endraw %}"
    items:
    - title: "Outside temperature"
      description: "{% raw %}{% if is_state('sensor.temp_outside','unknown') %}---{% else %}{{states('sensor.temp_outside')}} °C{% endif %}{% endraw %}"
```

{% configuration %}
requires_api_password:
  description: If true and an API password is set, the password must be passed via '?api_password=...' parameter. 
  required: false
  default: true
  type: boolean
feed_id:
  description: "The key is used as the ID of the feed. The feed can be accessed at /api/rss_template/feed_id (example: 'garden')."
  required: true
  type: string
title:
  description: The title of the feed, which is parsed as [template](/topics/templating/).
  required: false
  type: template
items:
  description: A list of feed items.
  required: true
  type: list
  keys:
    title:
      description: The title of the item, which is parsed as [template](/topics/templating/).
      required: false
      type: template
    description:
      description: The description of the item, which is parsed as [template](/topics/templating/).
      required: false
      type: template
{% endconfiguration %}
