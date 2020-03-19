---
title: 구글 와이파이(Google Wifi)
description: Instructions on how to integrate Google Wifi/OnHub routers into Home Assistant.
ha_category:
  - System Monitor
logo: google_wifi.png
ha_iot_class: Local Polling
ha_release: '0.50'
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/z4EswXzXqz8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`google_wifi` 센서 플랫폼에 [Google Wifi](https://madeby.google.com/wifi/) (또는 OnHub) 라우터의 노출 상태가 표시됩니다.

센서는 네트워크 상태, 가동 시간, 현재 IP 주소 및 펌웨어 버전을 보고 할 수 있습니다.

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: google_wifi
```

{% configuration %}
host:
  description: The address to retrieve status from the router. Valid options are `testwifi.here`, in some cases `onhub.here` or the router's IP address such as 192.168.86.1.
  required: false
  default: testwifi.here
  type: string
name:
  description: Name to give the Google Wifi sensor.
  required: false
  default: google_wifi
  type: string
monitored_conditions:
  description: Defines the data to monitor as sensors. Defaults to all of the listed options below.
  required: false
  type: list
  keys:
    current_version:
      description: Current firmware version of the router.
    new_version:
      description: Latest available firmware version. If router is up-to-date, this value shows to `Latest`.
    uptime:
      description: Days since router has been turned on.
    last_restart:
      description: Date of last restart. Format is `YYYY-MM-DD HH:mm:SS`.
    local_ip:
      description: Local public IP address.
    status:
      description: Reports whether the router is or is not connected to the internet.
{% endconfiguration %}
