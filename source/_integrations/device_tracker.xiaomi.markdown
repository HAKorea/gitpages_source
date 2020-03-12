---
title: "샤오미 Router"
description: "Instructions on how to integrate Xiaomi routers into Home Assistant."
logo: xiaomi.png
ha_category:
  - Presence Detection
ha_release: 0.36
---

`xiaomi` 플랫폼은 [Xiaomi](http://miwifi.com) 라우터에 연결된 장치를 보고 재실 감지 기능을 제공합니다.

## 셋업

설치에서 Xiaomi 라우터를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: xiaomi
    host: YOUR_ROUTER_IP
    password: YOUR_ADMIN_PASSWORD
```

{% configuration %}
host:
  description: "The IP address of your router, e.g., `192.168.0.1`."
  required: true
  type: string
username:
  description: The admin username.
  required: false
  default: admin
  type: string
password:
  description: The password for the admin account.
  required: true
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.

### 호환성 테스트

라우터가 호환되는지 확인하려면 `http://YOUR_ROUTER_IP/api/misystem/devicelist`로 이동하십시오.
현재 라우터에 연결된 장치 목록이 나타납니다.

그러나 일부 사용자는 이전 URL이 작동하지 않더라도 홈 라우터에 Mi Router 3을 연동할 수 있다고보고합니다. 예를 들어 Mi Router 3 및 펌웨어 버전 2.10.46 Stable을 사용하는 일부 사용자는 라우터를 성공적으로 연동했을 것이며 연동을 테스트하기위한 대체 URL은 `http://YOUR_ROUTER_IP/cgi-bin/luci/api/misystem/devicelist`입니다. 이 페이지로 이동하면 `{"code":401,"msg":"Invalid token"}` 메시지가 표시됩니다.