---
title: Azure 이벤트 허브
description: Setup for Azure Event Hub integration
logo: azure_event_hub.svg
ha_category:
  - History
ha_release: 0.94
ha_codeowners:
  - '@eavanvalkenburg'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/AHS3qpyU8gw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Azure Event Hub` 통합구성요소를 통해 Home Assistant 이벤트 버스에 연결하여 [Azure Event Hub](https://azure.microsoft.com/en-us/services/event-hubs/) 또는 [Azure IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-devguide-messages-read-builtin)로 이벤트를 보낼 수 있습니다.

## 최초 셋업

이것은 이미 Azure 계정이 있다고 가정합니다. 그렇지 않으면 무료 계정을 작성하십시오 [here](https://azure.microsoft.com/en-us/free/)

해당 네임 스페이스에 Event Hub 네임 스페이스와 Event Hub를 만들어야합니다. [this guide](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-create)를 참조하십시오. 또는 네임 스페이스와 Event Hub를 사용하여 ARM 템플릿을 직접 배포 할 수 있습니다. [from here](https://github.com/Azure/azure-quickstart-templates/tree/master/201-event-hubs-create-event-hub-and-consumer-group/).

그런 다음 'Send' 클레임을 사용하여 Event Hub에 대한 공유 액세스 정책을 작성하거나 네임 스페이스에서 RootManageAccessKey(이 키에는 이벤트 허브 관리 및 listening를 포함하여 이 목적에 필요하지 않은 추가 청구(claim)가 있습니다.)를 사용해야합니다. Event Hubs의 보안에 대한 자세한 내용은 [go here](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-authentication-and-security-model-overview)를 참조하십시오.

네임 스페이스, 인스턴스, 공유 액세스 정책의 이름 및 해당 정책의 키가 있으면 통합 자체를 설정할 수 있습니다.

## 설정

`configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
azure_event_hub:
  event_hub_namespace: NAMESPACE_NAME
  event_hub_instance_name: EVENT_HUB_INSTANCE_NAME
  event_hub_sas_policy: SAS_POLICY_NAME
  event_hub_sas_key: SAS_KEY
  filter:
    include_domains:
    - homeassistant
    - light
    - media_player
```

{% configuration %}
event_hub_namespace:
  description: The name of your Event Hub namespace.
  required: true
  type: string
event_hub_instance_name:
  description: The name of your Event Hub instance.
  required: true
  type: string
event_hub_sas_policy:
  description: The name of your Shared Access Policy.
  required: true
  type: string
event_hub_sas_key:
  description: The key for the Shared Access Policy.
  required: true
  type: string
filter:
  description: Filter domains and entities for Event Hub.
  required: true
  type: map
  default: Includes all entities from all domains
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
도메인 또는 엔터티를 필터링하지 않으면 모든 이벤트가 Azure Event Hub로 전송되므로 많은 공간을 차지합니다.
</div>

<div class='note warning'>
이벤트 허브의 보존 시간은 최대 7 일이며, 이벤트 허브에서 자동으로 삭제 된 이벤트를 캡처하거나 사용하지 않으면 기본 보존은 1 일입니다.
</div>

### Azure에서 데이터 사용하기

Event Hub로 들어오는 데이터를 Azure의 저장소로 스트리밍하는 여러 가지 방법이 있습니다. 가장 쉬운 방법은 기본 제공 Capture 기능을 사용하는 것입니다. 그러면 Azure Blob Storage 또는 Azure Data Lake Store에서 데이터를 캡처 할 수 있습니다. [details here](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-capture-overview)

Azure (외부포함)의 다른 저장소는 [Azure Stream Analytics job](https://docs.microsoft.com/en-us/azure/stream-analytics/stream-analytics-define-inputs#stream-data-from-event-hubs)은 예를들어 [Cosmos DB](https://docs.microsoft.com/en-us/azure/stream-analytics/stream-analytics-documentdb-output), [Azure SQL DB](https://docs.microsoft.com/en-us/azure/stream-analytics/stream-analytics-sql-output-perf), [Azure Table Storage](https://docs.microsoft.com/en-us/azure/stream-analytics/stream-analytics-define-outputs#table-storage), [Azure Blob Storage](https://docs.microsoft.com/en-us/azure/stream-analytics/stream-analytics-custom-path-patterns-blob-storage-output)에 대한 사용자 지정 작성과 [Topic and Queues](https://docs.microsoft.com/en-us/azure/stream-analytics/stream-analytics-quick-create-portal#configure-job-output) 등을 사용하여 가능합니다.

분석 측면에서 Event Hub를 [Azure Databricks Spark](https://docs.microsoft.com/en-us/azure/azure-databricks/databricks-stream-from-eventhubs?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fevent-hubs%2FTOC.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json), [Azure Time Series Insights](https://docs.microsoft.com/en-us/azure/time-series-insights/time-series-insights-how-to-add-an-event-source-eventhub) 및 [Microsoft Power BI](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-tutorial-visualize-anomalies)에 직접 공급할 수 있습니다.

Azure에서 데이터를 사용하는 마지막 방법은 [Event Hub trigger binding](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs)을 사용하여 Azure Function을 Event Hub에 연결하는 것입니다.