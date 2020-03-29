---
title: 지그비(Zigbee Home Automation)
description: Instructions on how to integrate your Zigbee Home Automation (ZHA) devices within Home Assistant.
logo: zigbee.png
ha_category:
  - Hub
  - Binary Sensor
  - Fan
  - Light
  - Lock
  - Sensor
  - Switch
  - Cover
ha_release: 0.44
ha_iot_class: Local Polling
featured: true
ha_config_flow: true
ha_codeowners:
  - '@dmulcahey'
  - '@adminiuga'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/9InA6kc6r9s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

홈어시스턴트에서 Zigbee 장치를 다루는 방법은 아래 ZHA(Zigbee Home Automation)로 연동하여 다루는 방법이 있기는 하지만, 가장 많이 쓰고 있지는 않습니다. 현재 가장 사용자층에서 많이 쓰는 방식은 Hass.io add-on에서 지원하는 현존 Zigbee 허브중 가장 많은 116개회사의 644개 장치를 지원하는 [Zigbee2mqtt](https://www.zigbee2mqtt.io/) 를 사용하는 방법이 현재 가장 널리 쓰이고 있는 방법입니다. 

왜 Zigbee2mqtt가 사용하기 좋은 장치인지는 [Zigbee 허브는 한개로 충분하다](https://cafe.naver.com/koreassistant/505)를 참조하십시오.

1. Zigbee2mqtt 장치 CC2531 USB Stick [펌웨어](https://cafe.naver.com/koreassistant/211) 작업하기 
2. Zigbee2mqtt의 [설치 방법](https://cafe.naver.com/koreassistant/216) 
3. Zigbee2mqtt의 [지원 장치](https://www.zigbee2mqtt.io/information/supported_devices.html) 및 페어링 방법
4. Zigbee2mqtt의 [Add-on](https://github.com/danielwelch/hassio-zigbee2mqtt/tree/master/zigbee2mqtt) 링크

-----------------------------------------------------------------------------------------------------------------------------
**이하 ZHA(Zigbee Home Automation) 번역 시작**

Home Assistant 용 [Zigbee Home Automation](https://zigbee.org/zigbee-for-developers/applicationstandards/zigbeehomeautomation/) 통합구성요소를 사용하면 [zigpy](https://github.com/zigpy/zigpy) 와 호환되는 사용 가능한 Zigbee 무선 모듈 중 하나를 사용하여 여러 기성품 Zigbee 장치를 Home Assistant에 연결할 수 있습니다 (Zigbee 스택을 구현하는 오픈 소스 Python 라이브러리, 각기 다른 제조업체와 Zigbee 라디오 모듈을 연결할 수 있는 별도의 라이브러리에 의존합니다.)

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. : 

- Binary Sensor
- Sensor
- Light
- Lock
- Switch
- Fan
- Cover

## ZHA 예외와 편차 처리 (ZHA exception and deviation handling)

[Zigbee Alliance](https://www.zigbee.org)에서 설정한 표준 사양에서 벗어나거나 Zigbee Alliance가 설정한 표준 사양을 완전히 준수하지 않는 Zigbee 장치는 모든 기능이 Home Assistant의 ZHA 통합구성요소와 제대로 작동하려면 사용자 지정 [ZHA Device Handlers](https://github.com/dmulcahey/zha-device-handlers) (ZHA custom quirks handler 구현)를 개발해야합니다. 따라서 홈어시스턴트용 ZHA Device Handlers를 사용하여 Zigbee 디바이스와 사용자 정의 메시지를 구문 분석할 수 있습니다.

홈어시스턴트용 ZHA Device Handlers로 구현된 zigpy에 대한 custom quirks 구현은 [SmartThings Classics 플랫폼용 허브 연결 Device Handlers](https://docs.smartthings.com/en/latest/device-type-developers-guide/)와 [Zigbee2mqtt에서 사용되는 Zigbee-Shepherd Converter](https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html)와 유사한 개념입니다. 이들은 각 플랫폼 간의 기존 연동으로 기본 제공되지 않는 추가 기능을 제공하는 물리적 장치의 각 가상 표현입니다.

## 알려진 동작 가능 지그비 무선 모듈

- EmberZNet based radios using the EZSP protocol (via the [bellows](https://github.com/zigpy/bellows) library for zigpy) 
  - [Nortek GoControl QuickStick Combo Model HUSBZB-1 (Z-Wave & Zigbee USB Adapter)](https://www.nortekcontrol.com/products/2gig/husbzb-1-gocontrol-quickstick-combo/)
  - [Elelabs Zigbee USB Adapter](https://elelabs.com/products/elelabs_usb_adapter.html)
  - [Elelabs Zigbee Raspberry Pi Shield](https://elelabs.com/products/elelabs_zigbee_shield.html)
  - Telegesis ETRX357USB (Note! This first have to be flashed with other EmberZNet firmware)
  - Telegesis ETRX357USB-LRS (Note! This first have to be flashed with other EmberZNet firmware)
  - Telegesis ETRX357USB-LRS+8M (Note! This first have to be flashed with other EmberZNet firmware)
- XBee Zigbee based radios (via the [zigpy-xbee](https://github.com/zigpy/zigpy-xbee) library for zigpy)
  - Digi XBee Series 3 (xbee3-24) modules
  - Digi XBee Series 2C (S2C) modules
  - Digi XBee Series 2 (S2) modules (Note! This first have to be flashed with Zigbee Coordinator API firmware)
- dresden elektronik deCONZ based Zigbee radios (via the [zigpy-deconz](https://github.com/zigpy/zigpy-deconz) library for zigpy)
  - [ConBee II (a.k.a. ConBee 2) USB adapter from dresden elektronik](https://phoscon.de/conbee2)
  - [ConBee USB adapter from dresden elektronik](https://phoscon.de/conbee)
  - [RaspBee Raspberry Pi Shield from dresden elektronik](https://phoscon.de/raspbee)
- ZiGate based radios (via the [zigpy-zigate](https://github.com/doudz/zigpy-zigate) library for zigpy and require firmware 3.1a or later)
  - [ZiGate USB-TTL](https://zigate.fr/produit/zigate-ttl/)
  - [ZiGate USB-DIN](https://zigate.fr/produit/zigate-usb-din/)
  - [PiZiGate](https://zigate.fr/produit/pizigate-v1-0/)
  - [Wifi ZiGate](https://zigate.fr/produit/zigate-pack-wifi-v1-3/) (work in progress)

## 설정 - GUI

홈어시스턴트 첫 페이지에서 **설정** 으로 이동한 후 목록에서 **통합구성요소** 를 선택하십시오.

오른쪽 하단의 더하기 버튼을 사용하여 **ZHA** 라는 새 통합구성요소를 추가하십시오

팝업 화면에서 :

  - USB 장치 경로 - 리눅스 시스템에서 `/dev/ttyUSB0`
  - 라디오 유형 - 장치 유형 **ezsp**, **deconz** 혹은 **xbee**
  - 제출

성공(Success) 대화 상자가 나타나거나 팝업에 오류가 표시됩니다. 홈어시스턴트가 USB 장치에 액세스할 수 없거나 장치가 최신 상태가 아닌 경우 오류가 발생했을 수 있습니다 (문제 해결 참조).

## 설정 - 수동

구성 요소를 설정하려면 통합구성요소 페이지에서 ZHA를 선택하고 Zigbee USB 스틱의 경로를 작성하십시오.

혹은 `configuration.yaml`에서 `zha` 섹션을 수동으로 설정할 수 있습니다 . 네트워크 데이터를 유지할 데이터베이스 경로가 필요합니다.

```yaml
# Example configuration.yaml entry
zha:
  usb_path: /dev/ttyUSB2
  database_path: /home/homeassistant/.homeassistant/zigbee.db
```

ZiGate를 사용하는 경우 특별한 usb_path 설정을 사용해야합니다. :
  - ZiGate USB TTL or DIN: `/dev/ttyUSB0` or `auto` to auto discover the zigate
  - PiZigate : `pizigate:/dev/serial0`
  - Wifi Zigate : `socket://[IP]:[PORT]` for example `socket://192.168.1.10:9999`

{% configuration %}
radio_type:
  description: One of `ezsp`, `xbee`, `deconz` or `zigate`.
  required: false
  type: string
  default: ezsp
usb_path:
  description: Path to the serial device for the radio.
  required: true
  type: string
baudrate:
  description: Baud rate of the serial device.
  required: false
  type: integer
  default: 57600
database_path:
  description: _Full_ path to the database which will keep persistent network data.
  required: true
  type: string
enable_quirks:
  description: Enable quirks mode for devices where manufacturers didn't follow specs.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

네트워크에 새 장치를 추가하려면 `zha` 에서 `permit`서비스를 호출하십시오. 개발자 도구에서 서비스 아이콘을 클릭하고 **서비스** 드롭 다운 상자에 `zha.permit`을 입력하면됩니다.  그런다음 장치 지침에 따라 추가, 스캔 혹은 공장 초기화를 수행하십시오.

## 장치 추가

**Configuration** 페이지로 이동하여 위의 설정 단계에 의해 추가된 **ZHA** 통합구성요소를 선택하십시오.

**ADD DEVICES**를 클릭하여 새 장치를 검색하십시오.

제조업체가 제공한 장치 지침에 따라 Zigbee 장치를 재설정하십시오 (예: 조명 켜기/끄기 표시등을 최대 10회, 스위치에는 일반적으로 재설정 버튼/핀이 있음).

## 문제 해결

### 이전 다른 브릿지에 추가된 Philips Hue 전구 추가

이전에 다른 브리지에 추가된 Philips Hue 전구는 검색중에 표시되지 않습니다. 먼저 전구를 공장 설정으로 복원해야합니다. 이를 위해 기본적으로 다음 방법이 있습니다. 

#### Philips Hue Dimmer Switch

전구를 공장 초기화하는 가장 쉬운 방법은 보통 Philips Hue Dimmer Switch를 사용하는 것입니다. 이 기능을 사용하려면 리모컨을 이전 브리지와 페어링할 필요가 없습니다.

1. 재설정하려는 Hue 전구를 켭니다.
2. 전구 근처에 디머 스위치를 배치합니다. (< 10 cm)
3. 전구가 깜박이기 시작할 때까지 디머 스위치의 (I)/(ON)과 (O)/(OFF) 버튼을 약 10 초 동안 누르고 있습니다.
4. 전구가 깜박임을 멈추고 결국 다시 켜집니다. 동시에 리모컨의 왼쪽 상단에 있는 녹색등은 전구가 공장 설정으로 성공적으로 재설정되었음을 나타냅니다.

#### hue-thief

[https://github.com/vanviegen/hue-thief/](https://github.com/vanviegen/hue-thief/)의 지침을 따르십시오 (EZSP 기반 Zigbee USB 스틱 필요)

### LINUX 호스트에 HOME-ASSISTANT DOCKER/HASS.IO 설치시 ZHA 시작 문제

Linux 호스트에서 Zigbee USB 장치가 호스트의 modemmanager service에 의해 쓰이기 때문에 HA 시작 중에 ZHA가 시작되지 않거나 다시 시작되지 않을 수 있습니다. 이 문제를 해결하려면 호스트 시스템에서 modemmanger를 비활성화하십시오.

Debian/Ubuntu 호스트에서 modemmanager를 제거하려면 다음 명령을 실행하십시오.

```bash
sudo apt-get purge modemmanager
```

### DOCKER를 사용하여 USB 장치에 연결할 수 없습니다

Docker를 사용중이고 연결할 수 없는 경우 호스트 컴퓨터에서 Docker 인스턴스로 장치를 전달해야합니다. 이는 시작 문자열의 끝에 장치 매핑을 추가하거나 보통은 docker compose를 사용하여 얻을 수 있습니다.

#### Docker Compose

Linux 용 Docker-Compose를 설치하십시오 (linux - `sudo apt-get install docker-compose`).


다음 데이터로 `docker-compose.yml`을 만듭니다. :

```yaml
version: '2'
services:
  homeassistant:
    # customisable name
    container_name: home-assistant
    
    # must be image for your platform, this is the rpi3 variant
    image: homeassistant/raspberrypi3-homeassistant
    volumes:
      - <DIRECTORY HOLDING HOME ASSISTANT CONFIG FILES>:/config
      - /etc/localtime:/etc/localtime:ro
    devices:
      # your usb device forwarding to the docker image
      - /dev/ttyUSB0:/dev/ttyUSB0
    restart: always
    network_mode: host
```
