---
title: "MQTT 카메라"
description: "Instructions on how to use an MQTT image message as a Camera within Home Assistant."
logo: mqtt.png
ha_category:
  - Camera
ha_release: 0.43
ha_iot_class: Configurable
---

`mqtt` 카메라 플랫폼을 사용하면 MQTT를 통해 전송 된 이미지 파일의 컨텐츠를 카메라로 홈어시스턴트에 연동할 수 있습니다. 설정에서 `topic` 아래의 메시지가 수신될 때마다 홈어시스턴트에 표시된 이미지도 업데이트됩니다.

MQTT를 통해 이미지를 전송할 수있는 애플리케이션 또는 서비스와 함께 사용할 수 있습니다.

## 설정

설치시 이 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오. : 

```yaml
# Example configuration.yaml entry
camera:
  - platform: mqtt
    topic: zanzito/shared_locations/my-device
```

{% configuration %}
topic:
  description: 구독할 MQTT topic.
  required: true
  type: string
name:
  description: 카메라의 이름.
  required: false
  type: string
unique_id:
  description: 이 카메라를 고유하게 식별하는 ID. 두 대의 카메라에 동일한 고유 ID가 홈어시스턴트에 있으면 예외가 발생.
  required: false
  type: string
device:
  description: "이 카메라가 [device registry](https://developers.home-assistant.io/docs/en/device_registry_index.html)에 연결되어 있는 장치에 대한 정보입니다. [MQTT discovery](/docs/mqtt/discovery/) 및 [`unique_id`](#unique_id)가 설정된 경우에만 작동합니다." 
  required: false
  type: map
  keys:
    identifiers:
      description: '장치를 고유하게 식별하는 ID 목록. 예를 들어 일련 번호.'
      required: false
      type: [list, string]
    connections:
      description: '`"connections": ["mac", "02:5b:26:a8:dc:12"]`. 튜플 목록인 `[connection_type, connection_identifier]`로 장치를 외부 세계에 연결한 목록입니다. 예를 들어 네트워크 인터페이스의 MAC주소: `"connections": ["mac", "02:5b:26:a8:dc:12"]` '
      required: false
      type: list
    manufacturer:
      description: 제조업체.
      required: false
      type: string
    model:
      description: 장치의 모델.
      required: false
      type: string
    name:
      description: 장치의 이름.
      required: false
      type: string
    sw_version:
      description: 장치의 펌웨어 버전.
      required: false
      type: string
{% endconfiguration %}
