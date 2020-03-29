---
title: 이더스캔(Etherscan)
description: Instructions on how to integrate Etherscan.io data within Home Assistant.
logo: etherscan.png
ha_category:
  - Finance
ha_release: 0.47
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/RYXD4xqurmE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Etherscan` 센서 플랫폼은 [Etherscan.io](https://etherscan.io)의 Ether 및 ERC-20 토큰 잔액을 표시합니다.

Etherscan 센서를 설치에 추가하려면 `configuration.yaml` 파일에서 볼 Ethereum 주소를 지정하십시오. 선택적으로 검색할 토큰 이름과 ERC-20 토큰 밸런스를 제공 할 수도 있습니다. 토큰이 제공되지 않으면 검색된 잔액은 ETH입니다. 토큰 이름을 찾을 수 없는 경우 토큰 계약 주소를 선택적으로 제공할 수도 있습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: etherscan
    address: '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359'
  - platform: etherscan
    address: "0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359"
    token: OMG
  - platform: etherscan
    address: "0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359"
    token_address: "0xef68e7c694f40c8202821edf525de3782458639f"
    token: LRC
```

{% configuration %}
address:
  description: Ethereum wallet address to watch.
  required: true
  type: string
name:
  description: The name of the sensor used in the frontend.
  required: false
  type: string
  default: ETH Balance
token:
  description: The ERC20 token symbol. i.e., OMG.
  required: false
  type: string
token_address:
  description: The ERC20 token contract address.
  required: false
  type: string
{% endconfiguration %}
