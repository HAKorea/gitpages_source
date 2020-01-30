---
title: 샤오미 게이트웨이(아카라)
description: Instructions for how to integrate the Xiaomi Gateway (Aqara) within Home Assistant.
logo: xiaomi.png
ha_category:
  - Hub
ha_release: 0.57
ha_iot_class: Local Push
ha_codeowners:
  - '@danielhiversen'
  - '@syssi'
---

`xiaomi_aqara` 통합구성요소는 [샤오미](https://www.mi.com/en/) 아카라 호환 기기를 홈어시스턴트와 연결하는데 사용합니다.

주의사항은 허브의 종류를 v1, v2 두가지로 구분하는데 v1은 아무 문제없이 홈어시스턴트와 통합되는데 v2는 로컬API를 활성화하는데 있어 조금 문제가 있습니다. 허브 장치를 분해하고 로컬API 활성화를 진행해야 합니다. 이에 대해 샤오미측은 수정 제안을 받는 상태입니다.

## 지원 기기

- Aqara Air Conditioning Companion (lumi.acpartner.v3)
- Aqara Intelligent Door Lock (lock.aq1)
- Aqara Wall Switch (Double)
- Aqara Wall Switch (Single)
- Aqara Wall Switch LN (Double)
- Aqara Wall Switch LN (Single)
- Aqara Wireless Switch (Double)
- Aqara Wireless Switch (Single)
- Battery
- Button 1st generation (Single, Double, Long Click)
- Button 2nd generation (Single, Double)
- Cube
- Door and Window Sensor (1세대와 2세대)
- Gas Leak Detector (reports alarm and density)
- Gateway (Light, Illumination Sensor, Ringtone play)
- Intelligent Curtain
- Motion Sensor (1세대와 2세대)
- Plug aka Socket (지그비 버전, reports power consumed, power load, state and if the device is in use)
- Smoke Detector (reports alarm and density)
- Temperature and Humidity Sensor (1세대와 2세대)
- Vibration Sensor
- Wall Plug (reports power consumed, power load, and state)
- Water Leak Sensor
- Xiaomi Mijia Gateway (lumi.gateway.v2, lumi.gateway.v3)

## 미지원 기기

- Xiaomi Aqara Gateway (lumi.gateway.aqhm01), 미홈 앱에서 dev mode를 활성화 할 수 없기 때문
- Gateway Radio
- Gateway Button
- Xiaomi Mi Air Conditioning Companion (lumi.acpartner.v2)
- Aqara Intelligent Air Conditioner Controller Hub (lumi.acpartner.v1)
- Decoupled mode of the Aqara Wall Switches (Single & Double)
- Gas와 Smoke Detector 에서 추가적인 알람이벤트: I2C 통신 실패로 Analog alarm, battery fault alarm (smoke detector only), sensitivity fault alarm 사용 못함

## 설치

스마트폰의 미홈 앱에서 설정 과정을 진행하세요. [이 튜토리얼](https://www.domoticz.com/wiki/Xiaomi_Gateway_(Aqara)#Adding_the_Xiaomi_Gateway_to_Domoticz)을 따라서 앱 안에 저장된 키(비밀번호)를 추출합니다.


{{ page.title }}를 사용하기 위해  `configuration.yaml` 파일에 아래와 같이 입력합니다:

### 게이트웨이가 1개인 경우

```yaml
# You can leave MAC empty if you only have one gateway.
xiaomi_aqara:
  discovery_retry: 5
  gateways:
    - key: xxxxxxxxxxxxxxxx
```

### 게이트웨이가 여러개인 경우

```yaml
# 12 characters MAC can be obtained from the gateway.
xiaomi_aqara:
  gateways:
    - mac: xxxxxxxxxxxx
      key: xxxxxxxxxxxxxxxx
    - mac: xxxxxxxxxxxx
      key: xxxxxxxxxxxxxxxx
```

### 특정 인터페이스의 게이트웨이를 지정하는 경우

```yaml
# 12 characters MAC can be obtained from the gateway.
xiaomi_aqara:
  interface: '192.168.0.1'
  gateways:
    - mac: xxxxxxxxxxxx
      key: xxxxxxxxxxxxxxxx
```

{% configuration %}
gateways:
  description: 게이트웨이 목록을 작성
  required: true
  type: map
  keys:
    mac:
      description: 게이트웨이의 MAC 어드레스. MAC 어드레스를 표현할 때 사용하는 ":"를 삭제하고 붙여씁니다. **하나의 게이트웨이만 사용한다면 입력하지 않아도 됩니다**
      required: false
      type: string
    key:
      description: 게이트웨이의 키 값. **sensors and/or binary sensors 라면 입력하지 않아도 됩니다**
      required: false
      type: string
    host:
      description: 게이트웨이의 이름 또는 IP주소. If this parameter is used the multicast discovery of the gateway is skipped.
      required: false
      type: string
    disable:
      description: 게이트웨이 사용 안함. 특정 게이트웨이를 연동하고 싶지 않을때 사용합니다.
      required: false
      type: boolean
      default: false
discovery_retry:
  description: 홈어시스턴트가 게이트웨이를 재탐색 하는 횟수
  required: false
  type: integer
  default: 3
interface:
  description: 특정 네트워크 인터페이스를 지정
  required: false
  type: string
  default: any
{% endconfiguration %}

### 서비스

게이트웨이는 다음과 같은 서비스를 제공합니다:

#### `xiaomi_aqara.play_ringtone` 서비스

특정 벨소리를 플레이. 게이트웨이 버전 `1.4.1_145` 이상에서 가능. 아래 적용 예시를 살펴보세요.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `gw_mac`                  |       no | 샤오미 아카라 게이트웨이의 MAC 어드레스       |
| `ringtone_id`             |       no | 원하는 벨소리 id                      |
| `ringtone_vol`            |      yes | 볼륨 크기(%값)                                 |

벨소리의`ringtone_id` 값은 다음과 같습니다:

- Alarms
  - 0 - Police car 1
  - 1 - Police car 2
  - 2 - Accident
  - 3 - Countdown
  - 4 - Ghost
  - 5 - Sniper rifle
  - 6 - Battle
  - 7 - Air raid
  - 8 - Bark
- Doorbells
  - 10 - Doorbell
  - 11 - Knock at a door
  - 12 - Amuse
  - 13 - Alarm clock
- Alarm clock
  - 20 - MiMix
  - 21 - Enthusiastic
  - 22 - GuitarClassic
  - 23 - IceWorldPiano
  - 24 - LeisureTime
  - 25 - ChildHood
  - 26 - MorningStreamLiet
  - 27 - MusicBox
  - 28 - Orange
  - 29 - Thinker
- 커스텀 벨소리(미홈 앱에서 업로드 가능)는 10001부터 시작합니다.

#### `xiaomi_aqara.stop_ringtone` 서비스

벨소리의 재생을 중지합니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `gw_mac`                  |       no |  샤오미 아카라 게이트웨이의 MAC 어드레스               |

#### `xiaomi_aqara.add_device` 서비스

샤오마 아카라 게이트웨이에 기기를 연결하도록 30초간 실행됩니다. 서비스 실행 후 새로운 기기에서 페이링 버튼을 눌러주면 게이트웨이에 추가할 수 있습니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `gw_mac`                  |       no | 샤오미 아카라 게이트웨이의 MAC 어드레스        |

#### `xiaomi_aqara.remove_device` 서비스

특정 기기를 제거. 사용중인 기기를 다른 게이트웨이에 추가하려면 제거 서비스를 실행해야 합니다.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `gw_mac`                  |       no | 샤오미 아카라 게이트웨이의 MAC 어드레스               |
| `device_id`               |       no | 제거할 기기의 하드웨어 주소            |

## 사용예제

### 1세대 스마트 버튼의 롱프레스

버튼을 긴시간 누르면 개짖는 소리를 재생하고 다시 짧게 누르면 재생을 멈추는 예제입니다. 1세대 둥근 스마트 버튼에만 적용 가능합니다.

**주의: 재생중인 사운드는 재생이 끝나면 자동으로 종료됩니다.**

```yaml
- alias: Let a dog bark on long press
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.switch_158d000xxxxxc2
      click_type: long_click_press
  action:
    service: xiaomi_aqara.play_ringtone
    data:
      gw_mac: xxxxxxxxxxxx
      ringtone_id: 8
      ringtone_vol: 8

- alias: Stop barking immediately on single click
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.switch_158d000xxxxxc2
      click_type: single
  action:
    service: xiaomi_aqara.stop_ringtone
    data:
      gw_mac: xxxxxxxxxxxx
```

### 스마트 버튼을 더블 클릭

버튼을 더블 클릭하면 룸 램프의 상태를 변경(토글)하는 예제입니다.

```yaml
- alias: Double Click to toggle living room lamp
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.switch_158d000xxxxxc2
      click_type: double
  action:
    service: light.toggle
    data:
      entity_id: light.living_room_lamp
```

## 문제 해결

### 게이트웨이 초기화 문제

게이트웨이를 미홈앱에서 초기화할 때 문제가 있다면 다른 스마트폰에서 미홈 앱을 실행해보세요. 예를 들어 OnePlus 3 스마트폰에서는 안되고 Nexus 5에서는 동작할 수 있습니다.

### 연결 불량

```bash
2017-08-20 16:51:19 ERROR (SyncWorker_0) [homeassistant.components.xiaomi] No gateway discovered
2017-08-20 16:51:20 ERROR (MainThread) [homeassistant.setup] Setup failed for xiaomi: Component failed to initialize.
```

위 내용은 홈어시스턴트가 샤오미 게이트웨이와 연결하지 못했다는 뜻힙니다. 내부 네트워크나 방화벽 문제일 수 있습니다.

- [enabled LAN access](https://www.domoticz.com/wiki/Xiaomi_Gateway_(Aqara)#Adding_the_Xiaomi_Gateway_to_Domoticz)를 확인합니다.
- 홈어시스턴트가 동작하는 네트워크의 방화벽을 해제합니다.
- 샤오미 게이트웨이는 multicast가 필요합니다. 공유기가 멀티캐스트를 지원하는지 확인하세요.
- MAC 어드레스 입력란 `mac:` 을 공백으로 설정해봅니다.
- 재탐색 횟수를 10회로 늘려봅니다. `discovery_retry: 10`
- LAN access 설정을 껐다가 켜봅니다.
- 게이트웨이를 하드 리셋해봅니다. 게이트웨이의 버튼을 30초간 계속 누르면 하드 리셋 시킬 수 있습니다.
- [도커](/docs/installation/docker/)로 홈어시스턴트를 구동중이라면 run 옵션으로 `--net=host`를 적용했는지 확인
- 게이트웨이 라이트를 제어할때 로그에 `{"error":"Invalid key"}` 가 찍힌다면:
  - 안드로이드 폰이나 [bluestacks](https://www.bluestacks.com)과 같은 에뮬레이터로 키를 다시 생성해야 합니다. iOS에서 생성한 키는 제대로 동작하지 않는 문제가 알려져있습니다.
  - 네트워크에 멀티캐스트가 적용되어 있는지 확인하세요. 만일 버추얼 머신에서(Proxmox같은) 홈어시스턴트를 실행중이라면 호스트에서 `echo 0 >/sys/class/net/vmbr0/bridge/multicast_snooping` 명령을 실행하고 홈어시스턴트를 재실행하거나 호스트를 리부팅합니다.
- 필수 라이브러리인 "PyXiaomiGateway"을 설치할 수 없다면 몇몇 의존 라이브러리를 확인해야 합니다. `python3-dev`, `libssl-dev`, `libffi-dev` 을 수동으로 설치하세요. (예:`$ sudo apt-get install python3-dev libssl-dev libffi-dev`).
- 게이트웨이의 MAC 어드레스가 `04:CF:8C` 또는 `7C:49:EB`로 시작하면 게이트웨이에서 `9898` 포트가 막혔을 수 있습니다. (이것은 Nmap 명령어로 확인해볼 수 있습니다. `sudo nmap -sU {gateway_ip} -p 9898`을 실행해보세요). 이것을 해결하기 위해서 다음 절차를 따라합니다:
  - 게이트웨이 케이스를 열어볼 적절한 드라이버를 준비합니다(없다면 포크를 준비하세요)
  - RX, TX, GND 접점을 납땜합니다. [실행 예제](https://cs5-3.4pda.to/14176168/IMG_20181020_201150.jpg).  
  - 게이트웨이 내부와 연결할 USB-UART cable/module을 구해서 컴퓨터에 연결합니다.
  - 게이트웨이의 전원을 켭니다(220V).
  - 시리얼 터미널 프로그램을 실행합니다(PuTTY 같은). USB-UART module이 연결된 시리얼 포트를 터미널 프로그램으로 접속합니다(baudrate: 115200).
  - 게이트웨이가 부팅되면 RX, TX, GND에 납땜한 전선을 UART module에 연결합니다. **절대로 Vcc를 연결하면 안됩니다!**
  - 터미널 프로그램에 게이트웨이가 보내는 메시지가 출력됩니다.
  - `psm-set network open_pf 3` 명령어를 전송합니다 (명령어는 `CR` newline character로 끝나야 합니다).
  - `psm-get network open_pf` 명령을 전송하여 OK가 표시되는지 확인합니다.
  - 게이트웨이를 끄고 다시 켭니다.
