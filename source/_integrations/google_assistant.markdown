---
title: 구글 어시스턴트
description: Setup for Google Assistant integration
logo: google-assistant.png
ha_category:
  - Voice
featured: true
ha_release: 0.56
ha_codeowners:
  - '@home-assistant/cloud'
---

The `google_assistant` integration allows you to control things via Google Assistant on your mobile, tablet or Google Home device.
`google_assistant`통합구성요소를 통해 휴대기기, 태블릿 또는 Google Home 기기에서 Google 어시스턴트를 통해 사물을 제어 할 수 있습니다.

## 홈어시스턴트 클라우드를 통한 자동 설정

[Home Assistant Cloud](/cloud/)를 사용하면 몇 번의 클릭만으로 Home Assistant 인스턴스를 Google Assistant에 연결할 수 있습니다. Home Assistant Cloud를 사용하면 dynamic DNS, SSL 인증서 또는 라우터의 개방 포트를 처리 할 필요가 없습니다. 사용자 인터페이스를 통해 로그인하면 클라우드와의 보안 연결이 설정됩니다. Home Assistant Cloud는 30 일 무료 평가판을 사용한 후에 유료 구독이 필요합니다.

홈 어시스턴트 클라우드 사용자의 경우 문서를 찾을 수 있습니다 [여기](https://www.nabucasa.com/config/google_assistant/).

## 수동 설정 (Manual setup)

Google 어시스턴트 통합구성요소 (홈어시스턴트 클라우드 제외)는 Google이 어시스턴트 앱을 설정해야하는 방식으로 인해 약간 더 설정해야합니다.

<div class='note warning'>

Google 어시스턴트를 사용하려면 홈어시스턴트 설정이 [호스트 이름 및 SSL 인증서로 외부에서 액세스 가능](/docs/configuration/remote/)해야합니다. 아직 설정하지 않았다면, 먼저 설정해야합니다. 이 작업을 수행하기 위해 DNS를 변경 한 경우 DNS 변경 사항이 전파 될 때까지 최대 48 시간을 허용했는지 확인하십시오. 그렇지 않으면 Google이 서버에 도달하지 못할 수 있습니다.

</div>

계정 연결을 해제하거나 다시 연결하지 않고 장치를 업데이트 할 수있는 서비스 계정 [서비스 계정 키 생성](https://console.cloud.google.com/apis/credentials/serviceaccountkey)을 만들어야합니다, ([아래참조](#troubleshooting-the-request_sync-service)). 서비스 계정을 제공하지 않으면`google_assistant.request_sync` 서비스가 노출되지 않습니다. 이 설정 키를 셋업하려면 "Ok Google, 장치 동기화해줘" 명령을 사용할 수 있으므로 이 설정 키를 설정하는 것이 좋습니다. 이 구성 요소(component)를 설정 한 후 Google Assistant 통합구성요소를 통해 제어하려는 Home Assistant에 새 장치를 추가 할 때마다 이 서비스 (또는 명령)를 호출해야합니다. 자세한 내용은 다음 2 단계를 참조하십시오.

1. [Actions on Google console](https://console.actions.google.com/)에서 새 프로젝트를 만듭니다.
    1. 프로젝트 Add/Import 를 하고 이름을 지정해 줍니다.
    2. `Smart Home` 클릭하고, `Smart home` recommendation을 선택하십시오.
    3. `Build your Action`을 클릭하고, `Add Action(s)`를 선택하십시오. Home Assistant의 URL추가: `Fulfillment URL` 상자의 `https://[YOUR HOME ASSISTANT URL:PORT]/api/google_assistant`에서 `[YOUR HOME ASSISTANT URL:PORT]`에 도메인/IP 주소 및 포트로 홈어시스턴트에 접근 할 수 있는 포트로 바꿉니다. 
    4. 클릭 `Save`하십시오. 그런 다음 `Overview`를 클릭하면 앱 세부 정보 화면으로 돌아갑니다.
2. 앱이 Home Assistant와 상호 작용하려면 `Account linking`이 필요합니다. `quick setup`섹션에서 설정.
    1. 기본 설정 인 `No, I only want to allow account creation on my website`를 그대로두고 `Next`을 선택.
    2. `Linking type`에서 `OAuth`및 `Authorization Code`를 선택하십시오. `next`을 클릭
    3. Client ID: `https://oauth-redirect.googleusercontent.com/`, 마지막 슬래시를 놓치지 마십시오. 
    4. Client Secret: 홈어시스턴트에는 이 필드가 필요하지 않습니다.
    5. Authorization URL (실제 URL로 교체): `https://[YOUR HOME ASSISTANT URL:PORT]/auth/authorize`.
    6. Token URL (실제 URL로 교체): `https://[YOUR HOME ASSISTANT URL:PORT]/auth/token`.  `Next` 클릭
    7. Configure your client: `email` 입력, `Add scope` 클릭, `name` 입력 `Add scope` 또 클릭.
    8. `Google to transmit clientID and secret via HTTP basic auth header`를 **체크하지 말고** `Next` 클릭
    9. Testing instructions: 아무거나 입력하십시오. 이 앱을 제출하지 않기 때문에 중요하지 않습니다. `save` 클릭

    <img src='/images/integrations/google_assistant/accountlinking.png' alt='Screenshot: Account linking'>

3. 페이지 상단의 `Develop`탭을 선택한 다음 오른쪽 상단에서 `Test`버튼을 선택하여 the draft version Test App을 생성하십시오.
4. `google_assistant` 통합구성요소 설정을 `configuration.yaml` 파일에 추가하고 아래 [configuration guide](#configuration)에 따라 홈어시스턴트를 다시 시작하십시오.
5. (앱 버전이 약간 다를 수 있습니다.) Google Home 앱을 열고 `settings`으로 이동하십시오.
6. `Add...`,`+ Set up or add`,`+ Set up device`을 클릭하고 `Have something already setup?` 를 클릭하십시오. 
'새로 추가'아래에 '[test] 앱 이름'이 있어야합니다. 이를 선택하면 홈 어시스턴트 인스턴스에 로그인하기 위해 브라우저로 이동 한 다음 원하는 경우 장치의 방과 별칭을 설정할 수있는 화면으로 다시 리디렉션됩니다.

<div class='note'>

휴대 전화의 홈 화면에 홈 어시스턴트를 추가 한 경우, 먼저 홈 화면에서 제거해야합니다, 그렇지 않으면이 HTML5 앱이 브라우저 대신 표시됩니다. 이를 사용하면 홈어시스턴트가 Google Home 앱으로 다시 리디렉션되지 않습니다.

</div>

1. 다른 가족 구성원이 장치를 제어 할 수 있게 하려면:
    1. [Actions on Google console](https://console.actions.google.com/)에서 생성 한 프로젝트의 설정으로 이동(https://console.actions.google.com/).
    2. `Test -> Simulator` 클릭, 오른쪽 상단에서 `share` 아이콘을 클릭하십시오. 화면의 지시를 따르십시오:
        1. 새로운 팀구성원 추가 : `Settings -> Permission` 이동, `Add` 클릭, 새로운 사용자의 이메일 주소를 입력하고 `Project -> Viewer` 역할을 선택.
        2. 링크를 복사하여 새 사용자와 공유.
        3. 새 사용자가 자신의 Google 계정으로 링크를 열면 계정에서 draft test app을 사용할 수 있습니다.
    3. 새 사용자가 `Google 어시스턴트`앱으로 이동하여 `[Test] 앱 이름`을 계정에 추가하도록합니다.
2. Google 서버에 대한 상태보고를 적극적으로 지원하고 (설정 옵션 `report_state`), `google_assistant.request_sync`를 지원하려면, 서비스 계정을 생성해야합니다
    1. GCP 콘솔에서, [Create Service account key](https://console.cloud.google.com/apis/credentials/serviceaccountkey) 페이지로 이동하십시오. 
    2. 서비스 계정 목록에서 새 서비스 계정을 선택하십시오.
    3. 서비스 계정 이름 필드에 이름을 입력하십시오.
    4. 서비스 계정 ID 필드에 ID를 입력하십시오.
    5. 역할(role) 목록에서 서비스 계정을 선택하십시오. > 서비스 계정 토큰 생성기.
    6. Key type에서 JSON 옵션을 선택하십시오.
    7. create을 클릭. 컴퓨터로의 key 다운로드가 포함 된 JSON 파일이 만들어집니다.
    8. 이 파일 또는 파일의 정보를 사용하여 설정에 `service_account` 키를 직접 추가하십시오.
    9. [Google API Console](https://console.cloud.google.com/apis/api/homegraph.googleapis.com/overview)로 이동합니다.
    10. 프로젝트를 선택하고 HomeGraph API 사용을 클릭하십시오.


### 설정 (Configuration)

이제 설정을`configuration.yaml` 파일에 추가하십시오. :

```yaml
# Example configuration.yaml entry
google_assistant:
  project_id: YOUR_PROJECT_ID
  service_account: !include SERVICE_ACCOUNT.JSON
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
  description: Google 콘솔에서 수행 한 작업(Actions)의 프로젝트 ID (`words-2ab12` 같은)
  required: true
  type: string
secure_devices_pin:
  description: "보안 장치와 상호 작용할 때 말하는 핀 코드입니다."
  required: false
  type: string
  default: ""
api_key:
  description: HomeGraph API 키 (`google_assistant.request_sync` 서비스용). service_account가 지정된 경우에는 필요하지 않습니다. 이 기능은 더 이상 사용되지 않으며 0.105에서 제거 될 예정이므로, 지금 `service_account`를 설정해야합니다.
  required: false
  type: string
service_account:
  description: 서비스 계정 정보. 다운로드 한 JSON 파일에 include 문을 사용하거나 여기에 데이터를 직접 입력하거나 secrets 파일을 사용하여 채울 수 있습니다.
  required: false
  type: map
  keys:
    private_key:
      description: PEM 형식의 개인 키
      required: true
      type: string
    client_email:
      description: 서비스 이메일 주소
      required: true
      type: string
report_state:
  description: 엔터티에 대한 상태 변경 사항을 적극적으로보고합니다. Google 어시스턴트가 사전 상태를 알고 있기 때문에 여러 엔티티에 영향을 미치는 작업에 대한 응답 시간이 단축됩니다. 시각적 컨트롤의 일부 기능에도 필요합니다.
  required: false
  default: false
  type: boolean
expose_by_default:
  description: "기본적으로 지원되는 모든 도메인에 장치를 노출합니다. `exposed_domains` 도메인이 설정되면 기본적으로이 도메인 만 노출됩니다. `expose_by_default`가 false로 설정되면, 장치는`entity_config`에 수동으로 노출되어야합니다."
  required: false
  default: true
  type: boolean
exposed_domains:
  description: 만일 `expose_by_default`가 true로 설정된 경우 Google Assistant에 표시 할 엔티티 도메인 목록입니다. `expose_by_default`가 false로 설정되어 있으면 효과가 없습니다.
  required: false
  type: list
entity_config:
  description: Google Assistant의 엔티티 특정 구성
  required: false
  type: map
  keys:
    '`<ENTITY_ID>`':
      description: 설정할 entity
      required: false
      type: map
      keys:
        name:
          description: Google 어시스턴트에 표시 할 엔티티 이름
          required: false
          type: string
        expose:
          description: 강제로 노출/제외시킬 entity.
          required: false
          type: boolean
          default: true
        aliases:
          description: 이 엔티티를 참조하는 데 사용할 수있는 별명
          required: false
          type: list
        room:
          description: 이 기기를 Google 어시스턴트 룸과 연결할 수 있습니다.
          required: false
          type: string
{% endconfiguration %}

### 사용 가능한 도메인 (Available domains)

현재 다음 유형의 도메인을 기본 유형과 함께 Google 어시스턴트와 함께 사용할 수 있습니다. :

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

### 보안 장치 (Secure Devices)

`lock` 도메인, `alarm_control_panel` 도메인 및 장치 유형이있는 `garage` 및 `door`가 있는 `covers`를 포함하여 특정 장치는 안전에 대해 고려해야 합니다. 

By default these cannot be opened by Google Assistant unless a `secure_devices_pin` is set up. To allow opening, set the `secure_devices_pin` to something and you will be prompted to speak the pin when opening the device. Closing or locking these devices does not require a pin.
`secure_devices_pin`이 설정되어 있지 않으면 기본적으로 Google Assistant에서 열 수 없습니다. 열기를 허용하려면 `secure_devices_pin`을 설정하면 장치를 열 때 핀을 말하라는 메시지가 표시됩니다. 이 장치를 닫거나 잠그는 데 핀이 필요하진 않습니다

For the Alarm Control Panel if a code is set it must be the same as the `secure_devices_pin`. If `code_arm_required` is set to `false` the system will arm without prompting for the pin.
알람 제어판의 경우 코드가 설정되어 있으면 `secure_devices_pin`과 동일해야합니다. `code_arm_required`가 false로 설정되면 시스템은 핀을 요구하지 않고 작동합니다.

### 미디어 플레이어 소스 (Media Player Sources)

Media Player sources are sent via the Modes trait in Google Assistant.
There is currently a limitation with this feature that requires a hard-coded set of settings. Because of this, the only sources that will be usable by this feature [are listed here](https://developers.google.com/actions/reference/smarthome/traits/modes).
미디어 플레이어 소스는 Google 어시스턴트의 모드 특성을 통해 전송됩니다. 현재 이 기능에는 하드 코딩 된 설정 세트가 필요한 제한 사항이 있습니다. 이 때문에이 기능에서 사용할 수있는 유일한 소스가 [여기](https://developers.google.com/actions/reference/smarthome/traits/modes)있습니다. 

#### 명령 사례 (Example Command)

"Hey Google, change input source to TV on Living Room Receiver"
"헤이 Google, 거실 수신기에서 TV로 입력 소스 변경해줘" 

### 방/지역 지원 (Room/Area support)

Entities that have not been explicitly assigned to rooms but have been placed in Home Assistant areas will return room hints to Google with the devices in those areas.
방에 명시 적으로 할당되지 않았지만 홈어시스턴트 영역(Area)에 배치 된 엔티티는 해당 영역(Area)의 장치를 사용하여 방 힌트를 Google에 반환합니다.

### 냉난방기 작동 모드 (Climate Operation Modes)

There is not an exact 1-1 match between Home Assistant and Google Assistant for the available operation modes.
Here are the modes that are currently available:
사용 가능한 작동 모드에 대해 홈 어시스턴트와 Google 어시스턴트가 정확히 1:1로 일치하지 않습니다. 현재 사용 가능한 모드는 다음과 같습니다.

- off
- heat
- cool
- heatcool (auto)
- fan-only
- dry
- eco

### REQUEST_SYNC 서비스 문제 해결 (Troubleshooting the request_sync service)

Syncing may fail after a period of time, likely around 30 days, due to the fact that your Actions on Google app is technically in testing mode and has never been published. Eventually, it seems that the test expires. Control of devices will continue to work but syncing may not. If you say "Ok Google, sync my devices" and get the response "Unable to sync Home Assistant" (or whatever you named your project), this can usually be resolved by going back to your test app in the [Actions on Google console](https://console.actions.google.com/) and clicking `Simulator` under `TEST`. Regenerate the draft version Test App and try asking Google to sync your devices again. If regenerating the draft does not work, go back to the `Action` section and just hit the `enter` key for the URL to recreate the Preview.
Google 앱에서의 작업이 기술적으로 테스트 모드에 있으며 게시된 적이 없기 때문에 약 30 일 후에 동기화가 실패 할 수 있습니다. 이경우는 결국 테스트가 만료 된 것 같습니다. 장치 제어는 계속 작동하지만 동기화되지 않을 수 있습니다. 당신이 "OK 구글, 장치 동기화해줘"를 말하고 "홈어시스턴트를 동기화 할 수 없습니다" 응답을 받을 경우 (또는 당신이 설정한 프로젝트 이름), 이는 보통 [Actions on Google console](https://console.actions.google.com/)의 `TEST`에서 `Simulater`를 클릭하는 방식으로 테스트 응용 프로그램에 다시 이동하여 해결할 수 있습니다. 초안 버전 Test App을 재생성하고 Google에 기기를 다시 동기화하도록 요청하십시오. draft를 재생성 할 수 없는 경우 `Action` 섹션으로 돌아가서 URL의 `enter` 키를 누르면 미리보기가 다시 생성됩니다.

The `request_sync` service requires that the initial sync from Google includes the `agent_user_id`. If not, the service will log an error that reads something like "Request contains an invalid argument". If this happens, then [unlink the account](https://support.google.com/googlenest/answer/7126338) from Home Control and relink.
`request_sync` 서비스에는 Google의 초기 동기화에 agent_user_id가 포함되어야합니다. 그렇지 않은 경우 서비스는 "요청에 잘못된 인수가 포함되어 있습니다"와 같은 오류를 기록합니다. 이 경우 홈 컨트롤에서 [계정 분리하기](https://support.google.com/googlenest/answer/7126338)하고 다시 연결하십시오.

The `request_sync` service may fail with a 404 if the `project_id` of the HomeGraph API differs from the `project_id` of the Actions SDK found in the preferences of your project on [Actions on Google console](https://console.actions.google.com). Resolve this by:
HomeGraph API의 `project_id`와 [Actions on Google console](https://console.actions.google.com)의 프로젝트 환경 설정에있는 Actions SDK의 `project_id`와 다른 경우 `request_sync` 서비스가 404로 실패 할 수 있습니다. 이는 다음으로 해결합니다. :

  1. Removing your project from the [Actions on Google console](https://console.actions.google.com).
  1. [Actions on Google console](https://console.actions.google.com)에서 프로젝트 제거.
  2. Add a new project to the [Google Cloud API Console](https://console.cloud.google.com). Here you get a new `project_id`.
  2. [Google Cloud API 콘솔] (https://console.cloud.google.com)에 새 프로젝트를 추가하십시오. 새로운 `project_id`를 만듭니다.
  3. 새 프로젝트에 HomeGraph API를 사용하십시오.
  4. 새로운 API 키를 생성하십시오.
  5. 다시 [Actions on Google console](https://console.actions.google.com/)에서 새 프로젝트를 만듭니다. 위에서 설명했듯이. 다시 'Build under the Actions SDK box' 단계에서 새로 만든 프로젝트를 선택하십시오. 

### NGINX 문제 해결 (Troubleshooting with NGINX)

When using NGINX, ensure that your `proxy_pass` line *does not* have a trailing `/`, as this will result in errors. Your line should look like:
NGINX를 사용하는 경우 `proxy_pass`라인에 `/` 후행 이 *없는지 확인하십시오*. 오류가 발생할 수 있습니다. 라인은 다음과 같아야합니다.

    proxy_pass http://localhost:8123;

### 연결 해제 및 다시 연결 (Unlink and relink)

If you're having trouble with *Account linking failed* after you unlinked your service, try clearing the browser history and cache.
서비스를 연결을 해제 한 후 *계정 연결에 실패* 문제가 발생하는 경우, 브라우저 기록 및 캐시를 지워보세요.