---
title: DOODS - 분산형 이미지처리 서비스
description: Detect and recognize objects with DOODS.
ha_category:
  - Image Processing
ha_iot_class: Local Polling
ha_release: '0.100'
---

`doods` 이미지 처리 플랫폼을 사용하면 [DOODS](https://github.com/snowzach/doods/)를 사용하여 카메라 이미지에서 물체를 감지하고 인식 할 수 있습니다. 개체의 상태는 감지된 개체의 수이며 인식된 개체는 수량과 함께 `summary` 속성에 나열됩니다. 
`matches` 속성은 인식에 대한 신뢰도 `score`와 각 탐지 범주에 대한 객체의 경계 `box`를 제공합니다.

## 셋업

[DOODS - Docker](https://hub.docker.com/r/snowzach/doods)
DOODS를 어딘가에서 실행해야 합니다. 도커 컨테이너로 실행하는 것이 가장 쉽고 배포는 도커 허브 [DOODS - Docker](https://hub.docker.com/r/snowzach/doods) 에 설명되어 있습니다.

## 설정

설정은 텐서플로우(Tensorflow) 설정을 비슷하게 따릅니다. 설치시 이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: doods
    url: "http://<my doods server>:8080"
    detector: default
    source:
      - entity_id: camera.front_yard
```

{% configuration %}
source:
  description: 이미지 소스 목록.
  required: true
  type: map
  keys:
    entity_id:
      description: 사진을 가져올 카메라 엔티티 ID.
      required: true
      type: string
    name:
      description: "`image_processing` 엔티티 이름을 대체할 수 있습니다."
      required: false
      type: string
url:
    description: DOODS 서버의 URL
    required: true
    type: string
timeout:
    description: 요청 시간 초과 (초)
    required: false
    type: integer
    default: 90
detector:
    description: 사용할 DOODS 감지기
    required: true
    type: string
confidence:
    description: 명시적으로 설정되지 않은 감지된 객체에 대한 기본 신뢰도
    required: false
    type: float
area:
    description: 글로벌 감지 영역. 이 상자의 개체가 보고됩니다. 이미지의 상단은 0, 하단은 1입니다. 왼쪽에서 오른쪽으로 동일합니다.
    required: false
    type: map
    keys:
      top:
        description: 이미지 상단에서 %로 정의된 상단 라인.
        required: false
        type: float
        default: 0
      left:
        description: 이미지 좌측에서 %로 정의된 좌측 라인.
        required: false
        type: float
        default: 0
      bottom:
        description: 이미지 상단에서 %로 정의된 하단 라인
        required: false
        type: float
        default: 1
      right:
        description: 이미지 오른쪽에서 %로 정의된 우측 라인
        required: false
        type: float
        default: 1
      covers:
        description: True이면이 상자(box)에 탐지가 완전히 완료되어야합니다. False인 경우 상자의 감지 부분이 트리거됩니다.
        required: false
        type: boolean
        default: true
file_out:
    description: 바운딩 박스(bounding box) 를 포함하여 처리된 이미지를 저장할 연동을 위한 [템플릿](/docs/configuration/templating/#processing-incoming-data). `camera_entity`는 트리거 된 소스 카메라의 `entity_id` 문자열로 사용 가능합니다.
    required: false
    type: list
labels:
    description: 선택된 레이블 모델에 대한 정보.
    required: false
    type: map
    keys:
      name:
        description: 탐지를 위해 선택할 개체의 레이블.
        required: true
        type: string
      confidence:
       description: 선택한 라벨에 대한 최소 신뢰
       required: false
       type: float
      area:
        description: Custom detection area. Only objects fully in this box will be reported. Top of image is 0, bottom is 1.  Same left to right. 사용자정의 감지 영역. 이 상자(box)에 완전하게 있는 개체만 보고됩니다. 이미지의 상단은 0, 하단은 1입니다. 왼쪽에서 오른쪽으로 동일합니다. 
        required: false
        type: map
        keys:
          top:
            description: Top line defined as % from top of image. 이미지 상단에서 %로 정의된 상단 라인
            required: false
            type: float
            default: 0
          left:
            description: Left line defined as % from left of image. 이미지 좌측에서 %로 정의된 좌측 라인
            required: false
            type: float
            default: 0
          bottom:
            description: Bottom line defined as % from top of image. 이미지 상단에서 %로 정의된 하단 라인
            required: false
            type: float
            default: 1
          right:
            description: Right line defined as % from left of image. 이미지 좌측에서 %로 정의된 우측 라인
            required: false
            type: float
            default: 1
          covers:
            description: True이면 상자(box)에 탐지가 완전히 완료되어야합니다. False 인 경우 상자의 감지 부분이 트리거됩니다.
            required: false
            type: boolean
            default: true

{% endconfiguration %}

```yaml
# Example advanced configuration.yaml entry
# Example configuration.yaml entry
image_processing:
  - platform: doods
    scan_interval: 1000
    url: "http://<my doods server>:8080"
    timeout: 60
    detector: default
    source:
      - entity_id: camera.front_yard
    file_out:
      - "/tmp/{% raw %}{{ camera_entity.split('.')[1] }}{% endraw %}_latest.jpg"
      - "/tmp/{% raw %}{{ camera_entity.split('.')[1] }}_{{ now().strftime('%Y%m%d_%H%M%S') }}{% endraw %}.jpg"
    confidence: 50
    # This global detection area is required for all labels
    area:
      # Exclude top 10% of image
      top: 0.1
      # Exclude right 5% of image
      right: 0.95
      # The entire detection must be inside this box
      covers: true
    labels:
      - name: person
        confidence: 40
        area:
          # Exclude top 10% of image
          top: 0.1
          # Exclude right 15% of image
          right: 0.85
          # Any part of the detection inside this area will trigger
          covers: false
      - car
      - truck
```

## 자원의 최적화 (Optimizing resources)

[Image processing components](/components/image_processing/)는 `scan_interval`에 의해 지정된 기간 동안 카메라에서 이미지를 처리합니다. 기본 `scan_interval` 이 10 초이므로 카메라의 이미지가 변경되지 않은 경우 과도한 처리가 발생합니다. 설정에 `scan_interval: 10000` (간격을 10,000초로 세팅)을 추가한 다음 실제로 처리를 수행하려는 경우 `image_processing.scan` 서비스를 호출하여 이를 무시할 수 있습니다.

```yaml
# Example advanced configuration.yaml entry
image_processing:
  - platform: doods
    scan_interval: 10000
    source:
      - entity_id: camera.driveway
      - entity_id: camera.backyard
```

```yaml
# Example advanced automations.yaml entry
- alias: Doods scanning
  trigger:
     - platform: state
       entity_id:
         - binary_sensor.driveway
  action:
    - service: image_processing.scan
      entity_id: image_processing.doods_camera_driveway
```
