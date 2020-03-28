---
title: "MQTT 인증서"
description: "Instructions on how to setup MQTT with a certificate in Home Assistant."
logo: mqtt.png
---

인증서를 사용하면 MQTT 통신을 위한 추가 보안 레이어가 제공됩니다. 

MQTT를 인증서와 함께 홈어시스턴트에 연동하려면, `configuration.yaml` 파일에 다음 섹션을 추가 하십시오. :

```yaml
# Example configuration.yaml entry
mqtt:
  certificate: /home/paulus/dev/addtrustexternalcaroot.crt
```

{% configuration %}
certificate:
  description: "이 클라이언트가 신뢰하는 것으로 취급될 'auto' 또는 인증 기관 인증서 파일. 서버에 보안(TLS) 연결을 사용하려면 'certificate'설정 매개 변수를 정의해야합니다. 'auto'는 certifite CA 번들 인증서를 사용합니다. 파일이 지정되면 파일은 브로커의 인증서에 서명한 인증 기관의 루트 인증서를 포함해야하지만 여러 인증서를 포함 할 수도 있습니다. 예시 `/home/user/identrust-root.pem`)" 
  required: false
  type: string
client_key:
  description: Client key, 예시 `/home/user/owntracks/cookie.key`.
  required: false
  type: string
client_cert:
  description: Client certificate, 예시 `/home/user/owntracks/cookie.crt`.
  required: false
  type: string
{% endconfiguration %}
