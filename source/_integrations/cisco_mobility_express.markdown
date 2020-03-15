---
title: 시스코 모바일(Cisco Mobility Express)
description: Instructions on how to integrate Cisco Mobility Express wireless controllers into Home Assistant.
logo: cisco.png
ha_category:
  - Presence Detection
ha_release: '0.90'
ha_codeowners:
  - '@fbradyirl'
---

[Cisco](https://www.cisco.com) Mobility Express 무선 컨트롤러의 재실 감지 스캐너입니다.

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: cisco_mobility_express
    host: CONTROLLER_IP_ADDRESS
    username: YOUR_ADMIN_USERNAME
    password: YOUR_ADMIN_PASSWORD
```

{% configuration %}
host:
  description: The IP address of your controller, e.g., 192.168.10.150.
  required: true
  type: string
username:
  description: The username of a user with administrative privileges.
  required: true
  type: string
password:
  description: The password for your given admin account.
  required: true
  type: string
ssl:
  description: Use HTTPS instead of HTTP to connect.
  required: false
  type: boolean
  default: false
verify_ssl:
  description: Enable or disable SSL certificate verification. Set to false if you have a self-signed SSL certificate and haven't installed the CA certificate to enable verification.
  required: false
  default: true
  type: boolean
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.