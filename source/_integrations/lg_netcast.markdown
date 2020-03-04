---
title: LG Netcast(넷캐스트)
description: Instructions on how to integrate a LG TV (Netcast 3.0 & 4.0) within Home Assistant.
logo: lg.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: '0.20'
---

`lg_netcast` 플랫폼을 사용하면 NetCast 3.0 (2012 년에 출시된 LG 스마트 TV 모델) 및 NetCast 4.0 (2013 년에 출시된 LG 스마트 TV 모델)을 실행하는 LG 스마트 TV를 제어 할 수 있습니다. 새로운 LG WebOS TV의 경우 [webostv](/integrations/webostv#media-player) 플랫폼을 사용하십시오.

LG TV를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: lg_netcast
    host: 192.168.0.20
```

{% configuration %}
host:
  description: "LG 스마트 TV의 IP 주소 (예 : 192.168.0.20)"
  required: true
  type: string
access_token:
  description: 연결하는 데 필요한 액세스 토큰.
  required: false
  type: string
name:
  description: LG 스마트 TV에 부여하려는 이름.
  required: false
  default: LG TV Remote
  type: string
{% endconfiguration %}

TV의 액세스 토큰을 얻으려면 `access_token`없이 Home Assistant에서 `lg_netcast` 플랫폼을 설정하십시오.
홈 어시스턴트를 시작하면 TV에 화면에 액세스 토큰이 표시됩니다.
구성에 토큰을 추가하고 홈어시스턴트를 다시 시작하면 LG TV의 미디어 플레이어 통합구성요소가 표시됩니다.

<div class='note'>
TV를 초기화 할 때까지 액세스 토큰이 변경되지 않습니다.
</div>
