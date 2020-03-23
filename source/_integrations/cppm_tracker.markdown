---
title: 아루바 클리어패스(Aruba ClearPass)
description: Instructions on how to integrate Aruba ClearPass into Home Assistant.
logo: aruba.png
ha_category:
  - Presence Detection
ha_release: '0.90'
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/8FFy_EtaMLo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 플랫폼을 사용하면 [Aruba Clearpass](https://www.arubanetworks.com/products/security/network-access-control/)에 연결된 장치를 보고 현재 상태를 감지 할 수 있습니다.

지원 플랫폼 (tested):

- Aruba ClearPass 6.7.5

<div class='note warning'>

먼저 [여기](https://www.arubanetworks.com/techdocs/ClearPass/6.6/Guest/Content/AdministrationTasks1/CreateEditAPIclient.htm)에서 API 클라이언트를 작성해야합니다.

</div>

본 장치 추적기를 설치시 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: cppm_tracker
    host: clearpass.server.org
    client_id: clearpassapi
    api_key: 00000004qyO513hTdCfjIO2ZWWnmex8QZ5000000000
```

{% configuration %}
host:
  description: "The IP address or hostname of the ClearPass server, e.g., `clearpass.server.com`."
  required: true
  type: string
client_id:
  description: "The client ID from the API Clients page."
  required: true
  type: string
api_key:
  description: "The secret from the API Clients page."
  required: true
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.