---
title: 씽스피크(ThingSpeak)
description: Record one entity in ThingSpeak
logo: thingspeak.png
ha_category:
  - History
ha_release: 0.32
---

`thingspeak` 통합구성요소는 홈어시스턴트가 [ThingSpeak API](https://thingspeak.com/)와 통신하게합니다.
지금은 정확히 한번에 하나의 엔티티를 기록하므로 테스트 목적으로 유용합니다. 장기 저장소의 경우 [InfluxDB component](/integrations/influxdb/)에 의존해야합니다.

## 설정

ThingSpeak에서 [new channel](https://thingspeak.com/channels/new)을 생성하고 사용하려는 채널의 "API Keys"탭에서 Write API Key를 가져와야합니다.

설치시 ThingSpeak 통합을 설정하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
thingspeak:
  api_key: MY_API_KEY
  id: 1337
  whitelist: sensor.yr_temperature
```

{% configuration %}
api_key:
  description: Your ThingSpeak Channel Write API key.
  required: true
  type: string
id:
  description: The ID of your desired ThingSpeak channel.
  required: true
  type: integer
whitelist:
  description: The name of the entity whose states should be sent to the channel.
  required: true
  type: string
{% endconfiguration %}
