---
title: 가상화폐(SoChain)
description: Instructions on how to integrate chain.so data within Home Assistant.
logo: sochain.png
ha_category:
  - Finance
ha_release: 0.61
ha_iot_class: Cloud Polling
---

`SoChain` 센서 플랫폼은 [SoChain](https://chain.so)에서 지원되는 암호화폐지갑 잔액을 표시합니다.

SoChain 센서를 설치시 추가하려면 `configuration.yaml` 파일에서 감시할 네트워크와 주소를 지정하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sochain
    network: LTC
    address: 'M9m37h3dVkLDS13wYK7vcs7ck6MMMX6yhK'
```

{% configuration %}
network:
  description: The network or blockchain of the cryptocurrency to watch.
  required: true
  type: string
address:
  description: Cryptocurrency wallet address to watch.
  required: true
  type: string
name:
  description: The name of the sensor used in the frontend. (recommended)
  required: false
  type: string
  default: Crypto Balance
{% endconfiguration %}

지원되는 네트워크([여기](https://chain.so/api#networks-supported)에서 찾을 수 있음)는 다음과 같습니다. :

* BTC
* LTC
* DOGE
* DASH
