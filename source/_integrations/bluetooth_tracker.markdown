---
title: 블루투스 추적기(Bluetooth Tracker)
description: Instructions for integrating Bluetooth tracking within Home Assistant.
logo: bluetooth.png
ha_category:
  - Presence Detection
ha_iot_class: Local Polling
ha_release: 0.18
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/A2JaMiIXW9Q?start=426" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 추적기는 부팅시 새 장치를 검색하고 `interval_seconds` 값을 기준으로 Bluetooth 장치를 정기적으로 추적합니다. 장치를 서로 페어링할 필요는 없습니다! 

발견된 장치는 `known_devices.yaml`에 장치 MAC 주소의 접두사로 'bt_'와 함께 저장됩니다.

이 플랫폼에는 pybluez가 설치되어 있어야합니다. 데비안 기반 설치에서 다음을 실행합니다. 

```bash
sudo apt install bluetooth libbluetooth-dev
```

Bluetooth 트래커를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: bluetooth_tracker
```

{% configuration %}
request_rssi:
  description: 추적된 각 장치의 "수신된 신호 강도 표시"(RSSI)에 대한 요청을 수행.
  required: false
  type: boolean
  default: false
device_id:
  description: "추적기에서 사용할 Bluetooth 어댑터 ID (예: use `0` for `hci0`, `1` for `hci1`, and so on.)"
  required: false
  type: integer
  default: "`-1` (The first available bluetooth adapter)"
{% endconfiguration %}

경우에 따라 장치가 검색되지 않을 수 있습니다. 이 경우 Home Assistant를 다시 시작하는 동안 전화기에서 Bluetooth 장치를 검색하도록 하십시오. 홈어시스턴트가 완전히 다시 시작되고 장치가 `known_devices.yaml`에 표시될 때까지 휴대 전화에서 `scan` 을 누르십시오.

추가 설정 변수에 대해서는 [Device tracker page](/integrations/device_tracker/)를 확인 하십시오 .