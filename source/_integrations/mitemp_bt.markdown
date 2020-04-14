---
title: 샤오미 미시아 온습도 센서
description: MiTemp BLE 온습도 센서를 Home Assistant와 통합하는 방법.
logo: xiaomi.png
ha_category:
  - DIY
ha_release: 0.69
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/RtJpx8BZvMw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

**참고** : 본 통합구성요소 이외에 샤오미 블루투스 센서 **전제품군**을 추가할 수 있는 [커스텀 컴포넌트](https://cafe.naver.com/koreassistant/1117)를 참조하십시오. 최근에 출시한 LYWSD03MMC와 같은 제품과 같은 경우 암호키를 별도로 찾아서 설정해주셔야 합니다. [여기](https://www.kapiba.ru/2017/11/mi-home.html)서 과거 Mi-Home 앱을 다운받으신 뒤 휴대폰의 `/your_interlal_storage/vevs/logs/pairings.txt`에서 key 값을 찾아 설정해주셔야 합니다. 

The `mitemp_bt` 센서 플랫폼은 모니터 온습도를 실시간으로 측정할 수 있습니다.  [LCD 내장 Xiaomi Mijia BLE 온습도 센서](https://www.amazon.com/Temperature-Humidity-Xiaomi-Bluetooth-Screen-Remote/dp/B079L6N6PC) 는 실내 온습도를 측정하는 소형 초저전력 블루투스 장치입니다. 

## 설치

실행중인 운영 체제에 따라 시스템에서 다음과 같은 여러상황에 맞는 Bluetooth 설정을 해야합니다.:

- [홈어시스턴트](/hassio/installation/): `mitemp_bt` 설치한 시스템이 블루투스를 지원한다면 즉시 사용 가능합니다. (블루투스를 지원하는 라즈베리파이의 경우 바로 사용가능).
- [홈어시스턴트 코어 on Docker](/docs/installation/docker/): `--net=host` 명령을 이용하여 시스템에 적절한 블루투스 설정을 할 수 있습니다.
- 그외 리눅스 시스템:
  - 기본 솔루션: `bluepy` 및 `btlewrap` 라이브러리를 pip 명령으로 설치하십시오. 가상 환경을 사용하는 경우 그에 맞는 라이브러리 설치를 해야합니다.
  - 대체 솔루션: pip 명령으로 `btlewrap` 라이브러리를 설치하고 Package 관리 명령으로 `gatttool` 를 설치합니다. 배포판에 따라 패키지 이름은 `bluez`, `bluetooth` 혹은 `bluez-deprecated`일 수 있습니다.
- Windows 및 MacOS는 현재 `btlewrap` 라이브러리를 지원하지 않습니다. 

## 설정

스캔 명령으로 센서의 MAC 주소를 파악하십시오.:

```bash
$ sudo hcitool lescan
LE Scan ...
4C:65:A8:D2:31:7F MJ_HT_V1
[...]
```

배포판이 bluetoothctl을 지원할 경우:

```bash
$ bluetoothctl
[bluetooth]# scan on
Discovery started
[CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
[NEW] Device 4C:65:A8:D2:31:7F MJ_HT_V1
```

찾은 센서가 `MJ_HT_V1` 혹은 유사 제품인지 확인하십시오. 

설치시 Mi 온습도 센서를 사용하려면,  `configuration.yaml` 파일에 다음 내용을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: mitemp_bt
    mac: 'xx:xx:xx:xx:xx:xx'
    monitored_conditions:
      - temperature
```

{% configuration %}
mac:
  description: 센서의 MAC 주소.
  required: true
  type: string
monitored_conditions:
  description: 측정하고자 하는 파라미터.
  required: false
  default: [temperature, humidity, battery]
  type: list
  keys:
    temperature:
      description: 해당 위치의 온도 (C).
    humidity:
      description: 해당 위치의 습도 (%).
    battery:
      description: 배터리 잔량 (%).
name:
  description: 프론트엔드에 나타나는 장치 이름.
  required: false
  type: string
force_update:
  description: 값이 변경되지 않았더라도 값을 강제적으로 보내는 옵션.
  required: false
  default: false
  type: boolean
median:
  description: "때로는 센서 측정에 튀는 값이 표시됩니다. 이 매개 변수를 사용하면, 출력값은 마지막 3 개 (더 큰 값을 사용할 수도 있음) 측정의 평균값을 출력합니다. 튀는 값을 걸러냅니다. Median: 5 라고 설정시 튀는 값이 2번 반복되어도 걸러냅니다. 튀는 값의 문제가 없다면, `median: 1` 로 설정해도 정상 동작합니다."
  required: false
  default: 3
  type: integer
timeout:
  description: 측정치 출력시 제한 시간을 몇 초 단위로 할지 정하는 옵션.
  required: false
  default: 10
  type: integer
retries:
  description: 측정치 출력시 재시도 횟수를 정하는 옵션.
  required: false
  default: 2
  type: integer
cache_value:
  description: 캐시 만기 기간을 초 단위로 정하는 옵션.
  required: false
  default: 300
  type: integer
adapter:
  description: "사용할 Bluetooth 어댑터 종류를 정하는 옵션. `hciconfig`를 사용하여 어뎁터의 종류를 확인해 보십시오."
  required: false
  default: hci0
  type: string
{% endconfiguration %}

기본적으로 센서는 5 분마다 한 번 씩만 반영됩니다. 이는 `median: 3` 설정시 홈 어시스턴트가 다시 시작된 후 센서가 값을 나타내기까지 15 분 이상 소요됨을 의미합니다. 하드웨어가 1 초마다 새로운 값을 제공 할 수 있지만 실내 온도는 빠르게 변하지 않습니다. 반영값의 간격을 줄여버리면 배터리 수명에 부정적인 영향을 미칩니다.

## 전체 적용 사례

전체적으로 모든 것을 설정한 구성 사례는 다음과 같습니다.:

```yaml
# Example configuration.yaml entry
sensor:
  - platform: mitemp_bt
    mac: 'xx:xx:xx:xx:xx:xx'
    name: Kids Room Temp
    force_update: true
    median: 1
    monitored_conditions:
      - temperature
      - humidity
      - battery
```
