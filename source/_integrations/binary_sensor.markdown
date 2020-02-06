---
title: Binary Sensor
description: Instructions on how-to setup binary sensors with Home Assistant.
logo: home-assistant.png
ha_category:
  - Binary Sensor
ha_release: 0.9
ha_quality_scale: internal
---

Binary sensors "디지털" 반환 값 (1 또는 0)을 가진 장치의 상태에 대한 정보를 수집합니다. 스위치, 접점, 핀 등일 수 있습니다. 이 센서들은 두 가지 상태만 있습니다 . : **0/off/low/closed/false** 와 **1/on/high/open/true**. 두 개의 상태 만 있다는 것을 알면 홈 어시스턴트는 기능에 따라 이러한 센서를 프론트 엔드에서 더 잘 표현할 수 있습니다.

### Device Class

T프런트 엔드에 이러한 센서가 표시되는 방식은 [customize section](/getting-started/customizing-devices/)에서 수정할 수 있습니다 .  binary sensors 에 대해 다음과 같은 장치 클래스를 지원합니다.:

- **None**: 보통의 on/off. 이것이 기본값이며 별도 설정할 필요가 없습니다.
- **battery**: `on` means low, `off` means normal
- **cold**: `on` means cold, `off` means normal
- **connectivity**: `on` means connected, `off` means disconnected
- **door**: `on` means open, `off` means closed
- **garage_door**: `on` means open, `off` means closed
- **gas**: `on` means gas detected, `off` means no gas (clear)
- **heat**: `on` means hot, `off` means normal
- **light**: `on` means light detected, `off` means no light
- **lock**: `on` means open (unlocked), `off` means closed (locked)
- **moisture**: `on` means moisture detected (wet), `off` means no moisture (dry)
- **motion**: `on` means motion detected, `off` means no motion (clear)
- **moving**: `on` means moving, `off` means not moving (stopped)
- **occupancy**: `on` means occupied, `off` means not occupied (clear)
- **opening**: `on` means open, `off` means closed
- **plug**: `on` means device is plugged in, `off` means device is unplugged
- **power**: `on` means power detected, `off` means no power
- **presence**: `on` means home, `off` means away
- **problem**: `on` means problem detected, `off` means no problem (OK)
- **safety**: `on` means unsafe, `off` means safe
- **smoke**: `on` means smoke detected, `off` means no smoke (clear)
- **sound**: `on` means sound detected, `off` means no sound (clear)
- **vibration**: `on` means vibration detected, `off` means no vibration (clear)
- **window**: `on` means open, `off` means closed

아날로그 센서는 [integration overview](/integrations/#sensor)를 확인하십시오.

<p class='img'>
<img src='/images/screenshots/binary_sensor_classes_icons.png' />
'켜짐'및 '꺼짐'상태의 다양한 장치 클래스 아이콘의 예
</p>
