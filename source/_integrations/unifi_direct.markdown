---
title: 유비쿼티 UniFi AP
description: Instructions on how to use a Unifi WAP as a device tracker.
logo: ubiquiti.png
ha_category:
  - Presence Detection
ha_iot_class: Local Polling
ha_release: 0.59
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/nuO8lwRgcwg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

이 플랫폼을 사용하면 [UniFi AP](https://www.ubnt.com/products/#unifi)에 연결된 장치를 보고 현재 상태를 감지할 수 있습니다. 이 장치 추적기는 Unifi 컨트롤러 소프트웨어가 필요하지 않기 때문에 [Ubiquiti Unifi WAP](/integrations/unifi)와 다릅니다.

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: unifi_direct
    host: YOUR_AP_IP_ADDRESS
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
host:
  description: The hostname or IP address of your Unifi AP.
  required: true
  type: string
username:
  description: The SSH device username used to connect to your Unifi AP.
  required: true
  type: string
password:
  description: The SSH device password used to connect to your Unifi AP.
  required: true
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지시 사항은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.