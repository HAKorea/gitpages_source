---
title: 오픈소스에너지데이터(Emoncms History)
description: Instructions on how to integrate Emoncms history into Home Assistant.
logo: emoncms.png
ha_category:
  - History
ha_release: 0.31
---

<div class='videoWrapper'>
<iframe width="1250" height="713" src="https://www.youtube.com/embed/8yhXND-uwVQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`emoncms_history` 통합구성요소을 통해 홈어시스턴트로 수집한 세부 정보를 [Emoncms.org](https://emoncms.org/) 또는 로컬 실행중인 Emoncms 인스턴스로 전송할 수 있습니다. 엔터티 ID를 키로 사용하여 Emoncms의 특정 입력 노드로 데이터를 보냅니다. 그 후 수집된 데이터를 사용하여 Emoncms에서 피드 및 대시 보드를 생성할 수 있습니다.

설치시 `emoncms_history` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
emoncms_history:
  api_key: YOUR_EMONCMS_WRITE_API_KEY
  url: https://emoncms.org
  inputnode: 19
  whitelist:
    - sensor.owm_temperature
    - sensor.owm_wind_speed
```

{% configuration %}
api_key:
  description: Your Emoncms write api key
  required: true
  type: string
url:
  description: The root URL of your Emoncms installation. (Use https://emoncms.org for the cloud based version)
  required: true
  type: string
inputnode:
  description:  Input node that will be used inside Emoncms. Please make sure you use a dedicated, not used before, node for this component!
  required: true
  type: integer
whitelist:
  description: List of entity IDs you want to publish.
  required: true
  type: list
scan_interval:
  description:  Defines, in seconds, how regularly the states of the whitelisted entities are being gathered and send to Emoncms.
  required: false
  type: integer
  default: 30
{% endconfiguration %}
