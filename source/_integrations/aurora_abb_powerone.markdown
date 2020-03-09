---
title: (태양광인버터)Aurora ABB Solar PV
description: Instructions on how to integrate an Aurora ABB Powerone solar inverter within Home Assistant.
logo: powerone.png
ha_category:
  - Sensor
  - Energy
ha_release: 0.96
ha_iot_class: Local Polling
ha_codeowners:
  - '@davet2001'
---

이는 PVI-3.0/3.6/4.2-TL-OUTD ABB 시리즈에서 태양광 인버터에 대한 직접 RS485 연결을 구현하며 다른 장치에서도 작동할 수 있습니다. 인버터는 이전에 ABB에 의해 인수된 PowerOne에 의해 만들어졌습니다.

인버터와 통신하는 TCP/IP 방법은 Python 라이브러리에서 지원하지만 이 통합구성요소에서 구현시 지원되지 않습니다.

이 통합구성요소는 실시간 전력 출력(와트)을 보고하는 단일 센서를 제공합니다.

어둠 속에서는 PV 인버터가 통신에 응답하지 않으므로 밤 동안 'unknown'값이 표시됩니다.

## 설정

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: aurora_abb_powerone
    device: 'SERIAL_PORT'
```

{% configuration %}
device:
  description: The serial port your RS485 adaptor is connected to.
  required: true
  type: string
address:
  description: The address of the inverter - only need to set this if you have changed your inverter away from the default address of 2.
  required: false
  type: integer
  default: 2
name:
  description: Name of the sensor to use in the frontend.
  required: false
  default: Solar PV
  type: string
{% endconfiguration %}

```yaml
# Example configuration.yaml entry for aurora_abb_powerone platform
sensor:
  - platform: aurora_abb_powerone
    address: 2
    device: '/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A50285BI-if00-port0'
```
