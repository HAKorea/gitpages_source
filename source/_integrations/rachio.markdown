---
title: 라치오(Rachio)
description: Instructions on how to use Rachio with Home Assistant.
logo: rachio.png
ha_category:
  - Irrigation
  - Binary Sensor
  - Switch
ha_iot_class: Cloud Push
ha_release: 0.73
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/qwYOxToNePM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`rachio` 플랫폼을 사용하면 [Rachio irrigation system](https://rachio.com/)을 제어 할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- **Binary Sensor** - [Rachio irrigation system](https://rachio.com/)의 상태를 볼 수 있습니다.
- [**Switch**](#switch)

Rachio 통합구성요소가 로드되면 자동으로 추가됩니다.

## Rachio API 키 얻기

1. Log in at [https://app.rach.io/](https://app.rach.io/).
2. Click the "Account Settings" menu item at the bottom of the left sidebar
3. Click "Get API Key"
4. Copy the API key from the dialog that opens.

## 설정

이 플랫폼을 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
rachio:
  api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: The API key for the Rachio account.
  required: true
  type: string
hass_url_override:
  description: If your instance is unaware of its actual web location (`base_url`).
  required: false
  type: string
manual_run_mins:
  description: For how long, in minutes, to turn on a station when the switch is enabled.
  required: false
  default: 10
  type: integer
{% endconfiguration %}

<div class='note'>

**Water-saving suggestion:**<br>
스크립트를 사용하여 영역을 제어 할 때 `manual_run_mins`를 최대 안전 장치값으로 설정하십시오. 스크립트, 홈어시스턴트에 문제가 있거나 하루에 1700 건의 Rachio API 속도 제한에 도달한 경우 컨트롤러는 이 시간이 지난 후에도 여전히 영역(zone)을 끄려고 합니다. 

</div>

### iFrame

보다 자세한 영역 정보를보고 제어하려면 Rachio 웹 앱을 렌더링하는 [iFrame](/integrations/panel_iframe/)을 만듭니다.

```yaml
panel_iframe:
  rachio:
    title: Rachio
    url: "https://app.rach.io"
    icon: mdi:water-pump
```

## Switch

`rachio` 스위치 플랫폼을 사용하면 [Rachio irrigation system](https://rachio.com/)에 연결된 구역을 켜고 끌 수 있습니다.

일단 설정되면 제공된 계정의 모든 컨트롤러에서 활성화된 모든 영역에 대한 스위치와 각 컨트롤러의 대기 모드를 전환하는 스위치가 추가됩니다.

## 사례

이 섹션에서는 이 스위치를 사용하는 방법에 대한 실제 예를 제공합니다.

### `groups.yaml` 예제

```yaml
irrigation:
  name: Irrigation
  icon: mdi:water-pump
  view: true
  entities:
  - group.zones_front
  - group.zones_back
  - switch.side_yard

zones_front:
  name: Front Yard
  view: false
  entities:
  - switch.front_bushes
  - switch.front_yard

zones_back:
  name: Back Yard
  view: false
  entities:
  - switch.back_garden
  - switch.back_porch
```
