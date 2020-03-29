---
title: 거리측정센서(Time of Flight)
description: Instructions on how to integrate a VL53L1X ToF sensor into Home Assistant.
logo: raspberry-pi.png
ha_category:
  - DIY
  - Sensor
ha_release: '0.90'
ha_iot_class: Local Polling
---

Time of Flight 센서는 보이지 않는 레이저를 사용하여 밀리미터 해상도로 거리를 측정합니다. 

테스트된 장치 :

- [Raspberry Pi](https://www.raspberrypi.org/)
- [VL53L1X](https://www.st.com/en/imaging-and-photonics-solutions/vl53l1x.html)
- [Schematic](https://cdn.sparkfun.com/assets/3/5/c/e/2/Qwiic_Distance_Sensor_-_VL53L1X.pdf)

## 설정

VL53L1X 센서를 사용하려면 `configuration.yaml`에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: tof
```

{% configuration %}
name:
  description: Name of the sensor.
  required: false
  default: VL53L1X
  type: string
i2c_bus:
  description: I2c bus used.
  required: false
  default: 1, for Raspberry Pi 2 and 3.
  type: integer
i2c_address:
  description: I2c address of the sensor.
  required: false
  default: "0x29"
  type: string
xshut:
  description: GPIO port used to reset device.
  required: false
  default: 16
  type: integer
{% endconfiguration %}

## 사례

거리는 VL53L1X 사양에 따라 밀리미터 단위로 측정됩니다.

```yaml
# Example of customized configuration.yaml entry
sensor:
  - platform: tof
    name: ToF sensor
    i2c_address: 0x29
    xshut: 16
```
여러 장치가 연결되어 있고 RPI의 GPIO 포트가 재설정에 사용됩니다. 초기화시 XSHUT 신호가 펄스 LOW로 생성된 후 항상 HIGH로 유지됩니다. 이 버전은 VL53L1X 장거리 모드를 사용하며 최대 4 미터에 이를 수 있습니다.

## Raspberry Pi에 i2c 설치 지침

Raspberry Pi 설정 유틸리티를 사용하여 I2c 인터페이스를 활성화하십시오.

```bash
# pi user environment: Enable i2c interface
$ sudo raspi-config
```

Select `Interfacing options->I2C` choose `<Yes>` and hit `Enter`, then go to `Finish` and you'll be prompted to reboot.

Install dependencies for use the `smbus-cffi` module and enable your _homeassistant_ user to join the _i2c_ group:

```bash
# pi user environment: Install i2c dependencies and utilities
$ sudo apt-get install build-essential libi2c-dev i2c-tools python-dev libffi-dev

# pi user environment: Add homeassistant user to the i2c group
$ sudo addgroup homeassistant i2c

# pi user environment: Reboot Raspberry Pi to apply changes
$ sudo reboot
```

### 센서의 i2c 주소 확인

`i2c-tools`를 설치한 후, 연결된 센서의 주소를 스캔할 수 있는 새로운 유틸리티가 제공됩니다 :

```bash
$ /usr/sbin/i2cdetect -y 1
```

It will output a table like this:

```text
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- 23 -- -- -- -- -- 29 -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: 40 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
```

따라서 찾고있는 센서 주소가 **0x29**임을 알 수 있습니다 (이 라즈베리 파이에는 i2c 센서가 더 있습니다).