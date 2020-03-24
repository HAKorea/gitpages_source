---
title: GPS데몬(GPSD)
description: Instructions on how to integrate GPSD into Home Assistant.
logo: gpsd.png
ha_category:
  - Utility
ha_release: 0.26
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/A1zmhxcUOxw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`gpsd` 통합구성요소는 [gpsd](http://catb.org/gpsd/)에서 수집한 GPS 정보와 GPS 수신기를 사용합니다.

## 셋업

`gpsd`가 설치되어 있어야합니다 (`$ sudo apt-get install gpsd` 또는 `$ sudo dnf -y install gpsd`). `gpsd`는 USB 리시버를 위한 최신 Linux 배포판에서 systemd의 소켓 활성화 기능을 사용합니다. 이것은 GPS 수신기를 연결하면 `gpsd`가 시작됨을 의미합니다. 다른 GPS 장치도 작동 할 수 있지만 이는 테스트되지 않았습니다.

```bash
$ sudo systemctl status gpsdctl@ttyUSB0.service
● gpsdctl@ttyUSB0.service - Manage ttyUSB0 for GPS daemon
   Loaded: loaded (/usr/lib/systemd/system/gpsdctl@.service; static; vendor preset: disabled)
   Active: active (exited) since Sat 2016-07-16 09:30:33 CEST; 1 day 23h ago
  Process: 5303 ExecStart=/bin/sh -c [ "$USBAUTO" = true ] && /usr/sbin/gpsdctl add /dev/%I || : (code=exited, status=0/SUCCESS)
 Main PID: 5303 (code=exited, status=0/SUCCESS)

Jul 16 09:30:33 laptop019 systemd[1]: Starting Manage ttyUSB0 for GPS daemon...
Jul 16 09:30:33 laptop019 gpsdctl[5305]: gpsd_control(action=add, arg=/dev/ttyUSB0)
Jul 16 09:30:33 laptop019 gpsdctl[5305]: reached a running gpsd
```

설정이 작동하는지 확인하려면 `gpsd`가 `telnet`으로 실행되는 호스트의 포트 2947에 연결하십시오. 방화벽을 조정해야 할 수도 있습니다.

```bash
$ telnet localhost 2947
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
{"class":"VERSION","release":"3.15","rev":"3.15-2.fc23","proto_major":3,"proto_minor":11}
```

## 설정

설비에서 GPSD 센서를 설정하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: gpsd
```

{% configuration %}
host:
  description: The host where GPSD is running.
  required: false
  type: string
  default: localhost
port:
  description: The port which GPSD is using.
  required: false
  type: integer
  default: 2947
name:
  description: Friendly name to use for the frontend.
  required: false
  type: string
  default: GPS
{% endconfiguration %}
