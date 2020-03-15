---
title: 구글 어시스턴트(Google Assistant)
description: Setup for Google Assistant integration
logo: google-assistant.png
ha_category:
  - Voice
featured: true
ha_release: 0.56
ha_codeowners:
  - '@home-assistant/cloud'
---

`google_assistant` 통합구성요소는 스마트폰, 태블릿 또는 구글 홈의 구글 어시스턴트를 통해서 장치들을 제어할 수 있게 해줍니다.

## 홈어시스턴트 클라우드를 통한 자동 설정

[홈어시스턴트 클라우드](/cloud/)를 사용하면, 클릭 몇번만으로 여러분의 홈어시스턴트와 구글 어시스턴트를 연동할 수 있습니다. 홈어시스턴트 클라우스에서는 다이나믹DNS나 SSL인증서 그리고 공유기의 포터 연동에 대해 신경쓰지 않아도 되고, 단지 UI를 통해 로그인하면 클라우드와 보안 접속이 가능합니다. 홈어시스턴트 클라우드는 정기구독료를 내야 하며 30일 무료체험을 해볼 수 있습니다.

홈어시스턴트 클라우드 사용자는 이 [문서](https://www.nabucasa.com/config/google_assistant/)를 참고하세요.

## 수동으로 설정

홈어시스턴트 클라우드가 아닌 구글 어시스턴트 통합구성요소를 수동으로 설정하려면 구글의 요구사항과 어시스턴트 앱 설정 과정에 조금 복잡한 과정을 거쳐야 합니다.

<div class='note warning'>

구글 어시스턴트를 사용하기 위해서는 홈어시스턴트에 [외부 접속 가능한 도메인명과 SSL 인증서 설치](/docs/configuration/remote/)가 필요합니다. 이 설정을 하지 않았다면 먼저 설정해주셔야 합니다. 도메인을 DNS에 설정하고 구글이 여러분의 도메인이 정상적인지 체크하기 위해 보통 48시간 정도 시간이 소요됩니다.
</div>

여러분의 기기를 구글 어시스턴트와 연결하기 위해서는 [구글 서비스 계정을 생성](https://console.cloud.google.com/apis/credentials/serviceaccountkey)해야 합니다([아래 참고](#troubleshooting-the-request_sync-service)). 구글 서비스 계정을 만들지 않으면  `google_assistant.request_sync` 서비스를 사용할 수 없습니다. 이것은 "오케이 구글, sync my devices"라는 명령으로 여러분의 HA에 연동된 기기를 구글 어시스턴트가 사용하도록 업데이트할 수 있게 합니다. 한번 설정하면 이 명령을 통해 홈어시스턴트에 새로운 기기를 추가하고 구글 어시스턴트가 제어할 수 있게 만듭니다.

1. [Actions on Google console](https://console.actions.google.com/)에서 Create a new project를 클릭하여 여러분의 프로젝트를 만드세요.
    1. New Project를 선택하여 새로운 프로젝트를 생성하고 적절한 프로젝트명을 입력합니다.
    2. 다음 화면에서 `Smart Home` 카드를 선택합니다.
    <img src='/images/integrations/google_assistant/gha01.png' alt='Screenshot: Smart Home Card'><br><br>

    3. 다음 화면 중간에 `Build your Action` 에서 `Add Action(s)`을 클릭합니다. `Fulfillment URL` 아래 주소입력란에 본인의 홈어시스턴트 외부 접속 도메인을 `https://[YOUR HOME ASSISTANT URL:PORT]/api/google_assistant` 과 같은 형식으로 입력합니다. 외부포트가 없으면 `:PORT`는 생략합니다.
    <img src='/images/integrations/google_assistant/gha02.png' alt='Screenshot: Add Actions'><br><br>

    4. 우측 상단 `Save` 버튼을 누르면 설정이 끝납니다.

2. 이어지는 과정으로 좌측 메뉴에서 `Account linking`을 선택합니다. 이것은 홈어시스턴트와 연동하는데 필요한 과정입니다.

    1. Client ID에 `https://oauth-redirect.googleusercontent.com/`을 복사해서 붙여넣습니다. 마지막에 붙은 슬래시( / )를 제거하면 안됩니다!<img src='/images/integrations/google_assistant/gha04.png' alt='Screenshot: Account Linking'><br><br>

    2. Client Secret은 아무거나 입력해도 됩니다. 홈어시스턴트에서는 사용하지 않습니다.

    3. Authorization URL은 `https://[YOUR HOME ASSISTANT URL:PORT]/auth/authorize` 와 같이 입력합니다. 본인의 홈어시스턴트 URL을 적용해서 입력합니다.
    4. Token URL은 `https://[YOUR HOME ASSISTANT URL:PORT]/auth/token`와 같은 형식으로 입력고 `Next` 버튼을 누릅니다.
    5. 스코프 설정에서 `email`을 입력하고 `Add scope`를 눌러 추가된 입력란에 `name`이라고 씁니다. <img src='/images/integrations/google_assistant/gha05.png' alt='Screenshot: Add Scope'><br><br>

    6. `Google to transmit clientID and secret via HTTP basic auth header`를 **절대로** 체크하지 마시고 `Next` 버튼을 누릅니다.

    7. `Save` 버튼을 눌러 저장합니다.

3. 상단의 `Test` 버튼을 눌러 테스트 앱을 생성합니다. 이때
Enable Web & App Activity 팝업 화면이 나오면 Visit Activity Controls을 눌러 모든 체크박스를 클릭해서 동의해줍니다. 이것은 구글 어시스턴트를 사용하기 위해 웹과 앱에서 활동 추적기능을 켜두는 것입니다.<img src='/images/integrations/google_assistant/gha06.png' alt='Screenshot: Web & App Activity 설정 1'><br><br><img src='/images/integrations/google_assistant/gha07.png' alt='Screenshot: Web & App Activity 설정 2'><br><br>

4. `google_assistant` 통합구성요소를  `configuration.yaml` 파일에 추가하고 홈어시스턴트를 재시동합니다. 아래 [설정 가이드](#configuration)를 참고하세요.

5. (스마트폰 앱의 버전마다 화면이 다를 수 있습니다) 구글홈 앱에서 `Settings`을 선택합니다.
6. 우측 상단에 `+` 버튼을 누르고 `+ 기기 설정(Set up device)`를 클릭하면 `새 기기 설정`, `이미 설정된 기기가 있나요?`가 나옵니다. `이미 설정된 기기가 있나요?`를 선택하면 `[test] 앞서 설정한 앱 이름` 이란 이름이 `새로 추가(Add new)` 밑에 나타나는지 확인합니다. [test] 앱을 선택하면 홈어시스턴트로 로그인하는 화면에서 계정과 비번을 입력해서 로그인 합니다. 이후 다시 구글홈 앱으로 돌아와서 기기의 집과 룸 이름, 그리고 별명을 설정할 수 있습니다.

<div class='note'>

이전에 홈어시스턴트를 스마트폰의 홈스크린에 단축아이콘으로 저장했다면 홈스크린에서 삭제해야 구글홈 앱에서 홈어시스턴트로 로그인 과정이 실행됩니다. 그렇지 않으면 중간에 로그인하는 과정에서 단축아이콘으로 저장한 홈어시스턴트 HTML5 앱이 동작해서 구글홈앱으로 복귀하지 않습니다.
</div>

1. 다른 가족이 집안 기기를 제어할 수 있게 하려면(역자주: 아래 내용은 구글에서 더이상 지원하지 않는 것으로 보입니다. 이 기능은 구글홈 앱에서 구성원 초대로 가족이 제어하게 만들 수 있습니다):
    1. Go to the settings for the project you created in the [Actions on Google console](https://console.actions.google.com/).
    2. Click `Test -> Simulator`, then click `Share` icon in the right top corner. Follow the on-screen instruction:
        1. Add team members: Got to `Settings -> Permission`, click `Add`, type the new user's e-mail address and choose `Project -> Viewer` role.
        2. Copy and share the link with the new user.
        3. When the new user opens the link with their own Google account, it will enable your draft test app under their account.
    3. Have the new user go to their `Google Assistant` app to add `[test] your app name` to their account.
2. 구글 서버와 실시간으로 상태 정보를 교환하거나(`report_state` 옵션)  `google_assistant.request_sync`를 사용하기 위해서는 서비스 계정 키를 발급받아야 합니다.
    1. In the 구글 클라우드 플랫폼(GCP) 콘솔에 Console, go to the [Create Service account key](https://console.cloud.google.com/apis/credentials/serviceaccountkey) page.
    2. 상단에 +Create Credentials 선택하고 Service account를 클릭합니다. 이때 본인의 프로젝트가 선택되어 있어야 합니다.<img src='/images/integrations/google_assistant/gha10.png' alt='Screenshot: Sevice Account 설정 1'><br><br>

    3. Service account name 입력란에 적절한 이름을 입력합니다.<img src='/images/integrations/google_assistant/gha11.png' alt='Screenshot: Sevice Account 설정 2'><br><br>

    4. Service account ID는 자동으로 만들어지는데 원하면 바꿀 수 있습니다.

    5. Create 버튼을 누르면 Service Account Permissions을 설정하는 화면이 나옵니다. Select a role에서  Service Accounts > Service Account Token Creator를 선택합니다.<img src='/images/integrations/google_assistant/gha12.png' alt='Screenshot: Sevice Account 설정 3'><br><br><img src='/images/integrations/google_assistant/gha13.png' alt='Screenshot: Sevice Account 설정 4'><br><br>

    6. CREATE KEY 버튼을 누르고 키 타입을 JSON으로 선택합니다.<img src='/images/integrations/google_assistant/gha14.png' alt='Screenshot: Sevice Account 설정 5'><br><br>

    7. CREATE 버튼을 눌러 JSON 파일을 다운로드 받습니다. 이 파일의 이름을 service_account.json으로 바꾸고 홈어시스턴트의 `/config/` 폴더에 업로드 합니다.

    8. `configuration.yaml`파일을 편집하여 아래 설정을 참고하여 `service_account` 항목에 해당 파일을 `!include`합니다.
    9. [Google API Console](https://console.cloud.google.com/apis/api/homegraph.googleapis.com/overview)로 이동합니다.

    10. 프로젝트를 선택하고 Enable HomeGraph API를 클릭합니다.<img src='/images/integrations/google_assistant/gha15.png' alt='Screenshot: HomeGraph API'>


### Configuration

`configuration.yaml` 파일에서 구글 어시스턴트를 다음과 같이 설정할 수 있습니다 file, such as:

```yaml
# Example configuration.yaml entry
google_assistant:
  project_id: YOUR_PROJECT_ID
  service_account: !include service_account.json
  report_state: true
  exposed_domains:
    - switch
    - light
  entity_config:
    switch.kitchen:
      name: CUSTOM_NAME_FOR_GOOGLE_ASSISTANT
      aliases:
        - BRIGHT_LIGHTS
        - ENTRY_LIGHTS
    light.living_room:
      expose: false
      room: LIVING_ROOM
```

{% configuration %}
project_id:
  description: Actions on Google console에서 만든 프로젝트 ID (`단어-2ab12`와 비슷한 형식입니다)
  required: true
  type: string
secure_devices_pin:
  description: "secure device와 연동하기 위한 pin code"
  required: false
  type: string
  default: ""
api_key:
  description: HomeGraph API key ( `google_assistant.request_sync` 서비스 연결을 위한). `service_account`를 설정했다면 불필요합니다.  **홈어시스턴트 0.105 이후 버전에서는 사용하지 않습니다** `service_account`를 꼭 설정하세요!
  required: false
  type: string
service_account:
  description: Service account 정보. JSON 파일을 다운로드 받아서 `!include`로 파일을 연동하거나 파일안의 내용을 직접 입력할 수 있습니다. 아래 `private_key`와 `client_email`은 직접 입력할 때 옵션입니다.
  required: false
  type: map
  keys:
    private_key:
      description: Private key in PEM format
      required: true
      type: string
    client_email:
      description: Service email address
      required: true
      type: string
report_state:
  description: 엔티티에 변화가 생길때 실시간 연동. 구글 어시스턴트가 먼저 어떤 상태인지 파악할 수 있게 되므로 여러 엔티티들 사이에 영향을 주는 액션에 대해 응답 속도를 빠르게 만듭니다. 몇몇 visual control 기능을 사용하기 위해서도 필요한 옵션입니다.
  required: false
  default: false
  type: boolean
expose_by_default:
  description: "지원하는 도메인의 기기들을 구글 어시스턴트와 기본적으로 연동할지 여부를 결정합니다.  `exposed_domains` 을 설정하면 해당 도메인의 기기들만 연동합니다. `expose_by_default` 값을 false로 설정하면 기기들을 `entity_config` 옵션으로 연동 여부를 설정해야 합니다."
  required: false
  default: true
  type: boolean
exposed_domains:
  description: 구글 어시스턴트와 연동할 도메인을 설정합니다. `expose_by_default` 값이 true인 경우만 동작하며 `expose_by_default` 값이 false인 경우 동작하지 않고 `entitiy_config`으로 개별 기기를 설정해야 합니다.
  required: false
  type: list
entity_config:
  description: 구글 어시스턴트와 연동할 특정 엔티티를 설정합니다.
  required: false
  type: map
  keys:
    '`<ENTITY_ID>`':
      description: 하위 옵션
      required: false
      type: map
      keys:
        name:
          description: 구글 어시스턴트와 연동할 엔티티 이름
          required: false
          type: string
        expose:
          description: 연동 여부를 설정
          required: false
          type: boolean
          default: true
        aliases:
          description: 엔티티에 대해 별명을 설정
          required: false
          type: list
        room:
          description: 해당 기기가 연동할 구글 어시스턴트의 룸 설정
          required: false
          type: string
{% endconfiguration %}

### Available domains

현재 구글 어시스턴트와 연동할 수 있는 도메인과 기본값은 다음과 같습니다:

- camera (streaming, requires compatible camera)
- group (on/off)
- input_boolean (on/off)
- scene (on)
- script (on)
- switch (on/off)
- fan (on/off/speed)
- light (on/off/brightness/rgb color/color temp)
- lock (lock/unlock (to allow assistant to unlock, set the `allow_unlock` key in configuration))
- cover (on/off/set position)
- media_player (on/off/set volume (via set volume)/source (via set input source))
- climate (temperature setting, hvac_mode)
- vacuum (dock/start/stop/pause)
- sensor (temperature setting for temperature sensors and humidity setting for humidity sensors)
- Alarm Control Panel (arm/disarm)

### Secure Devices

`lock`이나 `alarm_control_panel` 도메인, `garage`나  `door`의 `cover` 도메인의 특정 기기는 보안이 적용됩니다.

이들 기기는 기본적으로 `secure_devices_pin`을 제공하지 않으면 구글 어시스턴트는 열림 제어를 실행하지 않습니다. 해당 기기의 열림을 제어하고 싶다면  `secure_devices_pin`을 설정하고 이 핀코드를 말하면 기기의 열림 기능을 작동시킬 수 있습니다. 닫거나 잠금 기능을 위해서는 핀코드가 필요없습니다.

코드를 설정한 Alarm Control Panel은  `secure_devices_pin`과 동일해야합니다. 만일  `code_arm_required`를 `false`로 설정했다면, 핀코드와 상관없이 장비를 실행합니다.

### 미디어 플레이어 소스

Media Player sources are sent via the Modes trait in Google Assistant.
There is currently a limitation with this feature that requires a hard-coded set of settings. Because of this, the only sources that will be usable by this feature [are listed here](https://developers.google.com/actions/reference/smarthome/traits/modes).

#### 명령 예시

"Hey Google, change input source to TV on Living Room Receiver"

### Room/Area support

Entities that have not been explicitly assigned to rooms but have been placed in Home Assistant areas will return room hints to Google with the devices in those areas.

### Climate Operation Modes

There is not an exact 1-1 match between Home Assistant and Google Assistant for the available operation modes.
Here are the modes that are currently available:

- off
- heat
- cool
- heatcool (auto)
- fan-only
- dry
- eco

### Troubleshooting the request_sync service

특정 기간이 지나서 동기화를 하는 경우(예를 들어 30일 이후) 구글 어시스턴트와 홈어시스턴트 간에 기기 동기화가 실패할 수 있습니다. 이것은 Actions on Google app이 테스트 모드이고 출시를 하지 않았기 때문입니다. 따라서 테스트가 종료됐다고 볼 수 있습니다. 연동한 기기는 계속 사용할 수 있지만 기기 동기화는 동작하지 않습니다. "Ok Google, sync my devices"라고 말하면 구글홈(구글 어시스턴트)은 "Unable to sync Home Assistant"(또는 프로젝트 이름)이라고 대답할 것입니다. 이것을 해결하기 위해서는 [Actions on Google console](https://console.actions.google.com/)에서 테스트 앱을 선택하고 `TEST` 메뉴 아래 `Simulator`를 클릭하여 앱을 재생성하면 됩니다. Test App을 재생성한 다음 다시 동기화를 시켜보세요. 테스트 앱을 재생성할 수 없다면  Develop 밑에 `Action` 메뉴로 돌아가서 새로 키를 발급받아야 합니다.

`request_sync` 서비스는 `agent_user_id`를 통해 구글과 최초 동기화가 필요합니다. 그렇지 않으면 "Request contains an invalid argument"와 같은 에러 로그가 쌓이게 됩니다. 이 경우 [unlink the account](https://support.google.com/googlenest/answer/7126338)를 참고하여 재설정해야 합니다.

`request_sync` 서비스가 404 에러로 실패할 수 있는데, HomeGraph API의 `project_id`가 [Actions on Google console](https://console.actions.google.com)에 있는 Actions SDK의 `project_id`와 달라서 발생하는 경우입니다. 이것을 해결하려면:

  1. [Actions on Google console](https://console.actions.google.com)에서 프로젝트를 삭제합니다.
  2. [Google Cloud API Console](https://console.cloud.google.com)에서 새로 프로젝트를 생성합니다. 여기서 만든 `project_id`를 사용하세요.
  3. 새로운 프로젝트에서 Enable HomeGraph API 버튼을 클릭하세요.
  4. 새로운 API 키를 생성합니다.
  5. 다시, [Actions on Google console](https://console.actions.google.com/)에서 프로젝트를 생성하면서 'Build under the Actions SDK box'를 2번에서 생성한 프로젝트로 선택합니다. 이렇게 하면 동일한 `project_id`를 사용할 수 있습니다.

### Troubleshooting with NGINX

NGINX를 사용할 때 `proxy_pass` 끝이 역슬래시 `\`로 끝나지 않도록 해야 에러가 발생하지 않습니다. 다음과 같은 형식으로 작성해야합니다:

    proxy_pass http://localhost:8123;

### Unlink and relink

*Account linking failed* 문제가 발생하면 서비스를 재연결하세요. 브라우저 히스토리와 캐시도 모두 삭제해보시기 바랍니다.
