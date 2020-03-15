---
title: 시스코 IOS(Cisco IOS)
description: Instructions on how to integrate Cisco IOS routers into Home Assistant.
logo: cisco.png
ha_category:
  - Presence Detection
ha_release: 0.33
ha_codeowners:
  - '@fbradyirl'
---

[Cisco](https://www.cisco.com/) IOS 장치의 재실 감지 스캐너입니다.

<div class='note warning'>
이 장치 추적기는 라우터에서 SSH를 활성화해야합니다.
</div>

Cisco IOS에는 일반적으로 4 시간 기본 ARP 캐시 시간 초과가 제공되므로 이 스캐너를 사용하기 전에 라우터에서 ARP 캐시 시간 초과를 낮추는 것이 좋습니다.

예를 들어 다음 명령은 Vlan1에서 시간 초과를 2 분으로 줄입니다.

```bash
# 1. use this command to see what Vlan your devices are on
show ip arp

# 2. Go into configure mode
conf t

# 3. Use the Vlan name as you see it from step 1 above
interface Vlan1

# 4. Set a new arp cache timeout
arp timeout 120

# 5. Exit
# Press <ctrl+c> to exit configure mode

# 6. Don't forget to save the new config, so that it will survive a reboot
copy running-config startup-config
```

<div class='note warning'>

VLan (+1000)에 매우 많은 수의 장치가 있는 경우 필요에 따라 ARP 캐시 시간 초과를 조정해야 할 수 있습니다. 자세한 내용은 [this discussion](https://supportforums.cisco.com/discussion/10169296/arp-timeout)을 참조하십시오.

</div>

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: cisco_ios
    host: ROUTER_IP_ADDRESS
    username: YOUR_ADMIN_USERNAME
    password: YOUR_ADMIN_PASSWORD
```

{% configuration %}
host:
  description: The IP address of your router, e.g., 192.168.1.1.
  required: true
  type: string
username:
  description: The username of an user with administrative privileges.
  required: true
  type: string
password:
  description: The password for your given admin account.
  required: true
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.