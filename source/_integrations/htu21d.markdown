---
title: HTU21D(F) Sensor
description: Instructions on how to integrate a HTU21D Temperature and humidity sensor into Home Assistant.
logo: raspberry-pi.png
ha_category:
  - DIY
ha_release: 0.48
ha_iot_class: Local Push
---

htu21d 센서 플랫폼을 사용하면 [I2c](https://en.wikipedia.org/wiki/I²C) 버스 (SDA, SCL 핀)를 통해 연결된 [HTU21D 센서](https://cdn-shop.adafruit.com/datasheets/1899_HTU21D.pdf)에서 온도와 습도를 읽을 수 있습니다.

테스트된 장치 :

- [Raspberry Pi](https://www.raspberrypi.org/)

## 설정

설치시 HTU21D 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: htu21d
```

{% configuration %}
name:
  description: The name of the sensor.
  required: false
  default: i2c_bus
  type: string
i2c_bus:
  description: I2c bus where the sensor is.
  required: false
  default: 1 (for Raspberry Pi 2 and 3)
  type: integer
{% endconfiguration %}

## 사용자 정의 센서 데이터 

값에 친숙한 이름과 아이콘을 지정하고 `customize:` 섹션에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
customize:
  sensor.htu21d_sensor_temperature:
    icon: mdi:thermometer
    friendly_name: "Temperature"
  sensor.htu21d_sensor_humidity:
    icon: mdi:weather-rainy
    friendly_name: "Humidity"
```

그룹을 만들려면 `groups` 섹션에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
group:
  ambient_sensor:
    name: HTU21D Environment sensor
    entities:
      - sensor.htu21d_sensor_temperature
      - sensor.htu21d_sensor_humidity
```

## Raspberry Pi에 smbus 지원 설치 지침

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
20: -- -- -- 23 -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: 40 -- -- -- -- -- UU -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- 77
```

따라서 센서가 **0x40** 주소에 있음을 알 수 있습니다 (해당 라즈베리파이에는 i2c 센서가 더 있습니다).