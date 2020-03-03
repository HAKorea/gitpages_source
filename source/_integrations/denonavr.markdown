---
title: 데논 AVR Network Receivers
description: Instructions on how to integrate Denon AVR Network Receivers into Home Assistant.
logo: denon.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.7.2
---

`denonavr` 플랫폼을 사용하면 Home Assistant에서 [Denon Network Receivers](https://www.denon.co.uk/chg/product/compactsystems/networkmusicsystems/ceolpiccolo)를 제어할 수 있습니다. 장치가 [Denon] 플랫폼에서 지원 될 수 있습니다.

지원되는 장치:

- Denon AVR-X1300W
- Denon AVR-X1500H
- Denon AVR-X2000
- Denon AVR-X2100W
- Denon AVR-X4100W
- Denon AVR-X4300H
- Denon AVR-X4500H
- Denon AVR-1912
- Denon AVR-2312CI
- Denon AVR-3311CI
- Denon AVR-4810
- Marantz M-CR510
- Marantz M-CR603
- Marantz M-RC610
- Marantz SR5008
- Marantz SR6007 - SR6010
- Marantz NR1506
- Marantz NR1604
- Other Denon AVR receivers (untested)
- Marantz receivers (experimental)

<div class='note warning'>
URC 컨트롤러와 같이 Denon AVR 3808CI에 별도로 IP 컨트롤러를 사용하는 것이 있으면 작동하지 않습니다! 하나의 장치 만 IP 기능을 제어 할 수있는 일부 모델에는 버그 또는 보안 문제가 있습니다.
</div>

Denon Network Receiver를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: denonavr
    host: IP_ADDRESS
    name: NAME
    show_all_sources: true
    timeout: POSITIVE INTEGER
    zones:
      - zone: Zone2 / Zone3
        name: NAME
```

{% configuration %}
host:
  description: "장치의 IP 주소(예 : 192.168.1.32)를 설정하지 않으면 자동 검색이 사용됩니다."
  required: false
  type: string
name:
  description: 장치 이름. 설정하지 않으면 수신자의 친숙한 이름이 사용됩니다.
  required: false
  type: string
show_all_sources:
  description: True이면 모든 소스가 Receiver에서 삭제된 것으로 표시되더라도 소스 목록에 표시됩니다. False이면 지워진 소스들은 나타나지 않습니다. 일부 Receiver에는 모든 소스가 인터페이스에서 삭제된 것으로 표시하는 버그가 있습니다. 이 경우이 옵션이 도움이 될 수 있습니다.
  required: false
  default: false
  type: boolean
timeout:
  description: Receiver에 HTTP 요청에 대한 시간 초과.
  required: false
  default: 2
  type: integer
zones:
  description: 활성화할 추가 zone 목록. 장치의 Main Zone과 동일한 기능을 가진 추가 미디어 플레이어로 표시됩니다.
  required: false
  type: list
  keys:
    zone:
      description: Zone은 반드시 활성화 되야합니다. 유효한 옵션은 `Zone2`와 `Zone3`입니다. 
      required: true
      type: string
    name:
      description: Zone의 이름. 주 장치 + zone의 이름을 설정하지 않으면 접미사로 사용됩니다. 
      required: false
      type: string
{% endconfiguration %}

몇 가지 참고 사항 :

- 웹서버가 내장된 Denon AVR receiver 제어를 위한 추가 옵션은 `denonavr` 플랫폼과 HTTP 인터페이스를 사용하는 것 입니다.
- `denonavr` 플랫폼은 앨범 표지, 사용자 정의 입력 소스 이름 및 자동 검색과 같은 몇 가지 추가 기능을 지원합니다.
- Marantz receiver는 기기들이 서로 상당히 유사한 인터페이스를 가지고 있습니다. 따라서 당신이 하나를 소유하고 있다면 시도해보십시오.
- 홈어시스턴트로 Marantz receiver의 전원을 원격으로 켜려면 receiver 설정에서 자동 대기 기능을 활성화해야합니다
- 사운드 모드 : 특정 사운드 모드를 설정하는 명령이 수신기에서 보고한 현재 사운드 모드의 값 (sound_mode_raw)과 다릅니다. 원시 사운드 모드를 가능한 명령 중 하나와 일치시켜 사운드 모드를 설정하는 키-값 구조 (sound_mode_dict)가 있습니다 (예: {'MUSIC':['PLII MUSIC']}). "Not able to match sound mode" 라는 경고 메시지가 표시되면 [denonavr library](https://github.com/scarface-4711/denonavr)에서 어떤 원시 사운드 모드를 일치시킬 수 없는지 알려주는 문제를 여십시오. 일치하는 사전(dictionary)에 추가 할 수 있습니다. 전면 패널의 "개발 도구/상태"에서 현재 원시 사운드 모드를 찾을 수 있습니다.

#### `denonavr.get_command` 서비스

일반 명령이 지원됩니다. 특히, 텔넷 프로토콜이 지원하는 모든 명령은 `/goform/formiPhoneAppDirect.xml` (예: `/goform/formiPhoneAppDirect.xml?VSMONI2`)로 보내 지원되는 수신기에서 HDMI 출력을 전환 할 수 있습니다. IR 원격 코드를 이 엔드 포인트로 전송할 수 도 있습니다 (예: 음소거 토글로 "/goform/formiPhoneAppDirect.xml?CKSK0410370"). 텔넷 프로토콜 명령의 전체 목록은 https://ca.denon.com/ca/product/hometheater/receivers/avrx4400h?docname=AVR-X6400H_X4400H_X3400H_X2400H_X1400H_S930H_S730H_PROTOCOL_V01.xlsx에서 찾을 수 있습니다. 

| Service data attribute | Optional | Description                                          |
| ---------------------- | -------- | ---------------------------------------------------- |
| `entity_id`            |       no | Name of entity to send command to. For example `media_player.marantz`|
| `command`              |       no | Command to send to device, e.g. `/goform/formiPhoneAppDirect.xml?VSMONI2`|

[Denon]: /integrations/denon
