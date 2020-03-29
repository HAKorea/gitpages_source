---
title: 포켓 캐스트(Pocket Casts)
description: Instructions on how to set up Pocket Casts sensors within Home Assistant.
logo: pocketcasts.png
ha_category:
  - Multimedia
ha_release: 0.39
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/0vMsnU6S4k0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`pocketcasts` 센서 플랫폼을 사용하면 [Pocket Casts](https://play.pocketcasts.com/)에서 좋아하는 Podcast 중 재생되지 않은 에피소드 수를 모니터링할 수 있습니다.

## 설정

<div class='note warning'>
  
  이 연동을 위해서는 [Pocket Casts + Plus](https://www.pocketcasts.com/plus/) 구독이 필요합니다!
</div>

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: pocketcasts
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The username to access the PocketCasts service.
  required: true
  type: string
password:
  description: The password for the given username.
  required: true
  type: string
{% endconfiguration %}
