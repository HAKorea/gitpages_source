---
title: 원격부팅(Wake on LAN)
description: Instructions on how to setup the Wake on LAN integration in Home Assistant.
logo: ethernet.png
ha_category:
  - Network
  - Switch
ha_release: 0.49
ha_iot_class: Local Push
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/PtiX4TcdDSg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`wake_on_lan` 통합구성요소를 통해 _magic packet_ 을 [Wake on LAN](https://en.wikipedia.org/wiki/Wake-on-LAN) 지원 장치로 전송하여 장치를 켤 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다 :

- [Switch](#switch)

## 설정

설치시 이 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
wake_on_lan:
```

### Component 서비스

사용가능한 서비스 : `send_magic_packet`.

#### `wake_on_lan/send_magic_packet` 서비스

'Wake-On-LAN' 기능이 있는 장치를 깨우려면 _magic packet_ 을 보내십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `mac`                     |       no | 깨울 장치의 MAC 주소.                |
| `broadcast_address`       |      yes | 매직 패킷을 보낼 선택적 Broadcast IP 주소 |

샘플 서비스 데이터 :

```json
{
   "mac":"00:40:13:ed:f1:32"
}
```

## 스위치

`wake_on_lan` (WOL) 스위치 플랫폼을 사용하면 [WOL](https://en.wikipedia.org/wiki/Wake-on-LAN) 지원 컴퓨터를 켤 수 있습니다.

### 스위치 설정

WOL 스위치는 컴퓨터를 켜고 상태만 모니터링 할 수 있습니다. 컴퓨터를 원격으로 끄는 일반적인 방법은 없습니다. `turn_off` 변수는 컴퓨터를 원격으로 끄는 방법을 알아냈을 때 스크립트를 호출하는 데 도움이됩니다. 이를 수행하는 방법에 대한 제안 사항은 아래를 참조하십시오. 

바이너리 `ping`은 `$PATH`에 있어야합니다.

설치에서 이 스위치를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오. : 

```yaml
# Example configuration.yaml entry
switch:
  - platform: wake_on_lan
    mac: MAC_ADDRESS
```

{% configuration %}
mac:
  description: "깨우기 명령을 보낼 MAC 주소 (예: `00:01:02:03:04:05`)."
  required: true
  type: string
name:
  description: 스위치의 이름
  required: false
  default: Wake on LAN
  type: string
host:
  description: 장치 상태를 확인하기 위한 IP 주소 또는 호스트 이름입니다 (켜기/끄기).
  required: false
  type: string
turn_off:
  description: 스위치가 꺼질 때 실행할 [action](/getting-started/automation/)을 정의합니다 .
  required: false
  type: string
broadcast_address:
  description: 매직 패킷을 보낼 호스트의 IP 주소
  required: false
  default: 255.255.255.255
  type: string
{% endconfiguration %}

### 사례

다음은 **turn_off** 변수를 사용하는 방법에 대한 실제 예입니다.

#### Suspending Linux 

`turn_off` 스크립트가 다른 Linux 컴퓨터 (**server**)에서 실행되는 Home Assistant에서 Linux 컴퓨터 (**target**)를 일시 중지시키는 방법 제안

1. **server**에서 홈어시스턴트 사용자 계정이 실행중인 상태로 로그인하십시오. 이 예에서는 `hass`입니다
2. **server**에서 `ssh-keygen`을 실행하여 SSH키를 만듭니다. 모든 질문에서 Enter 키를 누르십시오.
3. **target**에서 Home Assistant가 `sudo adduser has`로 ssh로 접속할 수있는 새 계정을 만듭니다. 비밀번호를 제외한 모든 질문에서 Enter 키를 누르면됩니다. 서버와 동일한 사용자 이름을 사용하는 것이 좋습니다. 그렇다면, 아래의 SSH 명령에서 `hass @`를 생략해도됩니다.
4. **server**에서 `ssh-copy-id hass@TARGET`으로 공개 SSH키를 전송하십시오. 여기서 TARGET은 대상 컴퓨터의 이름 또는 IP 주소입니다. 3 단계에서 작성한 비밀번호를 입력하십시오.
5. **server**에서 `ssh TARGET`을 통해 비밀번호없이 대상 머신에 도달 할 수 있는지 확인하십시오.
6. **target**에서는 `hass` 사용자가 대상 컴퓨터를 일시 중지/종료하는 데 필요한 프로그램을 실행하도록 해야합니다. 다음은 `pm-suspend`입니다. 먼저 전체 경로를 가져옵니다 : `which pm-suspend`. 내 시스템에서 이는 `/usr/sbin/pm-suspend` 입니다.
7. **target**에서 sudo 액세스 권한이있는 계정(일반적으로 주계정)인 `sudo visudo`를 사용합니다. 이 행을 파일의 마지막 부분에 추가하십시오 :`hass ALL=NOPASSWD:/usr/sbin/pm-suspend`. 여기서 `hass`를 다른 대상의 사용자 이름으로 바꾸고 `/usr/sbin/pm-suspend`를 다른 명령으로 바꾸십시오.
8. **server**에서 TARGET을 대상 이름으로 바꾸어 설정에 다음을 추가하십시오.

```yaml
switch:
  - platform: wake_on_lan
    name: "TARGET"
    ...
    turn_off:
      service: shell_command.turn_off_TARGET

shell_command:
  turn_off_TARGET: 'ssh hass@TARGET sudo pm-suspend'
```
