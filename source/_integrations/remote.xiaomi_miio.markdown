---
title: "샤오미 IR Remote"
description: "Instructions for how to integrate the Xiaomi IR Remote within Home Assistant."
logo: xiaomi.png
ha_category:
  - Remote
ha_release: 0.63
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/Y1rg0tXAqbI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`xiaomi miio` 원격 플랫폼을 사용하면 Xiaomi IR Remote 에서 적외선 리모콘 신호을 보낼 수 있습니다.

## Setup

`configuration.yaml` 에서 사용할 API 토큰을 찾으려면 [액세스 토큰 검색] (/ integrations / vacuum.xiaomi_miio / # retrieving-the-access-token)의 지침을 따르십시오.

## Configuring the Platform

Xiaomi IR Remote를 추가하려면`configuration.yaml` 에 다음을 추가하십시오:

```yaml
remote:
  - platform: xiaomi_miio
    host: 192.168.42.42
    token: YOUR_TOKEN
```

{% configuration %}
host:
  description: 미리모트의 IP 주소.
  required: true
  type: string
token:
  description: 미리모트의 API 토큰값.
  required: true
  type: string
name:
  description: 미리모트의 이름.
  required: false
  type: string
slot:
  description: 학습된 명령어를 저장하는 slot.
  required: false
  type: integer
  default: 1
timeout:
  description: 새로운 명령어를 배우는 시간 제한.
  required: false
  type: integer
  default: 30
commands:
  description: 명령어 리스트들.
  required: false
  type: map
  keys:
    command:
      description: 명령어 리스트는 [raw (learned command)](/integrations/remote.xiaomi_miio/#raw) or [pronto hex code](/integrations/remote.xiaomi_miio/#pronto-hex-code)로 표현 가능합니다. 
      required: true
      type: list

{% endconfiguration %}

## 완전한 설정의 예 

```yaml
remote:
  - platform: xiaomi_miio
    name: "bathroom remote"
    host: 192.168.42.42
    token: YOUR_TOKEN
    slot: 1
    timeout: 30
    commands:
      activate_towel_heater:
        command:
          - raw:base64:[optional_frequency]
      read_bad_poem:
        command:
          - raw:base64:[optional_frequency]
          - pronto:pronto_hex:[optional_repeat]
```

## UI 버튼을 만들기위한 명명된 명령어의 사용 예

```yaml
script:
  towel_heater:
    sequence:
      - service: remote.send_command
        entity_id: 'remote.bathroom_remote'
        data:
          command:
            - 'activate_towel_heater'
  please_cover_your_ears:
    sequence:
      - service: remote.send_command
        entity_id: 'remote.bathroom_remote'
        data:
          command:
            - 'read_bad_poem'
```

## 명령어 타입 종류

The Xiaomi IR Remote Platform currently supports two different formats for IR codes.

### Raw

raw 명령어는 [`xiaomi_miio.remote_learn_command`](/integrations/remote.xiaomi_miio/#xiaomi_miioremote_learn_command)를 통해서 배웁니다.

raw 명령어는 다음 예제와 같이 정의할 수 있습니다:

```bash
raw:Z6UFANEAAAAjAQAAAwkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQIAE=
```

마지막 매개 변수로 주파수를 지정할 수 있습니다.:

```bash
raw:Z6UFANEAAAAjAQAAAwkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQIAE=:38400
```

### Pronto Hex Code

pronto hex 코드는 주로 가전기기 제조업체에서 제공하는 hex 코드입니다.

pronto hex 코드는 다음 예제와 같습니다:

```bash
pronto:0000 006C 0022 0002 015B 00AD 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0041 0016 0041 0016 0041 0016 0041 0016 0041 0016 0041 0016 0041 0016 0016 0016 0016 0016 0041 0016 0016 0016 0041 0016 0016 0016 0016 0016 0016 0016 0016 0016 0041 0016 0016 0016 0041 0016 0016 0016 0041 0016 0041 0016 0041 0016 0041 0016 0623 015B 0057 0016 0E6E
```

마지막 매개변수에 반복되는 데이터를 지정할 수 있습니다. (몇몇 기기에 해당):

```bash
pronto:0000 006C 0022 0002 015B 00AD 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0016 0041 0016 0041 0016 0041 0016 0041 0016 0041 0016 0041 0016 0041 0016 0016 0016 0016 0016 0041 0016 0016 0016 0041 0016 0016 0016 0016 0016 0016 0016 0016 0016 0041 0016 0016 0016 0041 0016 0016 0016 0041 0016 0041 0016 0041 0016 0041 0016 0623 015B 0057 0016 0E6E:2
```

다음과 같은 hostname을 가진 Xiaomi IR Remote 종류가 최소 4개 이상 있다는 것을 확인하십시오. : 

* `chuangmi.ir.v2`
* `chuangmi.remote.h102a03`
* `chuangmi.remote.v2`
* `chuangmi.remote.h102c01`

현재 pronto hex 코드는 첫 번째 버전에서만 작동합니다. (`chuangmi.ir.v2`).

## 플랫폼 서비스 

Xiaomi IR Remote Platform은 두 가지 서비스가 등록 가능 합니다.

### `remote.send_command`

식별자를 사용하여 명명 된 명령을 보내거나 [명령 유형] (/ integrations / remote.xiaomi_miio / # command-types)에 정의 된 두 가지 유형 중 하나로 명령을 보낼 수 있습니다.

### `xiaomi_miio.remote_learn_command`

새로운 명령을 배우는 데 사용됩니다.

학습 프로세스를 시작하려면 Xiaomi IR Remote의 entity_id를 사용하십시오.

`slot` 및 `timeout` 을 지정할 수 있지만 동일한 슬롯에 대해 학습 된 여러 명령을 덮어 쓰더라도 [`remote.send_command`](/integrations/remote.xiaomi_miio/#remotesend_command) 를 사용하여 계속 보낼 수 있습니다.

명령을 학습 한 후 Overview에서 base64 명령문자열을 notification으로 찾을 수 있습니다. 명령문자열을 마우스 왼쪽 버튼으로 클릭하고 복사 옵션을 선택하여 해당 명령문자열을 복사 할 수 있습니다.
