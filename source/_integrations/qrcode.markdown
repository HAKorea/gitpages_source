---
title: 큐알코드(QR Code)
description: Instructions on how to integrate QR Code Recognition into Home Assistant.
logo: home-assistant.png
ha_category:
  - Image Processing
ha_release: 0.87
---

`qrcode` 이미지 처리 플랫폼을 사용하면 카메라에서 QR코드를 인식할 수 있습니다.

이를 실행하려면 `zbar-tools`를 설치하십시오 (Ubuntu 18.04)

## 설정

이를 가능하게하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: qrcode
    source:
      - entity_id: camera.door
```

{% configuration %}
source:
  description: List of image sources.
  required: true
  type: list
  keys:
    entity_id:
      description: A camera entity id to get picture from.
      required: true
      type: string
    name:
      description: This parameter allows you to override the name of your `image_processing` entity.
      required: false
      type: string
{% endconfiguration %}
