---
title: 무전원무선기술(EnOcean)
description: Connect EnOcean devices to Home Assistant
logo: enocean.png
ha_category:
  - Hub
  - Binary Sensor
  - Sensor
  - Light
  - Switch
ha_release: 0.21
ha_iot_class: Local Push
ha_codeowners:
  - '@bdurrer'
---

[EnOcean] (https://en.wikipedia.org/wiki/EnOcean) 표준은 여러 공급 업체에서 지원합니다. 
다양한 종류의 스위치와 센서가 있으며 일반적으로 energy harvesting을 사용하여 배터리가 필요하지 않은 전력을 얻습니다.

`enocean` 통합구성요소는 이러한 장치 중 일부에 대한 지원을 추가합니다. 작동하려면 [USB300](https://www.enocean.com/en/enocean_modules/usb-300-oem/)과 같은 컨트롤러가 필요합니다.

현재 홈 어시스턴트에서 다음 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor) - 벽 스위치
- [Sensor](#sensor) - 파워 미터, 온도 센서, 습도 센서 및 창 핸들
- [Light](#light) - 디머
- [Switch](#switch)

그러나 광범위한 메시지 유형으로 인해 모든 장치가 코드 변경없이 작동하지는 않습니다. 다음 장치가 기본적으로 작동하는 것으로 확인되었습니다.

- Eltako FUD61 dimmer
- Eltako FT55 battery-less wall switch
- Jung ENOA590WW battery-less wall switch
- Omnio WS-CH-102-L-rw battery-less wall switch
- Permundo PSC234 (switch and power monitor)
- EnOcean STM-330 temperature sensor
- Hoppe SecuSignal window handle from Somfy

여기에 나열되지 않은 장치를 소유한 경우 장치가 리스트된 [EnOcean 장비 프로파일](https://www.enocean-alliance.org/what-is-enocean/specifications/) 중 있는지 확인하십시오. 그렇다면 대부분 작동 할 것입니다. 사용 가능한 프로파일은 일반적으로 장치 매뉴얼 어딘가에 리스트되어 있습니다.

기술 메시지 지원이 모두다 구현되지 않았습니다.

## 허브

EnOcean 컨트롤러를 Home Assistant와 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
enocean:
  device: /dev/ttyUSB0
```

{% configuration %}
device:
  description: 장치가 Home Assistant 호스트에 연결된 포트.
  required: true
  type: string
{% endconfiguration %}

## Binary Sensor

이는 일반적으로 배터리없는 벽면 스위치 중 하나 일 수 있습니다
다음 장치를 테스트하였습니다. :

- EnOcean PTM 215 모듈을 사용하는 Eltako FT55
- EnOcean PTM210 DB 모듈을 사용하는 [TRIO2SYS Wall switches](https://www.trio2sys.fr/index.php/fr/produits-enocean-sans-fil-sans-pile-interoperable/emetteur-sans-fils-sans-pile-interoperable-enocean) 
- Omnio WS-CH-102

다음과 같은 [EnOcean Equipment Profiles](https://www.enocean-alliance.org/what-is-enocean/specifications/)이 지원됩니다. :

- F6-02-01 (Light and Blind Control - Application Style 2)
- F6-02-02 (Light and Blind Control - Application Style 1)

EnOcean 장치를 사용하려면 먼저 [EnOcean hub](#hub)를 셋업한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: enocean
    id: [0x01,0x90,0x84,0x3C]
```

{% configuration %}
id:
  description: 장치의 ID. 디머에 쓰여진 4 바이트 길이의 숫자.
  required: true
  type: list
name:
  description: 프런트 엔드의 스위치 식별자.
  required: false
  type: string
  default: EnOcean binary sensor
device_class:
  description: 프런트 엔드에 표시되는 장치 상태 및 아이콘을 변경하여 [class of the device](/integrations/binary_sensor/) 를 세팅합니다.
  required: false
  type: device_class
{% endconfiguration %}

EnOcean 바이너리 센서는 상태가 없으며 'button_pressed' 이벤트만 생성합니다. 이벤트 데이터에는 다음 필드가 있습니다.

- **id**: The ID of the device (see configuration).
- **pushed**: `1` for a button press, `0` for a button release.
- **which**: Always `0` when using the single rocket.  `0` or `1` when using the dual rocket switch.
- **onoff**: `0` or `1` for either side of the rocket.

## 자동화 사례

조명을 켜고 끄는 자동화 사례 :

```yaml
# Example automation to turn lights on/off on button release
automation:
  - alias: hall light switches
    trigger:
      platform: event
      event_type: button_pressed
      event_data:
        id: [0xYY, 0xYY, 0xYY, 0xYY]
        pushed: 0
    action:
      service_template: "{% raw %}{% if trigger.event.data.onoff %} light.turn_on {% else %} light.turn_off {%endif %}{% endraw %}"
      data_template:
        entity_id: "{% raw %}{% if trigger.event.data.which == 1 %} light.hall_left {% else %} light.hall_right {%endif %}{% endraw %}"
```

## Light

EnOcean 조명은 여러 형태를 취할 수 있습니다. 현재 한 가지 유형만 테스트되었습니다 : Eltako FUD61 디머.

EnOcean 장치를 사용하려면 먼저 [EnOcean hub](#hub)를 셋업한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
light:
  - platform: enocean
    id: [0x01,0x90,0x84,0x3C]
    sender_id: [0xFF,0xC6,0xEA,0x04]
```

{% configuration %}
id:
  description: 장치의 ID. 디머에 쓰여진 4 바이트 길이의 숫자.
  required: true
  type: list
sender_id:
  description: 장치의 발신자 ID. 이것은 4 바이트 길이.
  required: true
  type: list
name:
  description: 프런트 엔드에서 Ligh의 식별자.
  required: false
  default: EnOcean Light
  type: string
{% endconfiguration %}

## Sensor

EnOcean 센서 플랫폼은 현재 다음 장치 유형을 지원합니다.

 * [power sensor](#power-sensor)
 * [humidity sensor](#humidity-sensor)
 * [temperature sensor](#temperature-sensor)
 * [window handle](#window-handle)
 
EnOcean 장치를 사용하려면 먼저 [EnOcean hub](#hub)를 셋업한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
sensor:
  - name: Television
    platform: enocean
    id: [0x01,0x90,0x84,0x3C]
```

{% configuration %}
id:
  description: 장치의 ID. 이것은 장치의 4 바이트 길이 식별자.
  required: true
  type: list
name:
  description: 프런트 엔드의 센서 식별자.
  required: false
  type: string
  default: EnOcean sensor
device_class:
  description: 프런트 엔드에 표시되는 장치 상태 및 아이콘을 변경하여 [class of the device](/integrations/binary_sensor/) 를 세팅합니다.
  required: false
  required: false
  type: device_class
  default: powersensor
{% endconfiguration %}

### Power sensor

이는 Permundo PSC234 스위치로 테스트되었지만 EEP **A5-12-01** 메시지를 보내는 모든 장치는 작동합니다.

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - name: Television
    platform: enocean
    id: [0x01,0x90,0x84,0x3C]
    device_class: powersensor
```

### Humidity sensor

다음 [EnOcean Equipment Profiles](https://www.enocean-alliance.org/what-is-enocean/specifications/)이 지원됩니다.

- Any profile that contains the humidity value at position **DB2.7** to **DB2.0** 
- **A5-04-01** - Temp. and Humidity Sensor, Range 0°C to +40°C and 0% to 100%
- **A5-04-02** - Temp. and Humidity Sensor, Range -20°C to +60°C and 0% to 100%
- **A5-10-10** to **A5-10-14** - Room Operating Panels

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - name: Bathroom
    platform: enocean
    id: [0x01,0x90,0x84,0x3C]
    device_class: humidity
```

### Temperature sensor

이 센서는 대부분의 실내 온도 센서 장치에 사용되는 일반 STM-330 센서로 테스트되었습니다.

다음 [EnOcean Equipment Profiles](https://www.enocean-alliance.org/what-is-enocean/specifications/)이 지원됩니다.

- Any profile that contains an 8-bit temperature at position DB1.7 to DB1.0. 10-bit is not supported.
- **A5-02-01** to **A5-02-1B** - Temperature Sensor with various temperature ranges
- **A5-10-01** to **A5-10-14** - Room Operating Panels
- **A5-04-01** - Temp. and Humidity Sensor, Range 0°C to +40°C and 0% to 100%
- **A5-04-02** - Temp. and Humidity Sensor, Range -20°C to +60°C and 0% to 100%
- **A5-10-10** - Temp. and Humidity Sensor and Set Point
- **A5-10-12** - Temp. and Humidity Sensor, Set Point and Occupancy Control

사용하는 EEP를 확인하려면 온도 센서 설명서를 확인하십시오. 
모르는 경우, 경험을 토대로 추측을 하고 보고된 값을 확인하십시오. 범위의 경계에서 온도를 확인하는 것이 가장 쉬운 방법이므로 센서를 냉장고에 잠시 동안 두십시오.

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - name: Living Room
    platform: enocean
    id: [0x01,0x90,0x84,0x3C]
    device_class: temperature
```

온도 센서는 이러한 추가 설정 속성을 지원합니다.

{% configuration %}
min_temp:
  description: 센서가 지원하는 최소 온도 (° C)
  required: false
  type: integer
  default: 0
max_temp:
  description: 센서가 지원하는 최대 온도 (° C)
  required: false
  type: integer
  default: 40
range_from:
  description: 센서가 `min_temp`에 대해 보고하는 범위 값
  required: false
  type: integer
  default: 255
range_to:
  description: 센서가 `max_temp`에 대해 보고하는 범위 값
  required: false
  type: integer
  default: 0
{% endconfiguration %}

_range_from_ 및 _range_to_ 의 기본 설정값은 오타가 아니며 범위는 대부분의 센서에서 거꾸로입니다.
그러나 일부 EEP의 반전 범위는 0에서 250 사이입니다. 여기에는 다음 EEP가 포함됩니다.

- **A5-04-01**
- **A5-04-02**
- **A5-10-10** to **A5-10-14**

해당 센서에 `configuration.yaml`을 적용하십시오:

```yaml
# Example configuration.yaml entry for EEP A5-10-10
sensor:
  - name: Living Room
    platform: enocean
    id: [0x01,0x90,0x84,0x3C]
    device_class: temperature
    range_from: 0
    range_to: 250
```

### Window handle

현재 Somfy의 Hoppe SecuSignal 창 핸들(Window handle)이 성공적으로 테스트되었습니다. 그러나 EnOcean RPS telegram 사양 F6 10 00 (Hoppe AG)을 따르는 모든 기계식 창 핸들은 지원됩니다.

창 핸들을 설정하려면 `configuration.yaml`에 다음 코드를 추가하십시오 

```yaml
# Example configuration.yaml entry for window handle EEP F6-10-00
sensor:
  - name: Living Room Window Handle
    platform: enocean
    id: [0xDE,0xAD,0xBE,0xEF]
    device_class: windowhandle
```

설정에 선택적 매개 변수가 없습니다.

창 핸들 센서는 다음 상태를 가질 수 있습니다.

- **closed**: The window handle is in closed position (typically down, or 6 o'clock)
- **open**: The window handle is in open position (typically left or right, or 3 o'clock or 9 o'clock)
- **tilt**: The window handle is in tilt position (typically up or 12 o'clock)

## Switch

EnOcean 스위치는 여러 형태를 취할 수 있습니다. 현재 Permundo PSC234 및 Nod On SIN-2-1-01 유형만 테스트되었습니다.

EnOcean 장치를 사용하려면 먼저 [EnOcean hub](#hub)를 셋업한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
switch:
  - platform: enocean
    id: [0x01,0x90,0x84,0x3C]
```

{% configuration %}
id:
  description: 장치의 ID. 이것은 4 바이트 길이.
  required: true
  type: list
name:
  description: 스위치의 식별자
  required: false
  default: EnOcean Switch
  type: string
channel:
  description: 출력 채널을 전환할 채널 번호. (일반적으로 0 또는 1)입니다.
  required: false
  default: 0
  type: integer
{% endconfiguration %}

```yaml
# Example entries for a switch with 2 outputs (channels), e.g., the Nod On SIN-2-1-01
switch nodon01_0:
  - platform: enocean
    id: [0x05,0x04,0x03,0x02]
    name: enocean_nodon01_0
    channel: 0

switch nodon01_1:
  - platform: enocean
    id: [0x05,0x04,0x03,0x02]
    name: enocean_nodon01_1
    channel: 1
```
