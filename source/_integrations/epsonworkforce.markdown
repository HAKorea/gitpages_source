---
title: 엡슨 Workforce(Epson Workforce)
description: Instructions on how to integrate Epson Workforce Printer into Home Assistant.
logo: epson.png
ha_category:
  - Sensor
ha_release: 0.92
ha_iot_class: Local Polling
ha_codeowners:
  - '@ThaStealth'
---

`epson workforce` 플랫폼을 사용하면 Home Assistant에서 Epson Workforce 프린터의 잉크량을 모니터링 할 수 있습니다.


Epson Workforce를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
sensor:
   - platform: epsonworkforce
     host: IP_ADDRESS
     monitored_conditions:
     - black
     - photoblack
     - yellow
     - magenta
     - cyan
     - clean   
```

{% configuration %}
host:
  description: Epson Workforce Printer의 호스트 이름 또는 주소
  required: true
  type: string
monitored_conditions:
  description: 모니터 할 카트리지 색상.
  required: true
  type: list
  keys:
    black:
      description: 검정 잉크 카트리지
    photoblack:
      description: 포토 검정 잉크 카트리지 (일부 프린터에서 지원되지는 않음).
    yellow:
      description: 노랑 잉크 카트리지.
    magenta:
      description: 마젠타 색 (= 빨간색) 잉크 카트리지.
    cyan:
      description: 시안 (= 파란색) 잉크 카트리지.   
    clean:
      description: 청소 카트리지.
{% endconfiguration %}

지원되는 장치:

- 잉크 카트리지 수준이 포함 된 HTTP 페이지를 게시하는 Epson Workforce 및 일부 EcoTank 프린터

테스트 된 장치:

- Epson WF3540
- Epson WF3620
- Epson WF3640
- Epson EcoTank ET-77x0
- Epson ET-2650

To make this module work you need to connect your printer to your LAN.
The best is to navigate to the status page of the printer to check if it shows the page with the ink levels on the URL http://<IP_ADDRESS>/PRESENTATION/HTML/TOP/PRTINFO.HTML
