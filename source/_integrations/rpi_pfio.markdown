---
title: PiFace Digital I/O (PFIO)
description: Instructions on how to integrate the PiFace Digital I/O module into Home Assistant.
logo: raspberry-pi.png
ha_category:
  - DIY
  - Binary Sensor
  - Switch
ha_release: 0.45
ha_iot_class: Local Push
---

`rpi_pfio` 통합구성요소는 Home Assistant의 모든 관련 [PiFace Digital I/O (PFIO)](http://www.piface.org.uk/) 플랫폼의 기본입니다. 통합 자체에 필요한 설정이 없습니다. 플랫폼에 대해서는 해당 페이지를 확인하십시오.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Switch](#switch)

PiFace 보드의 점퍼를 주소 0 (JP1: 1-2, JP2: 1-2)으로 설정하십시오.

## HassOS에서 사용하기

PiFace Digital 2는 [HassOS](https://github.com/home-assistant/hassos)를 사용할 때 기본적으로 비활성화된 Raspberry Pi SPI 포트를 사용합니다. HassOS를 사용하는 경우 SD 카드를 다른 컴퓨터에 마운트하고 카드의 부팅 파티션에 액세스해야합니다. `config.txt` 파일을 편집하고 `dtparam=spi=on` 줄을 끝에 추가하십시오. 이를 통해 HassOS가 부팅될 때 SPI를 활성화하고 Home Assistant가 PiFace Digital 2 보드에 액세스할 수 있어야합니다.

## Binary Sensor

rpi_pfio 바이너리 센서 플랫폼을 사용하면 [PiFace Digital I/O](http://www.piface.org.uk/products/piface_digital/)의 센서값을 읽을 수 있습니다.

설치시 PiFace Digital I/O 모듈을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: rpi_pfio
    ports:
      0:
        name: PIR Office
        invert_logic: true
      1:
        name: Doorbell
        settle_time: 50
```

{% configuration %}
ports:
  description: List of used ports.
  required: true
  type: map
  keys:
    num:
      description: The port number.
      required: true
      type: map
      keys:
        name:
          description: The port name.
          required: true
          type: string
        settle_time:
          description: The time in milliseconds for port debouncing.
          required: false
          type: integer
          default: 20
        invert_logic:
          description: If `true`, inverts the output logic to ACTIVE LOW.
          required: false
          type: boolean
          default: "`false` (ACTIVE HIGH)"
{% endconfiguration %}

## Switch

`rpi_pfio` 스위치 플랫폼을 사용하면 [PiFace Digital I/O](http://www.piface.org.uk/products/piface_digital/) 모듈을 제어할 수 있습니다.

설치시 PiFace Digital I/O 모듈을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: rpi_pfio
    ports:
      0:
        name: Doorlock
        invert_logic: true
      1:
        name: Light Desk
```

{% configuration %}
ports:
  description: Array of used ports.
  required: true
  type: list
  keys:
    num:
      description: Port number.
      required: true
      type: list
      keys:
        name:
          description: Port name.
          required: true
          type: string
        invert_logic:
          description: If true, inverts the output logic to ACTIVE LOW.
          required: false
          default: false
          type: boolean
{% endconfiguration %}
