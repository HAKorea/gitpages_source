---
title: Supervisord
description: Instructions on how to integrate Supervisord within Home Assistant.
logo: supervisord.png
ha_category:
  - System Monitor
ha_release: '0.20'
ha_iot_class: Local Polling
---

`supervisord` 플랫폼을 사용하면 [Supervisord](http://supervisord.org/)의 상태를 추적할 수 있습니다.

`/etc/supervisord.conf` 설정 파일에서 HTTP 기능을 활성화해야 합니다.

```text
[inet_http_server]
port=127.0.0.1:9001
```

`supervisord`를 다시 시작하면 웹 인터페이스에 액세스 할 수 있어야합니다. 필요한 경우 [iFrame panel](/integrations/panel_iframe/)로 추가 할 수 있습니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/supervisor.png' />
</p>

설치시 이 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: supervisord
```

{% configuration %}
url:
  description: The URL to track.
  required: false
  default: "`http://localhost:9001/RPC2`"
  type: string
{% endconfiguration %}
