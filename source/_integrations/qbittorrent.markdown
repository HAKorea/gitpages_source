---
title: qBittorrent
description: Instructions on how to integrate qBittorrent sensors within Home Assistant.
logo: qbittorrent.png
ha_category:
  - Downloading
ha_release: 0.84
ha_iot_class: Local Polling
---

`qbittorrent` 플랫폼을 사용하면 홈어시스턴트에서 [qBittorrent](https://www.qbittorrent.org/)로 다운로드를 모니터링하고 정보를 기반으로 자동화를 설정할 수 있습니다.

## 셋업

이 센서에는 qBittorrent 웹 UI가 활성화되어 있어야합니다. [공식 참조](https://github.com/qbittorrent/qBittorrent/wiki#webui-related)는 웹 UI를 설정하는 방법을 설명합니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: qbittorrent
    url: 'http://<hostname>:<port>'
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
url:
  description: The URL of the Web UI of qBittorrent.
  required: true
  type: string
name:
  description: The name to use when displaying this qBittorrent instance.
  required: false
  type: string
username:
  description: The username of the Web UI of qBittorrent.
  required: true
  type: string
password:
  description: The password of the Web UI of qBittorrent.
  required: true
  type: string
{% endconfiguration %}
