---
title: 미디어 플레이어 클래식 홈시네마 (MPC-HC)
description: Instructions on how to integrate MPC-HC into Home Assistant.
logo: mpchc.png
ha_category:
  - Media Player
ha_release: 0.25
ha_iot_class: Local Polling
---

`mpchc` 플랫폼을 사용하면 [Media Player Classic 홈 시네마](https://mpc-hc.org/)를 홈어시스턴트에 연결할 수 있습니다. 현재 재생중인 항목을 보고 플레이어 상태의 변화에 ​​응답할 수 있습니다.

이 연동 기능이 작동하려면 MPC-HC 옵션 대화 상자에서 웹인터페이스를 활성화해야합니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/mpc-hc.png' />
</p>

홈어시스턴트를 실행하는 서버가 MPC-HC를 실행하는 동일한 디바이스가 아닌 경우, *allow access from localhost only* 옵션이 설정되지 않았는지 확인해야합니다.

<div class='note warning'>

MPC-HC 웹 인터페이스는 안전하지 않으며 원격 클라이언트가 인증없이 파일 시스템 액세스를 완전히 제어 할 수 있습니다. 신뢰할 수있는 네트워크 외부에서 웹 UI에 대한 액세스를 허용하지 말고 가능한 경우 [프록시 스크립트를 사용하여 중요한 정보를 제어하거나 수정하십시오](https://github.com/abcminiuser/mpc-hc-webui-proxy).

</div>

MPC-HC를 설치시 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: mpchc
    host: http://192.168.0.123
```

{% configuration %}
host:
  description: The host name or IP address of the device that is running MPC-HC.
  required: true
  type: string
port:
  description: The port number of the device.
  required: false
  default: 13579
  type: integer
name:
  description: The name of the device used in the frontend.
  required: false
  default: MPC-HC
  type: string
{% endconfiguration %}
