---
title: 단순알림(Simplepush)
description: Instructions on how to add Simplepush notifications to Home Assistant.
logo: simplepush.png
ha_category:
  - Notifications
ha_release: 0.29
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/hZ671C1VSB4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`simplepush` 플랫폼은 [Simplepush](https://simplepush.io/)를 사용하여 Home Assistant에서 Android 장치로 알림을 전달합니다. 유사한 앱과 달리 Simplepush 앱은 등록이 필요하지 않습니다.

설치에 Simplepush를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: simplepush
    device_key: ABCDE
```

{% configuration %}
  name: 
    description: Setting the optional parameter `name` allows multiple notifiers to be created. The default value is `notify`. The notifier will bind to the service `notify.NOTIFIER_NAME`.
    required: false
    type: string
  device_key:
    description: The device key of your device.
    required: true
    type: string
  event:
    description: The event for the events.
    required: false
    type: string
  password:
    description: The password of the encryption used by your device.
    required: inclusive
    type: string
  salt:
    description: The salt used by your device.
    required: inclusive
    type: string
{% endconfiguration %}

서비스가 작동하는지 테스트하려면 command line에서 `curl` 메시지를 보내십시오.

```bash
$ curl 'https://api.simplepush.io/send/device_key/title/message'
```

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.