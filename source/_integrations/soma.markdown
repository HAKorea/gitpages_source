---
title: 스마트블라인드(Soma Connect)
description: Instructions on how to set up the Soma Connect within Home Assistant.
logo: soma.png
ha_category:
  - Cover
ha_iot_class: Local Polling
ha_config_flow: true
ha_release: '0.100'
ha_codeowners:
  - '@ratsept'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/rUWimvBEeZc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Soma 통합구성요소를 통해 사용자는 Soma Connect 허브를 사용하여 Soma Smarthome 장치를 Home Assistant에 연동할 수 있습니다.

여분의 Raspberry Pi가 있는 경우 Soma Connect를 직접 구축 할 수 있습니다. [ official instructions](https://somasmarthome.zendesk.com/hc/en-us/articles/360035521234-Install-SOMA-Connect-software-on-SOMA-Connect-Raspberry-Pi)을 따라가기만 하면 됩니다. 
SD 카드를 라즈베리파이에 연결 한 후 이더넷 케이블 또는 [set up WiFI](https://somasmarthome.zendesk.com/hc/en-us/articles/360026210333-Configuring-Wi-Fi-access)을 사용하십시오. 그런 다음 라우터의 DHCP 테이블을 확인하여 IP 주소를 찾으십시오 (이 단계에서 작업 가능).

Connect는 범위 내의 모든 Smartshade 장치를 자동으로 찾아 이 통합구성요소 및 Home Kit를 통해 노출합니다. 이 통합구성요소는 처음 설정될 때 새 shade만 열거합니다. 그 후에 shade를 추가하면 Home Assistant를 다시 시작하거나 이 통합구성요소를 다시 설정하면됩니다. 새로운 shade가 자동으로 감지되어 노출됨에 따라 Soma Connect에 자동으로 생성됩니다. 

실제로 shades을 이동하려면 먼저 함께 제공되는 지침에 따라 shades을 설정해야합니다.

## 설정

```yaml
# Example configuration.yaml entry
soma:
  host: CONNECT_IP_ADDR
  port: CONNECT_PORT
```

{% configuration %}
host:
  description: Your Soma Connect IP address.
  required: true
  type: string
port:
  description: Your Soma Connect port.
  required: true
  default: 3000
  type: string
{% endconfiguration %}
