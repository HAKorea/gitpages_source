---
title: 레비톤 데코라 Wifi (Leviton Decora Wi-Fi)
description: Instructions on how to setup Leviton Decora Smart Wi-Fi switches/dimmers within Home Assistant.
ha_category:
  - Light
ha_iot_class: Cloud Polling
logo: leviton.png
ha_release: 0.51
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/td65lPwp0TE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

MyLeviton API를 통한 [Leviton Decora Wi-Fi](https://www.leviton.com/en/products/lighting-controls/decora-smart-with-wifi) dimmers/switches 지원.

지원 장치 (tested):

- [DW6HD1-BZ](https://www.leviton.com/en/products/dw6hd-1bz) (Decora Smart Wi-Fi 600W Dimmer)
- [DW15S-1BZ](https://www.leviton.com/en/products/dw15s-1bz) (Decora Smart Wi-Fi 15A Switch)

이 조명을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: decora_wifi
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Your "My Leviton" app email address/user name.
  required: true
  type: string
password:
  description: Your "My Leviton" app password.
  required: true
  type: string
{% endconfiguration %}
