---
title: 벨킨 WeMo
description: Instructions on how to integrate Belkin WeMo devices into Home Assistant.
logo: belkin_wemo.png
ha_category:
  - Hub
  - Binary Sensor
  - Fan
  - Light
  - Switch
ha_release: pre 0.7
ha_config_flow: true
ha_codeowners:
  - '@sqldiablo'
---

`wemo`는 다양한 [Belkin WeMo](https://www.belkin.com/us/Products/home-automation/c/wemo-home-automation/) 장치들을 Home Assistant와 연동하기 위한 주요 통합구성요소입니다.

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.


- Binary Sensor
- Fan (Belkin WeMo (Holmes) Smart Humidifier)
- Light (Belkin WeMo LED lights and [Smart Dimmer Switch](https://www.belkin.com/us/F7C059-Belkin/p/P-F7C059/))
- Switch ([Belkin WeMo Switches](https://www.belkin.com/us/Products/home-automation/c/wemo-home-automation/) and includes support for Wemo enabled [Mr. Coffee](https://www.mrcoffee.com/wemo-landing-page.html) smart coffee makers.)

## 설정

{% configuration %}
  discovery:
    description: 이 값을 false로 설정하면 wemo 플랫폼 및 discovery 플랫폼이 WeMo 장치를 자동 감지하지 못하게됩니다 (정적 장치는 여전히 감지됨)
    required: false
    type: boolean
    default: true
  static:
    description: WeMo가 사용할 하나 이상의 정적 IP 주소
    required: false
    type: list
{% endconfiguration %}

선택적 `discovery` 설정 항목이 생략되거나 true로 설정되거나 `discovery` 통합구성요소가 사용 가능한 경우 지원되는 장치가 자동으로 감지됩니다. `discovery` 설정 항목이 false로 설정되면, wemo 통합구성요소 및 `discovery` 구성요소 모두에 대해 WeMo 디바이스의 자동 발견이 사용 불가능합니다. `discovery` 설정 항목을 생략하거나 true로 설정한 `wemo` 통합구성요소를 로드하면 `discovery` 구성 요소를 사용하지 않더라도 로컬 네트워크에서 WeMo 장치를 스캔합니다.

```yaml
# Example configuration.yaml entry with automatic discovery enabled (by omitting the discovery configuration item)
wemo:

# Example configuration.yaml entry with automatic discovery enabled (by explicitly setting the discovery configuration item)
wemo:
  discovery: true
```

다른 방법으로, 검색할 수 없는 WeMo 장치를 정적으로 설정할 수 있습니다. 홈어시스턴트가 실행되는 곳 이외의 서브넷에 WeMo 장치가 있거나 VPN을 통해 원격 위치에있는 장치가 있는 경우 수동으로 설정해야합니다. 정적으로 구성된 장치는 자동 검색을 사용하거나 사용하지 않고 사용할 수 있습니다. 정적 설정의 예는 다음과 같습니다. :

```yaml
# Example configuration.yaml entry with automatic discovery disabled, and 2 statically configured devices
wemo:
  discovery: false
  static:
    - 192.168.1.23
    - 192.168.52.172
```

고정 장치 항목을 사용하는 경우 WeMo 장치가 고정 IP 주소를 사용하도록 라우터 (또는 DHCP 서버를 실행하는 모든 것)를 설정할 수 있습니다. 이 기능에 대해서는 라우터 구성의 DHCP 섹션을 확인하십시오.

장치가 작동하지 않고 대시 보드에서 "unavailable" 상태인 경우 WeMo 장치가 업데이트를 보내는 포트이므로 방화벽이 포트 8989에서 들어오는 요청을 차단하지 않는지 확인하십시오.

## 에뮬레이트된 장치 (Emulated devices)

WeMo 장치를 에뮬레이트하는 다양한 소프트웨어는 종종 대체 포트를 사용합니다. 정적 구성에는 포트 값이 포함되어야합니다.

```yaml
# Example configuration.yaml entry with static device entries that include non-standard port numbers
wemo:
  static:
    - 192.168.1.23:52001
    - 192.168.52.172:52002
```

## Fan

`wemo` 플랫폼을 사용하면 Home Assistant 내에서 Belkin WeMo 가습기를 제어 할 수 있습니다. 여기에는 [Holmes Smart Humidifier](https://www.holmesproducts.com/wemo-humidifier.html)지원이 포함됩니다

`discovery` 통합구성요소가 활성화 된 경우 WeMo 장치가 자동으로 검색됩니다.

### 속성 

자동화 및 템플릿에 사용할 수있는 몇 가지 속성이 있습니다.

| Attribute | Description |
| --------- | ----------- |
| `current_humidity` | 장치의 온보드 습도 센서에 의해 결정된 실내의 현재 상대 습도 백분율을 나타내는 정수.
| `fan_mode` | WeMo 가습기에 의해 보고된 현재 팬 속도 세팅을 나타내는 문자열입니다.
| `filter_expired` | 필터가 만료되어 교체해야하는지 여부를 나타내는 boolean.
| `filter_life` | 필터 사용 수명 (백분율).
| `target_humidity` | 원하는 상대 습도 백분율을 나타내는 정수 (45, 50, 55, 60 및 100 인 장치의 습도 설정으로 제한됨).
| `water level` | 수위가 good, low 또는 empty 여부를 나타내는 문자열입니다.

### 서비스

가습기의 자동화 및 제어에 사용할 수있는 몇 가지 서비스가 있습니다.

| Service | Description |
| --------- | ----------- |
| `set_speed` | 이 서비스를 호출하면 팬 속도가 설정됩니다 (entity_id 및 speed는 필수 매개 변수이며 speed는 off, low, medium 또는 high 중 하나여야합니다). 속도를 낮게 선택하면 WeMo 가습기 속도가 최소로 매핑됩니다. 속도를 높게 선택하면 WeMo 가습기 최대속도에 매핑됩니다. 홈어시스턴트가 지원하는 팬 속도의 제약으로 인해 낮고 높은 WeMo 가습기 속도는 사용되지 않습니다.
| `toggle` | 이 서비스를 호출하면 가습기가 켜짐 및 꺼짐 상태간에 전환됩니다.
| `turn_off` | 이 서비스를 호출하면 가습기가 꺼집니다 (entity_id 필요).
| `turn_on` | 이 서비스를 호출하면 가습기를 켜고 속도를 마지막으로 사용한 속도로 설정합니다 (기본값은 medium, entity_id가 필요함).
| `wemo.set_humidity` | 이 서비스를 호출하면 장치에서 원하는 상대 습도 세팅이 설정됩니다 (entity_id는 습도를 설정하기위한 하나 이상의 엔티티의 필수 목록이며 target_humidity는 0에서 100 사이의 필수 부동 소수점 값입니다 (이 값은 반올림되어에 매핑 됨). WeMo 가습기에서 지원하는 45, 50, 55, 60 또는 100의 유효한 원하는 습도 설정 중 하나))
| `wemo.reset_filter_life` | 이 서비스를 호출하면 가습기의 필터 수명이 100 %로 다시 설정됩니다 (entity_id는 필터 수명을 재설정하기위한 하나 이상의 엔티티의 필수 목록입니다). 가습기의 필터를 교체 할 때이 서비스에 문의하십시오.
