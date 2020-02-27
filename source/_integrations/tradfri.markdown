---
title: IKEA TRÅDFRI (TRADFRI)
description: Access and control your IKEA Trådfri Gateway and its connected Zigbee-based devices.
featured: true
logo: ikea.svg
ha_iot_class: Local Polling
ha_config_flow: true
ha_release: 0.43
ha_category:
  - Cover
  - Light
  - Sensor
  - Switch
ha_codeowners:
  - '@ggravlingen'
---

현재 이케아 TRADFRI 제품은 별도의 [지그비 게이트웨이](https://www.ikea.com/ca/en/p/tradfri-gateway-white-00337813/) 가 필요합니다. 허나 Zigbee2mqtt 활용시 한개의 허브로 동작시킬 수 있습니다. 이에 이케아 통합구성요소에 임시로 Zigbee2mqtt 연동 방식을 올려둡니다. 

그중에서 **현재 가장 많이 쓰는 통신방식은 Zigbee 제품**임으로 [Zigbee2mqtt 설치방법](https://hakorea.github.io/integrations/zha/)를 통해 이케아 TRADFRI 제품군들을 설치하시길 권장합니다. 

zigbee2mqtt의 [이케아 장치들의 지원 목록](https://www.zigbee2mqtt.io/information/supported_devices.html#ikea) 을 참조하십시오. 

이외에도 Zigbee2mqtt는 2020년 2월 17일 현재 **112개 회사의 584개 장치**들을 공식 지원합니다. 

------------------------------------------------------------------------------------------------------------

이하 IKEA Trådfri Gateway 사용시 내용 

`tradfri` 통합구성요소로 IKEA Trådfri Gateway를 Home Assistant에 연결할 수 있습니다. 게이트웨이는 연결된 지그비 조명(certified Zigbee Light Link products)을 제어 할 수 있습니다. `configuration.yaml` 파일에 `discovery : ` 가 있는 경우 Home Assistant는 로컬 네트워크에서 게이트웨이의 존재를 자동으로 감지합니다.

Home Assistant 인터페이스를 통해 게이트웨이를 설정하라는 메시지가 표시됩니다. 설정 과정은 매우 간단합니다. 메시지가 표시되면 IKEA Trådfri Gateway 하단의 스티커에 인쇄된 보안키를 입력한 다음 *configure* 를 클릭하십시오.

<div class='note'>
"연결할 수 없음" 메시지가 표시되면 게이트웨이를 다시 시작하고 다시 시도하십시오. 라우터 또는 DHCP 서버의 IKEA Trådfri 게이트웨이에 고정 IP 주소를 할당하는 것을 잊지 마십시오.
</div>

## 설정 

[`discovery :`](/ integrations/discovery/) 컴포넌트를 사용하지 않는 경우 `configuration.yaml` 파일에 다음을 추가해서 설치할 수도 있습니다.

```yaml
# Example configuration.yaml entry
tradfri:
  host: IP_ADDRESS
```

{% configuration %}
host:
  description: "IKEA Trådfri Gateway의 IP주소 또는 호스트 이름."
  required: true
  type: string
allow_tradfri_groups:
  description: "홈어시스턴트가 IKEA Trådfri Gateway에 정의된 그룹을 가져오려면 이를 `true`로 설정하십시오."
  required: false
  type: boolean
  default: false
{% endconfiguration %}

## 문제 해결

### 펌웨어 업데이트

IKEA Trådfri Gateway 펌웨어를 업데이트한 후 설정 프로세스를 반복해야 할 수도 있습니다. 펌웨어 업데이트 후 발생할 수있는 한 가지 오류는 `Fatal DTLS error: code 115` 입니다. 문제가 발생하면 다음으로 해결해보십시오. : 
- 통합구성요소를 사용하여 설정한 경우 : 통합구성요소에서 제거, Settings > 통합구성요소 > Tradfri > 삭제 (휴지통 아이콘)
- 수동설정의 경우 : `/.homeassistant` 디렉토리(`/config` Hass.io 혹은 Docker 사용시 디렉토리는 `/config`)에서 `.tradfri_psk.conf` 파일을 삭제

그다음 홈어시스턴트를 다시 시작하십시오. 메시지가 표시되면, 초기 설정과 마찬가지로 보안키를 입력하고 *configure* 를 클릭하십시오 .

### 컴파일 문제 (Compilation issues)

<div class='note'>
  Hass.io 또는 Docker에는 적용되지 않습니다.
</div>

이 구성요소를 사용하려면 `autoconf`가 설치되어 있는지 확인하십시오 (`$ sudo apt-get install autoconf`). 또한 일부 종속 항목을 설치하면 느린 장치의 경우 상당한 시간(1시간 이상)이 걸릴 수 있습니다.

### `api_key` 세팅 

`configuration.yaml`에 `api_key` 변수를 사용하지 마십시오. API 키는 초기 설정시 한 번만 필요하며 저장됩니다.