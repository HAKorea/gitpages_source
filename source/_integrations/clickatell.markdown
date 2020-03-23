---
title: 해외문자(Clickatell)
description: Instructions on how to add Clickatell notifications to Home Assistant.
logo: clickatell.png
ha_category:
  - Notifications
ha_release: 0.56
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/gi5HYaaShXY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`clickatell` 플랫폼은 [Clickatell](https://clickatell.com)을 사용하여 Home Assistant에서 SMS 알림을 전달합니다.

## 셋업

[Clickatell SMS Platform Portal](https://portal.clickatell.com/#/) 섹션으로 이동하여 새 SMS 연동작업을 작성하십시오. 연동작업을 작성하는데 필요한 세 가지 정보 화면이 있습니다. 다음을 확인하십시오 :

1. Give the new Integration an identification name.
2. Ensure it is set for 'production' use.
3. Select 'HTTP' as your API type.
4. Ensure that the you select for the messaging type to be 'one way messaging'.
5. Be aware of the international number format option as this impacts the structure of the phone numbers you provide.
6. Once you have completed entering your details an API key is generated. Copy the API key.

## 설정

Clickatell을 설치에 추가하려면 Home Assistant `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - platform: clickatell
    name: USER_DEFINED_NAME
    api_key: CLICKATELL_API_KEY
    recipient: PHONE_NO
```

{% configuration %}
name:
  description: Setting the optional parameter name allows multiple notifiers to be created. The notifier will bind to the service notify.NOTIFIER_NAME.
  required: false
  default: clickatell
  type: string
api_key:
  description: Your Clicktell API key.
  required: true
  type: string
recipient:
  description: Your phone number. This is where you want to send your notification SMS messages. e.g., `61444333444`.
  required: true
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.