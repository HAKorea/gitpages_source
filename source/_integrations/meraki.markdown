---
title: 머라키(Meraki)
description: Instructions on how to integrate Meraki-based presence detection into Home Assistant.
logo: meraki.png
ha_category:
  - Presence Detection
ha_release: '0.60'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/nqzDHz1CaL4?list=PLTVCI_tE32rQ2zIWR0IlWiTnpS0KbhwEZ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Meraki AP를 장치 추적기로 사용하십시오. Meraki는 네트워크뿐만 아니라 모든 장치를 볼 수 있습니다.

### 전제 조건

1. Go to Network-wide/General page, and find the Location and scanning section.
1. Make sure analytics and Scanning API are both enabled.
1. Make note of the Validator string, which will be used in the `device_tracker` configuration.
1. Click **Add a Post URL**:
  1. Set the Post URL to `https://YOUR_HOSTNAME/api/meraki?api_password=YOUR_HASS_PASSWORD`
  1. Set the Secret to a randomly generated string, and make note of it for the `device_tracker` configuration.
  1. Make sure the API Version is set to `2.0`.
  1. Hit **Save** in the bottom right of the page.

## 설정

Meraki CMX API에 대한 액세스를 설정한 후 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: meraki
    secret: your_secret
    validator: meraki_validator
```

{% configuration %}
  secret:
    description: Secret code added in Meraki.
    required: true
    type: string
  validator:
    description: Validation string from Meraki.
    required: true
    type: string
{% endconfiguration %}
