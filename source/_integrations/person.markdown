---
title: 구성원(Person)
description: Instructions on how to set up people tracking within Home Assistant.
logo: home-assistant.png
ha_category:
  - Presence Detection
ha_release: 0.88
ha_quality_scale: internal
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/A2JaMiIXW9Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Person 통합구성요소를 통해 [device tracker](/integrations/device_tracker/) 엔터티를 하나 이상의 Person 엔터티에 연결할 수 있습니다. 연결된 장치 추적기의 상태 업데이트는 Person 상태를 설정합니다. 여러 장치 추적기를 사용하는 경우 Person 상태는 다음 순서로 결정됩니다.

1. 'home' 상태를 나타내는 고정 추적기 (GPS가 아닌 추적기, 즉 라우터 또는 Bluetooth 'device_trackers')가 있는 경우 가장 최근에 업데이트 된 추적기가 사용됩니다.
2. 'gps' 유형의 추적기가 있는 경우 가장 최근에 업데이트 된 추적기가 사용됩니다.
3. 그렇지 않으면 상태가 'not_home'인 최신 추적기가 사용됩니다.

예를 들어 'tracker_gps', 'tracker_router' 및 'tracker_ble' 의 3 가지 추적기가 있다고 가정합니다.

1. 당신은 집에 있고 3개의 장치 모두 'home' 상태를 표시합니다. Person 엔티티의 상태는 소스 'tracker_router' 또는 'tracker_ble' 중 가장 최근에 업데이트 된 'home' 입니다.
2. 당신은 방금 집을 떠났습니다. 'tracker_gps'는 'not_home' 상태를 표시하지만 다른 두 추적기는 'home' 상태를 표시합니다 ('consider_home'설정으로 인해 아직 업데이트되지 않았을 수 있습니다 [device_tracker](/integrations/device_tracker/#configuring-a-device_tracker-platform) 참조). 고정 추적기가 우선하므로 'home' 으로 간주됩니다.
3. 일정 시간이 지나면 두 고정 추적기 모두 'not_home' 상태를 표시합니다. 이제 Person 엔티티는 소스 'tracker_gps'와 함께 'not_home'상태입니다.
4. 집을 떠나있는 동안 홈어시스턴트가 다시 시작됩니다. 'tracker_gps'가 업데이트를 수신할 때까지는 고정 추적기에 의해 상태가 결정됩니다. 다시 시작한 후 최신 업데이트가 있기 때문입니다. 분명히 상태는 'not_home'입니다.
5. 그런 다음 'zone1'로 정의한 영역으로 이동하면 'tracker_gps'가 업데이트를 보내고 이제 상태가 'tracker_gps'가있는 'zone1'입니다.
6. 집으로 돌아 왔으며 휴대 기기가 라우터에 연결되었지만 'tracker_gps'는 아직 업데이트되지 않았습니다. 당신의 상태는 'tracker_router' 소스와 함께 'home'이됩니다.
7. 'tracker_gps' 업데이트가 발생한 후에도 소스 'tracker_router' 또는 'tracker_ble' 중 최신 업데이트가 있는 상태로 'home'상태가 유지됩니다.

요약 : 집에 있을 때는 먼저 위치 추적기 (있는 경우)와 GPS로 위치를 결정합니다. 집 밖에있을 때는 먼저 GPS에 의해 위치가 결정된 다음 고정 추적기에 의해 결정됩니다.

**Hint**: 여러 장치 추적기, 특히 고정 및 GPS 추적기를 함께 사용하는 경우 고정 추적기에 대해 `consider_home`을 가능한 한 낮게 설정하는 것이 좋습니다. [device_tracker](/integrations/device_tracker/#configuring-a-device_tracker-platform)참조 

UI를 통해 설정 패널의 Person 페이지 또는 `configuration.yaml` 파일의 `YAML`을 통해 Person을 관리할 수 ​​있습니다.

## 홈어시스턴트 설정 패널을 통해 Person 통합구성요소 설정

이 통합구성요소는 설정에서 [`default_config:`](https://www.home-assistant.io/integrations/default_config/) 행을 비활성화하거나 제거하지 않은 한 기본적으로 활성화되어 있습니다. 이 경우 다음 예는 이 통합구성요소를 수동으로 활성화하는 방법을 보여줍니다.

```yaml
person:
```

## YAML을 통한 `person` 통합구성요소 설정

YAML을 선호하는 경우 `configuration.yaml` 통해 다음과 같이 Person을 설정할 수도 있습니다

```yaml
# Example configuration.yaml entry
person:
  - name: Ada
    id: ada6789
    device_trackers:
      - device_tracker.ada
```

{% configuration %}
  id:
    description: person의 고유한 ID.
    required: true
    type: string
  name:
    description: person의 이름.
    required: true
    type: string
  user_id:
    description: person의 홈어시스턴트 사용자 계정의 사용자 ID입니다. *설정 패널의 "Users"/"Manage users" 화면에서 사용자의 `user_id` (일명`ID`)를 검사할 수 있습니다.*
    required: false
    type: string
  device_trackers:
    description: 추적 할 장치 추적기 엔티티 ID 목록. 이들은 Person의 상태를 나타냅니다.
    required: false
    type: [string, list]
{% endconfiguration %}

확장된 예제는 다음 샘플과 같습니다.:

```yaml
# Example configuration.yaml entry
person:
  - name: Ada
    id: ada6789
    device_trackers:
      - device_tracker.ada
  - name: Stacey
    id: stacey12345
    user_id: 12345678912345678912345678912345
    device_trackers:
      - device_tracker.stacey
      - device_tracker.beacon
```

YAML을 변경하면 `person.reload` 서비스 를 호출하여 YAML을 다시로드 할 수 있습니다

### Person의 사진 사용자 정의

[customizing entities](/docs/configuration/customizing-devices#entity_picture) 페이지의 지시 사항에따라 `customize:` 설정 섹션에서 Person 엔티티에 사용되는 그림을 사용자 정의 할 수 있습니다. 
예를 들면 다음과 같습니다. :

```yaml
customize:
  person.ada:
    entity_picture: "/local/ada.jpg"
```

`www` 폴더에 대한 자세한 내용은 [hosting files](/integrations/http/#hosting-files) 설명서를 참조하십시오.