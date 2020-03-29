---
title: 트윌리오(Twilio)
description: Instructions on how to add Twilio notifications to Home Assistant.
logo: twilio.png
ha_category:
  - Hub
ha_release: '0.40'
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/JCjzEKdlezk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`twilio` 통합구성요소는 SMS를 통해 알림을 전송하고 [Twilio](https://twilio.com)를 통해 전화통화를 생성할 수 있습니다.

무료 평가판 계정은 [Twilio](https://twilio.com) 웹 사이트에서 확인된 전화 번호로 무료 통화를 제공합니다.
통화는 10 분으로 제한되며 메시지가 실행되기 전에 짧은 평가판 메시지를 재생합니다. 업그레이드된 계정에는 제한이 없습니다.

## 설정

이 알림 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
twilio:
  account_sid: ACCOUNT_SID_FROM_TWILIO
  auth_token: AUTH_TOKEN_FROM_TWILIO
```

{% configuration %}
account_sid:
  description: "Your Twilio Account SID which can be found in your [console](https://www.twilio.com/console). It starts with the letters `AC`."
  required: true
  type: string
auth_token:
  description: "Your Twilio AUTH TOKEN which can be found in your [console](https://www.twilio.com/console). It should be directly under where you found the `account_sid`."
  required: true
  type: string
{% endconfiguration %}

### 사용법

기본 Twilio 구성 요소를 설정한 후 [twilio SMS](/integrations/twilio_sms) 및 [twilio Phone](/integrations/twilio_call) 통합구성요소 중 하나 혹은 둘 다를 추가하고 설정하여 알림 기능을 활용하십시오.

Twilio에서 이벤트를 수신하려면 웹에서 홈어시스턴트 인스턴스에 액세스할 수 있어야하고 ([Hass.io instructions](/addons/duckdns/)) HTTP 연동을 위해 `base_url`을 설정해야합니다 ([문서](/integrations/http/# base_url)).

설정하려면 설정 화면의 통합구성요소 페이지로 이동하여 Twilio를 찾으십시오. 설정을 클릭하십시오. 화면의 지시사항에 따라 Twilio를 설정하십시오.

다음 형식의 URL이 제공됩니다. : `https://<home-assistant-domain>/api/webhook/9940e99a26fae4dcf6fe0a478124b6b58b578ea4c55c9a584beb1c9f5057bb91`. 인바운드 이벤트를 생성하려면 [Twilio](https://www.twilio.com/docs/glossary/what-is-a-webhook)를 사용하여 웹 후크를 설정해야합니다.

Twilio에서 들어오는 이벤트는 Home Assistant에서 이벤트로 사용할 수 있으며 `twilio_data_received`로 시작됩니다. Twilio가 지정한 데이터는 이벤트 데이터로 사용 가능합니다. 이 이벤트를 사용하여 자동화를 트리거할 수 있습니다.

그런 후 다음 자동화를 통해 해당 정보를 사용할 수 있습니다. : 

```yaml
automation:
  trigger:
    platform: event
    event_type: twilio_data_received
    event_data:
      action: call_service
  action:
    service: light.turn_on
    entity_id: light.office
```
