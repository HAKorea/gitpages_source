---
title: Dlib 안면 인식
description: Instructions on how to integrate Dlib Face Detect into Home Assistant.
logo: dlib.png
ha_category:
  - Image Processing
ha_release: 0.44
---

`dlib_face_detect` 이미지 처리 플랫폼을 통해 Home Assistant를 통해 [Dlib](http://www.dlib.net/)를 사용할 수 있습니다. 이 플랫폼은 카메라에서 얼굴을 감지하고 속성을 사용하여 이벤트를 발생시킬 수 있습니다.

자동화 규칙을 트리거하는데 사용할 수 있습니다. 추가 정보는 [integration](/integrations/image_processing/) 페이지에 있습니다.

### 홈어시스턴트 설정

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: dlib_face_detect
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
