---
title: "RFLink Cover"
description: "Instructions on how to integrate RFLink Somfy RTS and KAKU ASUN-650 covers into Home Assistant."
logo: rflink.png
ha_category:
  - Cover
ha_release: 0.55
---

`rflink` 통합구성요소는 [RFLink 게이트웨이 펌웨어](http://www.nemcon.nl/blog2/)를 사용하는 장치 (예: [Nodo RFLink 게이트웨이](https://www.nodo-shop.nl/nl/21-rflink-gateway))를 지원합니다. RFLink 게이트웨이는 저렴한 하드웨어 (Arduino + 트랜시버)를 사용하여 여러 RF 무선 장치와 양방향 통신을 가능하게하는 Arduino 펌웨어입니다.

먼저 [RFLink hub](/integrations/rflink/)를 설정해야합니다.

RFLink 허브를 구성하면 커버가 자동으로 검색되어 추가됩니다. Somfy RTS 장치는 제외합니다.

### Somfy RTS 장치 설정

제공된 RFlinkLoader를 사용하여 Somfy RTS를 수동으로 추가해야합니다 (Windows 만 해당).

원래 Somfy 리모컨의 Learn 버튼을 3 초 이내에 다음 코드를 입력하십시오. 블라인드는 곧 위아래로 움직입니다.

```text
10;RTS;02FFFF;0412;3;PAIR;
```

블라인드가 다시 위아래로 움직입니다. 이는 RFLink가 RTS 모터와 페어링되었음을 의미합니다.
이를 확인하려면 다음 코드를 다시 입력하고 레코드가 있는지 확인하십시오.

```text
10;RTSSHOW;
```

```text
RTS Record: 0 Address: FFFFFF RC: FFFF
RTS Record: 1 Address: FFFFFF RC: FFFF
RTS Record: 2 Address: FFFFFF RC: FFFF
RTS Record: 3 Address: 02FFFF RC: 0018
RTS Record: 4 Address: FFFFFF RC: FFFF
RTS Record: 5 Address: FFFFFF RC: FFFF
RTS Record: 6 Address: FFFFFF RC: FFFF
RTS Record: 7 Address: FFFFFF RC: FFFF
RTS Record: 8 Address: FFFFFF RC: FFFF
RTS Record: 9 Address: FFFFFF RC: FFFF
RTS Record: 10 Address: FFFFFF RC: FFFF
RTS Record: 11 Address: FFFFFF RC: FFFF
RTS Record: 12 Address: FFFFFF RC: FFFF
RTS Record: 13 Address: FFFFFF RC: FFFF
RTS Record: 14 Address: FFFFFF RC: FFFF
RTS Record: 15 Address: FFFFFF RC: FFFF
```

RFLink Somfy RTS를 설정한 후에는 다른 RFlink 장치와 마찬가지로 `configuration.yaml` 파일에 커버를 추가해야합니다.

RFLink 커버 ID는 프로토콜, ID, 게이트웨이로 설정됩니다. 예를 들면 다음과 같습니다. : `RTS_0100F2_0`. 

커버의 ID를 알고 나면 홈어시스턴트에서 커버를 설정하는데 사용할 수 있습니다 (예 : 다른 그룹에 추가하거나 숨기거나 익숙한 이름을 설정).

장치를 커버로 설정 :

```yaml
# Example configuration.yaml entry
cover:
  - platform: rflink
    devices:
      RTS_0100F2_0: {}
      bofumotor_455201_0f: {}
```

{% configuration %}
device_defaults:
  description: The defaults for the devices.
  required: false
  type: map
  keys:
    fire_event:
      description: Set default `fire_event` for RFLink cover devices.
      required: false
      default: false
      type: boolean
    signal_repetitions:
      description: Set default `signal_repetitions` for RFLink cover devices.
      required: false
      default: 1
      type: integer
devices:
  description: A list of covers.
  required: false
  type: list
  keys:
    rflink_ids:
      description: RFLink ID of the device
      required: true
      type: map
      keys:
        name:
          description: Name for the device.
          required: false
          default: RFLink ID
          type: string
        aliases:
          description: Alternative RFLink ID's this device is known by.
          required: false
          type: [list, string]
        fire_event:
          description: Fire a `button_pressed` event if this device is turned on or off.
          required: false
          default: False
          type: boolean
        signal_repetitions:
          description: The number of times every RFLink command should repeat.
          required: false
          type: integer
        group:
          description: Allow light to respond to group commands (ALLON/ALLOFF).
          required: false
          default: true
          type: boolean
        group_aliases:
          description: The `aliases` which only respond to group commands.
          required: false
          type: [list, string]
        no_group_aliases:
          description: The `aliases` which do not respond to group commands.
          required: false
          type: [list, string]
        type:
          description: The option to invert (`inverted`) on/off commands sent to the RFLink device or not (`standard`).
          required: false
          type: string
{% endconfiguration %}

### KAKU ASUN-650 장치 설정

RFLink에서 ON 및 DOWN 명령은 커버를 닫고 OFF 및 UP 명령은 커버를 열 때 사용됩니다. KAKU (COCO) ASUN-650은 반대로 작동하며, ON 명령을 사용하여 커버를 열고 OFF 명령을 사용하여 커버를 닫습니다.

RFLink 커버 장치에는 2 가지 값을 갖는 `type` 이라는 속성이 있습니다. :

- `standard`: Do not invert the on/off commands sent to the RFLink device.
- `inverted`: Invert the on/off commands sent to the RFLink device.

다음 설정 예제는 `type` 속성을 사용하는 방법을 보여줍니다 :

```yaml
# Example configuration.yaml entry that shows how to
# use the type property.
cover:
  - platform: rflink
    devices:
      newkaku_xxxxxxxx_x:
        name: kaku_inverted_by_type
        type: inverted
      newkaku_xxxxxxxx_y:
        name: kaku_not_inverted_by_type
        type: standard
      newkaku_xxxxxxxx_z:
        name: kaku_inverted_by_default
      nonkaku_yyyyyyyy_x:
        name: non_kaku_inverted_by_type
        type: inverted
      nonkaku_yyyyyyyy_y:
        name: non_kaku_not_inverted_by_type
        type: standard
      nonkaku_yyyyyyyy_z:
        name: non_kaku_not_inverted_by_default
```

위의 설정은 `type` 속성이 생략될 수 있음을 보여줍니다. ID가 `newkaku`로 시작하면 구성 요소는 on 및 off 명령이 반전되도록합니다. ID가 `newkaku`로 시작하지 않으면 on 및 off 명령이 반전되지 않습니다.

### 지원 장치

[device support](/integrations/rflink/#device-support) 참조하십시오.

### 추가 설정 사례

사용자 정의 이름 및 별명을 가진 여러 커버

```yaml
# Example configuration.yaml entry
cover:
  - platform: rflink
    devices:
      RTS_0A8720_0:
        name: enanos
        aliases:
          - rts_31e53f_01
          - rts_32e53f_01
      RTS_30E542_0:
        name: comedor
        aliases:
          - rts_33e53f_01
          - rts_fa872e_01
      RTS_33E542_0:
        name: dormitorio
        aliases:
          - rts_30e53f_01
          - rts_32e53f_01
      RTS_32E542_0:
        name: habitaciones
        fire_event: true
```
