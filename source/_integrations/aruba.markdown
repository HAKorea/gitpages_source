---
title: 아루바(Aruba)
description: Instructions on how to integrate Aruba routers into Home Assistant.
logo: aruba.png
ha_category:
  - Presence Detection
ha_release: 0.7
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/x2fu8o-0X1Y" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 플랫폼을 사용하면 연결된 장치를 [Aruba Instant](https://www.arubanetworks.com/products/networking/aruba-instant/) 장치에서 현재 보고 상태를 감지할 수 있습니다.

지원되는 장치 (테스트 완료) :

- ARUBA AP-105

<div class='note warning'>
이 장치 추적기는 라우터에서 텔넷을 활성화해야합니다.
</div>

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: aruba
    host: YOUR_ROUTER_IP
    username: YOUR_ADMIN_USERNAME
    password: YOUR_ADMIN_PASSWORD
```

{% configuration %}
host:
  description: The IP address of your router, e.g., `192.168.1.1`.
  required: true
  type: string
username:
  description: The username of an user with administrative privileges, usually `admin`.
  required: true
  type: string
password:
  description: The password for your given admin account.
  required: true
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.