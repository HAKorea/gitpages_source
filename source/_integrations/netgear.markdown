---
title: 넷기어
description: Instructions on how to integrate Netgear routers into Home Assistant.
logo: netgear.png
ha_category:
  - Presence Detection
ha_iot_class: Local Polling
ha_release: pre 0.7
---

이 플랫폼을 사용하면 연결된 장치를 [Netgear](https://www.netgear.com/) 장치로 보고 현재 상태를 감지할 수 있습니다

<div class='note'>

최근 Orbi AP 업데이트에서는 로컬 네트워크의 존재를 감지하는 데 몇 시간이 걸리는 버그가 있었습니다. 현재 해결 방법은 설정에 `accesspoints :`노드를 추가하여 이 통합구성요소에서 Orbi의 API v2를 사용하도록 하는 것입니다.

</div>

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: netgear
    password: YOUR_ADMIN_PASSWORD
```

{% configuration %}
url:
  description: "The base URL, e.g., `http://routerlogin.com:5000` for example. If not provided `host` and `port` are used. If none provided autodetection of the URL will be used." 
  required: false
  type: string
host:
  description: "라우터의 IP 주소. (예: `192.168.1.1`)"
  required: false
  type: string
port:
  description: 라우터가 통신하는 포트.
  required: false
  default: 5000
  type: integer
username:
  description: 관리 권한이 있는 사용자의 사용자 이름.
  required: false
  default: admin
  type: string
password:
  description: 주어진 관리자 계정의 비밀번호.
  required: true
  type: string
devices:
  description: 제공된 경우 지정된 장치만 보고됩니다. Netgear UI에 보고된 MAC 주소 또는 장치 이름일 수 있습니다.
  required: false
  type: list
exclude:
  description: 스캔에서 제외 할 장치.
  required: false
  type: list
accesspoints:
  description: 특정 AP들에서 장치를 추적. MAC 주소만 지원합니다.
  required: false
  type: list
{% endconfiguration %}

`accesspoints`가 지정되면 여기에 지정된 AP에 연결된 각 장치에 대한 추가 장치가 `MY-LAPTOP on RBS40`으로 보고됩니다. `Router`는 메인 AP의 AP 이름으로 보고됩니다.

`accesspoints`를 사용하는 경우 항목이 많지 않도록 `devices` 또는 `exclude`를 사용하는 것이 좋습니다.

포트 80을 사용하는 것으로 알려진 모델 목록:
- Nighthawk X4S - AC2600 (R7800)
- Orbi

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.