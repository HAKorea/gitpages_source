---
title: 협업도구(Flock)
description: Instructions on how to add Flock notifications to Home Assistant.
logo: flock.png
ha_category:
  - Notifications
ha_release: 0.71
ha_codeowners:
  - '@fabaff'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/hIymRucpNSk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`flock` 플랫폼은 [Flock.com](https://flock.com)을 사용하여 Home Assistant에서 알림을 전달합니다.

## 셋업

[Flock.com Admin website](https://admin.flock.com/#!/webhooks)로 이동하여 새 "Incoming Webhooks"를 만듭니다. Home Assistant에서 알림을 보낼 채널을 선택하고 이름을 지정한 후 *Save and Generate URL* 을 누르십시오.

<p class='img'>
  <img src='{{site_root}}/images/integrations/flock/flock-webhook.png' />
</p> 

room의 `access_token`인 URL의 마지막 부분이 필요합니다.

<p class='img'>
  <img src='{{site_root}}/images/integrations/flock/new-webhook.png' />
</p> 

## 설정

설치에 Flock 알림을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: flock
    access_token: YOUR_ROOM_TOKEN
```

{% configuration %}
name:
  description: "The optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`."
  required: false
  type: string
  default: notify
access_token:
  description: The last part of the webhook URL.
  required: true
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.