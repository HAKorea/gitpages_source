---
title: 아이폰위치추적(Geofency)
description: Instructions for how to use Geofency to track devices in Home Assistant.
logo: geofency.png
ha_category:
  - Presence Detection
ha_release: 0.53
ha_iot_class: Cloud Push
ha_config_flow: true
---

통합구성요소는 [Geofency] (https://www.geofency.com/)와의 연동을 설정합니다. Geofency는 iOS용 유료앱으로, geofence 또는 iBeacon region을 입력하거나 종료할 때 전송되는 요청을 사용자가 설정할 수 있습니다. 위치를 업데이트하도록 홈어시스턴트로 설정할 수 있습니다.

## 설정

Geofency를 설정하려면 설정 화면의 통합구성요소 패널을 통해 Geofency를 설정해야합니다. 그런 다음 Webhook 기능을 통해 iOS앱을 설정하여 셋업 중에 통합구성요소에서 제공한 webhook URL로 POST 요청을 Home Assistant 서버에 보내야합니다. 기본 POST 형식을 사용하십시오. 모바일 beacon들에 대해 'Update Geo-Position' 기능을 활성화하십시오.

Geofency는 geofence들에 사용되는 장치 추적기 이름을 자동으로 생성하며 첫 번째 요청후 통합구성요소 섹션에서 찾을 수 있습니다. beacon의 경우 장치 이름은 `beacon_<name from Geofency>`입니다. (예: `device_tracker.beacon_car`).

모바일 beacon들(옵션)을 사용하는 경우 통합구성요소 패널을 통해 추가 할 수 없으므로 `configuration.yaml`의 항목이 여전히 필요합니다.

{% configuration %}
mobile_beacons:
  description: "*mobile*로 취급될 beacon 이름들의 목록. 이름은 Geofency에서 설정한 이름과 일치해야합니다. 기본적으로 beacon은 *stationary*로 취급됩니다."
  required: false
  type: list
{% endconfiguration %}

모바일 beacon을 사용할 때 `geofency` 통합구성요소에 대한 샘플 설정은 다음과 같습니다.

```yaml
# Example configuration.yaml entry
geofency:
  mobile_beacons:
    - car
    - keys
```

### 구역 (Zones)

geofence 또는 고정 beacon을 입력하면 홈어시스턴트의 위치 이름이  geofence 또는 Geofency의 beacon 위치 이름으로 설정됩니다. geofence 또는 고정 beacon을 종료하면 홈어시스턴트의 위치 이름이 `not home`으로 설정됩니다. 
모바일 beacon들의 경우 비콘이 [zone](/integrations/zone/) 외부에 들어오거나 나올 때마다 위치 이름은 `not_home`이 되며, 그렇지 않으면 zone 이름으로 설정됩니다.

[proximity](/integrations/proximity/) 구성 요소로 Geofency가 더 잘 작동하도록 하려면 Webhook 설정 화면에서 'Send Current Location'기능을 활성화해야합니다. 이를 통해 _current_ GPS 좌표가 종료된 zone (중심)의 좌표 대신 종료 이벤트에 포함됩니다.