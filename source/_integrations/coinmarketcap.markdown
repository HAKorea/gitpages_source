---
title: 코인마켓캡(CoinMarketCap)
description: Instructions on how to integrate CoinMarketCap data within Home Assistant.
logo: coinmarketcap.png
ha_category:
  - Finance
ha_release: 0.28
ha_iot_class: Cloud Polling
---

`coinmarketcap` 센서 플랫폼은 [CoinMarketCap](https://coinmarketcap.com/)에서 제공하는 암호 화폐에 대한 다양한 세부 정보를 표시합니다.

CoinMarketCap 센서를 설치에 추가하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: coinmarketcap
```

{% configuration %}
currency_id:
  description: The ID of the cryptocurrency to use, default is the ID of Bitcoin.
  required: false
  type: integer
  default: 1
display_currency:
  description: The currency to display.
  required: false
  type: string
  default: USD
display_currency_decimals:
  description: The amount of decimals to round to.
  required: false
  type: integer
  default: 2
{% endconfiguration %}

지원되는 모든 통화는 [여기](https://coinmarketcap.com/api/)에서 찾을 수 있으며 통화 ID 목록은 [여기](https://api.coinmarketcap.com/v2/ticker/)에서 찾을 수 있습니다.