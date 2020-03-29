---
title: 베라(Vera)
description: Instructions on how to setup Vera Z-Wave hubs and configure devices within Home Assistant.
logo: vera.png
ha_category:
  - Hub
  - Binary Sensor
  - Cover
  - Light
  - Lock
  - Scene
  - Sensor
  - Switch
  - Climate
ha_release: pre 0.7
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/thBwWReWGpc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Vera](https://getvera.com/) 허브는 주로 Z-Wave 장치에 연결하기위한 컨트롤러입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Binary Sensor
- Cover
- Light
- Lock
- Scene
- Sensor
- Switch
- Climate

HA가 Vera 컨트롤러에 연결되면 자동으로 추가됩니다.

## 설정

설치에서 Vera 장치를 사용하려면 Vera 컨트롤러의 IP 및 포트 번호를 사용하여 configuration.yaml 파일에 다음을 추가하십시오.

```yaml
vera:
  vera_controller_url: http://192.168.1.161:3480/
```

{% configuration %}
vera_controller_url:
  description: The URL for your Vera device.
  required: true
  type: string
{% endconfiguration %}

<div class='note'>

  고정 IP 주소를 Vera Controller에 할당하는 것이 좋습니다. 이렇게하면 IP 주소가 변경되지 않도록하므로 재부팅할 때 다른 IP 주소가 나오면 `vera_controller_url`을 변경할 필요가 없습니다. 이를 설정하는 방법에 대한 자세한 내용은 라우터 설명서를 참조하십시오. Vera의 MAC 주소가 필요한 경우 하단의 레이블을 확인하십시오.

</div>

### 장치 설정

기본적으로 스위치는 홈어시스턴트에 스위치로 추가되지만 일부 스위치가 조명 스위치인 경우 아래에 표시된 것처럼 `lights` 매개 변수를 사용하여 홈어시스턴트에게 이를 알릴 수 있습니다.

Vera는 정교하게 Z-Wave 장치를 Home Assistant로 가져옵니다. 여기에는 사용하지 않는 시스템 장치 및 기타 장치가 포함될 수 있습니다. 아래와 같이 `exclude:`매개 변수를 사용하여 이러한 장치를 로드하지 않도록 Home Assistant에 지시할 수 있습니다.

Vera UI에서 장치의 고급 속성을 통해 또는 Home Assistant로 가져온 각 장치에서 `Vera Device Id` 속성을 확인하여 Vera 장치 ID를 찾을 수 있습니다. (개발자 도구 에서).

```yaml
vera:
  vera_controller_url: http://192.168.1.161:3480/
  # Optional to exclude devices - this is a list of vera device ids
  exclude: [ 13, 14, 16, 20, 23, 72, 73, 74, 75, 76, 77, 78, 88, 89, 99]
  # Optional to import switches as lights - this is a list of vera device ids
  lights: [15, 17, 19, 21, 22, 24, 26, 43, 64, 70, 87]
```

### 자동화에서 Z-Wave 장치 사용

Home Assistant 자동화의 Vera 컨트롤러에서 Z-Wave 장치를 사용하려면 엔티티 ID가 필요합니다. 
홈어시스턴트 UI에는 개발자 도구 섹션의 <img src='/images/screenshots/developer-tool-states-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> 아이콘 아래에 모든 엔티티가 표시됩니다. 속성에 `Vera Device Id`가 포함된 엔티티를 찾으면 왼쪽에 엔티티 ID가 있습니다.

### Sensor

`vera` 플랫폼을 사용하면 Home Assistant 내에서 [Vera](https://getvera.com/) 센서에서 데이터를 가져올 수 있습니다.

일부 베라 센서( _motion_ , _flood_ 센서 같은)는 _arm_ 이 가능하므로 베라가 arm으로 상태가 변경되면 경고(email messages to txts)를 보냅니다. 

홈어시스턴트는 _armed_ 상태에 관계없이 이러한 센서의 상태를 표시합니다.

_armed state_ 를 변경하려면 - Home Assistant는 각 _Armable_ 센서에 대한 센서와 스위치를 만듭니다. 원하는 경우 사용자 지정을 사용하여 이러한 스위치를 숨길 수 있습니다.