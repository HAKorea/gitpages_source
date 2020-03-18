---
title: 가상화폐(IOTA)
description: Instructions on how to integrate IOTA wallets with Home Assistant.
logo: iota.png
ha_category:
  - Finance
  - Sensor
ha_release: 0.62
ha_iot_class: Cloud Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/ivWqqfzunhI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[IOTA](https://iota.org/)는 새로운 블록리스 분산 원장(blockless distributed ledger)으로 확장 가능하고 가벼우며 추가 비용없이 가치를 이전할 수 있습니다.

`iota` 통합구성요소는 IOTA 지갑의 다양한 세부사항 (예 : the balance, node attributes)을 표시합니다.

```yaml
# configuration.yaml example
iota:
  iri: https://testnet140.tangle.works:4434
  wallets:
    - name: Default Wallet
      seed: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

{% configuration %}
iri:
  description: URL of the IRI node.
  required: true
  type: string
testnet:
  description: Flag for indicating "testnet".
  required: false
  type: boolean
  default: false
wallets:
  description: List of IOTA wallets.
  required: true
  type: list
  keys:
    name:
      description: Name of the wallet.
    seed:
      description: Seed of the wallet.
{% endconfiguration %}

전체 설정 예는 다음과 같습니다.

```yaml
# Full example
iota:
  iri: https://testnet140.tangle.works:4434
  testnet: true
  wallets:
    - name: Default Wallet
      seed: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    - name: Exchange Wallet
      seed: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## Sensor

IOTA 통합구성요소가 있으면 센서가 자동으로 생성됩니다.

사용 가능한 sensor:

- Wallet balance
- Node information
