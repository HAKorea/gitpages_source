---
title: 엘라마랩 오토메이트(LlamaLab Automate)
description: Instructions on how to add user notifications to Home Assistant.
logo: llamalab_automate.png
ha_category:
  - Notifications
ha_release: 0.27
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/i53Yd30TFrU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`llamalab_automate` 플랫폼은 Google 클라우드 메시징 서비스를 사용하여 Home Assistant에서 LlamaLab [Automate](https://llamalab.com/automate/) 앱을 실행하는 Android 기기로 메시지를 푸시합니다. 이것은 Tasker + AutoRemote의 대안으로 사용될 수 있습니다.

[https://llamalab.com/automate/cloud/](https://llamalab.com/automate/cloud/)로 이동하여 new API key/secret을 만듭니다.

설치에 Automate를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: llamalab_automate
    api_key: YOUR_API_KEY
    to: YOUR_EMAIL_ADDRESS
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
api_key:
  description: Enter the API key for Automate.
  required: true
  type: string
to:
  description: E-Mail address the Automate-Fiber is configured for.
  required: true
  type: string
device:
  description: Name of the target device to receive the messages.
  required: false
  type: string
{% endconfiguration %}

Automate에서 클라우드 메시지 수신 :

1. Add a new flow
2. Insert block "Messaging -> Cloud message receive"
3. Insert block "Interface -> Toast show"
4. Connect OK from Flow beginning to IN of Cloud receive
5. Connect OK from Cloud receive to Toast show
6. Connect OK form Toast show to IN of Cloud receive
7. Tap Cloud receive and select the E-Mail account as setup in your configuration
8. Assign a variable name for the Payload
9. Tap Toast show and set the message value to the variable you've specified

하나의 Google Mail 계정에 여러 기기가 페어링되어 있고 각 Automate 인스턴스를 개별적으로 제어하려는 경우 특정 기기를 타겟팅하도록 알리미(notifier)를 설정할 수 있습니다. 장치 이름을 확인하려면 클라우드 메시지 전송 블록을 흐름(flow)에 추가하고 탭한 후 맨 아래로 스크롤하십시오. 장치 이름은 대소 문자를 구분합니다.