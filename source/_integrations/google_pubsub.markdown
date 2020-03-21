---
title: Google Pub/Sub
description: Setup for Google Pub/Sub integration
logo: google-pubsub.png
ha_category:
  - History
ha_release: 0.88
---

`google_pubsub` 통합구성요소를 통해 홈어시스턴트 이벤트 버스에 연결하여 [Google Cloud Pub/Sub](https://cloud.google.com/pubsub/docs/overview)로 이벤트를 보낼 수 있습니다. GCP의 현재 [free tier](https://cloud.google.com/free/)을 사용하면 평균 2 초마다 약 1 개의 이벤트를 동기화 할 수 있습니다 (한 달에 2백만 회 호출).

## 최초 셋업

이미 Google Cloud 프로젝트가 있다고 가정합니다. 그렇지 않은 경우 [Google Cloud Console](https://console.cloud.google.com/projectcreate)에서 계정을 만드십시오.

[Google Cloud API Console](https://console.cloud.google.com/apis/credentials/serviceaccountkey)에서 서비스 계정 키를 만들어야합니다.
- Choose a new "New Service Account", give it a name and leave the key type as JSON
- Select the role: Pub/Sub Publisher 

서비스 계정 JSON 키가 컴퓨터에 다운로드 됩니다. 이것을 다른 사람과 공유하지 마십시오. 이 파일을 Home Assistant 설정 폴더에 넣으십시오.

그런 다음 [Google Cloud API Console](https://console.cloud.google.com/cloudpubsub/topicList)에서 Google Pub/Sub topic을 만듭니다. topic 이름은 `projects/project-198373/topics/topic-name`과 같은 이름이 됩니다. 마지막 부분(선택한 이름)인 `topic-name`만 주목하십시오.

## 설정

`configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
google_pubsub:
  project_id: YOUR_PROJECT_ID
  topic_name: YOUR_TOPIC_NAME
  credentials_json: CREDENTIALS_FILENAME
```

{% configuration %}
project_id:
  description: Project ID from the Google console (looks like `words-2ab12`).
  required: true
  type: string
topic_name:
  description: The Pub/Sub [relative](https://cloud.google.com/pubsub/docs/admin#resource_names) topic name (looks like `hass`).
  required: true
  type: string
credentials_json:
  description: The filename of the Google Service Account JSON file.
  required: true
  type: string
filter:
  description: Filter domains and entities for Google Cloud Pub/Sub.
  required: true
  type: map
  keys:
    include_domains:
      description: List of domains to include (e.g., `light`).
      required: false
      type: list
    exclude_domains:
      description: List of domains to exclude (e.g., `light`).
      required: false
      type: list
    include_entities:
      description: List of entities to include (e.g., `light.attic`).
      required: false
      type: list
    exclude_entities:
      description: List of entities to include (e.g., `light.attic`).
      required: false
      type: list
{% endconfiguration %}

<div class='note warning'>
  도메인이나 엔티티를 필터링하지 않으면 모든 이벤트가 Google PubSub로 전송되므로 프리 티어 한도에 매우 빠르게 도달합니다. 이 설정 매개 변수를 작성하거나 Google Cloud에 유료 구독을 해야합니다.
</div>

### Google Cloud Function을 사용하여 데이터 저장

BigQuery에 자동으로 데이터를 저장하려면 [instructions here](https://github.com/timvancann/home-assistant-pubsub-cloud-function)을 따르십시오. GCP의 현재 [free tier](https://cloud.google.com/free/)는 최대 10GB의 데이터를 저장할 수 있어야합니다.