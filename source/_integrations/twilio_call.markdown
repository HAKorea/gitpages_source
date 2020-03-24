---
title: 트윌리오 콜(Twilio Call)
description: Instructions on how to add user notifications to Home Assistant.
logo: twilio.png
ha_category:
  - Notifications
ha_release: 0.37
ha_codeowners:
  - '@robbiet480'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/JCjzEKdlezk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`twilio_call` 알림 플랫폼은 [Twilio](https://twilio.com)에서 제공하는 음성을 통해 알림을 보낼 수 있습니다.
전달된 메시지는 TTS (텍스트 음성 변환) 서비스에서 읽습니다.

요구 사항은 [Twilio](/integrations/twilio/)를 설정해야합니다.

설치시 이 알림 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: twilio_call
    from_number: E164_PHONE_NUMBER
```

{% configuration %}
from_number:
  description: "An [E.164](https://en.wikipedia.org/wiki/E.164) formatted phone number, like +14151234567. See [Twilio's guide to formatting phone numbers](https://www.twilio.com/help/faq/phone-numbers/how-do-i-format-phone-numbers-to-work-internationally) for more information."
  required: true
  type: string
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: "`notify`"
  type: string
{% endconfiguration %}

### Usage

Twilio는 알림 플랫폼이므로 알림 서비스 [as described here](/integrations/notify/)를 호출하여 제어 할 수 있습니다. 알림 **target**의 모든 E.164 전화 번호로 알림을 보냅니다. `from_number`에 대해서는 위의 참고 사항을 참조하십시오

```yaml
# Example automation notification entry
automation:
  - alias: The sun has set
    trigger:
      platform: sun
      event: sunset
    action:
      service: notify.twilio_call
      data:
        message: 'The sun has set'
        target:
          - +14151234567
          - +15105555555
```
