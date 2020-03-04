---
title: Huawei 라우터
description: Instructions on how to integrate Huawei Routers into Home Assistant.
logo: huawei.svg
ha_category:
  - Presence Detection
ha_release: 0.51
ha_codeowners:
  - '@abmantis'
---

`huawei` 장치 추적기 플랫폼은 [Huawei router](http://m.huawei.com/enmobile/enterprise/products/network/access/pon-one/hw-371813.htm)에 연결된 장치를 보고 존재 감지(presence detection) 기능을 제공합니다. 

현재 이것은 Huawei HG8247H, HS8247W 및 HG8247Q Smart Router (Vodafone Portugal에서 사용)에서만 테스트되었습니다.

## 설정

설치에서 Huawei 라우터를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: huawei_router
    host: 192.168.1.1
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
host:
  description: "라우터의 IP 주소 (예 : 192.168.1.1)"
  required: true
  type: string
username:
  description: 라우터에 로그인하기 위한 사용자 이름 (라우터의 웹인터페이스를 통해 사용된 것과 동일).
  required: true
  type: string
password:
  description: 지정된 사용자 이름의 비밀번호
  required: true
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오 .