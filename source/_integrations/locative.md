---
title: 애플사용자용 위치앱(Locative)
description: "Instructions on how to use Locative to track devices in Home Assistant."
logo: locative.png
ha_category:
  - Presence Detection
ha_release: 0.86
ha_iot_class: Cloud Push
---

이 플랫폼에서는 [Locative](https://www.locative.io/)를 사용하여 위치 상태를 감지할 수 있습니다. 
Locative는 geofence가 시작되거나 종료될 때 사용자가 `GET` 또는`POST` 요청을 설정할 수있는 [iOS](https://apps.apple.com/us/app/locative/id725198453?ign-mpt=uo%3D4)용 오픈 소스 앱입니다. 홈 어시스턴트로 설정하여 위치를 업데이트 할 수 있습니다.

스마트 폰에 설치하십시오.

- [iOS](https://apps.apple.com/us/app/locative/id725198453?ign-mpt=uo%3D4)

Locative를 설정하려면 설정 화면의 **통합구성요소 패널**을 통해 Locative를 설정해야합니다. 설정하는 동안 통합구성요소에서 제공한 웹 후크 URL에서 POST 요청을 Home Assistant 서버로 보내도록 앱을 설정해야합니다. geofence를 입력하거나 종료하면 Locative가 해당 요청을 해당 URL로 보내 홈어시스턴트를 업데이트합니다. Locative에서 장치 이름을 지정할 수 없습니다. 대신, `dev-state` 메뉴에서 Locative가 첫 번째 `GET`에서 만들 새 장치를 찾아야합니다. Owntracks를 사용중이거나 업데이트해야할 경우 Owntracks 설정에 사용된 장치 이름을 Locative가 생성한 이름으로 업데이트해야합니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/locative.png'/>
</p>

지오펜스(geofence)를 입력하면 Home Assistant의 위치 이름이 Locative의 지오펜스 이름으로 설정됩니다. 지오펜스를 종료하면 Home Assistant의 위치 이름이 "not home"으로 설정됩니다.