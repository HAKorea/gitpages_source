---
title: "재실 감지 설정"
description: "Instructions on how to setup presence detection within Home Assistant."
---

재실 감지(Presence Detection)는 자동화의 가장 중요한 출발점인 특정 위치에 사용자나 장치가 보이는지 여부를 확인 하는 기능입니다. 누군가의 현재 위치를 알 수 있다면 이런 자동화를 실행할 수 있습니다:

- 아이가 학교에 도착하면 알람을 받는다
- 퇴근후 집으로 출발하면서 에어콘을 켠다


<p class='img'>
<img src='/images/screenshots/map.png' />
두 사람의 위치가 학교, 직장 또는 집 여부를 나타내는 홈어시스턴트 화면.
</p>

### 재실 감지 추가

재실 감지를 설정하는 방법에는 두가지가 있습니다. 재실을 감지하는 손쉬운 방법은 장비가 네트워크에 연결되는 것을 체크하는 것입니다. 이 기능을 [지원하는 공유기][routers]를 갖고 있다면 이 방법을 사용할 수 있습니다. 여러분의 공유기의 기능을 이용하는 것만으로 사람들이 집에 있고/없고를 감지할 수 있습니다.

또 다른 방법은 스마트폰의 위치 정보를 여러분이 운영하는 홈어시스터트로 전송하는 앱을 활용하는 것입니다. iOS나 안드로이드 스마트폰에서는 [Home Assistant Companion app][companion]을 사용할 수 있습니다.

Home Assistant Companion 앱을 스마트폰에 설치하는 과정에서 스마트폰의 위치 정보를 사용하여 홈어시스턴트로 보낼 것인지 권한을 요청합니다. 이 권한을 승인하면 스마트폰에 대한 `device_tracker` 엔티티가 만들어지고 위치정보를 자동화 조건으로 사용할 수 있습니다.


### 존

<img src='/images/screenshots/badges-zone.png' style='float: right; margin-left: 8px; height: 100px;'>

존(zone)은 지도상의 특정 지역에 이름을 부여하는 것입니다. 이름을 부여한 지역은 추적하는 사용자가 존에 들어오고/나가는 것을 체크하고 자동화의 [트리거][trigger] 또는 [조건][condition]으로 이용할 수 있습니다. 존은 통합 구성요소 페이지나 환경 설정 창에서도 설정 가능합니다.

<div class='note'>
지도 화면에서 집에 도착한 기기(사용자)들은 보이지 않습니다.
</div>

[routers]: /integrations/#presence-detection
[nmap]: /integrations/nmap_tracker
[ha-bluetooth]: /integrations/bluetooth_tracker
[ha-bluetooth-le]: /integrations/bluetooth_le_tracker
[ha-locative]: /integrations/locative
[ha-gpslogger]: /integrations/gpslogger
[ha-presence]: /integrations/#presence-detection
[mqtt-self]: /integrations/mqtt/#run-your-own
[mqtt-cloud]: /integrations/mqtt/#cloudmqtt
[zone]: /integrations/zone/
[trigger]: /getting-started/automation-trigger/#zone-trigger
[condition]: /getting-started/automation-condition/#zone-condition
[ha-map]: /integrations/map/
[companion]: https://companion.home-assistant.io/

### [다음 과정: 커뮤니티 참여 &raquo;](/getting-started/join-the-community/)
