---
title: 스플렁크(Splunk)
description: Record events in Splunk.
logo: splunk.png
ha_category:
  - History
ha_release: 0.13
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/oGuHDEuTU9E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`splunk` 통합은 Splunk의 HTTP 이벤트 콜렉터(HEC) 기능을 사용하여 모든 상태 변경을 외부 [Splunk](https://splunk.com/) 데이터베이스에 기록할 수있게합니다.
이것을 단독으로 사용하거나 Splunk의 홈어시스턴트 [app](https://github.com/miniconfig/splunk-homeassistant)와 함께 사용할 수 있습니다.
HEC 기능은 Splunk의 새로운 기능이므로 버전 6.3 이상을 사용해야합니다.

## 설정

설치에서 `splunk` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
splunk:
  token: YOUR_SPLUNK_TOKEN
```

{% configuration %}
token:
  description: The HTTP Event Collector Token already created in your Splunk instance.
  required: true
  type: string
host:
  description: "IP address or host name of your Splunk host, e.g., 192.168.1.10."
  required: false
  default: localhost
  type: string
port:
  description: Port to use.
  required: false
  default: 8080
  type: integer
ssl:
  description: Use HTTPS instead of HTTP to connect.
  required: false
  default: false
  type: boolean
verify_ssl:
  description: Allows you do disable checking of the SSL certificate.
  required: false
  default: false
  type: boolean
name:
  description: This parameter allows you to specify a friendly name to send to Splunk as the host, instead of using the name of the HEC.
  required: false
  default: HASS
  type: string
filter:
  description: Filters for entities to be included/excluded from Splunk. Default is to include all entities.
  required: false
  type: map
  keys:
    include_domains:
      description: Domains to be included.
      required: false
      type: list
    include_entities:
      description: Entities to be included.
      required: false
      type: list
    exclude_domains:
      description: Domains to be excluded.
      required: false
      type: list
    exclude_entities:
      description: Entities to be excluded.
      required: false
      type: list
{% endconfiguration %}
