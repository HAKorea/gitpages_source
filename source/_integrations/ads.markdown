---
title: 빌딩자동화시스템(ADS)
description: Connect Home Assistant to TwinCAT devices via the ADS interface
logo: beckhoff.png
ha_category:
  - Hub
  - Binary Sensor
  - Light
  - Sensor
  - Switch
  - Cover
ha_release: '0.60'
ha_iot_class: Local Push
---

ADS는 [TwinCAT](https://www.beckhoff.hu/english.asp?twincat/default.htm)을 실행하는 [Beckhoff](https://www.beckhoff.com/) 자동화 장치와 이 인터페이스를 구현하는 다른 장치 간의 통신을 위한 device-independent이고 fieldbus independent 인터페이스를 말합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Light](#light)
- [Sensor](#sensor)
- [Switch](#switch)
- [Cover](#cover)

## 설정

ADS를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
ads:
  device: '127.0.0.1.1.1'
  port: 801
```

{% configuration %}
device:
  description: The AMS NetId that identifies the device.
  required: true
  type: string
port:
  description: The port that runs the AMS server on the device, typically this would be 801 or 851.
  required: true
  type: integer
ip_address:
  description: The IP address of the ADS device, if not set the first 4 bytes of the device id will be used.
  required: false
  type: string
{% endconfiguration %}

## 서비스

ADS 통합구성요소는 `write_by_name` 서비스를 등록하여 ADS 장치의 변수에 값을 쓸 수 있습니다.

```json
{
    "adsvar": ".myvariable",
    "adstype": "int",
    "value": 123
}
```

서비스 매개 변수 :

- **adsvar**: ADS 장치의 변수 이름 *TwinCAT2*에서 전역 변수에 액세스하려면 앞에 붙는 점 `.myvariable`을 사용하고 TwinCAT3의 경우 `GBL.myvariable`을 사용하십시오.
- **adstype**: 변수의 유형을 지정하십시오. 다음 중 하나를 사용하십시오 :`int`, `byte`, `uint`, `bool`
- **value**: 변수에 쓰여질 값.

## Binary Sensor

`ads` 이진 센서 플랫폼을 사용하여 ADS 장치에서 boolean 값을 모니터링 할 수 있습니다.

ADS 장치를 사용하려면 먼저 [ADS hub](#configuration)를 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: ads
    adsvar: .boolean1
```

{% configuration %}
adsvar:
  description: The name of the variable which you want to access on the ADS device.
  required: true
  type: string
name:
  description: An identifier for the light in the frontend.
  required: false
  type: string
device_class:
  description: Sets the [class of the device](/integrations/binary_sensor/), changing the device state and icon that is displayed on the frontend.
  required: false
  type: string
{% endconfiguration %}

## Light

`ads` 조명 플랫폼을 사용하면 connecte ADS 조명을 제어할 수 있습니다.

ADS 장치를 사용하려면 먼저 [ADS hub](#configuration)를 설정 한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
light:
  - platform: ads
    adsvar: GVL.enable_light
    adsvar_brightness: GVL.brightness
```

{% configuration %}
adsvar:
  required: true
  description: The name of the boolean variable that switches the light on
  type: string
adsvar_brightness:
  required: false
  description: The name of the variable that controls the brightness, use an unsigned integer on the PLC side
  type: string
name:
  required: false
  description: An identifier for the Light in the frontend
  type: string
{% endconfiguration %}

## Sensor

`ads` 센서 플랫폼을 사용하면 ADS 장치의 숫자 변수 값을 읽을 수 있습니다. 변수는 *INT*, *UINT*, *BYTE*, *DINT* 또는 *UDINT* 유형일 수 있습니다.

ADS 장치를 사용하려면 먼저 [ADS hub](#configuration)를 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: ads
    adsvar: GVL.temperature
    unit_of_measurement: '°C'
    adstype: integer
```

{% configuration %}
adsvar:
  required: true
  description: The name of the variable which you want to access.
  type: string
adstype:
  required: false
  description: The datatype of the ADS variable, possible values are int, uint, byte, dint, udint.
  default: int
  type: string
name:
  required: false
  description: An identifier for the sensor.
  type: string
factor:
  required: false
  description: A factor that divides the stored value before displaying in Home Assistant.
  default: 1
  type: integer
{% endconfiguration %}

The *factor* can be used to implement fixed decimals. E.g., set *factor* to 100 if you want to display a fixed decimal value with two decimals. A variable value of `123` will be displayed as `1.23`.
*factor*는 고정 소수점을 구현하는 데 사용할 수 있습니다. 예를 들어, 소수점 이하 두 자리로 고정 소수점 값을 표시하려면 *factor*를 100으로 설정하십시오. `123`의 변수값은 `1.23`으로 표시됩니다.

## Switch

`ads` 스위치 플랫폼은 연결된 ADS 장치의 boolean 변수에 액세스합니다. 변수는 이름으로 식별됩니다.

ADS 장치를 사용하려면 먼저 [ADS hub](#configuration)를 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
switch:
  - platform: ads
    adsvar: .global_bool
```

{% configuration %}
adsvar:
  required: true
  description: The name of the variable which you want to access on the ADS device.
  type: string
name:
  required: false
  description: An identifier for the switch in the frontend.
  type: string
{% endconfiguration %}

## Cover

`ads` 커버 플랫폼을 사용하면 연결된 ADS 커버를 제어할 수 있습니다.

ADS 장치를 사용하려면 먼저 [ADS hub](#configuration)를 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
cover:
  - platform: ads
    name: Curtain master bed room
    adsvar_open: covers.master_bed_room_open
    adsvar_close: covers.master_bed_room_close
    adsvar_stop: covers.master_bed_room_stop
    device_class: curtain
```

{% configuration %}
adsvar:
  required: true
  description: The name of the boolean variable that returns the current status of the cover (`True` = closed)
  type: string
adsvar_position:
  required: false
  description: The name of the variable that returns the current cover position, use a byte variable on the PLC side
  type: string
adsvar_set_position:
  required: false
  description: The name of the variable that sets the new cover position, use a byte variable on the PLC side
  type: string
adsvar_open:
  required: false
  description: The name of the boolean variable that triggers the cover to open
  type: string
adsvar_close:
  required: false
  description: The name of the boolean variable that triggers the cover to close
  type: string
adsvar_stop:
  required: false
  description: The name of the boolean variable that triggers the cover to stop
  type: string
name:
  required: false
  description: An identifier for the Cover in the frontend
  type: string
device_class:
  required: false
  description: Sets the [class of the device](/integrations/cover/), changing the device state and icon that is displayed on the frontend.
  type: device_class
{% endconfiguration %}
