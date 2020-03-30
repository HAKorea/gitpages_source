---
title: "Z-Wave"
description: "Instructions on how-to enable Z-Wave with Hass.io."
---

지웨이브(Z-Wave)를 사용하려면 지웨이브 USB 스틱을 라즈베리파이 USB포트에 설치해야 합니다.  그 다음 `configuration.yaml` 파일에 아래 내용을 작성합니다:

```yaml
zwave:
  usb_path: /dev/ttyACM0
```
<div class='note'>

HA 최신 버전에서는 설정 - 통합구성요소 메뉴에서 우측 하단의 오렌지색 + 버튼을 눌러 z-wave 통합구성요소를 추가할 수 있습니다. yaml에 위와 같은 설정을 하지 않고 바로 usb path를 입력하면 z-wave 통합구성요소를 설정할 수 있습니다.
<img src='/images/hassio/zwave01.png'  alt='Screenshot: zwave 통합구성요소 추가'><br>
</div>


## RAZBERRY BOARD

라즈베리파이의 GPIO를 사용하는 지웨이브 모듈이라면 라즈베리파이의 `config.txt`를 수정해야 합니다. 이 파일은 해쇼에서 접근할 수 없고 SD카드에서 직접 수정해야 합니다. SD카드를 윈도우나 리눅스 컴퓨터에 꼽고 아래 내용을 `config.txt`에 입력하세요:

```txt
dtoverlay=pi3-miniuart-bt
```

다음으로 `configuration.yaml`파일에 `usb_path` 를 `/dev/ttyAMA0` 로 추가합니다.

```yaml
zwave:
  usb_path: /dev/ttyAMA0
```

## HUSBZB-1 스틱
지웨이브와 지그비 모두 사용 가능하므로 아래와 같이 설정합니다.
```yaml
zwave:
  usb_path: /dev/ttyUSB0

zha:
  usb_path: /dev/ttyUSB1
  database_path: /config/zigbee.db
```

## Ubuntu 와 Debian 기반의 시스템

우분투나 데비안 리눅스에서 홈어시스턴트를 운영중이라면 ModemManager 때문에 에러가 나기도 합니다.

 ModemManager는 몇몇 지웨이브 스틱을 방해합니다. 특히 가장 많이 사용하는 Aeotec 스틱에서 에러가 많이 발생합니다. 스틱이 응답하지 않거나 홈어시스턴트에서 지웨이브 스틱을 다시 꼽거나 리부팅을 해야 한다면 ModemManager 문제일 확률이 높습니다.

다음 명령어로 ModemManager 사용을 중지할 수 있습니다:

```bash
systemctl disable ModemManager.service
```

### USB path 찾기

위에서 작성한 바대로 지웨이브 스틱이 동작하지 않는다면  [`ha` 명령](/hassio/commandline/#hardware) 으로 USB의 경로를 확인해보세요:

```bash
$ ha hardware info
```
그 밖에웹페이지의 *Supervisor* 패널 안에서 *System 섹션에서도 경로를 확인할 수 있습니다. *Hardware* 버튼을 누르면 모든 하드웨어 정보들이 표시됩니다.

## Further reading

지웨이브의 더 많은 정보는 [지웨이브 설정 문서](/docs/z-wave/)를 참고하세요.
