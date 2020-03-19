---
title: 오픈하드웨어모니터(Open Hardware Monitor)
description: Instructions on how to integrate Open Hardware Monitor within Home Assistant.
logo: openhardwaremonitor.png
ha_category:
  - System Monitor
ha_release: 0.48
ha_iot_class: Local Polling
---

`openhardwaremonitor` 플랫폼은 [Open Hardware Monitor](https://openhardwaremonitor.org/) 설치를 시스템 정보를 표시할 센서의 소스로 사용합니다.

## 셋업

"Remote web server"가 활성화 된 상태에서 OpenHardwareMonitor가 호스트에서 실행 중이어야 합니다. 호스트에서 인바운드 포트 (TCP 8085)도 열어야합니다.

포트를 열려면 (Windows) :

1. Navigate to Control Panel, System and Security and Windows Firewall.
2. Select **Advanced settings** and highlight **Inbound Rules** in the left pane.
3. Right click Inbound Rules and select New Rule.
4. Add the port you need to open and click Next.
5. Add the protocol (TCP) and the port number (8085) into the next window and click Next.
6. Select Allow the connection in the next window and hit Next.
7. Select the network type as you see fit and click Next.
8. Name the rule and click Finish.

`firewalld`로 포트를 열려면 (Linux) :

```bash
sudo firewall-cmd --permanent --add-port=8085/tcp
sudo firewall-cmd --reload
```

## 설정

Open Hardware Monitor를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: openhardwaremonitor
    host: IP_ADDRESS
```

{% configuration %}
  host:
    description: The IP address or hostname of the system where Open Hardware Monitor is running.
    required: true
    type: string
  port:
    description: The port of your Open Hardware Monitor API. Defaults to 8085.
    required: false
    type: integer
{% endconfiguration %}
