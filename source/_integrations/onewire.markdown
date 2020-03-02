---
title: 1-와이어
description: Instructions on how to integrate One wire (1-wire) sensors into Home Assistant.
logo: onewire.png
ha_category:
  - DIY
ha_release: 0.12
ha_iot_class: Local Polling
ha_codeowners:
  - '@garbled1'
---

`onewire` 플랫폼은 통신을 위해 One wire (1-wire) 버스를 사용하는 센서를 지원합니다.

지원되는 장치 :

- [DS18B20](https://datasheets.maximintegrated.com/en/ds/DS18B20.pdf)
- [DS18S20](https://www.maximintegrated.com/en/products/sensors/DS18S20.html)
- [DS1822](https://datasheets.maximintegrated.com/en/ds/DS1822.pdf)
- [DS1825](https://datasheets.maximintegrated.com/en/ds/DS1825.pdf)
- [DS28EA00](https://datasheets.maximintegrated.com/en/ds/DS28EA00.pdf) 온도 센서
- [DS2406/TAI-8570](https://datasheets.maximintegrated.com/en/ds/DS2406.pdf) AAG에서 제조한 온도 및 압력 센서
- [DS2438/B1-R1-A](https://datasheets.maximintegrated.com/en/ds/DS2438.pdf) AAG에서 제조한 온도, 압력 및 습도 센서

1-Wire 버스는 Raspberry Pi의 IO 핀에 직접 연결하거나 전용 인터페이스 어댑터를 사용하여 연결할 수 있습니다 (예: [DS9490R](https://datasheets.maximintegrated.com/en/ds/DS9490-DS9490R.pdf)).

## 라즈베리파이 셋업

Raspberry Pi에서 1-Wire 지원을 설정하려면 [this documentation](https://www.waveshare.com/wiki/Raspberry_Pi_Tutorial_Series:_1-Wire_DS18B20_Sensor#Enable_1-Wire)에 따라 `/ boot / config.txt`를 편집해야합니다.
Hass.io에서 `/boot/config.txt`를 편집하려면 [this documentation](https://developers.home-assistant.io/docs/en/hassio_debugging.html)를 사용하여 SSH를 활성화하고 `vi`를 통해 `/mnt/boot/config.txt`를 편집하십시오.

## 인터페이스 어댑터 셋업

### owfs

인터페이스 어댑터를 사용하면 [owfs 1-Wire file system](https://owfs.org/)을 통해 Linux 호스트에서 센서에 액세스할 수 있습니다. 인터페이스 어댑터와 owfs를 사용할 때 `mount_dir` 옵션은 owfs 장치 트리가 마운트 된 디렉토리에 해당하도록 설정되어야합니다.


### owserver

인터페이스 어댑터를 사용하면 owserver를 실행중인 원격 또는 로컬 Linux 호스트의 센서에 액세스 할 수도 있습니다. owserver는 기본적으로 포트 4304에서 실행됩니다. `host` 옵션을 사용하여 원격 서버의 호스트 또는 IP를 지정하고 선택적인 `port` 옵션을 사용하여 포트를 기본값에서 변경하십시오.

### 여러 센서가있는 장치(unit)

이 플랫폼은 여러 센서가있는 장치와 함께 작동하여 기록된 값의 불연속성을 유발합니다. 기존 장치는 새 ID를 수신하므로 새 장치로 표시됩니다. 연속성을 유지하려면 기존 장치의 이름을 새 이름으로 바꾸어 데이터베이스에서 해결할 수 있습니다.

[Database section](/docs/backend/database/)의 지침을 사용하여 데이터베이스에 연결. 센서 이름을 확인하십시오.

```sql
SELECT entity_id, COUNT(*) as count FROM states GROUP BY entity_id ORDER BY count DESC LIMIT 10;
```
다음 예를 사용하여 센서 이름을 변경하십시오.

```sql
UPDATE states SET entity_id='sensor.<sensor_name>_temperature' WHERE entity_id LIKE 'sensor.<sensor_name>%' AND attributes LIKE '%\u00b0C%';
UPDATE states SET entity_id='sensor.<sensor_name>_pressure' WHERE entity_id LIKE 'sensor.<sensor_name>%' AND attributes LIKE '%mb%';
UPDATE states SET entity_id='sensor.<sensor_name>_humidity' WHERE entity_id LIKE 'sensor.<sensor_name>%' AND attributes LIKE '%%%' ESCAPE '';
```

`SELECT` 쿼리에서 볼 수 있듯이 `<sensor_name>`을 센서의 실제 이름으로 바꿔야합니다.

## 설정

하나의 와이어 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: onewire
```

{% configuration %}
names:
  description: 센서의 ID와 친숙한 이름.
  required: false
  type: string
mount_dir:
  description: owfs 드라이버가 사용된 경우 장치 트리(device tree)의 위치
  required: false
  type: string
host:
  description: owserver를 실행하는 원격 또는 로컬 호스트
  required: false
  type: string
port:
  description: "The port number of the owserver (requires `host`). owserver의 포트 번호. (`host` 필수) " 
  required: false
  type: integer
  default: 4304
{% endconfiguration %}

### 설정 사례

`onewire`가 Home Assistant에 추가되면 센서의 ID를 생성합니다. 이름 설정 옵션으로 센서의 이름을 지정할 수 있습니다.

```yaml
# Named sensor configuration.yaml entry
sensor:
  - platform: onewire
    names:
      GENERATED_ID: FRIENDLY_NAME
```
