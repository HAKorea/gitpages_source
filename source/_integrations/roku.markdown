---
title: 로큐(Roku)
description: Instructions how to integrate Roku devices into Home Assistant.
logo: roku.png
ha_category:
  - Hub
  - Media Player
  - Remote
ha_iot_class: Local Polling
ha_release: 0.86
---

[Roku](https://www.roku.com/) 통합구성요소는 Roku 연동을 허용하며, [discovery component](/integrations/discovery/)를 활성화하면 자동으로 검색됩니다.

현재 홈어시스턴트에는 다음 장치 유형이 지원됩니다.

- Media Player
- Remote

`roku` 통합구성요소는 `configuration.yaml`에 다음 줄을 추가하여 강제로 로드 할 수도 있습니다

```yaml
# Example configuration.yaml entry
roku:
  - host: IP_ADDRESS
```

{% configuration %}
host:
  description: Set the IP address of the Roku device.
  required: true
  type: string
{% endconfiguration %}

## 서비스

### `roku_scan` 서비스

로컬 네트워크에서 Roku를 검색합니다. 발견된 모든 장치는 지속적 알림으로 표시됩니다.

## Remote

`roku` 원격 플랫폼을 사용하면 리모컨 버튼을 Roku 장치로 보낼 수 있습니다. Roku가 구성되면 자동으로 설정됩니다.

현재 다음 버튼이 지원됩니다. : 

- back
- backspace
- channel_down
- channel_up
- down
- enter
- find_remote
- forward
- home
- info
- input_av1
- input_hdmi1
- input_hdmi2
- input_hdmi3
- input_hdmi4
- input_tuner
- left
- literal
- play
- power
- replay
- reverse
- right
- search
- select
- up
- volume_down
- volume_mute
- volume_up

여러 버튼을 누르는 일반적인 서비스 요청은 다음과 같습니다.

```yaml
service: remote.send_command
data:
  entity_id: remote.roku
  command:
    - left
    - left
    - select
```

## Media Player

홈어시스턴트 Roku 통합구성요소가 활성화되어 있고 Roku 장치를 찾은 경우 홈어시스턴트 GUI에서 Roku 미디어 플레이어는 "source" 아래에 설치된 채널 또는 앱 목록을 표시합니다. 하나를 선택하면 Roku 장치에서 채널을 시작하려고 시도합니다. 이 작업을 자동화할 수도 있지만 추가 정보를 얻어야합니다. Roku와 관련된 채널의 경우 ``appID`` 입니다. 이 정보는 Roku 통합구성요소에 의해 수집되지만 현재 최종 사용자에게는 노출되지 않습니다. 이 항목은 향후 릴리스에서 추가될 수 있습니다. 그러나 지금은 정보를 쉽게 얻을 수 있습니다. 장치와 동일한 네트워크에서 간단한 GET API 호출만하면 됩니다.

API 호출은 다음과 같습니다. :

```txt
GET http:// ROKU_IP:8060/query/apps
POST http://ROKU_IP:8060/launch/APP_ID

YouTube 예시 :
POST http://YOUR_ROKU_IP:8060/launch/837?contentID=YOUR_YOUTUBE_VIDEOS_CONTENT_ID&MediaType=live
```

자세한 내용은 [Roku dev 페이지](https://developer.roku.com/docs/developer-program/discovery/external-control-api.md)에서 확인할 수 있습니다.

홈어시스턴트 (예 : 자동화)에서 이를 사용하려면 형식은 다음과 같습니다. ```source :```는 API 호출에서 발견한 appID 입니다.

```yaml
action:
- data:
    entity_id: media_player.roku
    source: 20197
  service: media_player.select_source
```
