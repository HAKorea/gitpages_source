---
title: 클릭센드 TTS(ClickSend TTS)
description: Instructions on how to add ClickSend text-to-speech (TTS) notifications to Home Assistant.
logo: clicksend.png
ha_category:
  - Notifications
ha_release: 0.55
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/puuK07yPbsw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`clicksend_tts` 플랫폼은 [ClickSend](https://clicksend.com)를 사용하여 Home Assistant에서 TTS (text-to-speech) 알림을 전달합니다.

[ClickSend Dashboard](https://dashboard.clicksend.com) 섹션으로 이동하여 새 프로젝트를 작성하십시오. 프로젝트를 만든 후에는 `username`과 `api_key`를 얻을 수 있습니다.

ClickSend를 설치에 추가하려면 Home Assistant `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
notify:
  - platform: clicksend_tts
    username: CLICKSEND_USERNAME
    api_key: CLICKSEND_API_KEY
    recipient: PHONE_NO
```

{% configuration %}
name:
  description: Setting the optional parameter name allows multiple notifiers to be created. The notifier will bind to the service notify.NOTIFIER_NAME.
  required: false
  default: ClickSend
  type: string
username:
  description: Your username.
  required: true
  type: string
api_key:
  description: Your API Key.
  required: true
  type: string
recipient:
  description: Recipient phone number. This is the phone number that you want to call and notify via TTS (e.g., `09171234567`).
  required: true
  type: string
caller:
  description: Caller phone number. This is the phone number that you want to be the TTS call originator (e.g., `09181234567`). If not defined the recipient number is used.
  required: false
  type: string
language:
  description: The language you want to use to convert the message to audio. Accepted values are found in the [ClickSend Documentation](http://docs.clicksend.apiary.io/#reference/voice/voice-languages).
  required: false
  default: en-us
  type: string
voice:
  description: The voice that needs to be used to play the message to the recipient. Allowed values are `female` or `male`.
  required: false
  default: female
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.