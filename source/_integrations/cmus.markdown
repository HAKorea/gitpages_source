---
title: 초소형플레이어(cmus)
description: Instructions on how to integrate cmus Music Player into Home Assistant.
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.23
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/cGJZ5Cfaacg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`cmus` 플랫폼을 사용하면 홈어시스턴트의 원격 또는 로컬 컴퓨터에서 [cmus](https://cmus.github.io/) 뮤직 플레이어를 제어 할 수 있습니다.

cmus를 추가하려면 로컬에서 실행중인 경우 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: cmus
```

cmus가 원격 서버에서 실행중인 경우 :

```yaml
# Example configuration.yaml entry
media_player:
  - platform: cmus
    host: IP_ADDRESS_OF_CMUS_PLAYER
    password: YOUR_PASSWORD
```

{% configuration %}
host:
  description: Hostname or IP address of the machine running cmus. Note if a remote cmus is configured that instance must be configured to listen to remote connections, which also requires a password to be set.
  required: inclusive
  type: string
password:
  description: Password for your cmus player.
  required: inclusive
  type: string
port:
  description: Port of the cmus socket.
  required: false
  default: 3000
  type: integer
name:
  description: The name you'd like to give the cmus player in Home Assistant.
  required: false
  default: cmus
  type: string
{% endconfiguration %}
