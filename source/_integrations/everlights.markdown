---
title: 크리스마스조명(EverLights)
description: Instructions on how to set up EverLights within Home Assistant.
logo: everlights.png
ha_category:
  - Light
ha_iot_class: Local Polling
ha_release: 0.87
---
<iframe width="690" height="437" src="https://www.youtube.com/embed/uuo7a_DyXqc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[EverLights](https://myeverlights.com/)는 집의 지붕에 설치하거나 깜박거리는 영구 크리스마스 조명입니다. 이 통합구성요소로 영역(zone)의 모든 LED를 단일 색상으로 변경하거나 이전에 컨트롤 박스에 저장된 패턴을 활성화 할 수 있습니다.

### 상세 설정

EverLight를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
light:
  - platform: everlights
    hosts:
      - 192.168.1.123
      - 192.168.1.124
```

{% configuration %}
hosts:
  description: EverLights control box IP addresses.
  required: true
  type: list
{% endconfiguration %}

### 효과

컨트롤 박스에 저장된 EverLights 패턴은 effect 매개 변수를 사용하여 `light.turn_on` 서비스에 활성화할 수 있습니다. 효과가 지정되면 색상과 밝기가 무시됩니다.

### 제한 사항

EverLights 컨트롤 박스 상태는 영역이 활성화되어 있는지 여부를 나타내지만 현재 색상이나 패턴을 나타내지 않습니다. 상태 속성의 색상과 효과는 `light.turn_on`의 마지막 실행을 기준으로 합니다. 컨트롤 상자 스케줄러 또는 다른 앱이 변경하면 상태 속성이 업데이트되지 않습니다.