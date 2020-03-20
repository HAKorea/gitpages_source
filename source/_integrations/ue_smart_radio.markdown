---
title: 로지텍 UE 스마트 라디오
description: Instructions on how to integrate a Logitech UE Smart Radio player into Home Assistant.
logo: ueradio.png
ha_category:
  - Media Player
ha_release: '0.60'
ha_iot_class: Cloud Polling
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/a14QGa8Pi_o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`ue_radio` 플랫폼을 사용하면 Home Assistant에서 [Logitech UE Smart Radio](https://www.uesmartradio.com)를 제어할 수 있습니다. 이를 통해 UE Smart Radio 업데이트로 업데이트된 Logitech UE Smart Radio 및 Logitech Squeezebox Radio를 모두 제어할 수 있습니다.

UE Smart Radio 플레이어를 설치시 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: ue_smart_radio
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The email you use to log in to `uesmartradio.com`.
  required: true
  type: string
password:
  description: The password you use to log in to `uesmartradio.com`.
  required: true
  type: string
{% endconfiguration %}
