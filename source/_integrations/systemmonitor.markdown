---
title: 시스템 모니터(System Monitor)
description: Instructions on how to monitor the Home Assistant host.
logo: system_monitor.png
ha_category:
  - System Monitor
ha_release: pre 0.7
ha_iot_class: Local Push
---

`systemmonitor` 센서 플랫폼을 사용하면 디스크 사용량, 메모리 사용량, CPU 사용량 및 실행중인 프로세스를 모니터링 할 수 있습니다. 이 플랫폼은 더 이상 사용되지 않는 프로세스 통합구성요소를 대체했습니다.

이 플랫폼을 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: systemmonitor
    resources:
      - type: disk_use_percent
        arg: /home
      - type: memory_free
```

{% configuration %}
resources:
  description: Contains all entries to display.
  required: true
  type: list
  keys:
    type:
      description: The type of the information to display, please check the table below for details.
      required: true
    arg:
      description: Argument to use, please check the table below for details.
      required: false
{% endconfiguration %}

이 테이블에는`configuration.yaml` 파일에서 사용할 유형과 인수가 포함되어 있습니다.

| Type (`type:`)         | Argument (`arg:`)         |
| :--------------------- |:--------------------------|
| disk_use_percent       | Path, e.g., `/`           |
| disk_use               | Path, e.g., `/`           |
| disk_free              | Path, e.g., `/`           |
| memory_use_percent     |                           |
| memory_use             |                           |
| memory_free            |                           |
| swap_use_percent       |                           |
| swap_use               |                           |
| swap_free              |                           |
| load_1m                |                           |
| load_5m                |                           |
| load_15m               |                           |
| network_in             | Interface, e.g., `eth0`   |
| network_out            | Interface, e.g., `eth0`   |
| throughput_network_in  | Interface, e.g., `eth0`   |
| throughput_network_out | Interface, e.g., `eth0`   |
| packets_in             | Interface, e.g., `eth0`   |
| packets_out            | Interface, e.g., `eth0`   |
| ipv4_address           | Interface, e.g., `eth0`   |
| ipv6_address           | Interface, e.g., `eth0`   |
| processor_use          |                           |
| process                | Binary, e.g., `octave-cli` |
| last_boot              |                           |

## 리눅스에 한함

Linux 시스템에서 사용 가능한 모든 네트워크 인터페이스를 검색하려면 `ifconfig` 명령을 실행하십시오.

```bash
ifconfig -a | sed 's/[ \t].*//;/^$/d'
```

## 윈도우에 한함

Microsoft Windows에서이 플랫폼을 실행할 때 일반적으로 기본 인터페이스의 이름은 `Local Area Connection`이며 설정은 다음과 같습니다.

```yaml
sensor:
  - platform: systemmonitor
    resources:
      - type: network_in
        arg: 'Local Area Connection'
```

다른 인터페이스를 사용해야하는 경우 명령 행 프롬프트를 열고 `ipconfig`를 입력하여 모든 인터페이스 이름을 나열하십시오. 예를 들어 `ipconfig`의 무선 연결 출력은 다음과 같습니다.

```bash
Wireless LAN adapter Wireless Network Connection:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . :
```

이름이 `Wireless Network Connection` 인 경우