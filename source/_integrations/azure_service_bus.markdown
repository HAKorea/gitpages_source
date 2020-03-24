---
title: Azure 서비스 버스
description: Setup for Azure Service Bus integration
logo: azure_service_bus.svg
ha_category:
  - Notifications
ha_release: 0.102
ha_codeowners:
  - '@hfurubotten'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/AHS3qpyU8gw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Azure Service Bus` 통합구성요소를 통해 Home Assistant 내에서 [Azure Service Bus](https://azure.microsoft.com/en-us/services/service-bus/)로 메시지를 보낼 수 있습니다.

## 최초 셋업

이는 이미 Azure 계정이 있다고 가정합니다. 그렇지 않으면 무료 계정을 작성하십시오 [여기](https://azure.microsoft.com/en-us/free/).

Service Bus 네임 스페이스를 만들어야합니다. [이 안내서](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-create-namespace-portal)를 따를 수 있습니다.

그런 다음 `Send` 클레임을 사용하여 서비스 버스에 대한 공유 액세스 정책을 작성하거나 네임 스페이스에서 RootManageAccessKey를 사용해야합니다 (이 키에는 이벤트 허브 관리 및 청취(listening)를 위해 추가 클레임이 있으며 이 목적에는 필요하지 않음). 서비스 버스의 보안에 대한 세부 사항은 [go here](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-authentication-and-authorization#shared-access-signature)에서 확인하십시오. 또는 하나의 queue 또는 topic에 대한 전용 키를 작성하여 해당 queue 또는 topic에만 액세스를 제한 할 수 있습니다.

`Send` 정책을 가진 연결 문자열이 있으면 통합 자체를 설정할 수 있습니다.

<div class='note warning'>

Home Assistant 내에서 서비스 버스 네임 스페이스를 사용하려면 보내기 전에 큐 또는 토픽이 있어야합니다. 
대기열 설정 방법은 [여기](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-portal)와 topic 및 subscriptions 설정은 [여기](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-topics-subscriptions-portal)를 참조하십시오.
</div>

## 설정

`configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
notify:
  - platform: azure_service_bus
    connection_string: !secret servicebus_connection_string
    topic: t-test
  - platform: azure_service_bus
    connection_string: !secret servicebus_connection_string
    queue: q-test
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  type: string
  default: notify
connection_string:
  description: Connection string found in the Azure portal, with `send` claim in the key.
  required: true
  type: string
queue:
  description: Which queue to send notifications on.
  required: exclusive
  type: string
topic:
  description: Which topic to send notifications on.
  required: exclusive
  type: string
{% endconfiguration %}

<div class="note">

Home Assistant 내에서 하나 이상의 엔티티에서 모든 상태 변경을 보내려는 경우 [Azure Event Hub](/integrations/azure_event_hub/) 통합구성요소를 대신 사용하는 것이 좋습니다.

</div>

## 사용법

알림 서비스는 서비스 버스의 JSON 오브젝트에 제공된 데이터를 변환합니다. `message` 필드는 항상 설정되지만 `target` 및 `title` 필드는 선택 사항이며 설정된 경우 서비스 버스 메시지에만 포함됩니다. `data` 섹션에 주어진 모든 입력은 JSON 객체의 루트로 단조로워지고 주어진 구조를 따릅니다. 데이터 섹션에 제공된 모든 입력이 메시지에 포함됩니다.

자동화 트리거가 서비스 버스의 메시지로 변환되는 방법은 아래 예를 참조하십시오.

```yaml
automation:
  - alias: Sunset Service Bus message
    trigger:
      platform: sun
      event: sunset
    action:
      service: notify.test_queue
      data:
        message: "Sun is going down"
        title: "Good evening"
        data:
          sun_direction: "Down"
          custom_field: 123
          custom_object:
            trigger_more: true
            explain: "Its starting to get dark"
```

queue 또는 topic subscription에서 검색 할 수있는 메시지 :

```json
{
  "message": "Sun is going down",
  "title": "Good evening",
  "sun_direction": "Down",
  "custom_field": 123,
  "custom_object": {
    "trigger_more": true,
    "explain": "Its starting to get dark"
  }
}
```
