---
title: AI플랫폼(TensorFlow)
description: Detect and recognize objects with TensorFlow.
logo: tensorflow.png
ha_category:
  - Image Processing
ha_iot_class: Local Polling
ha_release: 0.82
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/iKQC4oCvSXU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`tensorflow` 이미지 처리 플랫폼을 사용하면 [TensorFlow](https://www.tensorflow.org/)를 사용하여 카메라 이미지의 객체를 감지하고 인식 할 수 있습니다. 개체의 상태는 감지된 개체의 수이며 인식된 개체는 수량과 함께 `summary` 속성에 나열됩니다. `matches` 속성은 인식에 대한 신뢰도 `score`와 각 탐지 범주에 대한 객체의 경계 `box`를 제공합니다.

<div class='note warning'>

  통합구성요소가 작동하려면 설정을 수행하기 전에 다음 패키지를 Raspbian에 설치해야합니다.
  `sudo apt-get install libatlas-base-dev libopenjp2-7 libtiff5`
  

</div>

## 셋업

`tensorflow` Python 패키지를 설치해야합니다. : `$ pip3 install tensorflow==1.13.2`. wheel이 모든 플랫폼에서 사용 가능한 것은 아닙니다. 다른 옵션에 대해서는 [the official install guide](https://www.tensorflow.org/install/)를 참조하십시오. Hass.io는 아직 지원되지 않지만 애드온이 개발중입니다.

이 통합구성요소를 위해서는 파일을 컴퓨터에서 다운로드하고 컴파일 한 후 홈어시스턴트 설정 디렉토리에 추가해야합니다. 이 단계는 [this gist](https://gist.github.com/hunterjm/6f9332f92b60c3d5e448ad936d7353c3)의 샘플 스크립트를 사용하여 수행 할 수 있습니다. 또는 프로세스를 수동으로 수행하려는 경우 프로세스는 다음과 같습니다.

- Clone [tensorflow/models](https://github.com/tensorflow/models/tree/master/research/object_detection)
- Compile protobuf models located in `research/object_detection/protos` with `protoc`
- Create the following directory structure inside your config directory:

```bash
  |- {config_dir}
    | - tensorflow/
      |- object_detection/
        |- __init__.py
```

- Copy required object_detection dependencies to the `object_detection` folder inside of the `tensorflow` folder:

  - `research/object_detection/data`
  - `research/object_detection/utils`
  - `research/object_detection/protos`

## 모델 선택

마지막으로 모델을 선택할 때입니다. [Model Detection Zoo](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md)에서 사용 가능한 COCO 모델 중 하나로 시작하는 것이 좋습니다 .

서로 다른 모델 간의 균형(trade-off)은 정확성 대 속도입니다. 적절한 CPU를 가진 사용자는 `faster_rcnn_inception_v2_coco` 모델로 시작해야합니다. Raspberry Pi와 같은 ARM 장치에서 실행중인 경우 `ssd_mobilenet_v2_coco` 모델로 시작하십시오.

어떤 모델을 선택하든, 다운로드하여 `frozen_inference_graph.pb` 파일을 설정 디렉토리의 `tensorflow` 폴더에 저장하십시오.

## 설정

설치에서이 플랫폼을 활성화하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: tensorflow
    source:
      - entity_id: camera.local_file
    model:
      graph: /home/homeassistant/.homeassistant/tensorflow/frozen_inference_graph.pb
```

{% configuration %}
source:
  description: 이미지 소스 목록.
  required: true
  type: map
  keys:
    entity_id:
      description: 사진을 가져올 카메라 엔티티 ID
      required: true
      type: string
    name:
      description: 이 매개 변수를 사용하면`image_processing` 엔티티의 이름을 대체 할 수 있습니다.
      required: false
      type: string
file_out:
    description: 바운딩 박스를 포함하여 처리된 이미지를 저장해서 연동하기 위한 [template](/docs/configuration/templating/#processing-incoming-data). `camera_entity`는 트리거된 소스 카메라의 `entity_id` 문자열로 사용 가능합니다.
    required: false
    type: list
model:
    description: TensorFlow 모델에 대한 정보.
    required: true
    type: map
    keys:
      graph:
        description: "`frozen_inference_graph.pb`로의 전체 경로"
        required: true
        type: string
      labels:
       description: "`*label_map.pbtext`로의 전체 경로"
       required: false
       type: string
       default: tensorflow/object_detection/data/mscoco_label_map.pbtxt
      model_dir:
        description: tensorflow 모델 디렉토리의 전체 경로
        required: false
        type: string
        default: /tensorflow inside config
      area:
        description: 맞춤형 감지 영역. 이 상자에 완전히 있는 개체만 보고됨. 이미지의 상단은 0, 하단은 1입니다. 왼쪽에서 오른쪽으로 동일합니다.
        required: false
        type: map
        keys:
          top:
            description: 이미지 상단에서 %로 정의된 상단 라인.
            required: false
            type: float
            default: 0
          left:
            description: 이미지 좌측에서 %로 정의된 좌측 라인
            required: false
            type: float
            default: 0
          bottom:
            description: 이미지 상단에서 %로 정의된 하단 라인
            required: false
            type: float
            default: 1
          right:
            description: 이미지 좌측에서 %로 정의된 우측 라인
            required: false
            type: float
            default: 1
      categories:
        description: 물체 감지에 포함할 카데고리 목록. `labels`에 제공된 파일에서 볼 수 있습니다.
        type: list
        required: false
{% endconfiguration %}

`categories`는 아래 고급 설정에서 볼 수 있듯 각 카데고리에 대한 영역을 제공하는 사전(dictionary)으로 정의 할 수도 있습니다.

```yaml
# Example advanced configuration.yaml entry
image_processing:
  - platform: tensorflow
    source:
      - entity_id: camera.driveway
      - entity_id: camera.backyard
    file_out:
      - "/tmp/{% raw %}{{ camera_entity.split('.')[1] }}{% endraw %}_latest.jpg"
      - "/tmp/{% raw %}{{ camera_entity.split('.')[1] }}_{{ now().strftime('%Y%m%d_%H%M%S') }}{% endraw %}.jpg"
    model:
      graph: /home/homeassistant/.homeassistant/tensorflow/frozen_inference_graph.pb
      categories:
        - category: person
          area:
            # Exclude top 10% of image
            top: 0.1
            # Exclude right 15% of image
            right: 0.85
        - car
        - truck
```

## 자원 최적화

[Image processing components](/integrations/image_processing/)는 `scan_interval`에 의해 주어진 일정한 주기로 카메라로부터 이미지를 처리합니다. 기본 `scan_interval`이  10 초이므로 카메라의 이미지가 변경되지 않은 경우 과도한 처리가 발생합니다. `scan_interval : 10000`(간격을 10,000초로 세팅)을 설정에 추가하여 이를 무시할 수 있습니다, 그렇게 한 후 실제로 처리를 수행하고자 할 때 `image_processing.scan` 서비스를 호출합니다.

```yaml
# Example advanced configuration.yaml entry
image_processing:
  - platform: tensorflow
    scan_interval: 10000
    source:
      - entity_id: camera.driveway
      - entity_id: camera.backyard
```

```yaml
# Example advanced automations.yaml entry
- alias: Tensorflow scanning
  trigger:
     - platform: state
       entity_id:
         - binary_sensor.driveway
  action:
    - service: image_processing.scan
      entity_id: camera.driveway
```
