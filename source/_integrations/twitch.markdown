---
title: 트위치(Twitch)
description: Instructions on how to integrate Twitch sensors into Home Assistant.
logo: twitch.png
ha_category:
  - Social
ha_release: '0.10'
ha_iot_class: Cloud Polling
---

`twitch` 플랫폼을 사용하면 Home Assistant 내에서 [Twitch](https://www.twitch.tv/) 채널 상태를 모니터링하고 정보를 기반으로 자동화를 설정할 수 있습니다.

## 셋업

[Twitch developer portal](https://glass.twitch.tv/console/apps)의 "Register Your Application"에서 new app을 만듭니다. 그런 다음 new app의 **Client ID**를 받으십시오.

## 설정

To use Twitch with your installation, add the following to your `configuration.yaml` file:
설치와 함께 Twitch를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  platform: twitch
  client_id: YOUR_TWITCH_CLIENT_ID
  channels:
    - channel1
    - channel2
```

{% configuration %}
client_id:
  description: Your Twitch client ID.
  required: true
  type: string
channels:
  description: List of channels names
  required: true
  type: list
{% endconfiguration %}
