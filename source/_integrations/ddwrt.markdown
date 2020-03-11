---
title: 오픈소스라우터(DD-WRT)
description: Instructions on how to integrate DD-WRT based routers into Home Assistant.
logo: ddwrt.png
ha_category:
  - Presence Detection
ha_release: pre 0.7
---

이 플랫폼은 연결된 장치를 [DD-WRT](https://dd-wrt.com/)기반 라우터로 보고 재실 감지 기능을 제공합니다.

설치시 DD-WRT 라우터를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: ddwrt
    host: ROUTER_IP_ADDRESS
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
ssl:
  description: Whether to connect via HTTPS.
  required: false
  type: boolean
  default: false
verify_ssl:
  description: If SSL/TLS verification for HTTPS resources needs to be turned off (for self-signed certs, etc.)
  required: false
  type: boolean
  default: true
wireless_only:
  description: Whether to only list devices that are connected directly to the router via WiFi or include those connected via Ethernet or other networked access points as well.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

기본적으로 Home Assistant는 5 초마다 DD-WRT에서 연결된 장치에 대한 정보를 가져옵니다.
추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.