---
title: 소니 플레이스테이션 4
description: Instructions on how to integrate a Sony PlayStation 4 into Home Assistant.
logo: ps4.png
ha_category:
  - Media Player
ha_release: 0.89
ha_config_flow: true
ha_iot_class: Local Polling
ha_codeowners:
  - '@ktnrg45'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/Yl_xymBz_6c" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
유튜브 시청시 자막을 한글로 변환해서 보시길 권장합니다. 

`ps4` 통합구성요소로 [Sony PlayStation 4 console](https://www.playstation.com/en-us/explore/ps4/)을 제어할 수 있습니다

## 요구사항

- 안드로이드 또는 iOS 기기
- 설치된 [Android](https://play.google.com/store/apps/details?id=com.playstation.mobile2ndscreen&hl=en_US) 혹은 [iOS](https://itunes.apple.com/us/app/ps4-second-screen/id1201372796?mt=8) 용 PS4 Second Screen App. 

## 셋업

1. PS4 Second Screen App을 다운로드하고 PlayStation 4를 정상적으로 찾고 제어할 수 있는지 확인하십시오.

<div class='note'>
  계속하기 전에 아래의 "포트 액세스 부여" 섹션을 읽으십시오.
</div>

2. `설정 -> 통합구성요소`로 이동하여 오른쪽 하단에서 더하기 버튼을 누릅니다. 통합 목록에서 `PlayStation 4`를 선택하십시오.

3. 표시되는 지시사항에 따라 사용자 인증 정보를 생성하십시오. 필드가 있는 양식이 나타나면 이 단계가 완료된 것입니다.

4. 필드를 채워 홈어시스턴트를 PlayStation 4에 페어링합니다. 
- **Note:** 올바른 지역을 찾으려면 [Regions](#regions) 섹션을 참조하십시오.

## 포트 액세스 권한 부여

PlayStation 4 연동을 위해서는 특권 포트, 특히 UDP 포트 987 및 TCP 포트 997이 올바르게 작동해야합니다. 홈어시스턴트 인스턴스의 OS에 따라 특권 포트의 수동 사용을 허용해야 할 수도 있습니다.

<div class='note warning'>
  이를 수행하기 위해 <b>Home Assistant</b> 인스턴스 자체를 <b>root</b> 또는 <b>root/sudo 권한</b>으로 실행하지 마십시오 . 이로 인해 호스트 시스템에 보안 위험이 발생합니다.
</div>

Home Assistant를 실행하는 OS에 따라 이를 수행하는 다양한 방법이 있습니다. 특히 Home Assistant 인스턴스를 실행하는 *Python Interpreter* 는 언급된 포트에 액세스해야합니다.

<div class='note'>

Home Assistant 장치가 **HassOS**에서 **Hass.io**를 실행 중인 경우 추가 설정이 필요하지 않습니다.

</div>

### Debian-based

데비안 타입 OS에 설치된 홈어시스턴트는 설정이 필요할 수 있습니다. 이 섹션은 다음 운영 체제에 적용 가능하지만 이에 국한되지는 않습니다.

- Debian
- Raspbian
- Armbian
- Ubuntu

터미널에서 다음 명령을 실행하십시오.

```bash
sudo setcap 'cap_net_bind_service=+ep' <python>
```

`<python>`을 Home Assistant에서 혹은 가상 환경이 실행되는 Python의 **system path**로 바꾸십시오. 경로는 **symlink**이거나 **inside of a virtual environment**에 있지 **않아야**합니다.

사례 :

```bash
sudo setcap 'cap_net_bind_service=+ep' /usr/bin/python3.5
```

시스템 Python 경로를 찾으려면 : 

- `configuration.yaml`에 [System Health](/integrations/system_health/) 통합구성요소를 추가하십시오. 웹브라우저에서 프론트엔드로 접근한 뒤 [about/log 페이지](http://<yourhomeassistanturl>/developer-tools/info)로 들어갑니다. 시스템 상태 상자에서 **python_version** 항목을 찾아 표시된 값을 적어 둡니다. 그런 다음 터미널에서 다음을 실행하십시오.

  ```bash
  whereis python<version>
  ```

  `<version>`을 시스템 상태 상자에 표시된 `python_version`의 값으로 바꾸십시오.

  Example:
  ```bash
  whereis python3.5.3
  ```

  `/bin/` 디렉토리가 있는 출력(output)은 아마도 다음과 같은 시스템 파이썬 경로 일 것입니다. `/usr/bin/python3.5`

- 홈어시스턴트가 가상 환경에 설치된 경우 터미널을 사용하여 `cd`로 최상위 디렉토리에 넘어가서 다음을 실행하십시오.

  ```bash
  readlink -f bin/python3
  ```
  or
  ```bash
  readlink -f bin/python
  ```

  출력은 시스템 Python 경로가 됩니다.

### 도커 

When running Home Assistant using Docker, make sure that the Home Assistant container is discoverable by the PS4. This can be achieved by ensuring that the Home Assistant container uses the `host` network driver (by passing `--net=host` to the container when creating, or adding `network_mode: "host"` to your compose file when using `docker-compose`).

## 설정

<div class='note'>

  PlayStation 4 통합구성요소는 `configuration.yaml`의 항목을 사용하지 않습니다. `통합구성요소`을 사용하여 이 연동을 설정해야합니다.

</div>

## 지역 (Regions)

[region](https://www.playstation.com/country-selector/index.html)에 따라 일부 타이틀은 PlayStation Store 데이터베이스에서 다른 SKU를 갖습니다. 해당 타이틀의 표지 그림을 올바르게 검색하려면 설정에서 특정 지역을 선택해야합니다. 
통합구성요소는 제목을 찾을 수 없는 경우 다른 데이터베이스에서 올바른 제목을 찾으려고 시도하지만 시간이 오래 걸리고 잘못된 표지를 가져올 수 있습니다. 

|  Available Regions                                                          | Unavailable Regions        |
| --------------------------------------------------------------------------- | -------------------------- |
| Argentina, Australia, Austria, Bahrain, Belgium, Brazil, Bulgaria,          | China, Japan, Philippines, |
| Canada, Chile, Columbia, Costa Rica, Croatia, Cyprus, Czech Republic,       | Serbia, Ukraine, Vietnam   |
| Denmark, Ecuador, El Salvador, Finland, France, Germany, Greece, Guatemala, |                            |
| Honduras, Hong Kong, Hungary, Iceland, India, Indonesia, Ireland, Israel,   |                            |
| Italy, Korea, Kuwait, Lebanon, Luxembourg, Malta, Malaysia, Mexico,         |                            |
| Middle East, Nederland, New Zealand, Nicaragua, Norway, Oman, Panama,       |                            |
| Peru, Poland, Portugal, Qatar, Romania, Russia, Saudi Arabia, Singapore,    |                            |
| Slovakia, Slovenia, South Africa, Spain, Sweden, Switzerland, Taiwan,       |                            |
| Thailand, Turkey, United Arab Emirates, United Kingdom, United States       |                            |

<div class='note'>
  데이터베이스가 없거나 데이터베이스에 서식만 있는 사용불가한 지역(region)은 구성요소에서 사용할 수 없습니다.
</div>

## 미디어 데이터

PlayStation 4 통합구성요소는 현재 해당 지역의 [PlayStation Store](https://store.playstation.com) 데이터베이스에서 실행 중인 게임 또는 앱에 대한 정보를 가져옵니다.
  
때때로 통합구성요소가 데이터를 전혀 얻지 못하거나 잘못된 데이터를 얻을 수 있습니다. 이 문제를 해결하기 위해 통합구성요소를 통한 텍스트 편집기를 통한 수동 편집이 가능합니다.
  
### 서식 (Formatting)

통합구성요소는 PlayStation Store에서 데이터를 검색 할 때 `configuration.yaml` 파일이 있는 디렉토리와 동일한 디렉토리에 `.ps4-games.json` 이라는 JSON 파일에 저장합니다. 파일의 첫 번째 줄은 `{`이고 마지막 줄은 `}`입니다. 이 줄 사이에는 통합구성요소가 찾은 각 게임이나 앱에 대해 들여쓰기 된 항목이 있습니다. 다음 예와 표를 참조하십시오
  
```json
{
    "CUSA00129": {
        "locked": true,
        "media_content_type": "app",
        "media_image_url": "http://localhost:8123/local/image.jpg",
        "media_title": "Some App"
    },
    "CUSA00123": {
        "locked": false,
        "media_content_type": "game",
        "media_image_url": "https://somerandomurl.com/image.jpg",
        "media_title": "Some Game"
    }
}
```

| Field | Value | Description |
| ----- | ----- | ----------- |
| `locked`             | boolean | Must be `true` or `false`
| `media_content_type` | string  | Must be `game` or `app`
| `media_image_url`    | string  | Any valid url for an image
| `media_title`        | string  | The title of the game or app

예제의 데이터는 2 개의 항목을 보여줍니다.

각 항목은 제목의 SKU ID (예: `CUSA00000`)로 시작하며 값이 `true` 또는 `false` 인 `locked`라는 필드를 갖습니다. 각 항목의 기본값은 `false` 입니다. `locked`가 `true`인 경우 통합구성요소는 해당 게임 또는 앱과 관련된 데이터를 덮어 쓰지 않습니다.

`media_image_url` 값은 유효한 URL일 수 있습니다. 여기에는 홈어시스턴트 인스턴스의 `local directory`가 포함됩니다. 예제의 첫 번째 항목은 `config/www/` 디렉토리에 있는 `image.jpg`라는 파일로 연결됩니다.
  
### 텍스트 편집기로 편집
<div class='note'>
  계속하기 전에 <b>.ps4-games.json</b> 파일의 복사본을 백업하십시오. 포맷에 오류가 있으면 파일이 삭제 될 수 있습니다.
</div>

편집하려면 텍스트 편집기에서 파일을 열고 편집하려는 게임이나 앱을 찾은 다음 변경하려는 값을 편집 한 다음 파일을 저장하십시오. 다음에 콘솔에서 게임이나 앱을 플레이 할 때 변경 사항이 나타납니다.

## 서비스

### `select_source` 서비스

새로운 응용 프로그램/게임을 열고 현재 실행중인 응용 프로그램/게임을 닫습니다. 게임/앱은 엔티티의 소스 목록에 있어야합니다. 게임을 정상적으로 열면 자동으로 추가됩니다.

| Service data attribute | Optional | Example                      | Description                           |
| ---------------------- | -------- | ---------------------------- | ------------------------------------- |
| `entity_id`            | No       | `media_player.playstation_4` | The entity id for your PlayStation 4. |
| `source`               | No       | `Some Game` or `CUSA00123`   | The game/app you want to open. You can use the title or SKU ID. Using the SKU ID will be the most reliable.|

### `send_command` 서비스

PlayStation 4에서 버튼 누르기 에뮬레이션. PS4 Second Screen App에서 사용할 수있는 명령을 에뮬레이트합니다. 이것은 DualShock 4 컨트롤러 버튼과 혼동되지 않습니다.

| Service data attribute | Optional | Example                      | Description                           |
| ---------------------- | -------- | ---------------------------- | ------------------------------------- |
| `entity_id`            | No       | `media_player.playstation_4` | The entity id for your PlayStation 4. |
| `command`              | No       | `ps`                         | The command you want to send.         |

#### 사용 가능한 Commands

지원되는 명령의 전체 목록

| Command  | Button Emulated  |
| -------- | ---------------- |
| `ps`     | PS (PlayStation) |
| `option` | Option           |
| `enter`  | Enter            |
| `back`   | Back             |
| `up`     | Swipe Up         |
| `down`   | Swipe Down       |
| `left`   | Swipe Left       |
| `right`  | Swipe Right      |

## 문제 해결

### Cover Art 문제
PS4에서 표지를 표시하지 않거나 잘못된 표지를 표시하는 게임/제목을 실행중인 경우 [here](https://github.com/ktnrg45/pyps4-2ndscreen/issues) 에 문제를 게시하십시오 .

다음 정보를 반드시 포함하십시오 :
- 국가정보

PS4 엔터티의 상태에서 찾은 다음 속성의 정확한 값뿐만 아닌 아래 내용까지  
- media_title
- media_content_id
