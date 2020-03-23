---
title: 다이슨 (Dyson)
logo: dyson.png
ha_category:
  - Hub
  - Climate
  - Fan
  - Sensor
  - Vacuum
ha_iot_class: Cloud Polling
ha_release: 0.47
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/8HT_W28OzaY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`dyson` 통합구성요소는 모든 [Dyson](https://www.dyson.com) 관련 플랫폼을 연동하기위한 주요 통합구성요소입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Climate
- Fan
- Sensor
- Vacuum
- Air Quality

## 설정

이 컴포넌트를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
dyson:
  username: YOUR_DYSON_USERNAME
  password: YOUR_DYSON_PASSWORD
  language: YOUR_DYSON_ACCOUNT_LANGUAGE
  devices:
    - device_id: DEVICE_ID_1 # e.g., Serial number: XXX-XX-XXXXXXXX
      device_ip: DEVICE_IP_1
    - device_id: DEVICE_ID_2
      device_ip: DEVICE_IP_2
```

{% configuration %}
username:
  description: 다이슨 계정 사용자 이름 (이메일 주소).
  required: true
  type: string
password:
  description: 다이슨 계정 비밀번호.
  required: true
  type: string
language:
  description: "다이슨 계정 언어 국가 코드. 국가 코드 :`FR`,`NL`,`GB`,`AU`. 다른 코드도 지원합니다."
  required: true
  type: string
devices:
  description: 장치 목록.
  required:  false
  type: map
  keys:
    device_id:
      description: 장치 아이디. 장치의 일련 번호. 스마트 폰 앱 장치 설정 페이지에서 찾을 수 있습니다.
      required: true
      type: string
    device_ip:
      description: 장치 IP 주소
      required: true
      type: string
{% endconfiguration %}

`devices` 목록은 선택사항이지만 검색이 작동하지 않을 경우 제공해야합니다. (로그의 경고 및 Home Assistant 웹 인터페이스에서 장치를 사용할 수 없음).

<div class='note warning'>

로봇 청소기 모델 (Dyson 360 Eye)에서는 아직 검색이 지원되지 않습니다. 이 장치들에 대해서는 `devices` 목록에 제공해야합니다.


</div>

장치 IP 주소를 찾으려면 라우터 또는 `nmap`을 사용할 수 있습니다. : 

```bash
$ nmap -p 1883 XXX.XXX.XXX.XXX/YY --open
```

결과 :

- **XXX.XXX.XXX.XXX** 는 네트워크 주소입니다
- **YY** 는 네트워크 마스크입니다

예시 :

```bash
$ nmap -p 1883 192.168.0.0/24 --open
```

## vacumm 

`dyson` vacumm 플랫폼을 사용하면 Dyson 360 Eye 로봇청소기를 제어할 수 있습니다.

### Component 서비스 

이 연동은 다음 서비스를 지원합니다 ([Vacuum Cleaner Robots](/integrations/vacuum/) 참조).

- [`turn_on`](/integrations/vacuum/#service-vacuumturn_on)
- [`turn_off`](/integrations/vacuum/#service-vacuumturn_off)
- [`start_pause`](/integrations/vacuum/#service-vacuumstart_pause)
- [`stop`](/integrations/vacuum/#service-vacuumstop)
- [`return_to_home`](/integrations/vacuum/#service-vacuumreturn_to_home)
- [`set_fan_speed`](/integrations/vacuum/#service-vacuumset_fanspeed). 팬 속도 값 :
  - `Quiet`
  - `Max`

## Climate 

`dyson` Climate 플랫폼을 사용하면 Dyson Pure Hot+Cool Fan thermal를 제어할 수 있습니다. 팬(fan) 기능을 제어하려면 이 페이지의 Dyson 팬 부분을 참조하십시오.

### Component 서비스

이 연동은 다음 서비스를 지원합니다 ([Climate](/integrations/climate/) 참고):

- [`turn_on`](/integrations/climate/#service-climateturn_on)
- [`turn_off`](/integrations/climate/#service-climateturn_off)
- [`set_temperature`](/integrations/climate/#service-climateset_temperature)
- [`set_fan_mode`](/integrations/climate/#service-climateset_fan_mode)
- [`set_hvac_mode`](/integrations/climate/#service-climateset_hvac_mode)

## Fan

`dyson` 팬 플랫폼을 사용하면 Dyson Purifier 팬을 제어 할 수 있습니다.

### 지원되는 팬 장치

- Pure Cool link (desk and tower)
- Pure Hot+cool link (see climate part) for thermal control
- Pure Cool 2018 (DP04 and TP04)

### 속성

자동화 및 템플릿에 사용할 수있는 몇 가지 속성이 있습니다.

| Attribute | Description |
| --------- | ----------- |
| `night_mode` | 팬 장치의 야간 모드가 켜져 있는지 여부를 나타내는 boolean.|
| `auto_mode` | 팬 장치의 자동 모드가 켜져 있는지 여부를 나타내는 boolean.|
| `angle_low` | 낮은 진동 각도를 나타내는 Int (5와 355 사이)입니다 (DP04 및 TP04에만 해당).|
| `angle_high` | 높은 진동 각도를 나타내는 Int (5와 355 사이)입니다 (DP04 및 TP04에만 해당).|
| `flow_direction_front` | 정면 흐름 방향이 활성화되어 있는지 여부를 나타내는 boolean (DP04 및 TP04에만 해당).|
| `timer` | 자동 전원 끄기 타이머의 상태를 나타내는 속성은 'OFF' 또는 종료까지 남은 시간을 분 단위로 나타내는 정수(DP04 및 TP04 만 해당)일 수 있습니다.|
| `hepa filter` |  팬의 HEPA 필터 상태 (%) (DP04 및 TP04에만 해당).|
| `carbon filter` | 팬의 카본 필터 상태 (%) (DP04 및 TP04에만 해당).|

## 센서

`dyson` 센서 플랫폼은 온도 및 습도 센서를 제공합니다.

## Air Quality

`dyson` Air Quality 플랫폼은 다음과 같은 Level을 제공합니다.

- Particulate matter 2.5 (<= 2.5 μm) level.
- Particulate matter 10 (<= 10 μm) level.
- Air Quality Index (AQI).
- NO2 (이산화질소) level.
- VOC (휘발성 유기 화합물) level.

참고: 현재 2018 년 다이슨 팬만 지원됩니다 (TP04 및 DP04).

### 지원되는 팬 장치

- Pure Cool link (desk and tower)
- Pure Hot+cool link (see climate part) for thermal control
- Pure Cool 2018 Models (TP04 and DP04)
- Pure Cool Cryptomic (TP06)
