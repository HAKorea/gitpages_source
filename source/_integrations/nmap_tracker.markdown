---
title: Nmap 추적기(nmap Tracker)
description: Instructions on how to integrate Nmap into Home Assistant.
logo: nmap.png
ha_category:
  - Presence Detection
ha_release: 0.7
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/9XlgyZORKiY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

라우터 기반 장치 추적의 대안으로 Nmap을 사용하여 장치의 네트워크를 직접 검색 할 수 있습니다. 스캔 할 IP 주소는 네트워크 접두사 표기법 (`192.168.1.1/24`) 및 범위 표기법 (`192.168.1.1-255`)을 포함하여 Nmap이 이해하는 모든 형식으로 지정할 수 있습니다

<div class='note'>
  최신 스마트 폰은 일반적으로 유휴 상태 일 때 WiFi를 끕니다. 이와 같은 간단한 추적기는 자체적으로 신뢰할 수 없습니다.
</div>

`arp` 및 `nmap` 용 패키지를 설치해야 할 수도 있습니다. 데비안 기반의 호스트 (예: Raspbian)에서는 `$ sudo apt-get install net-tools nmap`을 실행하십시오. Fedora 호스트에서 `$ sudo dnf -y install nmap`을 실행하십시오.

<div class='note'>

[Hass.io](/hassio/)를 사용하는 경우 모든 요구 사항이 이미 충족되었으므로 설정으로 이동하십시오.

</div>

호스트 감지는 가장 자주 사용되는 100 개 포트 중 Nmap의 "fast scan"(`-F`)을 통해 수행되며 호스트 시간 제한은 5 초입니다.

이 장치 추적기를 사용하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: nmap_tracker
    hosts: 192.168.1.0/24
```

{% configuration %}
hosts:
  description: The network address to scan (in any supported Nmap format). Mixing subnets and IPs is possible.
  required: true
  type: string
home_interval:
  description: The number of minutes Nmap will not scan this device, assuming it is home, in order to preserve the device battery.
  required: false
  type: integer
exclude:
  description: Hosts not to include in Nmap scanning. Scanning the host where Home Assistant is running can cause problems (websocket error and authentication failures), so excluding that host is a good idea.
  required: false
  type: list
scan_options:
  description: Configurable scan options for Nmap.
  required: false
  default: -F --host-timeout 5s
  type: string
{% endconfiguration %}

## 사례

`nmap` 트래커의 전체 예제는 다음 샘플과 같습니다.

```yaml
# Example configuration.yaml entry for Nmap
# One whole subnet, and skipping two specific IPs.
device_tracker:
  - platform: nmap_tracker
    hosts: 192.168.1.0/24
    home_interval: 10
    exclude:
     - 192.168.1.12
     - 192.168.1.13
```

```yaml
# Example configuration.yaml for Nmap
# One subnet, and two specific IPs in another subnet.
device_tracker:
  - platform: nmap_tracker
    hosts:
      - 192.168.1.0/24
      - 10.0.0.2
      - 10.0.0.15
```
위의 예에서 Nmap은 다음 프로세스와 같이 호출됩니다.:
`nmap -oX - 192.168.1.1/24 10.0.0.2 10.0.0.15 -F --host-timeout 5s`

Nmap 스캐너를 사용자 정의 할 수 있는 방법의 예 :

### 리눅스 기능

Linux 시스템 (예: Hass.io)에서 *Linux 기능*을 사용하여 루트로 실행하지 않고도 Nmap의 기능을 확장 할 수 있습니다. Nmap을 설치 한 곳의 전체 경로를 지정하십시오

```bash
$ sudo setcap cap_net_raw,cap_net_admin,cap_net_bind_service+eip /usr/bin/nmap
```

장치 추적기를 다음과 같이 설정할 수 있습니다.
```yaml
- platform: nmap_tracker
  hosts: 192.168.1.1-25
  scan_options: " --privileged -sP "
```

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.