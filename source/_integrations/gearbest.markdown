---
title: 기어베스트(Gearbest)
description: Instructions on how to integrate a Gearbest sensor into Home Assistant.
logo: gearbest.png
ha_category:
  - Sensor
ha_iot_class: Cloud Polling
ha_release: '0.60'
ha_codeowners:
  - '@HerrHofrat'
---

`gearbest` 센서는 [Gearbest](https://www.gearbest.com)에서 제품 가격을 추적합니다. 이 정보는 예를 들어 자동화에서 사용되어 가격이 떨어지면 알려줍니다. 모든 항목의 업데이트 간격은 현재 2 시간으로 설정되어 있습니다.

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: gearbest
    currency: EUR
    items:
      - url: https://www.gearbest.com/....
```

{% configuration %}
currency:
  description: "The currency in which the products should be tracked. Currently supported: USD, EUR, GBP, AUD, CAD, CHF, HKD, CNY, NZD, JPY, RUB, BRL, CLP, NOK, DKK, SEK, KRW, ILS, COP, MXN, PEN, THB, IDR, UAH, PLN, INR, BGN, HUF, RON, TRY, CZK, HRK, MAD, AED, SAR, ZAR, SGD, MYR, TWD, RSD, NGN - if the currency could not be found in the conversion rate list, USD will be used as default. Either an ID or an URL must be present."
  required: true
  type: string
items:
  description: List of products that should be tracked.
  required: true
  type: map
  keys:
    id:
      description: The ID of the product.
      required: false
      type: integer
    url:
      description: The URL of the product.
      required: false
      type: string
    name:
      description: The name of the item. If not set, it is parsed from the website.
      required: false
      type: string
    currency:
      description: Overwrite the currency for the current item.
      required: false
      type: string
{% endconfiguration %}

### 확장 사례

```yaml
# Example configuration.yaml entry
sensor:
  - platform: gearbest
    currency: EUR
    items:
      - url: https://www.gearbest.com/3d-printers-3d-printer-kits/pp_779174.html?wid=21
        name: Creality CR-10 upgraded
        currency: USD
      - id: 779174
        name: Creality CR-10 upgraded #2
        currency: EUR
```
