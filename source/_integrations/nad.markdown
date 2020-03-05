---
title: NAD(명품오디오리시버)
description: Instructions on how to integrate NAD receivers into Home Assistant.
logo: nad.png
ha_category:
  - Media Player
ha_release: 0.36
ha_iot_class: Local Polling
---

`nad` 플랫폼을 사용하면 Home Assistant의 RS232, TCP 및 Telnet을 통해 [NAD 수신기](https://nadelectronics.com/)를 제어할 수 있습니다.

설치에 NAD 수신기를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry for RS232 configuration
media_player:
  - platform: nad
    serial_port: /dev/ttyUSB0
```
```yaml
# Example configuration.yaml entry for TCP configuration
media_player:
  - platform: nad
    type: TCP
    host: IP_ADDRESS
```

{% configuration %}
type:
  description: 통신 타입. 유효한 타입은 `RS232`, `Telnet` 혹은 `TCP`
  required: false
  default: RS232
  type: string
serial_port:
  description: 시리얼 포트. (`RS232` 타입만 해당)
  required: false
  default: /dev/ttyUSB0
  type: string
host:
  description: 앰프의 IP 주소. (`TCP` 및 `Telnet` 유형)
  required: false
  type: string
port:
  description: 장치의 포트 번호. (`Telnet`유형만 해당)
  required: false
  default: 53
  type: integer
name:
  description: 장치 이름
  required: false
  default: NAD Receiver
  type: string
min_volume:
  description: 슬라이더와 함께 사용할 최소 볼륨 (dB).
  required: false
  default: -92
  type: integer
max_volume:
  description: 슬라이더와 함께 사용할 최대 볼륨 (dB).
  required: false
  default: -20
  type: integer
sources:
  description: 미디어에서 미디어이름을 매핑한 리스트. 유효한 미디어갯수는 `1 ~ 10`개 (`RS232` 및  `Telnet` 유형)
  required: false
  type: [list, string]
volume_step:
  description: 볼륨을 올리거나 내릴 때 볼륨을 높이려는 dB 단위의 양입니다. (`TCP` 타입 만 해당)
  required: false
  default: 4
  type: integer
{% endconfiguration %}

min_volume 및 max_volume은 슬라이더를 잘못 클릭하지 않도록 보호하기 위해 -92dB에서 + 20dB로 이동할 때 스피커가 터지지 않도록합니다. 플러스 및 마이너스 버튼으로 설정한 값보다 높거나 낮게 설정할 수 있습니다.

<div class='note warning'>

리눅스에서 홈어시스턴트를 실행하는 사용자는 시리얼 포트에 액세스하기 위해 `dialout` 권한이 필요합니다.
`sudo usermod -a -G dialout <username>`을 통해 사용자에게 추가 할 수 있습니다.
이러한 권한을 활성화하려면 사용자가 로그 아웃했다가 다시 로그온해야 할 수도 있습니다.

</div>

전체 설정 예는 다음과 같습니다.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: nad
    serial_port: /dev/ttyUSB0
    name: NAD Receiver
    min_volume: -60
    max_volume: -20
    sources:
      1: 'Kodi'
      2: 'TV'
```
