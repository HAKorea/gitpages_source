---
title: 피바로(Fibaro)
description: Instructions on how to setup Fibaro Z-Wave hubs (HCL and HC2) and configure devices within Home Assistant.
logo: fibaro.png
ha_category:
  - Hub
  - Binary Sensor
  - Climate
  - Cover
  - Light
  - Sensor
  - Scene
  - Switch
ha_release: 0.83
ha_iot_class: Local Push
---

[Fibaro](https://fibaro.com/) 허브는 주로 Z-Wave 장치에 연결되는 컨트롤러입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Binary Sensor
- Cover
- Climate
- Light
- Sensor
- Scene
- Switch

`fibaro` 허브가 홈어시스턴트에 연결 되면 자동으로 추가됩니다 

## 설정

Fibaro 장치를 사용하려면 Fibaro 컨트롤러의 IP 및 포트 번호를 사용하여 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
fibaro:
  gateways:
    - url: http://192.168.1.161/api/
      username: your_username
      password: your_password
      device_config:
        light_device_name_123:
          color: false
          white_value: false
          reset_color: true
        binary_device_name_123:
          device_class: "garage_door"
          icon: mdi:open
```

{% configuration %}
gateways:
  description: 게이트웨이 설정 목록.
  requires: true
  type: list
url:
  description: Fibaro HomeCenter 장치의 URL.
  required: true
  type: string
username:
  description: Fibaro 계정의 사용자 이름.
  required: true
  type: string
password:
  description: Fibaro 계정의 비밀번호.
  required: true
  type: string
plugins:
  description: Netatmo 및 Sonos 장치 등과 같이 Fibaro HomeCenter에서 플러그인 장치를 가져올 지 여부
  required: false
  type: boolean
  default: false
device_config:
  description: 장치 별 매개 변수 또는 동작 재정의(behaviour override)를 나열.
  required: false
  type: list
  default: None
{% endconfiguration %}

<div class='note'>

  Fibaro 컨트롤러에 고정 IP 주소를 할당하는 것이 좋습니다. 이렇게하면 IP 주소가 변경되지 않으므로 컨트롤러가 재부팅되고 다른 IP 주소가 나오는 경우 `url`을 변경할 필요가 없습니다. 이를 설정하는 방법에 대한 자세한 내용은 라우터 설명서를 참조하십시오. Fibaro의 MAC 주소가 필요한 경우 하단의 레이블을 확인하십시오.

</div>

### 자동화에서 Z-WAVE 장치 사용

홈어시스턴트 자동화에서 Fibaro 컨트롤러로부터 Z-Wave 장치를 사용하려면 엔티티 ID가 필요합니다. 
홈어시스턴트 UI에는 개발자 도구 섹션의 <img src='/images/screenshots/developer-tool-states-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> 아이콘 아래에 모든 엔티티가 있습니다. 속성에 'fibaro_id'가 포함 된 엔티티를 찾으면 왼쪽에 엔티티 ID가 있습니다.