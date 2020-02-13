---
title: "MQTT Publish service"
description: "Instructions on how to setup the MQTT Publish service within Home Assistant."
logo: mqtt.png
---

MQTT 연동은 MQTT topic으로에 메시지를 퍼블리싱하도록 `mqtt.publish` 서비스를 등록하게 됩니다. 페이로드를 지정하는 두 가지 방법이 있습니다.  하드코딩으로 만든 `payload`를 사용하던지 [template](/topics/templating/)을 사용해서 `payload_template`를 사용하는 방법으로 페이로드를 생성하여 렌더할 수 있습니다. 

### Service `mqtt.publish`

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `topic` | no | Topic to publish payload to.
| `payload` | yes | Payload to publish.
| `payload_template` | yes | Template to render as payload value. Ignored if payload given.
| `qos` | yes | Quality of Service to use.
| `retain` | yes | If message should have the retain flag set. (default: false)

<div class='note'>
payload 또는 payload_template 중 하나만 포함해야합니다.
</div>

```yaml
topic: home-assistant/light/1/command
payload: on
```

{% raw %}
```yaml
topic: home-assistant/light/1/state
payload_template: {{ states('device_tracker.paulus') }}
```
{% endraw %}

`payload` 문자열이어야합니다. JSON을 보내려면 다음같이 올바른 포맷/이스케이프를 지켜야합니다.:

```yaml
topic: home-assistant/light/1/state
payload: "{\"Status\":\"off\", \"Data\":\"something\"}"
``` 

`qos` 와 `retain`의 예시:

```yaml
topic: home-assistant/light/1/command
payload: on
qos: 2
retain: true
```
