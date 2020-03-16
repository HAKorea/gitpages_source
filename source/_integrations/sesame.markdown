---
title: 세서미 스마트락(Sesame Smart Lock)
description: Instructions on how to integrate Sesame by CANDY HOUSE into Home Assistant.
logo: sesame.png
ha_category:
  - Lock
ha_iot_class: Cloud Polling
ha_release: 0.47
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/M2fYzlsJW68" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`seame` 플랫폼을 사용하면 CANDY HOUSE, Inc.의 [Sesame](https://candyhouse.co/) 스마트 잠금 장치를 제어할 수 있습니다.

## 설정

세서미는 별도로 구매한 독립형 [Wi-Fi Access Point](https://candyhouse.co/collections/frontpage/products/wi-fi-access-point)와 페어링해야합니다.

또한 [my.candyhouse.co](https://my.candyhouse.co/#/credentials)에서 API 키를 생성해야합니다.

위의 설정 중 하나를 사용하여 원격 액세스를 활성화하고 해당 잠금 설정에 대해 Sesame 앱에서 Integration - cloud 옵션을 활성화 한 경우 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
lock:
  - platform: sesame
    api_key: YOUR_SESAME_API_KEY
```

{% configuration %}
api_key:
  description: The API key for your Sesame account.
  required: true
  type: string
{% endconfiguration %}
