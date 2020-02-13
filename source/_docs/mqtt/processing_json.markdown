---
title: "JSON 처리"
description: "Instructions on how to process the MQTT payload."
logo: mqtt.png
---

MQTT [switch](/integrations/switch.mqtt/) 및 [sensor](/integrations/sensor.mqtt/) 플랫폼은 MQTT 메시지를 통한 JSON 처리 및 JSONPath를 사용하여 구문 분석을 지원합니다. JSONPath를 사용하면 JSON에서 사용할 값이 있는 위치를 지정할 수 있습니다. 다음 예제는 항상 `100` 값을 반환합니다

| JSONPath query | JSON |
| -------------- | ---- |
| `somekey` | `{ 'somekey': 100 }`
| `somekey[0]` | `{ 'somekey': [100] }`
| `somekey[0].value` | `{ 'somekey': [ { value: 100 } ] }`

이를 사용하려면 다음 키를 추가하십시오  `configuration.yaml`:

```yaml
switch:
  platform: mqtt
  state_format: 'json:somekey[0].value'
```
값 템플릿을 사용하여 JSON 값을 추출 할 수도 있습니다. :

```yaml
switch:
  platform: mqtt
  value_template: '{% raw %}{{ value_json.somekey[0].value }}{% endraw %}'
```

전체 JSONPath 구문에 대한 자세한 내용은 [in their documentation](https://github.com/kennknowles/python-jsonpath-rw#jsonpath-syntax)를 참조.
