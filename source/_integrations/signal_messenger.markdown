---
title: 보안 메신저(Signal Messenger)
description: Instructions on how to integrate Signal Messenger within Home Assistant.
logo: signal_messenger.png
ha_category:
  - Notifications
ha_release: 0.104
ha_codeowners:
  - '@bbernhard'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/46ozjP-R2-E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`signal_messenger` 통합구성요소는 [Signal Messenger REST API](https://github.com/bbernhard/signal-cli-rest-api)를 사용하여 Home Assistant에서 Android 또는 iOS 장치로 알림을 전달합니다.

참고: [Signal Messenger 안드로이드](https://play.google.com/store/apps/details?id=org.thoughtcrime.securesms&hl=ko)

## 셋업
 
기본 요구 사항:

- Signal Messenger REST API를 설정해야합니다.
- Signal Messenger 서비스에 등록하려면 여분의 전화 번호가 필요합니다.


Signal Messenger REST API를 설정하려면 해당 [지침](https://github.com/bbernhard/signal-cli-rest-api/blob/master/doc/HOMEASSISTANT.md)을 따르십시오.

## 설정

홈어시스턴트로 Signal Messenger 알림을 보내려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry for Signal Messenger 
notify:
  - name: signal
    platform: signal_messenger
    url: "http://127.0.0.1:8080" # the URL where the Signal Messenger REST API is listening 
    number: "YOUR_PHONE_NUMBER" # the sender number
    recipients: # one or more recipients
      - "RECIPIENT1"
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  type: string
  default: notify
url:
  description: The URL where the Signal Messenger REST API listens for incoming requests. 
  required: true
  type: string
number:
  description: The sender number.
  required: true
  type: string
recipients:
  description: A list of recipients.
  required: true
  type: string
{% endconfiguration %}

## 사례

이 통합구성요소를 사용하는 방법에 대한 몇 가지 예.

### 텍스트 메시지

```yaml
...
action:
  service: notify.NOTIFIER_NAME
  data:
    message: "That's an example that sends a simple text message to the recipients specified in the configuration.yaml"
```

### 첨부자료와 테스트 메시지

```yaml
...
action:
  service: notify.NOTIFIER_NAME
  data:
    message: "Alarm in the living room!"
    data:
      attachment: "/tmp/surveillance_camera.jpg"
```
