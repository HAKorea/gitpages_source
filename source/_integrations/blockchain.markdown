---
title: 블록체인(blockchain)
description: Instructions on how to integrate Blockchain.info data within Home Assistant.
logo: blockchain.png
ha_category:
  - Finance
ha_release: 0.47
ha_iot_class: Cloud Polling
---

`Blockchain` 센서 플랫폼은 [blockchain.info](https://blockchain.info)의 Bitcoin 지갑 잔액을 표시합니다.

블록 체인 센서를 추가하려면 `configuration.yaml` 파일에서 감시할 비트 코인 주소 목록을 지정하십시오. 센서 상태는 나열된 모든 주소의 잔액 합계입니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: blockchain
    addresses:
      - '1BMsHFczb2vY1BMDvFGWgGU8mkWVm5fupp'
      - '183J5pXWqYYsxZ7inTVw9tEpejDXyMFroe'
```

{% configuration %}
addresses:
  description: 확인하고자 하는 비트 코인 지갑 주소 목록.
  required: true
  type: [string, list]
{% endconfiguration %}
