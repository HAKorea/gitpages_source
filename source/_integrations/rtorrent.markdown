---
title: 알토렌트(rTorrent)
description: Instructions on how to integrate rtorrent sensors within Home Assistant.
logo: rtorrent.png
ha_category:
  - Downloading
ha_release: 0.81
ha_iot_class: Local Polling
---

`rtorrent` 플랫폼을 사용하면 Home Assistant 내에서 [rtorrent](https://rakshasa.github.io/rtorrent/) 및 정보를 기반으로 설정 자동화를 통해 다운로드를 모니터링 할 수 있습니다.

이 센서를 사용하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: rtorrent
    url: 'http://<user>:<password>@<host>:<port>/RPC2'
    monitored_variables:
      - 'current_status'
      - 'download_speed'
      - 'upload_speed'
```

이 센서에는 HTTP 인터페이스에 노출된 rtorrent XMLRPC API가 필요합니다.
보안상의 이유로 rtorrent의 SCGI 인터페이스 (기본 `localhost:5000`)를 사용하는 것만으로는 작동하지 않습니다. [official reference](https://github.com/rakshasa/rtorrent/wiki/RPC-Setup-XMLRPC)는 해당 HTTP 인터페이스를 설정하는 방법을 설명합니다.

또는 [arch-rtorrentvpn](https://github.com/binhex/arch-rtorrentvpn) 컨테이너는 `url`을 `http://admin:rutorrent@127.0.0.1:9080/RPC2`로 설정하여 사용할 수 있습니다. 

{% configuration %}
url:
  description: The URL to the HTTP endpoint of the rtorrent XMLRPC API.
  required: true
  type: string
name:
  description: The name to use when displaying this rtorrent instance.
  required: false
  type: string
monitored_variables:
  description: Conditions to be monitored.
  required: true
  type: list
  keys:
    current_status:
      description: The status of your rtorrent daemon.
    download_speed:
      description: The current download speed.
    upload_speed:
      description: The current upload speed.
{% endconfiguration %}
