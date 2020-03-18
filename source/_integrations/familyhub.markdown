---
title: 삼성 냉장고 카메라(Samsung Family Hub)
description: Instructions on how to integrate Samsung Family Hub refrigerator cameras within Home Assistant.
logo: familyhub.png
ha_category:
  - Camera
ha_release: '0.70'
ha_iot_class: Local Polling
---

<iframe width="690" height="703" src="https://www.youtube.com/embed/XDfXm-YrZ8k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

familyhub플랫폼을 사용하면 홈어시스턴트에서 [Samsung Family Hub refrigerator](https://www.samsung.com/us/explore/family-hub-refrigerator/connected-hub/) 내부 이미지를 얻을 수 있습니다.

## 설정 

설치시 Family Hub 카메라를 활성화하려면 `configuration.yaml`파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: familyhub
    ip_address: 'IP_ADDRESS'
```

{% configuration %}
ip_address:
  description: 냉장고의 IP 주소.
  required: true
  type: string
{% endconfiguration %}
