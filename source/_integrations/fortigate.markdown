---
title: 방화벽(FortiGate)
description: Instructions on how to integrate FortiGate Firewalls into Home Assistant.
logo: fortinet.jpg
ha_category:
  - Presence Detection
ha_release: 0.97
ha_iot_class: Local Polling
ha_codeowners:
  - '@kifeo'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/klUBuhmbcj4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

FortiGate API의 장치 감지를 기반으로하는 FortiGate 재실 센서입니다.

## FortiGate 셋업

USERNAME API 사용자로 FortiGate를 설정하고 최소 권한 프로파일을 지정하십시오.

```text
config system accprofile
    edit "homeassistant_profile"
        set authgrp read
    next
end

config system api-user
    edit "USERNAME"
        set api-key API_KEY
        set accprofile "homeassistant_profile"
        set vdom "root"
        config trusthost
            edit 1
                set ipv4-trusthost <trusted subnets>
            next
        end
    next
end
```

## 설정

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
fortigate:
  host: HOST_IP
  username: YOUR_USERNAME
  api_key: YOUR_API_KEY
```

{% configuration %}
host:
  description: The IP address of the FortiGate device.
  required: true
  type: string
username:
  description: The username of the user that will connect to the FortiGate device.
  required: true
  type: string
api_key:
  description: The API key associated with the user.
  required: true
  type: string
devices:
  description: The MAC addresses of the devices to monitor.
  required: false
  type: string
{% endconfiguration %}

## 에러들

프로필의 권한이 충분하지 않으면 다음 오류가 발생합니다.

```txt
ERROR (MainThread) [homeassistant.core] Error doing job: Task exception was never retrieved
```
