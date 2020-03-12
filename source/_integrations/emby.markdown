---
title: 엠비(Emby)
description: Instructions on how to integrate Emby into Home Assistant.
logo: emby.png
ha_category:
  - Media Player
ha_release: 0.32
ha_iot_class: Local Push
ha_codeowners:
  - '@mezz64'
---

`emby` 플랫폼을 사용하면 Home Assistant에서 [Emby](https://emby.media/) 멀티미디어 시스템을 제어할 수 있습니다.

Emby를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: emby
    host: YOUR_IP_ADDRESS
    api_key: YOUR_API_KEY
```

{% configuration %}
host:
  description: The host name or IP address of the device that is running Emby.
  required: false
  default: localhost
  type: string
api_key:
  description: The API key to use to authenticate.
  required: true
  type: string
ssl:
  description: Connect with HTTPS/WSS. Your SSL certificate must be valid.
  required: false
  default: false
  type: boolean
port:
  description: The port number of the device that is running Emby.
  required: false
  default: 8096 (No SSL),  8920 (SSL)
  type: integer
{% endconfiguration %}
