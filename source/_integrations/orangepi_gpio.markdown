---
title: 오렌지파이 GPIO(Orangepi GPIO)
description: Instructions on how to integrate the GPIO capability of a Orange Pi into Home Assistant.
ha_category:
  - DIY
  - Binary Sensor
ha_release: 0.93
ha_iot_class: Local Push
logo: orange-pi.png
ha_codeowners:
  - '@pascallj'
---

orangepi_gpio 통합구성요소는 Home Assistant의 모든 관련 GPIO 플랫폼 기반입니다. 연동 자체에 필요한 설정이 없습니다. 플랫폼의 경우 해당 페이지를 확인하십시오.

## Binary Sensor

orangepi_gpio 바이너리 센서 플랫폼을 사용하면 Orange Pi 또는 NanoPi의 GPIO 센서값을 읽을 수 있습니다.

## 설정

설치에서 Orange Pi의 GPIO를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: orangepi_gpio
    pin_mode: pc
    ports:
      11: PIR Office
      12: PIR Bedroom
```

{% configuration %}
pin_mode:
  description: Type of pin mode to use. This depends on which device you are actually using ([Pin modes](#pin-modes)).
  required: true
  type: string
ports:
  description: List of used ports.
  required: true
  type: map
  keys:
    "port: name":
      description: The port numbers (physical pin numbers) and corresponding names.
      required: true
      type: string
invert_logic:
  description: If `true`, inverts the output logic to ACTIVE LOW.
  required: false
  type: boolean
  default: "`false` (ACTIVE HIGH)"
{% endconfiguration %}

[Raspberry Pi GPIO](/integrations/rpi_gpio/) 구성 요소와 비교하여 이 통합구성요소는 풀업 저항(pull-up resistors) 또는 포트 디바운싱(port debouncing)을 지원하지 않습니다. 외부 풀업 및 외부 포트 디바운싱을 사용하십시오.

## Pin modes

이 플랫폼은 다른 Orange Pi 또는 Nano Pi 장치에 대해 다양한 유형의 GPIO 핀아웃을 지원하므로 `pin_mode` 값을 사용하여 사용할 것을 지정합니다. 사용 가능한 값은 다음과 같습니다.

| Value | Description |
| ----- | ----------- |
| `lite` | Supports the Orange Pi Lite |
| `lite2` | Supports the Orange Pi Lite 2 |
| `one` | Supports the Orange Pi One |
| `oneplus` | Supports the Orange Pi One Plus |
| `pc` | Supports the Orange Pi PC |
| `pc2` | Supports the Orange Pi PC 2 |
| `pcplus` | Supports the Orange Pi PC Plus |
| `pi3` | Supports the Orange Pi 3 |
| `plus2e` | Supports the Orange Pi Plus 2E |
| `prime` | Supports the Orange Pi Prime |
| `r1` | Supports the Orange Pi R1 |
| `winplus` | Supports the Orange Pi WinPlus |
| `zero` | Supports the Orange Pi Zero |
| `zeroplus` | Supports the Orange Pi Zero Plus |
| `zeroplus2` | Supports the Orange Pi Zero Plus 2 |
| `duo` | Supports the NanoPi Duo |
| `neocore2` | Supports the NanoPi Neocore 2 |

## 추가 단계 (Additional steps)
이 통합구성요소는 `SYSFS` 파일 시스템을 사용하여 GPIO를 제어합니다. 따라서 `CONFIG_GPIO_SYSFS`가 있는 운영 체제가 필요합니다. 내가 아는 한 대부분의 기본 배포판은 ​​기본적으로 이를 활성화합니다.

Linux 4.8부터 sysfs-gpio는 더이상 사용되지 않는 것으로 표시됩니다. 그러나 현재로서는 대체 GPIO 문자 장치가 널리 사용되지 않습니다. 따라서 우리는 새로운 캐릭터 장치가 더 널리 지원 될 때까지 이것을 사용할 것입니다.

일반적으로 `/sys/class/gpio` 경로는 루트가 소유하므로 Home Assistant는 액세스 할 수 없습니다. 우리는 루트로 홈어시스턴트를 실행하고 싶지 않기 때문에이 경로를 제어 할 수 있도록 `gpio` 그룹을 추가 할 것이다. [Manual installation guide](/docs/installation/raspberry-pi/)에서 권장하는대로 `homeassistant` 사용자를 `gpio` 그룹에 이미 추가했다고 가정합니다.

`/etc/udev/rules.d/`에 `10-gpio.rules`라는 새 파일을 다음 내용으로 작성하십시오.

```txt
SUBSYSTEM=="gpio*", PROGRAM="/bin/sh -c 'find -L /sys/class/gpio/ -maxdepth 2 -exec chown root:gpio {} \; -exec chmod 770 {} \; || true'"
```

홈어시스턴트는 이제 GPIO 핀을 제어 할 수 있습니다.