---
title: Plex 모니터링(Tautulli)
description: Instructions on how to set up Tautulli sensors in Home Assistant.
logo: tautulli.png
ha_category:
  - Sensor
ha_release: 0.82
ha_iot_class: Local Polling
ha_codeowners:
  - '@ludeeus'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/zwEd4Mnt2Kg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`tautulli` 센서 플랫폼은 주어진 [Tautulli Server][tautulli]의 활동을 모니터링합니다. 현재 활성 스트림 수를 상태로 표시하는 센서를 만듭니다. 자세한 내용을 보려면 센서를 클릭하면 더 많은 통계가 표시되며 기본적으로 다음 통계를 사용할 수 있습니다.

- LAN bandwidth
- Number of direct plays
- Number of direct streams
- Stream count
- Top Movie
- Top TV Show
- Top User
- Total bandwidth
- Transcode count
- WAN bandwidth

`monitored_conditions` 설정 옵션으로 더 많은 사용자 통계를 추가 할 수 있습니다. 이것은 사용자의 현재 `activity` 외에도 사용자 당 하나의 속성을 추가합니다.

## 셋업

`api_key`를 찾으려면 Tautulli 웹인터페이스를 열고 `settings`으로 이동 한 다음 `Web interface`로 이동하면 `api_key`가 해당 페이지의 맨 아래에 있습니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: tautulli
    api_key: TAUTULLI_API_KEY
    host: TAUTULLI_HOST
```

{% configuration %}
api_key:
  description: The API key for your Tautulli server.
  required: true
  type: string
host:
  description: The DNS name or IP Address of the server running Tautulli.
  required: true
  type: string
port:
  description: The port of your Tautulli server.
  required: false
  default: 8181
  type: integer
path:
  description: The Base Url path of your Tautulli server.
  required: false
  type: string
ssl:
  description: Use HTTPS to connect to Tautulli server. *NOTE* A host *cannot* be an IP address when this option is enabled.
  required: false
  default: false
  type: boolean
monitored_users:
  description: A list of Tautulli users you want to monitor, if not set this will monitor **all** users.
  required: false
  type: list
monitored_conditions:
  description: A list of attributes to expose for each Tautulli user you monitor, every key in the `session` [section here][tautulliapi] can be used.
  required: false
  type: list
{% endconfiguration %}

## 전체 설정 사례

```yaml
# Example configuration.yaml entry
sensor:
  - platform: tautulli
    api_key: TAUTULLI_API_KEY
    host: TAUTULLI_HOST
    monitored_users:
      - USER_1
      - USER_2
    monitored_conditions:
      - ATTRIBUTE_1
      - ATTRIBUTE_2
```

[tautulli]: https://tautulli.com
[tautulliapi]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_activity
