---
title: 장치확인 Ping (ICMP) 
description: Instructions on how to integrate Ping (ICMP)-based into Home Assistant.
logo: home-assistant.png
ha_category:
  - Network
  - Binary Sensor
  - Presence Detection
ha_release: 0.43
ha_quality_scale: internal
---

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Presence Detection](#presence-detection)

## Binary Sensor

`ping` 이진 센서 플랫폼에서는 `ping`을 사용하여 ICMP 에코 요청을 보낼 수 있습니다. 이렇게하면 지정된 호스트가 온라인 상태인지 확인하고 Home Assistant 인스턴스에서 해당 시스템으로의 왕복 시간을 결정할 수 있습니다.

설치시 이 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: ping
    host: 192.168.0.1
```

{% configuration %}
host:
  description: 추적하려는 시스템의 IP 주소 또는 호스트 이름.
  required: true
  type: string
count:
  description: 보낼 패킷 수.
  required: false
  type: integer
  default: 5
name:
  description: 장치 이름을 덮어 씁니다..
  required: false
  type: string
  default: Ping Binary sensor
{% endconfiguration %}

센서는 `ping`에 의해 측정된 서로 다른 왕복 시간 값을 속성으로 노출합니다.

- `round trip time mdev`
- `round trip time avg`
- `round trip time min`
- `round trip time max`

기본 폴링 간격은 5 분입니다. [based on the entity class](/docs/configuration/platform_options)이므로 `scan_interval` 설정 키 (초 단위의 값)를 지정하여 이 스캔 간격을 덮어쓸 수 있습니다. 아래 예에서는 `ping` 바이너리 센서를 설정하여 30 초마다 장치를 폴링합니다.

```yaml
# Example configuration.yaml entry to ping host 192.168.0.1 with 2 packets every 30 seconds.
binary_sensor:
  - platform: ping
    host: 192.168.0.1
    count: 2
    scan_interval: 30
```

<div class='note'>
Windows 시스템에서 실행될 때 왕복 시간 속성은 가장 가까운 밀리초로 반올림되며 mdev 값을 사용할 수 없습니다.
</div>

## 존재 감지 (Presence Detection)

`ping` 장치 추적기 플랫폼은 `ping`을 사용하여 ICMP 에코 요청을 전송하여 존재 감지를 제공합니다. 이는 장치가 방화벽을 실행 중이고 UDP 또는 TCP 패킷을 차단하지만 ICMP 요청 (Android 전화 등)에 응답 할 때 유용 할 수 있습니다. 호스트는 다른 서브넷에 있을 수 있으므로 이 트래커는 MAC 주소를 알 필요가 없습니다. 이것은 `arp`가 작동하지 않기 때문에 `nmap` 또는 다른 솔루션이 작동하지 않을 때 다른 서브넷에서 호스트를 감지하는 옵션입니다.

<div class='note'>
  최신 스마트 폰은 일반적으로 유휴 상태 일 때 WiFi를 끕니다. 이와 같은 간단한 추적기는 자체적으로 신뢰할 수 없습니다.
</div>

### 설정

설치에서 이 존재 감지를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: ping
    hosts:
      hostone: 192.168.2.10
```

{% configuration %}
hosts:
  description: 장치 이름 및 해당 IP 주소 또는 호스트 이름 목록.
  required: true
  type: list
count:
  description: 각 장치에 사용 된 패킷 수 (오탐지 방지).
  required: false
  type: integer
{% endconfiguration %}

추적 할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.