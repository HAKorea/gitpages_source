---
title: 네트워크전원스위치(Anel NET-PwrCtrl)
description: Instructions on how to integrate ANEL PwrCtrl switches within Home Assistant.
logo: anel.png
ha_category:
  - Switch
ha_iot_class: Local Polling
ha_release: '0.30'
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/9DFLwBoC5NA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`anel_pwrctrl` 스위치 플랫폼을 통해 [ANEL PwrCtrl](https://anel-elektronik.de/SITE/produkte/produkte.htm) 장치를 제어 할 수 있습니다.

지원되는 장치 (테스트됨) :

- PwrCtrl HUT

이 플랫폼을 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  platform: anel_pwrctrl
  host: IP_ADDRESS
  port_recv: PORT
  port_send: PORT
  username: USERNAME
  password: PASSWORD
```

{% configuration %}
host:
  description: The IP address or hostname of your PwrCtrl device.
  required: false
  type: string
port_recv:
  description: The port to receive data from the device.
  required: true
  type: integer
port_send:
  description: The port to send data to the device.
  required: true
  type: integer
username:
  description: The username for your device.
  required: true
  type: string
password:
  description: The password for your device.
  required: true
  type: string
{% endconfiguration %}

<div class="note">

**host**가 제공되지 않으면 플랫폼은 네트워크의 모든 장치를 지정된 **port_recv**에서 수신 대기중인 자동 검색을 시도합니다.

</div>
