---
title: 하이크비전(Hikvision)
description: Instructions on how to integrate Hikvision camera switches into Home Assistant.
logo: hikvision.png
ha_category:
  - Switch
ha_release: pre 0.7
ha_codeowners:
  - '@fbradyirl'
---

이 `hikvisioncam` 스위치 플랫폼을 사용하면 [Hikvision](https://www.hikvision.com/) 카메라에서 모션 감지 세팅으로 제어할 수 있습니다.

<div class='note warning'>
현재 기본 https 포트만 사용합니다.
</div>

Hikvision 캠을 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오

```yaml
# Example configuration.yaml entry
switch:
  - platform: hikvisioncam
    host: 192.168.1.32
```

{% configuration %}
host:
  description: "Hikvision 카메라의 IP 주소 (예 : 192.168.1.32)"
  required: true
  type: string
port:
  description: Hikvision 카메라에 연결하는 포트
  required: false
  default: 80
  type: integer
name:
  description: 이 매개 변수를 사용하면 카메라 이름을 무시할 수 있습니다.
  required: false
  default: Hikvision Camera Motion Detection
  type: string
username:
  description: Hikvision 카메라에 액세스하기 위한 사용자 이름
  required: false
  default: admin
  type: string
password:
  description: Hikvision 카메라에 액세스하기위한 비밀번호.
  required: false
  default: 12345
  type: string
{% endconfiguration %}
