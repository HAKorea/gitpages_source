---
title: 시놀로지 SRM(Synology SRM)
description: Instructions on how to integrate Synology SRM routers into Home Assistant.
logo: synology.png
ha_category:
  - Presence Detection
ha_release: 0.87
ha_codeowners:
  - '@aerialls'
---

이 플랫폼을 사용하면 [Synology SRM](https://www.synology.com/en-us/srm) 라우터에 연결된 장치를 보고 재실 감지를 할 수 있습니다.

## 설정

설치시 이 장치 추적기를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: synology_srm
    host: 192.168.1.254
    password: YOUR_ADMIN_PASSWORD
```

{% configuration %}
host:
  description: "Synology SRM 라우터 호스트 또는 IP 주소, (예: `192.168.1.1` or `router.mydomain.local`)"
  required: true
  type: string
port:
  description: Synology SRM 라우터에 연결할 포트.
  required: false
  default: 8001
  type: integer
username:
  description: 관리권한이 있는 사용자의 사용자이름.
  required: false
  default: admin
  type: string
password:
  description: 주어진 관리자계정의 비밀번호.
  required: true
  type: string
ssl:
  description: HTTP 대신 HTTPS를 사용하여 연결.
  required: false
  default: true
  type: boolean
verify_ssl:
  description: SSL 인증서 확인을 활성화 또는 비활성화.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

SRM에서 관리자권한으로 다른계정을 만들 수 없습니다. 이 연결에 관리자계정 (또는 생성시 이름을 바꾼 계정)을 사용해야합니다.

지원되는 것으로 알려진 모델 목록:

- RT1900ac
- RT2600ac

추적할 사람을 구성하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/) 를 참조하십시오 .