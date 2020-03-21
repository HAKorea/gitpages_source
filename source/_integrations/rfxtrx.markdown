---
title: RFXCOM RFXtrx
description: Instructions on how to integrate RFXtrx into Home Assistant.
logo: rfxtrx.png
ha_category:
  - Hub
ha_release: pre 0.7
ha_codeowners:
  - '@danielhiversen'
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/zcjNvSMG-hg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`rfxtrx` 통합구성요소는 433.92 MHz의 주파수 범위에서 통신하는 [RFXCOM](http://www.rfxcom.com)에 의해 RFXtrx 장치를 지원합니다.

설치에서 RFXtrx를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry for local serial device
rfxtrx:
  device: /dev/ttyUSB0
```

혹은

```yaml
# Example configuration.yaml entry for TCP connected device using ser2net
rfxtrx:
  host: 192.168.0.2
  port: 50000
```

{% configuration %}
device:
  description: "The path to your device, e.g., `/dev/serial/by-id/usb-RFXCOM_RFXtrx433_A1Y0NJGR-if00-port0` or `/dev/ttyUSB0`. Required if you are using a locally connected USB device."
  required: false
  type: string
host:
  description: "The hostname the remote RFXtrx is available on if connecting via TCP. If this is set, a port is required."
  required: false
  type: string
port:
  description: "The TCP port the remote RFXtrx is available on. If this is set, a host is required."
  required: false
  type: integer
debug:
  description: "If you want to receive debug output."
  required: false
  default: false
  type: boolean
dummy:
  description: "Then you need a connected drive to test your settings. Can be useful for debugging and testing."
  required: false
  default: false
  type: boolean
{% endconfiguration %}

## 지원되는 protocols

알려진대로 모든 protocol이 트랜시버의 초기 설정에서 활성화되는 것은 아닙니다. 모든 protocol을 활성화하는 것은 권장되지 않습니다. 433.92 제품이 로그에 표시되지 않습니까? RFXtrx 웹 사이트를 방문하여 [RFXmgmr 다운로드](http://www.rfxcom.com/epages/78165469.sf/nl_NL/?ObjectPath=/Shops/78165469/Categories/Downloads)를 하고 필요한 프로토콜을 활성화하십시오.

### ser2net

ser2net을 설정하고 ser2net의 설정 예를 다음과 같이 설정 한 다음 Home Assistant 설정에서 host/port를 사용하여 다른 컴퓨터에서 장치를 호스트 할 수 있습니다.

```text
50000:raw:0:/dev/ttyUSB0:38400 8DATABITS NONE 1STOPBIT
```
