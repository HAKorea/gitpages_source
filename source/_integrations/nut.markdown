---
title: 네트워크 전력관리(Network UPS Tools (NUT))
description: Instructions on how to set up NUT sensors within Home Assistant.
logo: nut.png
ha_category:
  - System Monitor
ha_iot_class: Local Polling
ha_release: 0.34
---

`nut` 센서 플랫폼을 사용하면 [NUT](https://networkupstools.org/)(Network UPS Tools) 서버의 데이터를 사용하여 UPS (배터리 백업)를 모니터링 할 수 있습니다.

## 설정

이 센서 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: nut
    resources:
      - ups.load
      - ups.realpower.nominal
      - input.voltage
      - battery.runtime
```

{% configuration %}
  name:
    description: Name prefix for defined sensors.
    required: false
    default: 'NUT UPS'
    type: string
  host:
    description: The host name or IP address of the device that is running NUT.
    required: false
    default: localhost
    type: string
  port:
    description: The port number.
    required: false
    default: 3493
    type: integer
  alias:
    description: Name of the ups on the NUT server.
    required: false
    default: Will default to the first UPS name listed.
    type: string
  username:
    description: Username to login to the NUT server.
    required: false
    default: none
    type: string
  password:
    description: Password to login to the NUT server.
    required: false
    default: none
    type: string
  resources:
    description: Contains all entries to display.
    required: true
    type: list
{% endconfiguration %}

## 사례

NUT에서 다음과 같은 출력 예가 제공되면 변수가 다를 수 있습니다.

```yaml
$ upsc ups_name@192.168.11.5
ups.timer.reboot: 0
battery.voltage: 27.0
ups.firmware.aux: L3 -P
ups.mfr: American Power Conversion
battery.runtime.low: 120
ups.delay.shutdown: 20
ups.load: 19
ups.realpower.nominal: 600
battery.charge.warning: 50
battery.charge.low: 10
ups.vendorid: 051d
ups.timer.shutdown: -1
ups.test.result: No test initiated
ups.firmware: 868.L3 -P.D
battery.mfr.ups.serial: 3B1519X19994
ups.productid: 0002
battery.runtime: 2552
battery.battery.voltage.nominal: 24.0
battery.type: PbAc
ups.mfr.ups.status: OL
ups.model: Back-UPS RS1000G
ups.beeper.status: disabled
battery.charge: 100
input.sensitivity: medium
input.transfer.low: 88
input.transfer.high: 147
input.voltage: 121.0
input.voltage.nominal: 120
input.transfer.reason: input voltage out of range
output.current: 1.10
output.frequency: 60.20
output.voltage: 121.50
output.voltage.nominal: 120
```

왼쪽 열의 값을 사용하십시오. 'ups', 'battery', 'input', 'output' 접두사가 있는 대부분의 값에 대한 지원이 포함됩니다.

```yaml
sensor:
  - platform: nut
    name: UPS Name
    host: 192.168.11.5
    port: 3493
    alias: ups_name
    username: user
    password: pass
    resources:
      - ups.load
      - ups.realpower.nominal
      - input.voltage
      - battery.runtime
```

## UPS 상태 - human-readable version

`ups.status` 에서 검색된 UPS 상태 값을 human-readable version으로 변환하는 추가 가상 센서 유형 `ups.status.display`를 사용할 수 있습니다.

```yaml
sensor:
  - platform: nut
    resources:
      - ups.status.display
```
