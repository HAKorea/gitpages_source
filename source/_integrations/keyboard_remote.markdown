---
title: 키보드 리모트(Keyboard Remote)
description: Instructions on how to use a keyboard to remote control Home Assistant.
logo: keyboard.png
ha_category:
  - Other
ha_release: 0.29
ha_iot_class: Local Push
ha_codeowners:
  - '@bendavid'
---

키보드에서 신호를 수신하여 리모컨으로 사용하십시오

이 통합을 통해 하나 이상의 키보드를 리모컨으로 사용할 수 있습니다.
`keyboard_remote_command_received` 이벤트는 자동화 규칙에 사용될 수 있습니다.

`evdev` 패키지는 키보드와의 인터페이스에 사용되므로 Linux 전용입니다. 또한 `evdev`가 키보드를 차단하기 때문에 일반 키보드를 사용할 수 없습니다.

```yaml
# Example configuration.yaml entry
keyboard_remote:
  type: 'key_up'
```

{% configuration %}
type:
  description: 가능한 값은 `key_up`, `key_down` 및 `key_hold`입니다. `key_hold`는 많은 이벤트를 발생시킵니다. 유형 목록이 될 수 있습니다.
  required: true
  type: string
emulate_key_hold:
  description: 키를 누르고 있을 때 키 hold 이벤트를 에뮬레이트합니다. (일부 입력 장치는이를 보내지 않습니다.)
  required: false
  type: boolean
  default: false
emulate_key_hold_delay:
  description: 첫 번째 에뮬레이트 된 키 hold 이벤트를 보내기 전에 대기 할 시간 (밀리 초)
  required: false
  type: float
  default: 0.250
emulate_key_hold_repeat:
  description:  후속 에뮬레이트 된 키 hold 이벤트를 보내기 전에 대기 할 시간 (밀리 초)
  required: false
  type: float
  default: 0.033
device_descriptor:
  description: 키보드에 해당하는 로컬 이벤트 입력 장치 파일의 경로
  required: false
  type: string
device_name:
  description: 키보드 장치의 이름
  required: false
  type: string
{% endconfiguration %}

`device_name` 또는 `device_descriptor`가 구성 항목에 있어야합니다. 장치 이름을 나타내는 것은 장치의 연결을 끊고 다시 연결을 반복 할 때 유용합니다 (예: 블루투스 키보드) : 로컬 입력 장치 파일이 변경되어 설정이 깨지는 반면 이름은 동일하게 유지됩니다. 동일한 모델의 여러 장치가있는 경우에는 `device_descriptor` 를 사용해야합니다.

설정 항목에 표시된 장치를 찾을 수 없을 때 시작시 디버그 로그에 가능한 장치 설명 및 이름 목록이 보고됩니다.

두 개의 키보드 리모컨에 대한 전체 설정은 다음과 같습니다.

```yaml
keyboard_remote:
- device_descriptor: '/dev/input/by-id/bluetooth-keyboard'
  type: 'key_down'
  emulate_key_hold: true
  emulate_key_hold_delay: 250
  emulate_key_hold_repeat: 33
- device_descriptor: '/dev/input/event0'
  type:
    - 'key_up'
    - 'key_down'
```

또는 하나의 키보드에 대해 다음과 같이 :

```yaml
keyboard_remote:
  device_name: 'Bluetooth Keyboard'
  type: 'key_down'
```

그리고 생명을 불어 넣는 자동화 규칙 : 

```yaml
automation:
  alias: Keyboard all lights on
  trigger:
    platform: event
    event_type: keyboard_remote_command_received
    event_data:
      device_descriptor: "/dev/input/event0"
      key_code: 107 # inspect log to obtain desired keycode
  action:
    service: light.turn_on
    entity_id: light.all
```

`device_descriptor` 또는 `device_name`은 트리거에서 특정 될 수 있으므로 해당 키보드에 대해서만 자동화가 시작됩니다. 여러 블루투스 리모컨을 사용하여 다른 장치를 제어하려는 경우 특히 유용합니다. 동일한 키가 모든 키보드/원격의 자동화를 트리거하도록 하려면 생략하십시오.

## 끊김 (Disconnections)

이 통합 기능은 키보드의 연결 해제 및 재연결을 관리합니다 (예 : 배터리를 유지하기 위해 자동으로 꺼지는 Bluetooth 장치의 경우).

키보드가 분리되면 통합은 `keyboard_remote_disconnected` 이벤트를 발생시킵니다.
키보드가 다시 연결되면 `keyboard_remote_connected` 이벤트가 시작됩니다.

키보드가 연결/연결 해제 될 때마다 미디어 플레이어를 통해 사운드를 재생하는 자동화 예제는 다음과 같습니다.

```yaml
automation:
  - alias: Keyboard Connected
    trigger:
      platform: event
      event_type: keyboard_remote_connected
    action:
      - service: media_player.play_media
        data:
          entity_id: media_player.speaker
          media_content_id: keyboard_connected.wav
          media_content_type: music

  - alias: Bluetooth Keyboard Disconnected
    trigger:
      platform: event
      event_type: keyboard_remote_disconnected
      event_data:
        device_name: "00:58:56:4C:C0:91"
    action:
      - service: media_player.play_media
        data:
          entity_id: media_player.speaker
          media_content_id: keyboard_disconnected.wav
          media_content_type: music
```

## 권한 (Permissions)

이벤트 입력 장치 파일에 권한 문제가있을 수 있습니다. 이 경우 Home Assistant가 실행되는 사용자는 다음을 사용하여 읽기 및 쓰기 권한이 허용되어야합니다.

```bash
sudo setfacl -m u:HASS_USER:rw /dev/input/event*
```

여기서 `HASS_USER`는 Home Assistant를 실행하는 사용자입니다.

이것을 영구적으로 만들려면 모든 이벤트 입력 장치에 대해 규칙을 설정하는 udev 규칙을 사용할 수 있습니다. 다음을 포함하는 `/etc/udev/rules.d/99-userdev-input.rules` 파일을 추가하십시오 :

```bash
KERNEL=="event*", SUBSYSTEM=="input", RUN+="/usr/bin/setfacl -m u:HASS_USER:rw $env{DEVNAME}"
```

다음을 사용하여 ACL 권한을 확인할 수 있습니다.:

```bash
getfacl /dev/input/event*
```
