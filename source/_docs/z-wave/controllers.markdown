---
title: "Z-Wave 컨트롤러"
description: "Extended instructions how to setup Z-Wave."
---

## 지원되는 Z-Wave USB 스틱과 하드웨어 모듈

호환되는 Z-Wave 스틱 혹은 모듈이 설치되어 있어야합니다. 이는 대부분의 Z-Wave 스틱과 모듈이 될 *static controller* 여야합니다. *bridge* 장치인 경우 [OpenZWave](http://openzwave.com/)에서 작동하지 않으므로 Home Assistant의 Z-Wave 기능이 제공됩니다. 새로운 700 시리즈 Z-Wave 플랫폼을 사용하는 USB 스틱은 호환되지 않습니다. 다음 장치가 작동하는 것으로 확인되었습니다. : 

<div class='note'>
  
Raspberry Pi 4에서 작동하지 않는 Aeotec 스틱의 [보고](https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=245031#p1502030)가 있습니다.

</div>

* Aeotec Z-Stick Series 5
* Everspring USB stick - Gen 5
* Sigma Designs UZB stick
* Vision USB stick - Gen5
* Zooz Z-Wave Plus S2 stick ZST10
* ZWave.me Razberry Board
* ZWave.me UZB1 stick

개선된 기능을 활용하려면 [Z-Wave Plus](https://z-wavealliance.org/z-wave_plus_certification/) 컨트롤러를 구입하는 것이 좋습니다. OpenZWave는 S2 또는 Smart Start를 지원하지 않으므로 이러한 기능을 지원하기 위해 하나만 구입할 필요는 없습니다.

<div class='note'>
  HA를 사용하거나 Docker 컨테이너에서 Home Assistant를 실행하는 경우 모듈이 아닌 USB 스틱을 사용하는 것이 좋습니다. Docker를 통해 모듈을 전달하는 것은 USB 스틱을 전달하는 것보다 더 복잡합니다. 
</div>

## 스틱 대안

스틱 대신 Z-Wave를 지원하는 허브가 있습니다. Home Assistant는 Z-Wave를 지원하는 다음 허브를 지원합니다.

 - [Vera](/integrations/vera/)
 - [Wink](/integrations/wink/)
 - [Fibaro](/integrations/fibaro/)
 - [SmartThings](/integrations/smartthings/)

## 컨트롤러 노트 

### Aeotec 스틱

기본적으로 "disco lights"가 켜지며 [장치별 페이지](/docs/z-wave/device-specific/#aeotec-z-stick)의 지침에 따라 끌 수 있습니다.

### Razberry Board

보드에 하드웨어 UART를 사용해야하고 Pi3에는 하드웨어가 하나만 있기 때문에 온보드 Bluetooth를 비활성화해야합니다. [장치 별 페이지](/docs/z-wave/device-specific/#razberry-board)의 지침에 따라 이를 수행하십시오.