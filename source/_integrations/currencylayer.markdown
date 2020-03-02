---
title: 실시간환률(currencylayer)
description: Instructions on integrating exchange rates from https://currencylayer.com/ within Home Assistant.
ha_category:
  - Finance
logo: currencylayer.png
ha_iot_class: Cloud Polling
ha_release: 0.32
---

`currencylayer` 센서는 [170 currencies](https://currencylayer.com/currencies)에 대한 실시간 환율을 제공하는 [Currencylayer](https://currencylayer.com/)의 현재 환율을 보여줍니다. 무료 계정은 기본 통화로 USD로만 제한되며 매월 1000 건의 요청을 허용하며 매시간 업데이트됩니다.

[here](https://currencylayer.com/product)에서 API 키를 얻으십시오

이 센서를 사용하려면 `configuration.yaml` 파일에 다음 줄을 추가 하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: currencylayer
    api_key: YOUR_API_KEY
    base: USD
    quote:
      - EUR
      - INR
```

{% configuration %}
api_key:
  description: "[Currencylayer](https://currencylayer.com/)에서 받은 API키"
  required: true
  type: string
quote:
  description: 대상 통화의 기호.
  required: false
  type: [string, list]
  default: Exchange rate
base:
  description: 기본 통화.
  required: false
  type: string
  default: USD
{% endconfiguration %}
