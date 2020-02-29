---
title: 시놀로지
description: Instructions on how to integrate Synology Surveillance Station cameras within Home Assistant.
logo: synology.png
ha_category:
  - Camera
ha_release: 0.31
ha_iot_class: Local Polling
---

`synology` 카메라 플랫폼을 사용하면 Home Assistant에서 [Synology](https://www.synology.com/) Surveillance Station 기반 IP 카메라의 라이브 스트림을 볼 수 있습니다.

<div class='note'>

Synology는 라이브 스트리밍 API를 비활성화했으며 Surveillance Station 버전 8.2.3-5828을 사용하는 경우 연동이 현재 중단되었습니다.  
지원되지 않는 미리보기 수정 프로그램이 있습니다. (8.2.3-5829) - 수동업데이트 지침은 [here](https://www.vcloudinfo.com/2019/04/how-to-manually-upgrade-your-synology-surveillance-system-firmware.html)에서 찾을 수 있습니다.

</div>

## 설정

Surveillance Station 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Minimum configuration.yaml entry
camera:
  - platform: synology
    url: IP_ADDRESS_OF_SYNOLOGY_NAS
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
name:
  description: Synology 카메라의 이름.
  required: false
  type: string
  default: Synology Camera
url:
  description: 포트를 포함한 Synology의 URL.
  required: true
  type: string
username:
  description: Surveillance Station에 액세스하기 위한 사용자 이름.
  required: true
  type: string
password:
  description: Surveillance Station에 액세스하기 위한 비밀번호.
  required: true
  type: string
timeout:
  description: Surveillance Station에 연결할 때 사용되는 시간 초과 (초).
  required: false
  type: integer
  default: 5
whitelist:
  description: 추가 할 카메라의 목록이며 이름은 Surveillance Station과 동일해야합니다. 생략하면 모든 카메라가 추가됩니다..
  required: false
  type: list
verify_ssl:
  description: HTTPS 요청에 대한 SSL/TLS 인증서를 확인.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

## 전쳬 사례

`synology` 카메라 플랫폼의 전체 샘플 설정은 다음과 같습니다.

```yaml
# Example configuration.yaml entry
camera:
  - platform: synology
    url: https://192.168.1.120:5001
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    timeout: 15
    verify_ssl: false
```

<div class='note'>

내장된 자체 서명 인증서 대신 유효한 SSL/TLS 인증서를 설치하지 않은 경우 대부분의 사용자는 `verify_ssl`을 false로 설정해야합니다.

</div>
