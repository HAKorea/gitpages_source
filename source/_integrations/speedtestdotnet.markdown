---
title: 네트워크속도테스트(Speedtest.net)
description: How to integrate Speedtest.net within Home Assistant.
logo: speedtest.png
ha_category:
  - System Monitor
  - Sensor
ha_release: 0.13
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@rohankapoorcom'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/kV3NBzz2Afw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`speedtestdotnet` 통합구성요소는 [Speedtest.net](https://speedtest.net/) 웹 서비스를 사용하여 네트워크 대역폭 성능을 측정합니다.

이 통합구성요소를 활성화하면 모니터링된 조건(아래)에 대한 Speedtest.net 센서가 자동으로 생성됩니다.

기본적으로 속도 테스트는 1시간마다 실행됩니다. 사용자는 속도 테스트를 실행하기 위해 `scan_interval`을 정의하여 설정에서 업데이트 빈도를 변경할 수 있습니다.

대부분의 Speedtest.net 서버가 작동하려면 TCP 포트 8080 아웃 바운드가 필요합니다. 이 포트를 열지 않으면 상당한 지연이 발생하거나 결과가 전혀 나타나지 않을 수 있습니다. [help page](https://www.speedtest.net/help)에 있는 참고 사항을 참조하십시오.

## 설정

`server_id`의 경우 [available servers](http://www.speedtestserver.com)목록을 확인하십시오.

Speedtest.net 센서를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

시간당 한 번 (기본값) :

```yaml
# Example configuration.yaml entry
speedtestdotnet:
```

{% configuration %}
monitored_conditions:
  description: Sensors to display in the frontend.
  required: false
  default: All keys
  type: list
  keys:
    ping:
      description: "Reaction time in ms of your connection (how fast you get a response after you've sent out a request)."
    download:
      description: "The download speed (Mbit/s)."
    upload:
      description: "The upload speed (Mbit/s)."
server_id:
  description: Specify the speed test server to perform the test against.
  required: false
  type: integer
scan_interval:
  description: "Minimum time interval between updates. Supported formats: `scan_interval: 'HH:MM:SS'`, `scan_interval: 'HH:MM'` and Time period dictionary (see example below)."
  required: false
  default: 60 minutes
  type: time
manual:
  description: "`true` or `false` to turn manual mode on or off. Manual mode will disable scheduled speed tests."
  required: false
  type: boolean
  default: false
{% endconfiguration %}

### 주기에 따른 사전(dictionary) 사례

```yaml
scan_interval:
  # At least one of these must be specified:
  days: 0
  hours: 0
  minutes: 3
  seconds: 30
  milliseconds: 0
```

### 서비스

일단 `speedtestdotnet` 통합구성요소는 필요할 때 Speedtest.net 속도 테스트를 실행하기 위해 호출  수있는 서비스 (`speedtestdotnet.speedtest`)를 노출합니다. 이 서비스에는 매개 변수가 없습니다. 수동 모드를 활성화한 경우 활용할 수 있습니다.

```yaml
action:
  service: speedtestdotnet.speedtest
```

이 통합구성요소는 [speedtest-cli](https://github.com/sivel/speedtest-cli)를 사용하여 Speedtest.net에서 네트워크 성능 데이터를 수집합니다.
이 통합구성요소가 표시할 수있는 잠재적인 [inconsistencies](https://github.com/sivel/speedtest-cli#inconsistency)에 유의하십시오.
홈어시스턴트가 처음 시작되면 속도 테스트 센서의 값이 `Unknown` 으로 표시됩니다. `speedtestdotnet.speedtest` 서비스를 사용하여 수동 속도 테스트를 실행하고 데이터를 채우거나 정기적으로 예약된 다음 테스트를 기다릴 수 있습니다. 수동 모드를 켜서 예약된 속도 테스트를 비활성화 할 수 있습니다.

## 사례

이 섹션에서는이 구성 요소를 사용하는 방법에 대한 실제 예를 제공합니다.

### 주기적으로 실행

매일 30 분마다 :

```yaml
# Example configuration.yaml entry
speedtestdotnet:
  scan_interval:
    minutes: 30
  monitored_conditions:
    - ping
    - download
    - upload
```

### 자동화에서 트리거로 사용

{% raw %}
```yaml
# Example configuration.yaml entry
automation:
  - alias: "Internet Speed Glow Connect Great"
    trigger:
      - platform: template
        value_template: "{{ states('sensor.speedtest_download')|float >= 10 }}"
    action:
      - service: shell_command.green

  - alias: "Internet Speed Glow Connect Poor"
    trigger:
      - platform: template
        value_template: "{{ states('sensor.speedtest_download')|float < 10 }}"
    action:
      - service: shell_command.red
```
{% endraw %}

## 참고사항

- Raspberry Pi에서 실행할 때 최대 속도는 LAN 어댑터에 의해 제한됩니다. Raspberry Pi 3+ 모델은 300Mbit/s의 [maximum throughput](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)을 지원하는 기가비트 LAN 어댑터와 함께 제공됩니다.
- 이 통합구성요소를 실행하면 상당한 양의 메모리가 필요하므로 시스템 성능에 부정적인 영향을 줄 수 있습니다.
- `monitored_conditions` 아래의 항목은 Home Assistant에서 사용할 수있는 엔티티 만 제어하며 실행시 조건들을 비활성화하지 않습니다.
- 자주 실행하는 경우이 통합구성요소에는 상당한 양의 데이터를 사용할 수 있습니다. 대역폭 제한 연결시엔 자주 업데이트하지 않아야합니다.
- 속도 테스트가 실행되는 동안 네트워크 용량이 전부 활용됩니다. 이는 게임 콘솔이나 스트리밍 박스와 같은 네트워크를 사용하는 다른 장치에 부정적인 영향을 줄 수 있습니다.
