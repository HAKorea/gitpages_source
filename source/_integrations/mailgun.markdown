---
title: 메일건(Mailgun)
description: Instructions on how to add Mailgun mail notifications to Home Assistant.
logo: mailgun.png
ha_category:
  - Notifications
ha_release: 0.38
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/BmEj3EBo0vg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Mailgun에서 웹 후크를 수신하려면 웹에서 홈어시스턴트 인스턴스에 액세스할 수 있어야하고 ([Hass.io instructions](/addons/duckdns/)) HTTP 연동([docs](/integrations/http/#base_url))을 위해 `base_url`을 설정해야합니다.

설정하려면 설정 화면의 통합구성요소 페이지로 이동하여 Mailgun을 찾으십시오. 설정을 클릭하십시오. 화면의 지시 사항에 따라 Mailgun을 설정하십시오.

다음 형식의 URL이 제공됩니다.: `https://<home-assistant-domain>/api/webhook/9940e99a26fae4dcf6fe0a478124b6b58b578ea4c55c9a584beb1c9f5057bb91`. 
Mailgun에서 웹 후크를 수신하려면 Mailgun 제어판의 Webhook 탭에서 해당 URL을 콜백 URL로 제공해야합니다.

현재홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Notifications](#notifications).

## 설정

```yaml
# Example configuration.yaml entry
mailgun:
  domain: EXAMPLE.COM
  api_key: YOUR_API_KEY
```

{% configuration %}
domain:
  description: This is the domain name to be used when sending out mail. Needs to be the first custom domain you have set up.
  required: true
  type: string
api_key:
  description: This is the API token that has been generated in your Mailgun account.
  required: true
  type: string
sandbox:
  description: "(**Deprecated**) Whether to use the sandboxed domain for outgoing mail. Since the `domain` item is required, it should be set to the sandbox domain name, so this isn't needed."
  required: false
  default: false
  type: boolean
{% endconfiguration %}

Mailgun에서 들어오는 이벤트는 Home Assistant에서 이벤트로 사용할 수 있으며 `mailgun_message_received` 로 시작됩니다. [Mailgun에서 지정한 데이터](https://documentation.mailgun.com/en/latest/api-events.html#event-structure)가 이벤트 데이터로 사용 가능합니다. 이 이벤트를 사용하여 자동화를 트리거 할 수 있습니다.

그런 후 다음 자동화를 통해 해당 정보를 사용할 수 있습니다.

```yaml
automation:
  trigger:
    platform: event
    event_type: mailgun_message_received
    event_data:
      action: call_service
  action:
    service: light.turn_on
    entity_id: light.office
```

## 알림(Notifications)

Mailgun 알림 서비스를 사용하면 Mailgun의 REST API를 통해 이메일을 보낼 수 있습니다. [Mailgun 구성 요소](#configuration)를 설정해야합니다.

### 알림 설정

```yaml
# Example configuration.yaml entry
notify:
  - name: mailgun
    platform: mailgun
    recipient: CHANGE@EXAMPLE.COM
```

{% configuration %}
domain:
  description: This is the domain name to be used when sending out mail.
  required: true
  type: string
sandbox:
  description: "(**Deprecated**) If a sandboxed domain is used, specify it in `domain`."
  required: false
  default: false
  type: boolean
api_key:
  description: This is the API Key that has been generated in your Mailgun account.
  required: true
  type: string
recipient:
  description: The email address of the recipient.
  required: true
  type: string
sender:
  description: The sender's email address.
  required: false
  default: "`hass@DOMAIN`, where `DOMAIN` is the outgoing mail domain, as defined by the `domain` configuration entry."
  type: string
{% endconfiguration %}

### 자동화 사례

다음 자동화는 두 개의 첨부 파일이 포함된 이메일을 발송하여 이벤트에 반응합니다.

```yaml
# Example automation using Mailgun notifications
automation:
  trigger:
    platform: event
    event_type: SPECIAL_EVENT
  action:
    service: notify.mailgun
    data:
      title: "Something special has happened"
      message: "This a test message from Home Assistant"
      data:
        images:
          - /home/pi/pic_test1.png
          - /home/pi/pic_test2.png
```
