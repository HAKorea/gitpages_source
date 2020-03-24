---
title: 구역(Zone)
description: Instructions on how to set up zones within Home Assistant.
logo: home-assistant.png
ha_category:
  - Organization
ha_release: 0.69
ha_config_flow: true
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/wVjKiIs2WNM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

구역(zone)을 사용하면 지구상의 특정 지역을 지정할 수 있습니다 (현재). 장치 추적기가 장치가 구역 내에 있는 것을 발견하면 상태는 해당 구역에서 이름을 가져옵니다. 구역은 자동화 설정 내에서 [trigger](/getting-started/automation-trigger/#zone-trigger) 또는 [condition](/getting-started/automation-condition/#zone-condition)으로 사용할 수도 있습니다.

`zone` 통합구성요소는 YAML 시퀀스를 사용하여 여러 구역들을 설정합니다 : 

```yaml
# Example configuration.yaml entry
zone:
  - name: School
    latitude: 32.8773367
    longitude: -117.2494053
    radius: 250
    icon: mdi:school

  - name: Work
    latitude: 32.8753367
    longitude: -117.2474053

  # This will override the default home zone
  - name: Home
    latitude: 32.8793367
    longitude: -117.2474053
    radius: 100
    icon: mdi:account-multiple
```

{% configuration %}
name:
  description: 친숙한 구역 이름.
  required: false
  type: string
latitude:
  description: 구역 중심점의 위도.
  required: true
  type: float
longitude:
  description: 구역 중심점의 경도.
  required: true
  type: float
radius:
  description: 영역의 반경 (미터).
  required: false
  type: integer
  default: 100
icon:
  description: 이름 대신 표시되는 아이콘.
  required: false
  type: string
passive:
  description: 자동화에만 영역을 사용하고 프런트 엔드에서 숨기고 장치 추적기 이름에 영역을 사용하지 않습니다.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

특정 장소의 위도/경도를 찾으려면 [Google Maps](https://www.google.com/maps/) 혹은 [Bing Maps](https://www.bing.com/maps)를 사용할 수 있습니다. 마우스 오른쪽 버튼을 클릭하고 거기에서 좌표를 복사하거나 (Bing) "What is here?"를 클릭하십시오. (구글)

## Home 구역 (zone)

설정이 제공되지 않으면 `zone` 통합구성요소는 가정용 영역을 생성합니다. 이 구역은 `configuration.yaml` 파일에 제공된 위치를 사용하며 반경은 100 미터입니다. 이를 무시하려면 구역 설성을 작성하고 이름을 **'Home'**으로 지정하십시오.

<div class='note'>

**'Home'** 구역에 있는 장치는 홈어시스턴트 UI의 폴더에 나타나지 않습니다.

</div>

## Icons

해당 구역에 사용할 아이콘을 선택하는 것이 좋습니다. [materialdesignicons.com](https://materialdesignicons.com/)에서 찾을 수있는 아이콘을 선택하고 이름 앞에 `mdi :`를 붙입니다. 예를 들어, `mdi : school`,`mdi : worker`,`mdi : home`,`mdi : cart` 또는`mdi : castle` 입니다.

## State

`zoning`은 `zone`이 설정되었을 때의 상태입니다. `zone`은 다른 상태가 아닙니다. 설정된 모든 구역(zone)들은 은 항상 `zoning` 상태입니다.