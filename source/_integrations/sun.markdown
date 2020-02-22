---
title: Sun
description: Instructions on how to track the sun within Home Assistant.
logo: home-assistant.png
ha_category:
  - Environment
ha_release: pre 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@Swamp-Ig'
---

Sun 통합구성요소는 태양이 수평선 위 또는 아래에 있는지 추적하기 위해 현재 위치를 사용합니다.
태양은 자동화 내에서 다음과 같이 사용될 수 있습니다. 
[새벽/황혼을 시뮬레이트하기위한 선택적 오프셋이있는 트리거][sun_trigger] 또는 [해가 이미 졌는지 혹은 떴는지 테스트하기위한 선택적 오프셋이있는 조건][sun_condition].

[sun_trigger]: /docs/automation/trigger/#sun-trigger
[sun_condition]: /docs/scripts/conditions/#sun-condition

## 설정

이 통합구성요소는 설정에서 [`default_config :`](https://www.home-assistant.io/integrations/default_config/) 행을 비활성화하거나 제거하지 않는 한 기본적으로 활성화됩니다. 다음 예는이 통합구성요소를 수동으로 활성화하는 방법을 보여줍니다.

```yaml
# Example configuration.yaml entry
sun:
```

{% configuration %}
elevation:
  description: "해발 미터로 표시된 위치의 (물리적) 고도입니다. `configuration.yaml`의 `elevation`은 기본적으로 설정되어 있지 않으면 Google지도에서 검색됩니다. "
  required: false
  type: integer
{% endconfiguration %}

<p class='img'>
<img src='/images/screenshots/more-info-dialog-sun.png' />
</p>

## 구현 세부 사항

태양의 이벤트 리스너는 태양이 뜨거나 오프셋으로 설정 될 때 서비스를 호출합니다.

sun 이벤트에는 'sun' 유형, 호출 할 서비스, 어떤 이벤트 (일몰 또는 일출) 및 오프셋이 있어야합니다.

```json
{
    "type": "sun",
    "service": "switch.turn_on",
    "event": "sunset",
    "offset": "-01:00:00"
}
```

### `sun.sun` 엔티티의 지원 사항

| Possible state | Description |
| --------- | ----------- |
| `above_horizon` | 태양이 수평선 위에 있을 때.
| `below_horizon` | 태양이 수평선 아래에 있을 때.

| State Attributes | Description |
| --------- | ----------- |
| `next_rising` | 다음 해가 뜨는 날짜와 시간 (UTC).
| `next_setting` | 다음 태양 설정 날짜 및 시간 (UTC).
| `next_dawn` | 다음 새벽의 날짜와 시간 (UTC).
| `next_dusk` | 다음 황혼의 날짜와 시간 (UTC).
| `next_noon` | 다음 정오의 날짜 및 시간 (UTC).
| `next_midnight` | 다음 태양 자정의 날짜와 시간 (UTC).
| `elevation` |  태양 고도. 이것은 태양과 수평선 사이의 각도입니다. 음수 값은 태양이 수평선 아래에 있음을 의미.
| `azimuth` | 태양 방위각. 각도는 북쪽에서 시계 방향으로 표시.
| `rising` | 태양이 자정 이후 및 정오 이전에 태양이 현재 상승중인 경우에 해당.
