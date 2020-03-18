---
title: 실시간환율(Fixer)
description: Instructions on how to integrate exchange rates from Fixer.io within Home Assistant.
ha_category:
  - Finance
logo: fixer-io.png
ha_iot_class: Cloud Polling
ha_release: 0.23
ha_codeowners:
  - '@fabaff'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/u1zb4dHthss" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`fixer` 센서는  [European Central Bank (ECB)](https://www.ecb.europa.eu)의 데이터를 사용하는 [Fixer.io](https://fixer.io/)의 현재 환율을 표시합니다.

사용 가능한 [currencies](https://fixer.io/symbols)를 살펴보십시오. 

## 셋업

[API key](https://fixer.io/product)를 만들어야합니다. 한 달에 1000 콜의 제한이 있습니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: fixer
    api_key: YOUR_API_KEY
    target: CHF
```

{% configuration %}
api_key:
  description: Your API key for [Fixer.io](https://fixer.io/).
  required: true
  type: string
target:
  description: The symbol of the target currency.
  required: true
  type: string
name:
  description: Name to use in the frontend.
  required: false
  type: string
  default: Exchange rate
{% endconfiguration %}

API에 대한 자세한 내용은 [Fixer.io documentation](https://fixer.io/documentation)에서 확인할 수 있습니다.