---
title: 아두이노
description: Instructions on how to setup an Arduino boards within Home Assistant.
logo: arduino.png
ha_category:
  - DIY
  - Sensor
  - Switch
ha_release: pre 0.7
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

[Arduino](https://www.arduino.cc/) 디바이스 제품군은 주로 ATmega328 칩을 기반으로하는 마이크로 컨트롤러 보드입니다. 디지털 입력/출력 핀 (PWM출력으로 사용 가능), 아날로그 입력 및 USB 연결이 제공됩니다.

장비는 보드의 [유형](https://www.arduino.cc/en/Main/Products)에 따라 다릅니다. 가장 일반적인 것은 Arduino Uno와 Arduino Leonardo이며 14 개의 디지털 입력/출력 핀과 6개의 아날로그 입력 핀이 있습니다.

사용할 수 있는 확장 기능(소위 [shields](https://www.arduino.cc/en/Main/ArduinoShields))이 다수 있습니다. 이러한 실드는 기존 커넥터에 꽂고 서로 쌓을 수 있습니다. 이를 통해 Arduino 보드의 기능을 확장할 수 있습니다.

`arduino` 통합구성요소는 USB를 통해  어시스턴트 호스트에 직접 연결된 보드를 사용할 수 있도록 설계되었습니다.

현재 홈 어시스턴트에서 다음 장치 유형이 지원됩니다. : 

- [Sensor](#sensor)
- [Switch](#switch)

## 설정

보드에 [Firmata firmware](https://github.com/firmata/)가 있어야합니다. `StandardFirmata` 스케치를 보드에 업로드하십시오. 자세한 내용은 [Arduino documentation](https://www.arduino.cc/en/Main/Howto)를 참조하십시오.

Arduino 보드를 Home Assistant와 통합하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오. 

```yaml
# Example configuration.yaml entry
arduino:
  port: /dev/ttyACM0
```

{% configuration %}
port:
  description: 보드가 홈어시스턴트 호스트에 연결된 포트입니다. 원래 Arduino를 사용하는 경우 포트이름은 `ttyACM*` 이며 그렇지 않으면 `ttyUSB *`입니다.
  required: true
  type: string
{% endconfiguration %}

정확한 숫자는 아래 표시된 명령으로 확인할 수 있습니다.

```bash
$ ls /dev/ttyACM*
```

그래도 작동하지 않으면 `dmesg` 또는 `journalctl -f` 출력을 확인하십시오. Arduino 클론은 종종 다른 이름을 사용합니다. (예: `/dev/ttyUSB*`).

<div class='note warning'>
주의 사항 : Arduino 보드는 상태를 저장하지 않습니다. 이는 모든 초기화시 핀이 off/low으로 설정되어 있음을 의미합니다.
</div>

직렬 포트에 액세스 할 수 있도록 Home Assistant를 실행하는데 사용되는 사용자를 그룹에 추가하십시오.

```bash
$ sudo usermod -a -G dialout,lock $USER
```

## 센서

`arduino` 센서 플랫폼을 사용하면 [Arduino](https://www.arduino.cc/) 보드의 아날로그 입력 핀에서 숫자 값을 얻을 수 있습니다. 일반적으로 값은 0과 1024 사이입니다.

홈어시스턴트로 Arduino 센서를 활성화하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  platform: arduino
  pins:
    1:
      name: Door switch
    0:
      name: Brightness
```

{% configuration %}
pins:
  description: 사용할 핀 목록.
  required: true
  type: map
  keys:
    pin_number:
      description: 보드의 핀 넘버링 스키마에 해당하는 핀 번호.
      required: true
      type: map
      keys:
        name:
          description: 핀의 프론트 엔드에서 사용될 이름.
          type: string
{% endconfiguration %}

Arduino UNO의 6 개의 아날로그 핀은 A0에서 A5까지 번호가 매겨져 있습니다.

## 스위치

`arduino` 스위치 플랫폼을 사용하면 [Arduino](https://www.arduino.cc/) 보드의 디지털 핀을 제어 할 수 있습니다. 
PWM (Arduino Uno의 핀 3, 5, 6, 9, 10 및 11)은 아직 지원되지 않습니다.

홈어시스턴트로 Arduino 핀을 활성화하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오

```yaml
# Example configuration.yaml entry
switch:
  platform: arduino
  pins:
    11:
      name: Fan Office
    12:
      name: Light Desk
      initial: true
      negate: true
```

{% configuration %}
pins:
  description: 사용할 핀 목록..
  required: true
  type: map
  keys:
    pin_number:
      description: 보드의 핀 넘버링 스키마에 해당하는 핀 번호.
      required: true
      type: map
      keys:
        name:
          description: 핀의 프론트 엔드에서 사용될 이름.
          type: string
          required: false
        initial:
          description: 이 포트의 초기 값.
          type: boolean
          required: false
          default: false
        negate:
          description: 이 핀을 invert 해야하는 경우.
          type: boolean
          required: false
          default: false
{% endconfiguration %}

Arduino UNO에서 디지털 핀의 번호는 0에서 13까지입니다. 사용 가능한 핀은 2 ~ 13입니다. 테스트 목적으로 핀 13을 사용할 수 있습니다. 핀과 함께 내부 LED를 제어 할 수 있기 때문입니다.
