---
title: 인증서 만료(Certificate Expiry)
description: Instructions on how to set up HTTPS (SSL) certificate expiry sensors within Home Assistant.
logo: home-assistant.png
ha_category:
  - Network
ha_release: 0.44
ha_iot_class: Configurable
ha_config_flow: true
ha_codeowners:
  - '@Cereal2nd'
  - '@jjlawren'
---

`cert_expiry` 센서는 설정된 URL에서 정보를 가져오고 인증서 만료를 일 단위로 표시합니다.

## 설정

`cert_expiry` 센서 설정에는 두 가지 옵션이 있습니다. : 

- Home Assistant 사용자 인터페이스를 통해 인증서에서 확인할 이름, 호스트 및 포트를 입력 할 수 있습니다.
- Home Assistant `configuration.yaml` 파일을 통해.


```yaml
# Example configuration.yaml entry
sensor:
  - platform: cert_expiry
    host: home-assistant.io
```

{% configuration %}
host:
  description: 인증서를 검색할 호스트 FQDN (또는 IP).
  required: true
  type: string
port:
  description: 서버가 실행중인 포트 번호
  required: false
  default: 443
  type: integer
name:
  description: 인증서의 이름.
  required: false
  default: SSL Certificate Expiry
  type: string
{% endconfiguration %}

<div class='note warning'>
URL이 엔드 포인트 또는 리소스와 정확히 일치하는지 확인하십시오.
</div>
