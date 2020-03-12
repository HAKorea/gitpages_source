---
title: Dlib 안면 식별
description: Instructions on how to integrate Dlib Face Identify into Home Assistant.
logo: dlib.png
ha_category:
  - Image Processing
ha_release: 0.44
---

`dlib_face_identify` 이미지 처리 플랫폼은 Home Assistant를 통해 [Dlib](http://www.dlib.net/)를 사용할 수있게합니다. 이 플랫폼을 사용하면 카메라에서 인물을 식별하고 인물을 식별하여 이벤트를 시작할 수 있습니다.

자동화 규칙 내에서 결과를 사용하려면 [integration](/integrations/image_processing/) 페이지를 보십시오.

### 설정

```yaml
# Example configuration.yaml entry
image_processing:
 - platform: dlib_face_identify
   source:
    - entity_id: camera.door
   faces:
     Jon: /home/hass/jon.jpg
     Bob: /home/hass/bob.jpg
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
faces:
  description: List of faces sources.
  required: true
  type: list
confidence:
  description: How much distance between faces to consider it a match. Using tolerance values lower than 0.6 will make the comparison more strict.
  required: false
  type: float
  default: 0.6
{% endconfiguration %}

<div class='note'>

플랫폼이 요구 사항을 설치할 수 없어서 로드에 실패하면, cmake를 설치하십시오: `sudo apt-get install cmake`.

</div>
