---
title: HDMI 원격조정(HDMI-CEC)
description: Instructions on how to interact with HDMI-CEC via Home Assistant.
ha_category:
  - Automation
logo: hdmi.png
ha_release: 0.23
ha_iot_class: Local Push
---

`hdmi_cec` 통합구성요소는 원하는 장치를 선택하고 모든 장치의 전원을 켜고 모든 장치를 대기로 설정하고 HDMI 장치의 스위치 엔티티를 생성할 수 있는 서비스를 제공합니다. 장치는 HDMI 포트 번호와 장치 이름을 연결하여 설정 파일에 정의됩니다. 사운드바 및 AVR과 같은 추가 HDMI 포트를 제공하는 연결된 장치도 지원됩니다. CEC 지원 Home Assistant 장치의 관점에서 장치가 나열됩니다. CEC 지원 여부에 관계없이 연결된 모든 장치를 나열할 수 있습니다. 장치의 HDMI 포트 번호가 CEC 실제 주소를 올바르게 매핑하는 것이 이상적입니다. 그렇지 않으면 `cec-client`(`libcec`패키지의 일부)를 사용하여 CEC 버스의 트래픽을 듣고 올바른 번호를 찾으십시오.

## CEC 셋업

### Adapter

Home Assistant를 실행하는 컴퓨터는 CEC를 지원해야하며 물론 CEC를 지원하는 장치에 HDMI를 통해 연결해야합니다. 필요한 경우 [USB CEC adapter](https://www.pulse-eight.com/p/104/usb-hdmi-cec-adapter)를 구입하여 지원을 추가 할 수 있습니다. 모든 Raspberry Pi 모델은 기본적으로 CEC를 지원합니다.

### libcec

이 통합구성요소가 작동하려면 [libcec](https://github.com/Pulse-Eight/libcec)가 설치되어 있어야합니다. 링크에 제공된 환경에 맞는 설치 지침을 따르십시오. `libcec`는 기본적으로 파이썬 3 바인딩을 시스템 파이썬 모듈로 설치합니다. [Python virtual environment](/docs/installation/virtualenv/)에서 Home Assistant를 실행중인 경우 시스템 모듈을 심볼릭 링크로 연결하거나 `--system-site-packages` 플래그를 사용하여 시스템 모듈에 액세스할 수 있는지 확인하십시오.

<div class='note'>

[Hass.io](/hassio/)를 사용하는 경우 모든 요구 사항이 이미 충족되었으므로 설정으로 이동하십시오.

</div>

#### 가상 환경으로의 심볼릭 링크

_cec.so 파일을 포함하여 `cec` 설치에 대한 심볼릭 링크를 만듭니다. 설치 방법이 다르면 cec의 위치가 다를 수 있습니다.

```bash
ln -s /path/to/your/installation/of/cec.py /path/to/your/venv/lib/python*/site-packages
ln -s /path/to/your/installation/of/_cec.so /path/to/your/venv/lib/python*/site-packages

```

##### 심볼릭 링크 예 :

[Manual install for Raspberry Pi](/docs/installation/raspberry-pi/) 기본 가상 환경에서 명령은 다음과 같습니다.

```bash
ln -s /usr/local/lib/python*/dist-packages/cec.py /srv/homeassistant/lib/python*/site-packages
ln -s /usr/local/lib/python*/dist-packages/_cec.so /srv/homeassistant/lib/python*/site-packages
```

<div class='note'>

`hdmi_cec:`를 심볼릭 링크하고 설정에 추가한 후 로그에 다음과 같은 오류가 발생합니다, `* failed to open vchiq instance` 이럴 경우 Home Assistant가 실행하는 사용자 계정을 `video` Group에 추가해야합니다. Home Assistant 사용자 계정을 `video` 그룹에 추가하려면 다음 명령을 실행하십시오. `$ usermod -a -G video <hass_user_account>`

</div>

## 설치 테스트

*  라즈베리파이에 로그인

```bash
ssh pi@your_raspberry_pi_ip
```

*  command line에서 :

```bash
echo scan | cec-client -s -d 1
```
Note: 이 명령을 사용하려면 cec-utils 패키지를 설치해야합니다. 데비안 기반의 경우 : ``sudo apt install cec-utils''``

*   버스에 있는 장치 목록을 제공합니다. 

```bash
opening a connection to the CEC adapter...
requesting CEC bus information ...
CEC bus information
===================
device #4: Playback 1
address:       3.0.0.0
active source: no
vendor:        Sony
osd string:    BD
CEC version:   1.4
power status:  on
language:      ???
```

<div class='note'>

`address:` 항목은 홈어시스턴트를 설정하는데 사용되며 이 주소는 아래 3: BlueRay player 로 표시됩니다.

</div>

## 설정 사례

다음 예에서 Home Assistant를 실행하는 Pi Zero는 TV의 HDMI 포트 1에 있습니다. HDMI 포트 2는 AV수신기에 연결되어 있습니다. 3개의 장치가 HDMI 포트 1-3의 AV 수신기에 연결되어 있습니다.

장치의 실제 주소에 직접 매핑 이름을 사용할 수 있습니다 

```yaml
hdmi_cec:
  devices:
    TV: 0.0.0.0
    Pi Zero: 1.0.0.0
    Fire TV Stick: 2.1.0.0
    Chromecast: 2.2.0.0
    Another Device: 2.3.0.0
    BlueRay player: 3.0.0.0
```

또는 포트 매핑 트리:

```yaml
hdmi_cec:
  devices:
    1: Pi Zero
    2:
      1: Fire TV Stick
      2: Chromecast
      3: Another Device
    3: BlueRay player
```

하나의 스키마만 선택하십시오. 두 가지 접근법을 혼합하는 것은 불가능합니다.

config에서 사용할 수 있는 또 다른 옵션 `platform`은 HDMI 장치의 기본 플랫폼을 지정하는 것입니다. "switch" 및 "media_player"가 지원됩니다. 스위치가 기본값입니다.

```yaml
hdmi_cec:
  platform: media_player
```

그런 다음 사용자 정의에서 장치에 대한 개별 플랫폼을 설정하십시오. :

```yaml
hdmi_cec:
  types:
    hdmi_cec.hdmi_5: media_player
```

그리고 마지막 옵션은 `host`입니다. PyCEC는 TCP를 통한 CEC 명령 브리징을 지원합니다. HDMI 포트(python -m pycec)가 있는 컴퓨터에서 pyCEC를 시작하면 다른 컴퓨터에서 홈어시스턴트를 실행하고 TCP를 통해 CEC에 연결할 수 있습니다. pyCEC 서버의 TCP 주소를 지정하십시오 :

```yaml
hdmi_cec:
  host: 192.168.1.3
```


## 서비스

### 장치 선택

설정에서 장치 이름으로 혹은 entity_id 혹은 물리적 주소에서 `hdmi_cec.select_device` 서비스를 호출하여 선택하십시오. 예를 들면 다음과 같습니다. : 

```json
{"device": "Chromecast"}
```

```json
{"device": "switch.hdmi_3"}
```

```json
{"device": "1.1.0.0"}
```

따라서 위 예제를 사용한 자동화 작업은 다음과 같습니다.

```yaml
action:
  service: hdmi_cec.select_device
    data:
      device: Chromecast
```

### Power On

이 기능을 지원하는 모든 장치의 전원을 켜려면 `hdmi_cec.power_on` 서비스 (인수 없음)를 호출하십시오.

위 예제를 사용한 자동화 작업은 다음과 같습니다.

```yaml
action:
  service: hdmi_cec.power_on
```

### 대기 모드

이 기능을 지원하는 모든 장치를 대기 모드로 두려면 `hdmi_cec.standby` 서비스 (인수 없음)를 호출하십시오.

위 예제를 사용한 자동화 작업은 다음과 같습니다.

```yaml
action:
  service: hdmi_cec.standby
```

### 볼륨 조절

다음 명령 중 하나를 사용하여 `hdmi_cec.volume` 서비스를 호출하십시오.

#### 볼륨 늘리기

볼륨을 세 번 늘리십시오. :

```json
{"up": 3}
```

릴리스가 호출될 때까지 볼륨을 계속 늘리십시오. :

```json
{"up": "press"}
```

볼륨 증가를 중지하십시오. :

```json
{"up": "release"}
```

#### 볼륨 줄이기
음량을 세 번 줄이십시오. :

```json
{"down": 3}
```

릴리스가 호출될 때까지 볼륨을 줄이십시오.:

```json
{"down": "press"}
```

볼륨 감소를 중지하십시오 :

```json
{"down": "release"}
```

#### 음소거
음소거 전환 :

```json
{"mute": ""}
```

값은 무시됩니다.


## 유용한 참고 자료

* [CEC overview](http://wiki.kwikwai.com/index.php?title=The_HDMI-CEC_bus)
* [CEC-o-matic](http://www.cec-o-matic.com/)
