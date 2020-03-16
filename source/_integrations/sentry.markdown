---
title: 센트리(Sentry)
description: Record errors to Sentry.
logo: sentry.svg
ha_category:
  - System Monitor
ha_iot_class: Cloud Polling
ha_release: 0.104
ha_config_flow: true
ha_codeowners:
  - '@dcramer'
---

<div class='note warning'>
  
  무료 Sentry 계정은 매월 5000 개의 이벤트를 허용합니다. Sentry로 전송되는 이벤트의 양에 따라 Sentry 계정을 업그레이드하거나 홈어시스턴트에서 Sentry로 데이터가 흐르지 않는 기간이 있어야합니다.
  
</div>

`sentry` 통합구성요소는 [Sentry](https://sentry.io/)와 연동되어 홈어시스턴트에서 처리되지 않은 예외뿐만 아니라 기록된 오류를 모두 캡처합니다.

## 설정

설치에서 `sentry` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sentry:
  dsn: SENTRY_DSN
```

{% configuration %}
dsn:
  description: The DSN provided to you by Sentry.
  required: true
  type: string
environment:
  description: An environment name to associate with events.
  required: false
  type: string
{% endconfiguration %}

### DSN 받기

Follow these steps to get the DSN:
- Go to **Projects**.
- Click **Create project**.
- Fill out **Give your project a name** and **choose Assign a Team** fields and click Create project button.
- Click **Get your DSN** link in top of the page.
- Your DSN is now visable and looks like https://sdasdasdasdsadsadas@sentry.io/sdsdfsdf
