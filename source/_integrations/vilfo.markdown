---
title: VPN 라우터(Vilfo Router)
description: Instructions on how to integrate a Vilfo Router into Home Assistant.
logo: vilfo.png
ha_release: '0.106'
ha_category:
  - Network
  - System Monitor
  - Sensor
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@ManneW'
---

`Vilfo Router` 연동을 통해 Home Assistant에서 [Vilfo Router](https://www.vilfo.com)의 상태를 관찰할 수 있습니다.

현재 장치의 현재 부하를 백분율로 보고하고 현재 가동 시간을 분 단위로 보고하는 기능을 지원합니다.

## 설정

UI를 사용하여 연동을 추가할 수 있습니다. **설정** >> **통합구성요소**으로 이동하여 `+` 기호 버튼을 클릭하고 목록에서 **Vilfo Router**를 선택하십시오.

연동을 설정하려면 API 액세스 토큰뿐만 아니라 라우터의 호스트 이름 또는 IP (`admin.vilfo.com`이 기본 호스트 이름임)가 필요합니다.

### 액세스 토큰 얻기

API의 액세스 토큰은 "general"이라는 이름의 창에서 Vilfo 웹 UI를 통해 얻을 수 있습니다. 토큰을 찾는 방법에 대한 자세한 내용은 [the official API documentation](https://www.vilfo.com/apidocs/#header-authorization)를 방문하십시오.

<div class="note warning">

Vilfo 펌웨어 버전 1.0.13에서는 웹 UI에 새로 로그인하면 액세스 토큰이 무효화됩니다. 웹 UI 로그인이 API 호출을 방해하지 않도록 API 목적으로만 별도의 사용자를 작성하고 해당 액세스 토큰을 사용할 수 있습니다.

</div>
