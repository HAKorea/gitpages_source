---
title: 장치 추적기(Device Tracker)
description: Instructions on how to setup device tracking within Home Assistant.
logo: home-assistant.png
ha_category:
  - Presence Detection
ha_release: 0.7
ha_quality_scale: internal
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/whGuasU9wEw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

device_tracker를 사용하면 Home Assistant에서 장치를 추적할 수 있습니다. 이는 무선 라우터를 쿼리하거나 응용 프로그램이 위치 정보를 푸시하도록하여 설정할 수 있습니다.

## device_tracker 플랫폼 설정

시작하려면 다음 설정을 `configuration.yaml`(Netgear의 예)에 추가하십시오. :

```yaml
# Example configuration.yaml entry for Netgear device
device_tracker:
  - platform: netgear
    host: IP_ADDRESS
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    new_device_defaults:
      track_new_devices: true
```

다음과 같은 선택적 매개 변수는 모든 플랫폼에서 사용할 수 있습니다.:

<div class='note'>
  Device tracker 첫 번째로 설정된 플랫폼의 설정값에서 전역 설정만을 찾습니다. 다음 3 가지 전역 설정입니다. : 
</div>

| Parameter           | Default | Description                                                                                                                                                                                                                                                                                                                                                                               |
|----------------------|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `interval_seconds`   | 12      | 새 장치를 검색 할 때마다 시간 (초)                                                                                                                                                                                                                                                                                     |
| `consider_home`      | 180     | 미처 찾지 못한 이후 누군가가 집에 없는 것으로 표시될 때까지 기다립니다. 이 매개 변수는 집에서 배터리 수명을 절약하기 위해 절전 모드로 전환되는 Apple iOS 장치가 있는 가정에서 가장 유용합니다. iPhone은 때때로 네트워크를 끊었다가 다시 나타납니다. `consider_home`은 Nmap과 같은 IP 스캐너를 사용할 때 재실 감지시 잘못된 탐지를 방지합니다. `consider_home`  다양한 시간 표현을 인식합니다. (예를 들어, 다음 모두가 3분을 나타냅니다 : `180`, `0:03`, `0:03:00`)  |

<div class='note'>

  `track_new_devices: false` 설정은  `known_devices.yaml`에서 기록되고 있는 새로운 장치들을 여전히 찾습니다만 이들은 반영되진 않습니다. (`track: false`).

</div>

위에서 확장된 예제는 다음 샘플과 같습니다. :

```yaml
# Example configuration.yaml entry for Netgear device
device_tracker:
  - platform: netgear
    host: IP_ADDRESS
    username: YOUR_USERNAME
    interval_seconds: 10
    consider_home: 180
    new_device_defaults:
      track_new_devices: true
```

[Owntracks](/integrations/owntracks/) 및 [Nmap](/integrations/nmap_tracker/)과 같은 여러 장치 추적기를 병렬로 사용할 수 있습니다. 장치의 상태는 마지막으로 보고한 소스에 따라 결정됩니다.

## `known_devices.yaml`

<div class='note warning'>

0.94 기준 `known_devices.yaml`은 단계적으로 폐지되어 모든 트래커에서 더이상 사용하지 않습니다. 통합구성요소의 상황에 따라 이 섹션이 더이상 적용되지 않을 수 있습니다. 여기에는 모바일앱, OwnTracks, GeoFency, GPSLogger, Locative 및 Huawei LTE가 해당됩니다.

</div>

`device_tracker`가 활성화되면 config 디렉토리에 `known_devices.yaml`파일이 생성됩니다. 추적할 장치를 조정하려면 이 파일을 편집하십시오.

단일 장치에 대한 설정예는 다음과 같습니다. :

```yaml
devicename:
  name: Friendly Name
  mac: EA:AA:55:E7:C6:94
  picture: https://www.home-assistant.io/images/favicon-192x192.png
  track: true
```

<div class='note warning'>

위의 사례는 `devicename` 에서 감지된 장치 이름을 나타냅니다.  예를들어 `nmap` 사용시, 이는 MAC address(바이트 구분 기호는 생략)로 나타납니다. 

</div>

| Parameter      | Default                       | Description                                                                                             |
|----------------|-------------------------------|---------------------------------------------------------------------------------------------------------|
| `name`         | Host name or "Unnamed Device" | 장치의 이름.                                                                         |
| `mac`          | None                          | MAC 주소. Nmap 또는 SNMP와 같은 네트워크 장치 추적기를 사용하는 경우 이를 추가하십시오.     |
| `picture`      | None                          | 사람이나 장치를 쉽게 식별하는데 사용할 수 있는 사진. configuration.yaml 파일에 `picture:/local/favicon-192x192.png`를 입력하고 동일 위치의 (개발자 도구에서 얻을 수 있는) “www” 폴더에 배치시킬 경우. 'local' 이라는 경로는 지금 만든 'www' 폴더로 매핑됩니다. 
| `icon`         | mdi:account                   | 이 장치의 아이콘. (`picture` 대신 사용).                           |
| `gravatar`     | None                          | 기기 소유자의 이메일 주소. 설정할 경우, `picture`에 합쳐집니다.                        |
| `track`        | [uses platform setting]       | `yes`/`on`/`true`일 경우 추적됩니다. 그렇지 않으면 위치와 상태가 업데이트되지 않습니다. |
| `consider_home` | [uses platform setting]      | 미처 찾지 못한후 누군가가 집에 없는 것으로 표시될 때까지 기다립니다. 각 장치별 플랫폼 설정에서 `consider_home` 전역설정을 통해 재정의 할 수 있습니다.  

## 장치 상태(Device states)

[home zone](/integrations/zone#home-zone) 에 있을 경우 추적된 장치가 네트워크나 블루투스 기반의 재실 감지로 찾아지면 `'home'` 상태가 될 것입니다. 좌표를 포함하는 재실 감지 방법을 사용하는 경우 영역에 있을 때, 상태는 영역의 이름이됩니다 (대소 문자 구분). 기기가 집에 없고 어떤 구역에도 있지 않으면 상태는 `'not_home'` 입니다.

## `device_tracker.see` 서비스

`device_tracker.see` 서비스를 사용하여 device tracker의 상태를 수동으로 업데이트 할 수 있습니다. :

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `dev_id`               |       no | `entity_id` 전체이름의 후반부 이름, 예:  `device_tracker.tardis` 에서 `tardis`   |
| `location_name`        |       no | 위치, `home`, `not_home`, 또는 영역의 이름 |
| `host_name`            |      yes | device tracker의 호스트 이름 |
| `mac`                  |      yes | entity의 MAC 주소 (네트워크 기반 추적기를 업데이트하는 경우에만 지정) |
| `gps`                  |      yes | 위치를 제공하는 경우 예: `[51.513845, -0.100539]` |
| `gps_accuracy`         |      yes | GPS의 정확성 |
| `battery`              |      yes | 장치의 배터리 잔량 |
