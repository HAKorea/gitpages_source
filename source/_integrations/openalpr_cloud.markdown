---
title: OpenALPR Cloud(차량번호판인식)
description: Instructions on how to integrate licences plates with OpenALPR cloud into Home Assistant.
logo: openalpr.png
ha_category:
  - Image Processing
ha_release: 0.36
---

Home Assistant에 대한 [OpenALPR] (https://www.openalpr.com/) 통합을 통해 카메라에서 차량 번호판을 처리 할 수 ​​있습니다. 이를 사용하여 차고문을 열거나 다른 [automation](/integrations/automation/)를 트리거 할 수 있습니다.

자동화 규칙 내에서 결과를 사용하려면 [component](/integrations/image_processing/)페이지를 보십시오.

### 설정

```yaml
# Example configuration.yaml entry
image_processing:
 - platform: openalpr_cloud
   api_key: YOUR_API_KEY
   region: eu
   source:
    - entity_id: CAMERA.GARAGE
```

{% configuration %}
region:
  description: Country or region. List of supported [values](https://github.com/openalpr/openalpr/tree/master/runtime_data/config). 국가 혹은 지역. 지원되는 [values](https://github.com/openalpr/openalpr/tree/master/runtime_data/config)
  required: true
  type: string
api_key:
  description: "[OpenALPR Cloud](https://cloud.openalpr.com/)의 API 키가 필요합니다."
  required: true
  type: string
confidence:
  description: 홈어시스턴트로 처리할 수있는 최소 신뢰 백분율.
  required: false
  type: integer
  default: 80
source:
  description: 이미지 소스 목록.
  required: true
  type: list
  keys:
    entity_id:
      description: 사진을 가져올 카메라 엔티티 ID.
      required: true
      type: string
    name:
      description: 이 매개 변수를 사용하면 OpenALPR 엔티티의 이름을 대체 할 수 있습니다.
      required: false
      type: string
{% endconfiguration %}
