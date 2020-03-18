---
title: Axis 보안 카메라
description: Integration between network devices from Axis Communications with Home Assistant.
logo: axis.png
ha_category:
  - Camera
  - Binary Sensor
  - Switch
ha_config_flow: true
ha_release: 0.45
ha_iot_class: Local Push
ha_codeowners:
  - '@kane610'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/LoiVGkyCkWg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Axis Communications](https://www.axis.com/) 장치는 감시 카메라, 스피커, 액세스 제어 및 기타 보안 관련 네트워크 연결 하드웨어입니다. 이벤트 API는 펌웨어 5.50 이상에서 작동합니다.

홈어시스턴트는 네트워크에서 Axis 카메라를 자동으로 감지합니다.

## 설정

설정하려면 Home Assistant 인스턴스의 `통합구성요소 UI`로 이동하십시오.

<div class='note'>
  Axis Assistant에서 특별히 홈어시스턴트용 사용자를 작성하는 것이 좋습니다. 현재의 모든 기능에 대해 사용자 그룹 뷰어에 속하는 사용자를 작성하면 충분합니다.
</div>

## 자동검색(discovery) 문제해결

장치가 검색되지 않은 경우 카메라에서 **System Options** -> **Advanced** -> **Plain Config**으로 이동합니다. 드롭 다운 상자를 `network` 로 변경하고 `Select Group`을 클릭하십시오. `Network Interface I0 ZeroConf`에 `169.x.x.x` IP 주소가 포함되어있는 경우,이 섹션의 `Enabled` 옆에있는 상자를 체크 해제하고 `Save`을 클릭하십시오.

## Binary Sensor

다음과 같은 센서 유형이 지원됩니다.

- Motion detection (VMD3/VMD4)
- Passive IR motion detection
- Sound detection
- Day/night mode
- Inputs and Supervised Inputs

## Switch

다음과 같은 제어 가능한 포트 유형이 지원됩니다.

- Output
- Relay
