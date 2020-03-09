---
title: Asterisk 보이스메일
description: Instructions on how to integrate your existing Asterisk voicemail within Home Assistant.
logo: asterisk.png
ha_category:
  - Mailbox
ha_iot_class: Local Push
ha_release: 0.51
---

홈어시스턴트를 위한 `asterisk_mbox` Asterisk 음성 메일 통합 기능을 사용하면 Asterisk 음성 메일 사서함에서 음성 메일을 보고 듣고 삭제할 수 있습니다. 통합구성요소에는 프런트 엔드에 패널이 포함되어 있으며 재생 및 메시지 삭제 외에도 발신자 ID 및 (Google의 API를 사용하여) 텍스트 음성 변환을 제공합니다.사용 가능한 메시지 수를 나타내는 센서도 포함되어 있습니다. Asterisk PBX와 Home Assistant가 동일한 시스템에서 실행될 필요는 없습니다.

구성 요소를 사용하려면 Asterisk 서버뿐만 아니라 Home Assistant에서도 설정이 필요합니다.

먼저 [Asterisk PBX configuration guide](/docs/asterisk_mbox/)에 따라 Asterisk PBX 서버에 필요한 서버를 설정하십시오 (Asterisk와 Home Assistant가 동일한 서버에서 실행되는 경우에도 필요함)

## 설정

완료되면 다음 항목 `configuration.yaml` 파일을 추가하십시오.

```yaml
# Example configuration.yaml entry
asterisk_mbox:
  password: ASTERISK_PBX_PASSWORD
  host: ASTERISK_PBX_SERVER_IP_ADDRESS
  port: ASTERISK_PBX_SERVER_PORT
```

새 'Mailbox' 측면 패널과 사용 가능한 메시지 수를 나타내는 센서가 추가됩니다.

{% configuration %}
password:
  description: The password that was set during Asterisk PBX configuration
  required: true
  type: string
host:
  description: The IP-address of the server that is running the Asterisk PBX
  required: true
  type: string
port:
  description: The port on the Asterisk PBX server that was configured during Asterisk PBX configuration
  required: true
  type: string
{% endconfiguration %}

<div class='note warning'>
Asterisk PBX 서버와 Home Assistant 서버 간의 통신은 비밀번호로 보호되지만 데이터 전송은 암호화되지 않습니다. 통신이 근거리 통신망 내에 포함 된 경우에만 이 통합구성요소를 사용하는 것이 좋습니다.
</div>
