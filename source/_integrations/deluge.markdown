---
title: 토렌트클라이언트(Deluge)
description: Instructions on how to integrate Deluge within Home Assistant.
logo: deluge.png
ha_category:
  - Downloading
  - Sensor
  - Switch
ha_release: 0.57
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/cqvyPHq0gmg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Sensor](#sensor)
- [Switch](#switch)

## Sensor


이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: deluge
    host: IP_ADDRESS
    username: USERNAME
    password: PASSWORD
    monitored_variables:
      - 'current_status'
      - 'download_speed'
      - 'upload_speed'
```

{% configuration %}
host:
  required: true
  type: string
  description: This is the IP address of your Deluge daemon, e.g., 192.168.1.32.
port:
  required: false
  type: integer
  description: The port your Deluge daemon uses. Warning, this is not the port of the WebUI.
  default: 58846
name:
  required: false
  type: string
  default: Deluge
  description: The name to use when displaying this Deluge instance.
username:
  required: true
  type: string
  description: Your Deluge daemon username.
password:
  required: true
  type: string
  description: Your Deluge daemon password.
monitored_variables:
  required: true
  type: list
  description: Conditions to display in the frontend.
  keys:
    current_status:
      description: The status of your Deluge daemon.
    download_speed:
      description: The current download speed.
    upload_speed:
      description: The current upload speed.
  {% endconfiguration %}

## Switch

`deluge` 스위치 플랫폼을 사용하면 Home Assistant 내에서 [Deluge](https://deluge-torrent.org/) 클라이언트를 제어할 수 있습니다. 이 플랫폼을 사용하면 모든 토렌트를 일시중지한 다음 모두 다시시작할 수 있습니다.

설치에 Deluge를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  platform: deluge
  host: IP_ADDRESS
  username : USERNAME
  password : PASSWORD
```

{% configuration %}
host:
  required: true
  type: string
  description: This is the IP address of your Deluge daemon, e.g., 192.168.1.32.
username:
  required: true
  type: string
  description: Your Deluge username, if you use authentication.
password:
  required: true
  type: string
  description: Your Deluge password, if you use authentication.
port:
  required: false
  type: integer
  default: 58846
  description: "The port your Deluge daemon uses. (Warning: This is not the port of the WebUI.)"
name:
  required: false
  type: string
  default: Deluge Switch
  description: The name to use when displaying this Deluge instance.
{% endconfiguration %}
