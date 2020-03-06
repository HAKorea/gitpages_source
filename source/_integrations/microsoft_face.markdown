---
title: Microsoft 페이스
description: Instructions on how to integrate Microsoft Face integration into Home Assistant.
logo: microsoft.png
ha_category:
  - Image Processing
ha_release: 0.37
---

`microsoft_face` 통합 플랫폼은 Microsoft Azure Cognitive Service [Face](https://azure.microsoft.com/en-us/services/cognitive-services/face/)의 주요 통합구성요소입니다. 모든 데이터는 Azure 클라우드의 자체 프라이빗 인스턴스에 저장됩니다.

## 셋업

무료인 API 키가 필요하지만 Microsoft ID를 사용하는 [Azure registration](https://azure.microsoft.com/en-us/free/)이 필요합니다. 무료 자원 (*F0*)은 분당 20 개의 요청과 한 달에 30k 요청으로 제한됩니다. Azure 클라우드를 사용하지 않으려는 경우 [cognitive-services](https://azure.microsoft.com/en-us/try/cognitive-services/)에 등록하여 API 키를 얻을 수도 있습니다. 인지(cognitive) 서비스의 모든 키는 90 일마다 다시 작성해야합니다.

## 설정

Microsoft Face 구성 요소를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
microsoft_face:
  api_key: YOUR_API_KEY
  azure_region: eastus2
```

{% configuration %}
api_key:
  description: 인지 자원에 대한 API 키.
  required: true
  type: string
azure_region:
  description: Microsoft Cognitive Services 엔드 포인트를 인스턴스화 한 지역
  required: false
  type: string
timeout:
  description: API 연결 시간 초과 설정.
  required: false
  type: time
  default: 10s
{% endconfiguration %}

### 사람과 그룹들

대부분의 서비스에는 그룹 또는 사람을 설정해야합니다. 이는 처리 및 탐지를 그룹에서 제공한 요소로 제한합니다. 홈어시스턴트는 모든 그룹에 대한 엔티티를 작성하고 프런트 엔드에 state(미국), 사람 및 ID를 직접 표시 할 수 있습니다.

이 기능을 관리하기 위해 다음 서비스를 사용할 수 있으며 프론트 엔드, 스크립트 또는 REST API를 통해 호출할 수 있습니다.

- *microsoft_face.create_group*
- *microsoft_face.delete_group*

```yaml
service: microsoft_face.create_group
data:
  name: 'Family'
```

- *microsoft_face.create_person*
- *microsoft_face.delete_person*

```yaml
service: microsoft_face.create_person
data:
  group: family
  name: 'Hans Maier'
```

사람의 이미지를 추가해야합니다. 모든 사람에 대해 여러 이미지를 추가하여 더 나은 탐지를 만들 수 있습니다. 카메라에서 사진을 찍거나 로컬 이미지를 Azure 리소스로 보낼 수 있습니다.

- *microsoft_face.face_person*

```yaml
service: microsoft_face.face_person
data:
  group: family
  name: 'Hans Maier'
  camera_entity: camera.door
```

로컬 이미지에는 `curl`이 필요합니다. `{personId}`는 그룹 엔티티에 속성으로 존재합니다.

```bash
$ curl -v -X POST "https://westus.api.cognitive.microsoft.com/face/v1.0/persongroups/{GroupName}/persons/{personId}/persistedFaces" \
  -H "Ocp-Apim-Subscription-Key: YOUR_API_KEY" \
  -H "Content-Type: application/octet-stream" --data-binary "@/tmp/image.jpg"
```

그룹에 대한 변경 작업을 마친후에는 AI에 새 데이터를 처리하는 방법을 가르치도록 이 그룹을 훈련시켜야합니다.

- *microsoft_face.train_group*

```yaml
service: microsoft_face.train_group
data:
  group: family
```
