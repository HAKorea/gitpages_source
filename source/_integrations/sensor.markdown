---
title: 센서(Sensor)
description: Instructions on how to setup your sensors with Home Assistant.
logo: home-assistant.png
ha_category:
  - Sensor
ha_release: 0.7
ha_quality_scale: internal
---

센서가 상태 및 조건에 대한 정보를 수집합니다. 

홈 어시스턴트는 현재 광범위한 센서를 지원합니다. 홈 어시스턴트가 직접 제공하고 웹 서비스 및 물리적 장치에서 수집 한 정보를 표시 할 수 있습니다.

## 장치 클래스 (device class)

프런트 엔드에 이러한 센서가 표시되는 방식은 [customize section](/docs/configuration/customizing-devices/)에서 수정할 수 있습니다. 센서에 지원되는 장치 클래스는 다음과 같습니다.

- **None**: 일반 센서. 이것이 기본값이며 설정할 필요가 없습니다.
- **battery**: 배터리 잔량.
- **humidity**:  대기 중 습도의 백분율.
- **illuminance**:  대기 중 습도의 백분율.
- **signal_strength**: dB 또는 dBm 단위의 신호 강도.
- **temperature**: °C 또는 °F 단위의 온도.
- **power**: W 또는 kW의 전력.
- **pressure**: hPa 또는 mbar 단위의 압력.
- **timestamp**: Datetime 객체 혹은 timestamp 문자열.

<p class='img'>
<img src='/images/screenshots/sensor_device_classes_icons.png' />
센서에 대한 다양한 장치 클래스 아이콘의 예.
</p>
