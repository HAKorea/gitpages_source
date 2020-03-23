---
title: 코인베이스(Coinbase)
description: Instructions for how to add Coinbase sensors to Home Assistant.
logo: coinbase.png
ha_category:
  - Finance
  - Sensor
ha_release: 0.61
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/HQaegigv6jU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`coinbase` 통합구성요소를 통해 [coinbase](https://coinbase.com)에서 계정 잔액 및 환율에 액세스 할 수 있습니다.

이 구성 요소를 사용하려면 코인베이스의 [개발자 사이트](https://www.coinbase.com/settings/api)에서 API 키를 얻어야합니다. 통합구성요소가 관련 데이터에 액세스하려면 `wallet:accounts`에 대한 읽기 권한을 부여해야합니다.

## 설정

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
coinbase:
  api_key: YOUR_API_KEY
  api_secret: YOUR_API_SECRET
```

{% configuration %}
api_key:
  description: Your API key to access coinbase.
  required: true
  type: string
api_secret:
  description: Your API secret to access coinbase.
  required: true
  type: string
account_balance_currencies:
  description: List of currencies to create account wallet sensors for.
  required: false
  type: list
  default: all account wallets
exchange_rate_currencies:
  description: List of currencies to create exchange rate sensors for.
  required: false
  type: list
{% endconfiguration %}

가능한 통화는 가능한 경우 ISO 4217 표준을 따르는 코드입니다. ISO 4217에서 표현이 있거나 없는 통화는 사용자 정의 코드 (예: BTC)를 사용할 수 있습니다. https://api.coinbase.com/v2/currencies를 통해 값 목록을 얻을 수 있습니다. 자세한 내용은 [the Coinbase API documentation](https://developers.coinbase.com/api/v2#get-currencies)를 방문하십시오.

## 전체 설정 사례

선택적 변수를 포함한 전체 설정 샘플 :

```yaml
# Example configuration.yaml entry
coinbase:
  api_key: YOUR_API_KEY
  api_secret: YOUR_API_SECRET
  account_balance_currencies:
    - EUR
    - BTC
  exchange_rate_currencies:
    - BTC
    - ETH
    - LTC
```
