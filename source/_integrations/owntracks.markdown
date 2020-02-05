---
title: OwnTracks
description: Instructions on how to use Owntracks to track devices in Home Assistant.
logo: owntracks.png
ha_category:
  - Presence Detection
ha_release: 0.7.4
ha_config_flow: true
---

[OwnTracks](https://owntracks.org/)는 아이폰과 안드로이드에서 위치정보를 트래킹하여 홈어시스턴트와 연동하는 오픈소스입니다. 설정 화면에서 통합구성요소로 간단히 추가할 수 있습니다.

기본 통합 설정은 HTTP 프로토콜을 통해 OwnTracks가 보내는 메시지를 수신합니다. 그리고 홈어시스턴트의 MQTT 서버 설정을 한 다음 MQTT 프로토콜로 메시지를 수신하는 것도 가능합니다.

<div class='videoWrapper'>
<!-iframe width="560" height="315" src="https://www.youtube.com/embed/UieAQ8sC6GY" frameborder="0" allowfullscreen></iframe>
</div>

## 설정

OwnTracks를 사용하기 위해 설정화면에서 통합구성요소를 추가합니다. 이 과정에서 모바일 기기와 연동가능한 웹훅 URL이 제공됩니다.

### Android

[OwnTracks 안드로이드 앱 설치](https://play.google.com/store/apps/details?id=org.owntracks.android)

Owntracks 앱에서 환경 설정을 선택하고 connection 설정을 찾아 다음과 같이 입력합니다:

 - Mode: Private HTTP
 - Host: `<통합구성요소 설정 단계에서 제시한 URL>`
 - Identification:
   - Username: `<Username>`
   - Password: 비번이 없는 경우 공백으로 남김
   - Device ID: `<Device name>`
   - Tracker ID: `<xx>` 트래커에 표시할 알파벳 두자리(없어도 됨)

트래커 기기는 홈어시스턴트에서 `<Username>_<Device name>` 형태로 나타납니다. Tracker ID를 기입하면 tid attribute 속성값을 사용할 수 있습니다.

### iOS

[Owntracks 아이폰 앱 설치](https://itunes.apple.com/us/app/owntracks/id692424691?mt=8)

아이폰 OwnTracks 앱에서 좌측 상단에 있는 (i) 아이콘을 클릭하고 설정을 시작합니다:

 - Mode: HTTP
 - URL: `<통합구성요소 설정 단계에서 제시한 URL>`
 - Turn on authentication
 - User ID: `<Your name>`

## 고급 설정

OwnTracks는  `configuration.yaml` 파일에서 다양한 설정을 할 수 있습니다.

```yaml
# Example configuration.yaml entry
owntracks:
```

{% configuration %}
max_gps_accuracy:
  description: Owntracks는 간혹 낮은 정확도로 GPS 위치를 전달하고(수키로미터 차이가 나는 경우) 이 경우 홈어시스턴트에서 잘못된 존(Zone)에 따른 잘못된 재실 감지 이벤트를 발생시킬 수 있습니다. GPS 위치에 따른 오차를 보정하기 위해 이 옵션을 설정합니다. 설정값은 미터단위입니다.예를 들어 값을 200으로 설정하면 GPS 위치가 이전 값과 200미터 차이나는 것은 무시합니다(GPS 위치 중 튀는 값을 제외).
  required: false
  type: integer
waypoints:
  description: "Owntracks 사용자는  [waypoints](https://owntracks.org/booklet/features/waypoints/) (a.k.a regions)를 설정할 수 있습니다. 이것은 홈어시스턴트의 존 기능과 유사합니다. 이 옵션을 `true`로 설정하면, `waypoint_whitelist`에 있는 Owntracks 사용자는 기기의 waypoints를 홈어시스턴트가 존 설정으로 가져올 수 있게 허용합니다.
  required: false
  default: true
  type: boolean
waypoint_whitelist:
  description: "자신의 기기의 waypoints를  홈어시스턴트가 사용할 수 있게 허락하는 Owntracks 사용자 리스트. 베이스 토픽에 `username` 서브 토픽을 추가함(예시: owntracks/**username**/iPhone)"
  required: false
  default: OwnTracks를 통해 홈어시스턴트에 연결된 모든 사용자.
  type: list
secret:
  description: "[Payload encryption key](https://owntracks.org/booklet/features/encrypt/). 신뢰할 수 없는 서버나 퍼블릭 서버(다수의 사용자가 공유해서 토픽을 주고받는 경우)를 사용한다면 유용한 기능입니다. 기본적으로 페이로드는 암호화 없이 전송하는 걸 가정합니다(홈어시스턴트와 서버가 암호화 전송을 한다 하더라도).이 기능은 `libsodium`를 필요로 합니다"
  required: false
  type: string
mqtt_topic:
  description: Owntracks가 전송하는 MQTT 메시지 토픽
  required: false
  default: owntracks/#
  type: string
events_only:
  description: 홈어시턴트는 모든 위치 정보를 무시하고 재실 감지 이벤트인(geofence) enter/leave만 사용합니다.
  required: false
  type: boolean
  default: false
region_mapping:
  description: "OwnTracks에서 사용하는 region을 홈어시스턴트에서 사용하는 zone 이름으로 대체할 때 사용합니다. 다수의 home 이라는 이름을 써야 하거나 홈어시스턴트를 여러개 운용할 때 다른 이름으로 변경을 원한다면 사용하세요. `key: value`에서 Owntracks의 region이 `key`이며 홈어시스턴트의 zone이 `value`입니다."
  required: false
  type: list
{% endconfiguration %}

`owntracks` 플랫폼에 대한 설정 예시는 다음과 같습니다:

```yaml
# Example configuration.yaml entry
owntracks:
  max_gps_accuracy: 200
  waypoints: true
  mqtt_topic: "owntracks/#"
  events_only: true
  waypoint_whitelist:
    - jon
    - ram
  region_mapping:
    cabin: home
    office: work
```

## Owntracks의 region

OwnTracks는 특정 영역(region)에 대해 들어가고 나가는 것을 체크하여 홈어시스턴트로 전달이 가능합니다. OwnTracks 앱에서 region을 설정하고 홈어시스턴트의 존(zone)과 동일한 이름을 부여한다음 OwnTracks 앱에서 region에 대해 `share` 옵션을 켤 수가 있습니다. 자세한 것은  [owntracks documentation](https://owntracks.org/booklet/guide/waypoints/)을 참고하세요.

홈어시스턴트는 존에 대한 출입 여부를 메시지로 사용할 수 있습니다. 만일 여러분이 존으로 들어가면 여러분의 위치는 존의 중심 위치로 설정되며 존 안에 있을 때 OwnTracks가 전달하는 위치는 무시합니다.

존을 벗어나면 홈어시스턴트는 다시 여러분을 추적하기 위해 위치 정보를 업데이트합니다. 홈어시스턴트가 존을 벗어난 것을 정확히 감지하고 싶다면(GPS 좌표를 기준으로 계산합니다), 홈어시스턴트에서 존의 반경을 OwnTracks의 region 반경보다 살짝 작게 설정하면 됩니다.

## Owntracks regions - iBeacon 사용

<div class='note'>
안드로이드에서는 Owntracks v2.0.0 부터 iBeacons을 지원하지 않습니다.
</div>
*significant changes mode* (스마트폰의 배터리를 조금 빨리 소모)에서 OwnTracks는 존에 출입한 것을 원하는 만큼 빨리 반영하지 못하기도 합니다. 이 경우 집에 도착한 것을 자동화 트리거로 사용하고 싶은데 그렇지 못해 짜증날 수도 있습니다. 이런 상황은 iBeacon으로 개선할 수 있습니다.

iBeacon은 "나 여깄어"라는 메시지를 보내는 소형 블루투스 기기로 아이폰이나 몇몇 안드로이드폰에서 이용할 수 있습니다. 자세한 설명은 Owntracks [문서](https://owntracks.org/booklet/guide/beacons/)를 참고하세요.

iBeacon 영역으로 들어가면 OwnTracks는 `region enter` 메시지를 홈어시스턴트에 전달합니다. 따라서 집에 도착한 것을 이벤트 트리거로 사용하고 싶다면 iBeacon을 대문 근처에 두고 사용할 수 있습니다. OwnTracks iBeacon으로 `home`이라는 영역을 설정하고 비콘에 가까이 갔을때 홈어시스턴트 트리거를 생성하여 `home` 존에 도착한 것을 감지하면 됩니다.

iBeacon 영역을 벗어나면 홈어시스턴트는 위치를 추적하기 위해 GPS 정보를 사용기 시작합니다. GPS 위치의 정확도와 존의 크기에 따라 홈어시스턴트가 반응하는 범위에 차이가 날 수 있습니다.

OwnTracks는 간혹 iBeacon과의 수초간 연결이 안될 수도 있는데 이럴 때는 비콘의 region 이름에 `-`를 붙여 Owntracks가 비콘 영역을 벗어난 것에 대해 체크하는 시간을 늘릴 수 있습니다. 홈어시스턴트는 존과 매칭되는 OwnTracks region 이름에서 `-` 기호는 무시합니다. Owntracks의  region을 `-home`라고 지으면 홈어시스턴트에서는 `home`으로 인식하고 iBeacon 연결을 보다 확실하게 체크합니다.

## 디바이스를 추적하기 위해 Owntracks iBeacons을 사용

iBeacon은 한곳에 고정한채로 사용하지 않아도 됩니다. 가령 열쇠꾸러미나 차안에 두고 이동식으로 사용할 수도 있죠.

스마트폰으로 이동식 iBeacon을 발견하면 iBeacon의 위치를 홈어시스턴트에 전송할 수 있습니다. iBeacon에 연결된채 스마트폰이 이동한다면 홈어시스터트는 iBeacon의 위치도 함께 업데이트합니다. 그러나 스마트폰이 iBeacon과 끊어지면 홈어시스턴트는 iBeacon의 위치 업데이트를 중단합니다.

이동식 iBeacon을 홈어시스턴트와 함께 사용하면 region은 zone과 동일하게 만들 수는 없습니다. 홈어시스턴트가 iBeacon의 region으로 들어갔다는 이벤트를 받으면 이것을 zone과 연결하지 않아야 하고(예를 들어 열쇠에 달린 `keys` region) 기기 형태로 `device_tracker.beacon_keys`를 추적해야 합니다.

이 방법은 기기를 존으로 설정하여 자동화로 사용할 수 있습니다 예를 들어 **내가 집을 나설때 열쇠가 집안에 있다면 알람을 받는다** 는 자동화가 가능합니다. 다른 예로 **차가 집에 도착하면 차고문을 연다** 와 같이 쓸 수 있습니다.

## 이동식/고정식 iBeacons을 함께 사용

iBeacon의 두가지 타입을 함께 사용할 수 있는데 `-drive` 라는 iBeacon region이 있고 `drive`라는 존이 존재하며 이동식 iBeacon인 `-car`가 집에 도착할 때  `device_tracker.beacon_car` 는 `drive`의 상태를 변경할 수 있습니다.

## Importing Owntracks waypoints as zones

By default, any Owntracks user connected to Home Assistant can export their waypoint definitions (from the *Export - Export to Endpoint* menu item) which will then be translated to zone definitions in Home Assistant. The zones will be named `<user>-<device> - <waypoint name>`. This functionality can be controlled in 2 ways:

1. The configuration variable `waypoints` can be set to `false` which will disable importing waypoints for all users.
2. The configuration variable `waypoint_whitelist` can contain a list of users who are allowed to import waypoints.
