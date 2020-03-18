---
title: TP-Link LTE
description: Instructions on how to integrate your TP-Link LTE routers within Home Assistant.
logo: tp-link.png
ha_release: 0.83
ha_category:
  - Network
  - Notifications
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/UXMrE4c0l_k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Home Assistant용 TP-Link LTE 통합구성요소를 통해 현재 TL-MR6400 (펌웨어 1.4.0)으로만 테스트된 TP-Link LTE 라우터를 관찰하고 제어할 수 있습니다.

The integration provides a notification service that will send an SMS.
통합구성요소는 SMS를 보낼 알림 서비스를 제공합니다.

## 설정

컴포넌트를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
tplink_lte:
  - host: IP_ADDRESS
    password: SECRET
    notify:
      - name: sms1
        recipient: "+15105550123"
      - name: sms2
        recipient: "+55520525252"
```

{% configuration %}
host:
  description: The IP address of the router web interface.
  required: true
  type: string
password:
  description: The password used for the router web interface.
  required: true
  type: string
notify:
  description: A list of notification services connected to this specific host.
  required: false
  type: list
  keys:
    target:
      description: The phone number of a default recipient or a list with multiple recipients.
      required: true
      type: [string, list]
    name:
      description: The name of the notification service.
      required: false
      default: notify
      type: string
{% endconfiguration %}
