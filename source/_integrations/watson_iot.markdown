---
title: IBM 왓슨 IoT 플랫폼
description: Record events in the IBM Watson IoT Platform.
logo: ibm.png
ha_category:
  - History
ha_release: 0.72
---

`watson_iot` 연동을 통해 Home Assistant의 디바이스를 [IBM Watson IoT Platform instance](https://www.ibm.com/us-en/marketplace/internet-of-things-cloud)와 연결할 수 있습니다.

## 설정

이 구성 요소를 사용하려면 먼저 게이트웨이 디바이스 유형을 등록한 다음 IoT 플랫폼 인스턴스에 게이트웨이 디바이스를 등록해야합니다. 이를 확인하는 방법에 대한 지침인 [official documentation](https://cloud.ibm.com/docs/services/IoT?topic=iot-platform-getting-started#IoT_connectGateway)는 이 작업에 대한 세부 정보를 제공합니다. Home Assistant 인스턴스에 대한 게이트웨이 장치를 등록한 후에는 네 가지 정보가 필요합니다. :

- Organization ID
- Gateway device Type
- Gateway device ID
- Authentication Token

이 기본 정보를 사용하여 구성 요소를 설정할 수 있습니다.

```yaml
# Example configuration.yaml entry:
watson_iot:
  organization: 'organization_id'
  type: 'device_type'
  id: 'device_id'
  token: 'auth_token'
```

{% configuration %}
organization:
  description: The Organization ID for your Watson IoT Platform instance.
  required: true
  type: string
type:
  description: The device type for the gateway device to use.
  required: true
  type: string
id:
  description: The device id for the gateway device to use.
  required: true
  type: string
token:
  description: The authentication token for the gateway device.
  required: true
  type: string
exclude:
  description: Configure which integrations should be excluded from recording to Watson IoT Platform.
  required: false
  type: map
  keys:
    entities:
      description: The list of entity ids to be excluded from recording to Watson IoT Platform.
      required: false
      type: list
    domains:
      description: The list of domains to be excluded from recording to Watson IoT Platform.
      required: false
      type: list
include:
  description: Configure which integrations should be included in recordings to Watson IoT Platform. If set, all other entities will not be recorded to Watson IoT Platform. Values set by the **blacklist** option will prevail.
  required: false
  type: map
  keys:
    entities:
      description: The list of entity ids to be included from recordings to Watson IoT Platform.
      required: false
      type: list
    domains:
      description: The list of domains to be included from recordings to Watson IoT Platform.
      required: false
      type: list
{% endconfiguration %}

## Examples

### Full configuration

```yaml
watson_iot:

  exclude:
    entities:
       - entity.id1
       - entity.id2
    domains:
       - automation
  include:
    entities:
       - entity.id3
       - entity.id4
```
