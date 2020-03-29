---
title: 유닉스프린터시스템(CUPS)
description: Instructions on how to integrate CUPS sensors into Home Assistant.
logo: cups.png
ha_category:
  - System Monitor
ha_iot_class: Local Polling
ha_release: 0.32
ha_codeowners:
  - '@fabaff'
---

`cups` 센서 플랫폼은 오픈 소스 인쇄 시스템 [CUPS](https://www.cups.org/)을 사용하여 잉크 잔량을 포함한 프린터에 대한 세부 정보를 표시합니다. CUPS 서버를 사용하거나 인터넷 인쇄 프로토콜을 사용하여 프린터와 직접 통신하여 정보를 얻을 수 있습니다.

## 셋업

`python3-dev` 또는 `python3-devel` 패키지와 CUPS 개발 파일(`libcups2-dev` 또는 `cups-devel`)을 시스템에 컴파일러 (`gcc`)와 함께 수동으로 설치해야합니다.(예: `sudo apt-get install python3-dev libcups2-dev` 혹은 `sudo dnf -y install python3-devel cups-devel`) 이 통합구성요소는 컨테이너 기반 설정에서 기본적으로 작동하지 않습니다.

센서를 설정하려면 프린터의 "Queue Name"이 필요합니다. 가장 빠른 방법은 CUPS 웹인터페이스 "http://[IP ADDRESS PRINT SERVER]:631"을 방문하여 "Printers"로 이동하는 것입니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/cups-sensor.png' />
</p>

## 설정

CUPS 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: cups
    printers:
      - C410
      - C430
```

{% configuration %}
printers:
  description: List of printers to add. If you're not using a CUPS server, add here your "Printer Name".
  required: true
  type: list
host:
  description: The IP address of the CUPS print server or of the printer.
  required: false
  type: string
  default: 127.0.0.1
port:
  description: The port number of the CUPS print server or of the printer.
  required: false
  type: integer
  default: 631
is_cups_server:
  description: Set true if you want to use a CUPS print server, set false otherwise.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

## 예시

IPP 프린터의 기본 구성 :

```yaml
# Example configuration.yaml entry for an IPP printer
sensor:
  - platform: cups
    host: PRINTER_IP
    is_cups_server: false
    printers:
      - ipp/print
```

<div class='note'>

시스템에 수동으로 `python3-dev` 혹은 `python3-devel`와 CUPS(`libcups2-dev` 혹은 `cups-devel`) 패키지용 개발 파일을 설치해야합니다 (예: `sudo apt-get install python3-dev libcups2-dev` 또는 `sudo dnf -y는 python3-devel cups-devel`을 컴파일러(`gcc`)와 함께 설치합니다.)
</div>
