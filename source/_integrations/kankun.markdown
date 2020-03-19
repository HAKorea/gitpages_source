---
title: 칸쿤(Kankun)
description: Instructions for the Kankun SP3 Wifi switch
ha_category:
  - Switch
ha_release: 0.36
ha_iot_class: Local Polling
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/eIQriVOy2l8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`kankun` 스위치 플랫폼을 사용하면 맞춤형 Kankun SP3 Wifi 스위치를 토글할 수 있습니다. HTTP API를 제공하기 위해 [json.cgi](https://github.com/homedash/kankun-json/blob/master/cgi-bin/json.cgi) 스크립트를 포함하도록 스위치가 수정되었습니다. 
필요한 수정에 대한 자세한 내용은 [here](http://www.homeautomationforgeeks.com/openhab_http.shtml#kankun)를 참조하십시오. (위의 링크대로 스크립트의 JSON 버전을 설치하십시오)

## 설정

이를 활성화하려면`configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  platform: kankun
  switches:
    bedroom_heating:
      host: hostname_or_ipaddr
```

{% configuration %}
switches:
  description: The array that contains all Kankun switches.
  required: true
  type: map
  keys:
    identifier:
      description: Name of the Kankun switch as slug. Multiple entries are possible.
      required: true
      type: map
      keys:
        host:
          description: Hostname or IP address of the switch on the local network.
          required: true
          type: string
        name:
          description: Friendly name of the switch.
          required: false
          type: string
        port:
          description: HTTP connection port.
          required: false
          default: 80
          type: integer
        patch:
          description: Path of CGI script.
          required: false
          default: "/cgi-bin/json.cgi"
          type: string
        username:
          description: Username for basic authentication.
          required: false
          type: string
        password:
          description: Password for basic authentication.
          required: false
          type: string
{% endconfiguration %}
