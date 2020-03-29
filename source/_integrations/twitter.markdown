---
title: 트위터(Twitter)
description: Instructions on how to add Twitter notifications to Home Assistant.
logo: twitter.png
ha_category:
  - Notifications
ha_release: 0.12
---

`twitter` 알림 플랫폼은 [Twitter](https://twitter.com)를 사용하여 Home Assistant에서 알림을 전달합니다.

## 셋업

Twitter에 등록된 개발자 계정이 있는지 확인한 다음 [Twitter Apps](https://apps.twitter.com/app/new)로 이동하여 응용 프로그램을 만드십시오. 개발자 계정이 없는 경우 신청해야하며 승인을 받는데 시간이 걸릴 수 있습니다. 자세한 내용을 보려면 "Keys and Access Tokens"을 방문하십시오 (Consumer Key, Consumer Secret, Access Token 및 Access Token Secret을 만드십시오).

## 설정

설치에 Twitter를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: twitter
    consumer_key: YOUR_API_KEY
    consumer_secret: YOUR_API_SECRET
    access_token: YOUR_ACCESS_TOKEN
    access_token_secret: YOUR_ACCESS_SECRET
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: "`notify`"
  type: string
consumer_key:
  description: Your Consumer Key (API Key) for the application.
  required: true
  type: string
consumer_secret:
  description: Your Consumer Secret (API Secret) for the application.
  required: true
  type: string
access_token:
  description: Your Access Token for the application.
  required: true
  type: string
access_token_secret:
  description: Your Access Token Secret for the application.
  required: true
  type: string
username:
  description: "Twitter handle without `@` or with `@` and quoting for direct messaging."
  required: false
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.