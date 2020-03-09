---
title: 파나소닉 Blu-Ray Player
description: Instructions on how to integrate a Panasonic Blu-Ray player into Home Assistant.
logo: panasonic.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.83
---

`panasonic_bluray` 플랫폼을 사용하면 Panasonic Blu-Ray 플레이어를 제어할 수 있습니다. 장치는 홈어시스턴트와 동일한 서브넷에 있어야합니다. 다른 서브넷에서 연결하면 오류가 반환됩니다.

현재 알려진 지원 모델 :

- DMP-BDT120
- DMP-BDT220
- DMP-BDT221
- DMP-BDT320
- DMP-BDT500
- DMP-BBT01

모델이 목록에 없으면 시도해보십시오. 모든 것이 올바르게 작동하면 [GitHub](https://github.com/home-assistant/home-assistant.io/blob/current/source/_integrations/panasonic_bluray.markdown)의 목록에 추가하십시오.

설정 예 :

```yaml
media_player:
  - platform: panasonic_bluray
    host: 192.168.0.10
```

{% configuration %}
host:
  description: The IP of the Panasonic Blu-Ray device, e.g., `192.168.0.10`.
  required: true
  type: string
name:
  description: The name you would like to give to the Panasonic Blu-Ray device.
  required: false
  default: Panasonic Blu-Ray
  type: string
{% endconfiguration %}

### 지원 동작

- 이 장치는 재생, 일시 정지, 중지 및 전원 켜기/끄기 작업을 지원합니다. 또한 현재 상태, 타이틀 지속 시간 및 현재 재생 위치를 보고합니다.
