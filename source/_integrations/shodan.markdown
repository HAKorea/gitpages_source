---
title: 사물인터넷 검색엔진(Shodan)
description: Instructions on how to integrate Shodan sensors into Home Assistant.
ha_category:
  - Sensor
ha_iot_class: Cloud Polling
logo: shodan.png
ha_release: 0.51
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/oDkg1zz6xlw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`shodan` 센서 플랫폼은 [Shodan](https://www.shodan.io/) 쿼리 결과의 총계를 표시합니다.

로그인하거나 "My Account" 페이지에서 오른쪽 상단 모서리에 있는 "Show API Key"를 사용하여 API 키를 검색하십시오.

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: shodan
    api_key: SHODAN_API_KEY
    query: 'home-assistant'
```

{% configuration %}
  api_key:
    description: The API key for Shodan.io.
    required: true
    type: string
  query:
    description: The search string.
    required: true
    type: string
  name:
    description: Name of the Shodan sensor.
    required: false
    type: string
{% endconfiguration %}
