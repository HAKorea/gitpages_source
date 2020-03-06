---
title: Microsoft 안면 식별
description: Instructions on how to integrate Microsoft Face Identify into Home Assistant.
logo: microsoft.png
ha_category:
  - Image Processing
ha_release: 0.37
---

`microsoft_face_identify` 이미지 처리 플랫폼을 사용하면 Home Assistant를 통해 [Microsoft Face identify](https://www.microsoft.com/cognitive-services/en-us/) API를 사용할 수 있습니다. 이 플랫폼을 사용하면 카메라의 인물을 식별하고 속성이 있는 이벤트를 실행할 수 있습니다.

API 키 설정 방법에 대해서는 [Microsoft Face component](/integrations/microsoft_face/) 설정을 참조하십시오.

자동화 규칙 내에서 결과를 사용하려면 [Image Processing component](/integrations/image_processing/)페이지 를 보십시오.

<div class='note'>

무료 버전의 Microsoft Face 식별 API는 한 달에 가능한 요청 수를 제한합니다. 따라서 기본 [Image Processing component](/integrations/image_processing/) 페이지에 설명 된대로 이 엔티티의 인스턴스를 설정할 때 `scan_interval` 을 제한하는 것이 좋습니다.

</div>

### 설정

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: microsoft_face_identify
    group: family
    source:
      - entity_id: camera.door
```

{% configuration %}
group:
  description: Micrsoft 얼굴 그룹에서 사람을 감지.
  required: true
  type: string
confidence:
  description: 홈어시스턴트로 처리할 수있는 최소 신뢰 백분율입니다.
  required: false
  type: integer
  default: 80
source:
  description: 이미지 소스 목록.
  required: true
  type: list
  keys:
    entity_id:
      description: 사진을 가져 오는 카메라 엔티티 ID.
      required: true
      type: string
    name:
      description: 이 매개 변수를 사용하면 `image_processing` 엔티티의 이름을 대체 할 수 있습니다.
      required: false
      type: string
{% endconfiguration %}
