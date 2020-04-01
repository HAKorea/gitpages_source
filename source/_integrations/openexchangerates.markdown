---
title: 오픈환률정보(Open Exchange Rates)
description: Instructions on how to integrate exchange rates from https://openexchangerates.org within Home Assistant.
ha_category:
  - Finance
logo: openexchangerates.png
ha_iot_class: Cloud Polling
ha_release: 0.23
---

`openexchangerates` 센서는 [170개 통화](https://openexchangerates.org/currencies)에 대한 실시간 환율을 제공하는 [Open Exchange Rates](https://openexchangerates.org)의 현재 환율을 보여줍니다.

당신의 API 키를 [여기](https://openexchangerates.org/signup)서 받으십시오 

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: openexchangerates
    api_key: YOUR_API_KEY
    quote: EUR
```

{% configuration %}
name:
  description: The name of the sensor.
  required: false
  type: string
  default: Exchange Rate Sensor
api_key:
  description: "The API Key for [Open Exchange Rates](https://openexchangerates.org)."
  required: true
  type: string
quote:
  description: The symbol of the quote or target currency.
  required: true
  type: string
base:
  description: The symbol of the base currency.
  required: false
  type: string
  default: USD
{% endconfiguration %}
