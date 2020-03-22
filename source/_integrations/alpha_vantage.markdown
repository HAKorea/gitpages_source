---
title: 실시간해외주식(Alpha Vantage)
description: Instructions on how to setup Alpha Vantage within Home Assistant.
logo: alpha_vantage.png
ha_category:
  - Finance
ha_iot_class: Cloud Polling
ha_release: '0.60'
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="560" height="315" src="https://www.youtube.com/embed/339AfkUQ67o" frameborder="0" allowfullscreen></iframe>
</div>

`alpha_vantage` 센서 플랫폼은 [Alpha Vantage](https://www.alphavantage.co)를 사용하여 주식 시장을 모니터링합니다. 이 플랫폼은 환율에 대한 세부 정보도 제공합니다.


`alpha_vantage` 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: alpha_vantage
    api_key: YOUR_API_KEY
    symbols:
      - symbol: GOOGL
        name: Google
    foreign_exchange:
      - name: USD_EUR
        from: USD
        to: EUR
```

symbol 또는 외환(foreign exchange)을 설정해야합니다. 그렇지 않으면 데이터를 얻을 수 없습니다.

{% configuration %}
api_key:
  description: "The API Key from [Alpha Vantage](https://www.alphavantage.co)."
  required: true
  type: string
symbols:
  description: List of stock market symbols for given companies.
  required: false
  type: map
  keys:
    name:
      description: The name of the sensor to use for the frontend.
      required: false
      type: string
    currency:
      description: The name of the sensor to use for the frontend.
      required: false
      type: string
      default: USD
    symbol:
      description: The stock market symbol for the given company.
      required: true
      type: string
foreign_exchange:
  description: List of currencies.
  type: map
  required: false
  keys:
    name:
      description: The name of the sensor to use for the frontend.
      required: false
      type: string
    from:
      description: The source currency.
      required: true
      type: string
    to:
      description: The target currency.
      required: true
      type: string
{% endconfiguration %}

## 사례 

이 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 구글 주가와 비트 코인의 환율

```yaml
sensor:
  - platform: alpha_vantage
    api_key: YOUR_API_KEY
    symbols:
      - name: Google
        currency: USD
        symbol: GOOGL
    foreign_exchange:
      - from: BTC
        to: USD
        name: Bitcoin
```
