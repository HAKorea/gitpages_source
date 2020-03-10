---
title: 도어버드(DoorBird)
description: Instructions on how to integrate your DoorBird video doorbell with Home Assistant.
logo: doorbird.png
ha_category:
  - Doorbell
  - Camera
  - Switch
ha_release: 0.54
ha_iot_class: Local Push
ha_codeowners:
  - '@oblogic7'
---

`doorbird` 구현을 통해 [DoorBird](https://www.doorbird.com/) 장치를 Home Assistant에 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Camera](#camera) - 실시간 및 과거 이벤트 기반 이미지를 봅니다.
- [Switch](#switch) - 릴레이 및 카메라를 나이트 모드로 제어할 수 있습니다.

## 셋업

홈 어시스턴트와 함께 사용하려면 Doorbird 앱에서 새 계정을 설정하는 것이 좋습니다. settings (cog icon)-> Administration-> LOGIN (using your App Administration details)을 클릭하여 Doorbird 앱을 통해 추가 할 수 있습니다. "USER" 섹션에서 "Add"를 선택하십시오. 이 새로운 사용자 계정에는 원하는 기능에 따라 특정 권한이 활성화되어 있어야합니다. 권한은 "Permissions"에서 찾을 수 있습니다. 다음 권한이 권장됩니다. 

- "Watch Always" (live view)
- "History" (last motion)
- "Motion" (last motion)
- "API-Operator" (this needed to be enabled as a minimum)

## 설정

장치를 연결하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
doorbird:
  devices:
    - host: DOORBIRD_IP_OR_HOSTNAME
      username: YOUR_USERNAME
      password: YOUR_PASSWORD
      token: YOUR_DOORBIRD_TOKEN
```

{% configuration %}

devices:
  description: List of Doorbird devices.
  required: true
  type: list
  keys:
    host:
      description: The LAN IP address or hostname of your device. You can find this by going to the [DoorBird Online check](https://www.doorbird.com/checkonline) and entering the information from the paper that was included in the box.
      required: true
      type: string
    username:
      description: The username of a non-administrator user account on the device ([User setup](/integrations/doorbird/#setup))
      required: true
      type: string
    password:
      description: The password for the user specified.
      required: true
      type: string
    token:
      description: Token to be used to authenticate Doorbird calls to Home Assistant. This is a user defined value and should be unique across all Doorbird devices.
      required: true
      type: string
    name:
      description: Custom name for this device.
      required: false
      type: string
    hass_url_override:
      description: If your DoorBird cannot connect to the machine running Home Assistant because you are using dynamic DNS or some other HTTP configuration (such as HTTPS), specify the LAN IP of the machine here to force a LAN connection.
      required: false
      type: string
    events:
      description: Custom event names to be registered on the device. User defined values. Special characters should be avoided.
      required: false
      type: list
      
{% endconfiguration %}

## 전체 예시 

```yaml
doorbird:
  devices:
    - host: DOORBIRD_IP_OR_HOSTNAME
      username: YOUR_USERNAME
      password: YOUR_PASSWORD
      token: CUSTOM_TOKEN_1
      hass_url_override: HASS_URL
      name: Front Door
    - host: DOORBIRD_IP_OR_HOSTNAME
      username: YOUR_USERNAME
      password: YOUR_PASSWORD
      token: CUSTOM_TOKEN_2
      name: Driveway Gate
      events:
        - doorbell_1
        - somebody_pressed_the_button
        - relay_unlocked
        - unit_2_bell
        - rfid_card_scanned
```

## Events

설정된 각 DoorBird 장치에 대해 이벤트를 독립적으로 정의 할 수 있습니다. 이 이벤트는 장치에 등록되며 DoorBird 앱을 통해 일정에 첨부 할 수 있습니다.

스케줄을 구성하는 방법에 대한 자세한 내용은 아래의 [Schedules](#schedules) 섹션을 참조하십시오.

이벤트 이름 앞에는 `doorbird_devicename`이 붙습니다. 예를 들어, 'Driveway Gate' 장치에 대한 `somebody_pressed_the_button` 이벤트는 Home Assistant에서 `doorbird_driveway_gate_somebody_pressed_the_button` 으로 표시됩니다. 이것은 다른 이벤트와의 충돌을 방지하기위한 것입니다.

자동화에서 이벤트 이름을 사용하는 방법에 대한 자세한 내용은 아래의 [Automation Example](#automation_example) 섹션을 참조하십시오.

<div class="note info">
일정이 DoorBird 앱을 통해 정의될 때까지 홈어시스턴트에서 이벤트가 수신되지 않습니다.
</div>

#### 등록된 이벤트 지우기
특수 URL을 방문하여 DoorBird 장치에서 이벤트를 삭제할 수 있습니다.

새 브라우저 창을 열고 `{Home Assistant URL}/api/doorbird/clear?token={DEVICE_TOKEN}`으로 이동하십시오. `{Home Assistant URL}`을 실행중인 인스턴스의 전체 경로 (예: `localhost:8123`)로 바꾸십시오. `{DEVICE_TOKEN}`을 지우려는 장치의 설정에 지정된 토큰으로 바꾸십시오.
<br><br>
장치 이벤트를 지우려면 위의 설정 단계를 다시 수행해야합니다. DoorBird 장치와 함께 사용할 수 있는 다른 타사 응용 프로그램에도 영향을 줄 수 있습니다. 어떤식 으로든 공식 모바일 앱을 중단되지 않으며 모바일 푸시 알림이 계속 작동합니다.

#### Event Data

각 이벤트에는 이벤트를 트리거한 Doorbird 장치의 라이브 이미지 및 비디오 URL이 포함됩니다. 이 URL은 이벤트 데이터에서 찾을 수 있으며 자동화 액션에 유용할 수 있습니다. 예를 들어, 알림에서 `html5_viewer_url`을 사용하여 자동화를 트리거한 장치의 라이브 뷰에 직접 연결될 수 있습니다.

`event_data`에서 다음 키를 사용할 수 있습니다.

- `timestamp`
- `live_video_url`
- `live_image_url`
- `rtsp_live_video_url`
- `html5_viewer_url`

<div class="note">
이벤트 URL은 Doorbird 장치에 연결하는데 사용되는 설정을 기반으로합니다. 네트워크 외부에서 연결하는 기능은 설정에 따라 다릅니다.
</div>

#### Schedules

DoorBird 장치에 이벤트가 등록되면 Android 또는 iOS의 공식 DoorBird 앱을 사용하여 일정에 첨부해야합니다. 현재 초인종, 모션, 릴레이 및 RFID 이벤트 (지원되는 도어 버드 장치)에 대한 일정이 있습니다.

일정은 Doorbird 앱의 다음 영역(area) (Android 또는 IOS)으로 이동하여 찾을 수 있습니다.

Settings (cog icon) -> Administration -> LOGIN LOGIN (using your App Administration details) -> (under "EXPERT SETTINGS") Schedule for doorbell

- `Push notification`
- `Trigger Relay ("Relay 1" or "Relay 2")`
- `HTTP(S) Calls (button, motion/movement, RFID)`

왼쪽 상단의 드롭 다운 버튼을 클릭하고 특정 "Schedule for actions"(위에 나열된)을 선택하십시오. 선택한 항목에 따라 가운데 제목을 클릭하여 하위 카테고리 메뉴를 볼 수도 있습니다.

원하는 이벤트에서 이벤트를 홈어시스턴트로 보낼 시간 블록을 지정할 수 있어야합니다. 이벤트를 항상 보내려면 오른쪽 상단의 사각형을 사용하여 전체 일정을 채울 수 있습니다. 일정이 파란색으로 표시되면 홈 어시스턴트에서 이벤트가 시작됩니다.

참고 : 등록한 각 이벤트 유형에 대해 위의 스케줄 지정 단계를 완료하십시오.

### 자동화 사례

```yaml
- alias: Doorbird Ring
  trigger:
    platform: event
    event_type: doorbird_driveway_gate_somebody_pressed_the_button
  action:
    service: light.turn_on
      entity_id: light.side_entry_porch
```

## Camera

`doorbird` 구현을 통해 Home Assistant의 [DoorBird](https://www.doorbird.com/) 장치에서 라이브 비디오, 마지막 초인종 링 이미지 및 마지막 모션 센서 이미지를 볼 수 있습니다.

### 설정

카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: doorbird
```

## Switch

`doorbird` 스위치 플랫폼을 사용하면 [DoorBird](https://www.doorbird.com/) 비디오 초인종 장치에서 연결된 릴레이에 전원을 공급하고 IR 어레이를 트리거 할 수 있습니다.

이 스위치를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: doorbird
```
