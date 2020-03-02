---
title: 컴맨드 라인(Command Line)
description: Instructions on how to integrate Command binary sensors within Home Assistant.
logo: command_line.png
ha_category:
  - Utility
ha_release: 0.12
ha_iot_class: Local Polling
---

`command_line` binary sensor 플랫폼은 데이터를 가져오기 위한 특정 명령을 만들어 낼 수 있습니다.

## 설정

binary sensor 명령을 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.:

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: command_line
    command: 'cat /proc/sys/net/ipv4/ip_forward'
```

<div class='note'>

명령에 `'` 문자를 사용할 수 있고 의도하지 않은 이스케이프 위험을 줄이기 때문에 명령을 작은 따옴표 로 묶는 것이 좋습니다. 작은 따옴표로 묶인 명령에 작은 따옴표를 포함하려면 `''`(따옴표를 두 번) 사용하십시오.

</div>

{% configuration %}
command:
  description: 값을 가져오기 위한 action.
  required: true
  type: string
name:
  description: 장치 이름을 덮어 쓰게 합니다.
  required: false
  type: string
  default: "*name* from the device"
device_class:
  description: 프론트 엔드에 표시되는 디바이스 상태 및 아이콘을 변경하여 [class of the device](/integrations/binary_sensor/) 를 설정합니다. 
  required: false
  type: string
payload_on:
  description: 활성화 된 상태를 나타내는 페이로드입니다.
  required: false
  type: string
  default: 'ON'
payload_off:
  description: 비활성화 된 상태를 나타내는 페이로드입니다.
  required: false
  type: string
  default: 'OFF'
value_template:
  description: 페이로드에서 값을 추출하기 위한 [template](/docs/configuration/templating/#processing-incoming-data) 을 정의합니다.
  required: false
  type: string
scan_interval:
  description: 폴링 간격의 시간 (초)를 정의합니다.
  required: false
  type: integer
  default: 60
command_timeout:
  description: 명령 제한 시간 (초)을 정의합니다.
  required: false
  type: integer
  default: 15
{% endconfiguration %}

## 사례

이 섹션에는 본 센서를 실생활에 사용하는 방법에 대한 사례를 찾을 수 있습니다. 

### SickRage

[SickRage](https://github.com/sickragetv/sickrage)인스턴스 상태를 확인합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: command_line
    command: 'netstat -na | find "33322" | find /c "LISTENING" > nul && (echo "Running") || (echo "Not running")'
    name: 'sickragerunning'
    device_class: moving
    payload_on: "Running"
    payload_off: "Not running"
```

### Check RasPlex

[RasPlex](https://www.rasplex.com/)가 `online`인지 확인합니다.

```yaml
binary_sensor:
  - platform: command_line
    command: 'ping -c 1 rasplex.local | grep "1 received" | wc -l'
    name: 'is_rasplex_online'
    device_class: connectivity
    payload_on: 1
    payload_off: 0
```

또한 다른 방법은 다음과 같습니다.:

```yaml
binary_sensor:
  - platform: command_line
    name: Printer
    command: 'ping -W 1 -c 1 192.168.1.10 > /dev/null 2>&1 && echo success || echo fail'
    device_class: connectivity
    payload_on: "success"
    payload_off: "fail"
```

위의 샘플 대신 [`ping` sensor ](/integrations/ping#binary-sensor) 를 사용하십시오.

### 시스템 서비스가 실행 중인지 확인

`/etc/systemd/system`에 실행중인 서비스가 나열되어 있으며 `systemctl` 명령으로 확인할 수 있습니다. :

```bash
$ systemctl is-active home-assistant@rock64.service
active
$ sudo service home-assistant@rock64.service stop
$ systemctl is-active home-assistant@rock64.service
inactive
```

binary command line 센서로 다음과 같이 확인할 수 있습니다. :

```yaml
binary_sensor:
  - platform: command_line
    command: '/bin/systemctl is-active home-assistant@rock64.service'
    payload_on: 'active'
    payload_off: 'inactive'
```
