---
title: 보안로그(Logentries)
description: Send events to Logentries.
logo: logentries.png
ha_category:
  - History
ha_release: 0.13
---

`logentries` 통합구성요소는 Logentries Webhook 엔드 포인트를 사용하여 모든 상태 변경을 [Logentries](http://logentries.com/)에 기록할 수 있게합니다.

Open the **Add a Log** page and choose **Manual**. Enter a name for your log in **Log Name**, add a group in **Select Log Set**, set **Token TCP - logs are identified by a token.** and press **Create Log Token**. The generated token is required for the Home Assistant configuration.

설치에서 `logentries` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
logentries:
  token: TOKEN
```

{% configuration %}
token:
  description: The token for the log to use.
  required: true
  type: string
{% endconfiguration %}
