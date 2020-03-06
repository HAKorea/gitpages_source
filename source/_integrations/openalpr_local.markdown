---
title: OpenALPR Local(차량번호판인식)
description: Instructions on how to integrate licences plates with OpenALPR local into Home Assistant.
logo: openalpr.png
ha_category:
  - Image Processing
ha_release: 0.36
---

Home Assistant에 대한 [OpenALPR](https://www.openalpr.com/) 통합구성요소를 통해 카메라에서 차량 번호판을 처리 할 수 ​​있습니다. 이를 사용하여 차고문을 열거나 다른 [automation](/integrations/automation/)를 트리거 할 수 있습니다

자동화 규칙 내에서 결과를 사용하려면 [component](/integrations/image_processing)페이지를 보십시오.

### 로컬 설치

모든 데이터를 로컬에서 처리하려면 `alpr` commandline tool 버전 2.3.1 이상이 필요합니다.

배포판의 바이너리를 찾지 못하면 소스에서 컴파일 할 수 있습니다. 
OpenALPR 작성 방법에 대한 문서는 [here](https://github.com/openalpr/openalpr/wiki)에 있습니다.

데비안 시스템에서는 `cmake` 명령을 사용하여 command line tool에서만 만들 수 있습니다 :

```bash
$ cmake -DWITH_TEST=FALSE -DWITH_BINDING_JAVA=FALSE --DWITH_BINDING_PYTHON=FALSE \
  --DWITH_BINDING_GO=FALSE -DWITH_DAEMON=FALSE -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
```

다른 운영 체제에 대해서는 [OpenALPR wiki](https://github.com/openalpr/openalpr/wiki)를 참조하십시오.

다음과 같이 `alpr` 설치를 확인하십시오 :

```bash
$ wget -O- -q http://plates.openalpr.com/h786poj.jpg | alpr -
```

### 설정

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: openalpr_local
    region: eu
    source:
    - entity_id: camera.garage
```

{% configuration %}
region:
  description: 국가 혹은 지역. 지원되는 [values](https://github.com/openalpr/openalpr/tree/master/runtime_data/config) 목록. 대한민국 있음. 
  required: true
  type: string
alpr_bin:
  description: 로컬 처리를 위한 OpenALPR 소프트웨어의 command line tool alpr
  required: false
  type: string
  default: alpr
confidence:
  description: 홈어시스턴트로 처리 할 수 있는 최소 신뢰 백분율입니다.
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
