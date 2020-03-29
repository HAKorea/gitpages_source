---
title: 네트워크측정(Iperf3)
description: How to use Iperf3 within Home Assistant to measure your network bandwidth.
logo: iperf3.png
ha_category:
  - System Monitor
  - Sensor
ha_release: 0.71
ha_iot_class: Local Polling
ha_codeowners:
  - '@rohankapoorcom'
---

`iperf3` 센서 연동을 통해 private 또는 public [Iperf3](https://software.es.net/iperf/index.html) 서버에 대한 네트워크 대역폭 성능을 측정할 수 있습니다.

이 통합구성요소를 활성화하면 모니터링된 조건(아래)에 대한 Iperf3 센서가 자동으로 생성됩니다. 기본적으로 매시간 실행됩니다. 사용자는 Iperf3 테스트를 실행할 `scan_interval`을 정의하여 설정에서 업데이트 빈도를 변경할 수 있습니다.

## 셋업

본 연동을 위해서는 OS에 `iperf3` 명령이 설치되어 있어야합니다. 설치 지침은 [official Iperf3 documentation](https://software.es.net/iperf/obtaining.html)를 참조하십시오.

## 설정

`iperf3` 센서를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

시간당 한 번, 시간 (기본값) :

```yaml
# Example configuration.yaml entry
iperf3:
  hosts:
    - host: iperf.he.net
```

{% configuration %}
  monitored_conditions:
    description: Sensors to display in the frontend.
    required: false
    type: list
    keys:
      download:
        description: The download speed (Mbit/s).
      upload:
        description: The upload speed (Mbit/s).
  hosts:
    description: A list of Iperf3 servers to perform the test against.
    required: true
    type: list
  scan_interval:
    description: "Minimum time interval between updates. Supported formats: `scan_interval: 'HH:MM:SS'`, `scan_interval: 'HH:MM'` and Time period dictionary (see example below)."
    required: false
    default: 60 minutes
    type: time
  manual:
    description: "`true` or `false` to turn manual mode on or off. Manual mode will disable scheduled tests."
    required: false
    type: boolean
    default: false
{% endconfiguration %}

Configuration variables (host):

{% configuration %}
  host:
    description: Server name/IP address running Iperf3 to test against.
    required: true
    type: string
  port:
    description: Port that Iperf3 is running on.
    required: false
    default: 5201
    type: integer
  duration:
    description: Specify the test duration in seconds. Default is 10 and the valid range is from 5 to 10.
    required: false
    default: 10
    type: integer
  parallel:
    description: Specify the number of concurrent streams to connect to the server. Default is 1 and the valid range is from 1 to 20.
    default: 1
    type: integer
  protocol:
    description: Specify the protocol to be used on the test. Default is TCP and the valid values are TCP or UDP. If your Iperf3 server is located in the Internet, consider to use TCP instead of UDP. If the protocol is set to use UDP, the sensor may not get updated due to package retransmission issues due to its nature.
    required: false
    default: tcp
    type: string
{% endconfiguration %}

#### Time period dictionary example

```yaml
scan_interval:
  # At least one of these must be specified:
  days: 0
  hours: 0
  minutes: 3
  seconds: 30
  milliseconds: 0
```

public Iperf3 서버 목록은 [여기](https://iperf.fr/iperf-servers.php)에서 찾을 수 있습니다. [mlabbe/iperf3's](https://hub.docker.com/r/mlabbe/iperf3/) 도커 이미지를 사용하여 자체 Iperf3 서버를 시작하거나 `iperf3` 명령의 매뉴얼 페이지를 참조할 수도 있습니다.

`scan_interval` 값을 초단위로 설정하여 테스트가 자동으로 트리거되는 빈도를 조정할 수 있습니다.

병렬 스트림은 일부 상황에서 도움이 될 수 있습니다. TCP가 공정하고 보수적일 때 `parallel` 속성을 높이는 것을 고려할 수 있습니다. 이 값을 신중하게 사용하고 자세한 내용은 Iperf3 매뉴얼 페이지를 참조하십시오.

`sensor.iperf3_update` 서비스를 사용하여 모든 센서에 대해 수동 속도 테스트를 시작할 수 있습니다. Iperf3에는 특정 엔티티에 대한 속도 테스트를 수행할 수있는 자체 서비스 호출이 있습니다.

### 서비스

`iperf3` 통합구성요소는 일단 로드되면 요청시 속도 테스트를 실행하기 위해 호출할 수 있는 서비스(`ipepe3.speedtest`)를 노출합니다. 수동 모드를 활성화한 경우 유용할 수 있습니다.

| Service data attribute | Description |
| `host` | String that point at a configured `host` from configuration.yaml. Otherwise, tests will be run against all configured hosts.

서비스 데이터 예 :

```json
{"host": "192.168.0.121"}
```

## Notes

- Raspberry Pi에서 실행할 때 최대속도는 100Mbit/s로서 LAN 어댑터에 의해 제한됩니다.
