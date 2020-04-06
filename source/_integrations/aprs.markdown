---
title: 아마추어무선(APRS)
description: Instructions on how to use APRS to track devices in Home Assistant.
logo: aprs.png
ha_release: 0.95
ha_category: Presence Detection
ha_iot_class: Cloud Push
ha_codeowners:
  - '@PhilRW'
---

<div class='videoWrapper'>
<iframe width="775" height="436" src="https://www.youtube.com/embed/GRSbjmnlP_g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`aprs` [(Automatic Packet Reporting System)](https://en.wikipedia.org/wiki/Automatic_Packet_Reporting_System) 장치 추적기 통합구성요소는 아마추어 무선 장치 추적을 위한 네트워크인 [APRS-IS](http://aprs-is.net/)에 연결됩니다 

## 설정

Home Assistant에서 APRS 추적을 활성화하려면 `configuration.yaml`에 다음 섹션을 추가하십시오.


```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: aprs
    username: FO0BAR  # or FO0BAR-1 to FO0BAR-15
    callsigns:
      - 'XX0FOO*'
      - 'YY0BAR-1'
```

{% configuration %}
username:
  description: "Your callsign (or callsign-SSID combination). This is used to connect to the host. Note: Do not use the same callsign or callsign-SSID combination as a device you intend to track: the APRS-IS network will not route the packets to Home Assistant. This is a known limitation of APRS packet routing."
  required: true
  type: string
password:
  description: Your APRS password. This will verify the connection.
  required: false
  type: string
  default: -1
callsigns:
  description: A list of callsigns you wish to track. Wildcard `*` is allowed. Any callsigns that match will be added as devices.
  required: true
  type: list
host:
  description: The APRS server to connect to.
  required: false
  type: string
  default: rotate.aprs2.net
timeout:
  description: The number of seconds to wait to connect to the APRS-IS network before giving up.
  required: false
  type: float
  default: 30.0
{% endconfiguration %}

검증된 연결은 APRS-IS 네트워크로 데이터를 전송하는데만 필요하며, `aprs` 플랫폼은 아직 그렇지 않습니다. 
그러나 APRS 암호를 알고 있으면 연결을 자유롭게 확인할 수 있습니다.