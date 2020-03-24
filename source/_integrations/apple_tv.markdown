---
title: 애플 TV
description: Instructions on how to integrate Apple TV devices into Home Assistant.
logo: apple.png
ha_category:
  - Multimedia
  - Media Player
  - Remote
ha_iot_class: Local Push
ha_release: 0.49
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/WIjyerTfQMw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`apple_tv` 플랫폼을 사용하면 Apple TV (3세대 및 4세대)를 제어할 수 있습니다. 화살표 키와 같은 리모컨 버튼을 보내려면 [remote platform](/integrations/apple_tv#remote)을 참조하십시오 .

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :

- Media Player
- [Remote](#remote)

<div class='note'>
현재이 기능을 사용하려면 홈 공유가 활성화되어 있어야합니다. Home Assistant와 장치의 페어링 지원은 이후 릴리스에서 지원됩니다.
</div>

## 설정

이 구성 요소를 사용하려면 먼저 일부 시스템 라이브러리와 컴파일러를 설치해야합니다. 데비안 또는 이와 유사한 시스템의 경우 다음을 충족해야합니다.

```shell
$ sudo apt-get install build-essential libssl-dev libffi-dev python-dev
```

새로운 장치를 자동으로 발견하려면 `configuration.yaml` 파일에 `discovery :`가 있는지 확인하십시오. 하나 이상의 Apple TV를 설치에 수동으로 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
apple_tv:
  - host: IP_1
    login_id: LOGIN_ID_1
    name: NAME_1
    start_off: START_OFF_1
    credentials: CREDENTIALS_1
  - host: IP_2
    login_id: LOGIN_ID_2
    name: NAME_2
    start_off: START_OFF_2
    credentials: CREDENTIALS_2
```

{% configuration %}
host:
  description: 장치의 IP 주소.
  required: true
  type: string
login_id:
  description: 장치에 로그인하는 데 사용되는 식별자 (아래 참조).
  required: true
  type: string
name:
  description: 프런트 엔드에 사용 된 장치의 이름
  required: false
  type: string
start_off:
  description: 장치가 가짜 대기 모드에서 시작해야하는 경우 true로 설정.
  required: false
  type: boolean
  default: false
credentials:
  description: AirPlay 재생에 사용되는 자격 증명.
  required: false
  type: string
{% endconfiguration %}

장치에 연결하려면 *login id*가 필요합니다. 이 식별자를 얻는 가장 쉬운 방법은 `apple_tv_scan` 서비스를 사용하는 것입니다 (아래 설명 참조). `start_off` 및 `credentials` 에 대한 추가 정보는 안내서 섹션에서도 찾을 수 있습니다.

## 가이드

### 장치 검색

Apple TV에서 홈 공유가 활성화되어 있는지 확인하십시오.

장치를 검색하고 `login_id`를 결정하려면 사이드바에서 망치 아이콘을 선택하여 개발자 도구를여십시오. 
개발자 도구에서 **services** 를 선택하십시오.

<img src='/images/screenshots/developer-tools.png' />

도메인으로 `apple_tv`를 선택하고 서비스로 `apple_tv_scan`을 선택한 다음 버튼을 누릅니다. :

<img src='/images/integrations/apple_tv/scan_start.jpg' />

스캔은 3초 동안 수행되며 발견된 모든 장치와 함께 상태보기에 알림이 표시됩니다. : 

<img src='/images/integrations/apple_tv/scan_result.jpg' />

또는 ``atvremote`` 응용 프로그램을 사용할 수 있습니다. 홈어시스턴트 환경에서 ``pip3 install --upgrade pyatv`` 로 설치하십시오 (주의: sudo를 사용하지 *마십시오*). 그런 다음 ``atvremote scan`` 을 실행하여 모든 장치를 검색하십시오 (장치가 없는 경우 다시시도).

```bash
$ atvremote scan
Found Apple TVs:
 - Apple TV at 10.0.10.22 (login id: 00000000-1234-5678-9012-345678901234)

Note: You must use 'pair' with devices that have home sharing disabled
```

추가하려는 장치에서 `login_id`를 복사하여 붙여넣기만 하면됩니다. `atvremote`에 대한 자세한 내용은 [this page](https://pyatv.readthedocs.io/en/master/atvremote.html)를 참조하십시오.

### 장치 인증 설정

`play_url`을 사용하여 미디어를 재생할 때 다음 오류 메시지가 표시됩니다

*"이 AirPlay 연결에는 iOS 7.1 이상, OS X 10.10 이상 또는 iTunes 11.2 이상이 필요합니다."*

장치 인증이 필요하면 사이드 바에서 망치 아이콘을 선택하여 개발자 도구를 여십시오. 개발자 도구에서 **services**를 선택하십시오.

<img src='/images/screenshots/developer-tools.png' />

도메인으로 `apple_tv`를, 서비스로 `apple_tv_authenticate`를 선택하고 `{ "entity_id": "XXX"}`를 "Service Data"에 입력하지만 XXX를 장치의 엔티티 ID (예 :`media_player.apple_tv`)로 바꾸십시오. 버튼을 누르면 핀 코드를 묻는 입력 대화 상자가 나타납니다. : 

<img src='/images/integrations/apple_tv/auth_start.jpg' />

대화 상자가 나타나지 않으면 상태보기로 돌아가서 여기에서 표시하십시오 (이미지에 표시된대로 `CONFIGURE`를 누름).

<img src='/images/integrations/apple_tv/auth_pin.jpg' />

이제 TV에 PIN 코드가 표시됩니다. 대화 상자에 코드를 입력한 후 "확인"을 누르십시오. 상태보기에서 성공했는지 확인해야합니다. credentials를 복사하여 줄바꿈없이 ``credentials :`` 다음에 값을 삽입하십시오 (모든 문자를 복사했는지, 81자 여야 함).

```yaml
# Example configuration.yaml entry
apple_tv:
  - host: 10.0.0.20
    login_id: 00000000-1234-5678-9012-345678901234
    credentials: 1B8C387DDB59BDF6:CF5ABB6A2C070688F5926ADB7C010F6DF847252C15F9BDB6DA3E09D6591E90E5
```

홈어시스턴트를 다시 시작하면 이전과 같이 `play_url`을 사용할 수 있습니다.

### Home Assistant를 다시 시작하면 Apple TV가 켜집니다.

Apple TV는 요청이 전송되는 경우 (예: 버튼을 누르거나 AirPlay를 통해 스트리밍되거나 현재 상태(현재 재생중)인 경우) 자동으로 켜집니다. 이것이 Apple이 설계 한 방식이며 HDMI-CEC를 사용하는 경우 문제가 발생할 수 있습니다. 홈어시스턴트가 시작될 때마다 현재 재생중인 항목을 파악하기 위해 새 요청이 장치로 전송됩니다. CEC를 사용하면 TV 및 설정한 다른 장치가 활성화됩니다.

따라서 TV가 무작위로 켜지는 경우일 수 있습니다. 언급한 바와 같이, 이는 의도적으로 설계된 것이며 실제 해결방법은 없습니다. 통신에 사용되는 프로토콜을 통해 Apple TV를 끄는 방법도 알려져 있지 않습니다. 다음과 같은 옵션이 있습니다. :

- 이 플랫폼을 사용하지 마십시오
- Apple TV에서 HDMI-CEC 비활성화하십시오
- "fake standby"를 사용하십시오. 

처음 두 지점은 분명합니다. Fake standby는 이 플랫폼에서 구현된 개념으로, 장치에 대한 모든 요청을 비활성화하고 웹 인터페이스에서 "끄기"로 표시합니다. 이렇게하면 장치가 깨어나지 않고, 정보를 표시하거나 제어 할 수도 없습니다. 그러나 웹 인터페이스에서 쉽게 켜거나 끄거나 `turn_on`으로 자동화를 사용하는 것은 쉽습니다. 더 유용하게 사용하려면 수신기의 입력 소스와 같은 다른 장치에 따라 자동화를 켜거나 끄는 자동화를 작성할 수 있습니다.

Home Assistant를 시작할 때 장치를 가짜 대기 상태로 만들려면 설정에 `start_off : true`를 추가하십시오.

<div class='note warning'>
사용자 인터페이스에서 장치를 켜거나 끄면 위의 설명에 따라 물리적 장치를 켜거나 끌 수 없습니다.
</div>

## 서비스

### `apple_tv_authenticate` 서비스

장치 인증이 활성화 된 Apple TV (예: tvOS 10.2 이상이있는 ATV4)에서 미디어를 재생하려면 Home Assistant가 올바르게 인증되어야합니다. 이 방법은 프로세스를 시작하고 재생에 필요한 자격 증명을 지속적인 알림으로 표시합니다. 사용법은 위의 가이드를 참조하십시오. 

| Service data attribute | Optional | Description                                                        |
| ---------------------- | -------- | ------------------------------------------------------------------ |
| `entity_id`            | yes      | Apple TV의 `entity_id`를 가리키는 문자열 또는 문자열 목록. |

### `apple_tv_scan` 서비스

Apple TV의 로컬 네트워크를 스캔합니다. 발견 된 모든 장치는 지속적 알림(persistent notification)으로 표시됩니다.

## Remote

`apple_tv` 원격 플랫폼을 사용하면 리모컨 버튼을 Apple TV로 보낼 수 있습니다. Apple TV가 셋업되면 자동으로 설정됩니다.

현재 다음 버튼이 지원됩니다 : 

- up
- down
- left
- right
- menu
- top_menu
- select

여러 버튼을 누르는 일반적인 서비스 요청은 다음과 같습니다. 

```yaml
service: remote.send_command
data:
  entity_id: remote.apple_tv
  command:
    - left
    - left
    - menu
    - select
```
