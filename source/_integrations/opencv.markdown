---
title: OpenCV(오픈소스이미지프로세싱)
description: Instructions on how to integrate OpenCV image processing into Home Assistant.
logo: opencv.png
ha_category:
  - Image Processing
ha_release: 0.47
---

[OpenCV](https://www.opencv.org/)는 오픈 소스 컴퓨터 비전 이미지 및 비디오 처리 라이브러리입니다.

일부 사전 정의된 classifiers는 [here](https://github.com/opencv/opencv/tree/master/data)에서 찾을 수 있습니다.

## 설정

Home Assistant로 OpenCV를 설정하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: opencv
    name: Front Door Faces
    source:
      - entity_id: camera.front_door
    classifier:
      mom: /path/to/classifier.xml
```

- **name** (*Required*): OpenCV 이미지 프로세서의 이름.
- **source** array (*Required*): 이미지 소스 목록.
  - **entity_id** (*Required*): 사진을 가져올 카메라 엔티티 ID.
    - **name** (*Optional*): 이 매개 변수를 사용하면 `image_processing` 엔티티 이름을 대체할 수 있습니다 .
- **classifier** (*Optional*): classifier ​​xml 파일에 대한 경로의 이름 사전(dictionary)입니다. 이 필드를 제공하지 않으면 OpenCV의 Github 저장소에서 face classifier가 다운로드됩니다.

**classifier**는 classifier 설정에 대한 이름들의 사전(dictionary)으로 정의될 수도 있습니다.

```yaml
    mom:
      file: /path/to/classifier/xml
      neighbors: 4
      min_size: (40, 40)
      scale: 1.1f
```

- **file** (*Required*): classifier ​​xml 파일의 경로입니다.
- **scale** (*Optional*): 처리시 수행할 스케일로, `float` 값은 `1.0`이상 이어야하며 기본값은 `1.1`입니다.
- **neighbors** (*Optional*): 매치하는데 필요한 최소 neighbor 갯수, 기본값은 `4`입니다. 이 숫자가 높을수록 일치하는 것이 더 까다 롭습니다. 숫자가 낮을수록 더 많은 오탐지가 발생할 수 있습니다.

