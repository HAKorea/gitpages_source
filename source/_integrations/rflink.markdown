---
title: RFLink
description: Instructions on how to integrate RFLink gateway into Home Assistant.
logo: rflink.png
ha_category:
  - Hub
ha_release: 0.38
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/dqjK-LWDwE4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`rflink` 통합구성요소는 [RFLink 게이트웨이 펌웨어](http://www.rflink.nl/blog2/download)를 사용하는 장치 (예: [Nodo RFLink Gateway](https://www.nodo-shop.nl/nl/21-rflink-gateway))를 지원합니다. RFLink 게이트웨이는 저렴한 하드웨어 (Arduino + 트랜시버)를 사용하여 여러 RF 무선 장치와 양방향 통신을 가능하게하는 Arduino Mega 펌웨어입니다.

433MHz 스펙트럼은 대부분 자체 제조업체의 프로토콜/표준을 사용하는 많은 제조업체에서 사용하며 조명 스위치, 블라인드, 기상 관측소, 경보 및 기타 다양한 센서와 같은 장치를 포함합니다.

RFLink 게이트웨이는 광범위한 저비용 하드웨어를 사용하여 여러 RF 주파수를 지원합니다. [Their website](http://www.rflink.nl/blog2/)는 433MHz, 868MHz 및 2.4GHz를위한 다양한 RF 송신기, 수신기 및 송수신기 모듈에 대한 세부 정보를 제공합니다.

<div class='note'>
참고: R44 이후 버전은 Ikea Ansluta, Philips Living Colors Gen1 및 MySensors 장치에 대한 지원을 추가합니다.
</div>

RFLink가 지원하는 전체 장치 목록은 [여기](http://www.rflink.nl/blog2/devlist)에서 확인할 수 있습니다.

이 통합구성요소는 다음 하드웨어/소프트웨어로 테스트되었습니다.

- Nodo RFLink Gateway V1.4/RFLink R46

## 설정

설치시 RFLink를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
rflink:
  port: /dev/serial/by-id/usb-id01234
```

{% configuration %}
port:
  description: The path to RFLink USB/serial device or TCP port in TCP mode.
  required: true
  type: string
host:
  description: Switches to TCP mode, connects to host instead of to USB/serial.
  required: false
  type: string
wait_for_ack:
  description: Wait for RFLink to acknowledge commands sent before sending new command (slower but more reliable).
  required: false
  default: true
  type: boolean
ignore_devices:
  description: List of device id's to ignore. Supports wildcards (`*`, `?`).
  required: false
  type: [list, string]
reconnect_interval:
  description: Time in seconds between reconnect attempts.
  required: false
  default: 10
  type: integer
{% endconfiguration %}

### 전체 사례
```yaml
# Example configuration.yaml entry
rflink:
  port: /dev/serial/by-id/usb-id01234
  wait_for_ack: false
  ignore_devices:
    - newkaku_000001_01
    - digitech_*
```

### TCP mode

TCP 모드에서는 TCP/IP 네트워크를 통해 RFLink 장치에 연결할 수 있습니다. 이는 RF 서버 장치를 HA 서버 옆에 배치하는 것이 최적이거나 바람직하지 않은 경우에 유용합니다 (예: 수신 불량).

다른 호스트 (Linux)에서 TCP를 통해 USB/serial 인터페이스를 표시하려면 다음 명령을 사용할 수 있습니다.

```bash
$ socat /dev/ttyACM0,b57600 TCP-LISTEN:1234,reuseaddr
```

TCP를 통해 serial 인터페이스를 노출하는 다른 방법이 가능합니다 (예: ESP8266 또는 Arduino Wifi shield 사용). 기본적으로 serial 스트림은 TCP 스트림에 직접 매핑되어야합니다.

Arduino MEGA 2560 RX (Pin 2) 및 TX (Pin 3)에 각각 연결된 ESP8266 TXD0 (Pin D10) 및 RXD0 (Pin D9)이 있는 NodeMCU(ESP8266 Wifi module)에서 실행되는 Wi-Fi 직렬 브리지 [esp-link V2.2.3](https://github.com/jeelabs/esp-link/releases/tag/v2.2.3)로 테스트되었습니다.

<div class='note warning'>

로직 레벨이 다르기 때문에 3.3V NodeMCU와 5V Arduino MEGA 2560 PIN 사이에 전압 레벨 시프터(level shifter)가 필요합니다. BSS138 양방향 로직 레벨 컨버터는 serial pins에 대해 테스트되었으며 CC2500 트랜시버 (Ikea Ansluta 및 Philips Living Colors에 사용)에 [link](https://www.aliexpress.com/item/8CH-IIC-I2C-Logic-Level-Converter-Bi-Directional-Module-DC-DC-5V-to-3-3V-Setp/32238089139.html)가 권장됩니다. 

</div>

<div class='note'>
Arduino MEGA를 다시 플래시할 때는 프로그래밍 문제를 피하기 위해 ESP8266을 분리하십시오.
</div>

```yaml
# Example configuration.yaml entry
rflink:
  host: 192.168.0.10
  port: 1234
```

### 자동 장치 추가

장치가 자동으로 검색되도록 하려면 설정에 다음을 추가해야합니다. 
물리적 리모콘의 버튼을 누르면 RFLink가 신호를 감지하고 장치가 홈어시스턴트에 자동으로 추가되어야합니다.

```yaml
light:
  - platform: rflink
    automatic_add: true
sensor:
  - platform: rflink
    automatic_add: true
```

[RFLink Switches](/integrations/switch.rflink/) and [RFLink Binary Sensors](/integrations/binary_sensor.rflink/) cannot be added automatically. 
[RFLink Switches](/integrations/switch.rflink/) 및 [RFLink Binary Sensors](/integrations/binary_sensor.rflink/)는 자동으로 추가할 수 없습니다.

RFLink 통합구성요소는 이진 센서, 스위치 및 조명의 차이점을 모릅니다. 따라서 모든 전환가능한(switchable) 장치는 기본적으로 자동으로 조명으로 추가됩니다. 그러나 스위치의 ID를 알고 나면 Home Assistant에서 스위치나 이진 센서 유형으로 설정하는데 사용할 수 있습니다 (예: 다른 그룹에 추가하거나 숨기거나 친숙한 이름을 설정하는 등).

### 장치 무시하기

플랫폼 레벨에서 장치를 완전히 무시하도록 RFLink 플랫폼을 설정할 수 있습니다. 이것은 433MHz 기술을 사용하는 이웃이 있을 때 유용합니다.

사례 :

```yaml
# Example configuration.yaml entry
rflink:
  port: /dev/serial/by-id/usb-id01234
  wait_for_ack: false
  ignore_devices:
    - newkaku_000001_01
    - digitech_*
    - kaku_1_*
```

이 설정은 ID가 `000001`인 `newkaku` 장치의 `1`버튼, `digitech` 프로토콜의 모든 장치 및 codewheel ID `1`의 `kaku` 프로토콜 장치의 모든 스위치를 무시합니다.

### 지원 장치

RFLink는 많은 장치를 지원하지만 모든 테스트/구현된 것은 아닙니다. RFLink에서 지원하지만 이 통합구성요소에서 지원하지 않는 장치가 있는 경우 직접 테스트하고 지원을 고려하십시오.

### 장치가 잘못 식별되었을 때  

장치가 다른 프로토콜로 다르게 인식되거나 ON OFF가 두 개의 ON 명령으로 바뀌거나 감지되는 경우 RFLink Rev 46(2017년 3월 11일)의 RFLink 'RF 신호 학습' 메커니즘으로 극복할 수 있습니다. [Link to further detail.](http://www.rflink.nl/blog2/faq#RFFind)

### 기술 개요

- The`rflink` Python module is an asyncio transport/protocol which is setup to fire a callback for every (valid/supported) packet received by the RFLink gateway.
- This integration uses this callback to distribute 'rflink packet events' over [Home Assistant's event bus](/docs/configuration/events/) which can be subscribed to by entities/platform implementations.
- The platform implementation takes care of creating new devices (if enabled) for unseen incoming packet ID's.
- Device entities take care of matching to the packet ID, interpreting and performing actions based on the packet contents. Common entity logic is maintained in this main component.

### 디버그 로깅

문제를 조사할 때 디버깅 목적 또는 컨텍스트를 위해 다음 설정 스니펫을 사용하여 RFLink에 대한 디버그 로깅을 사용할 수 있습니다.

```yaml
logger:
  default: error
  logs:
    rflink: debug
    homeassistant.components.rflink: debug
```

이렇게하면 다음과 같이 출력됩니다.

```bash
17-03-07 20:12:05 DEBUG (MainThread) [rflink.protocol] received data: 20;00;Nod
17-03-07 20:12:05 DEBUG (MainThread) [rflink.protocol] received data: o RadioFrequencyLink - R
17-03-07 20:12:05 DEBUG (MainThread) [rflink.protocol] received data: FLink Gateway V1.1 - R45
17-03-07 20:12:05 DEBUG (MainThread) [rflink.protocol] received data: ;
17-03-07 20:12:05 DEBUG (MainThread) [rflink.protocol] got packet: 20;00;Nodo RadioFrequencyLink - RFLink Gateway V1.1 - R45;
17-03-07 20:12:05 DEBUG (MainThread) [rflink.protocol] decoded packet: {'firmware': 'RFLink Gateway', 'revision': '45', 'node': 'gateway', 'protocol': 'unknown', 'hardware': 'Nodo RadioFrequencyLink', 'version': '1.1'}
17-03-07 20:12:05 DEBUG (MainThread) [rflink.protocol] got event: {'version': '1.1', 'firmware': 'RFLink Gateway', 'revision': '45', 'hardware': 'Nodo RadioFrequencyLink', 'id': 'rflink'}
17-03-07 20:12:05 DEBUG (MainThread) [homeassistant.components.rflink] event of type unknown: {'version': '1.1', 'firmware': 'RFLink Gateway', 'revision': '45', 'hardware': 'Nodo RadioFrequencyLink', 'id': 'rflink'}
```
