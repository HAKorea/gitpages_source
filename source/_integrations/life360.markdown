---
title: Life360
description: Instructions how to use Life360 to track devices in Home Assistant.
logo: life360.png
ha_release: 0.95
ha_config_flow: true
ha_category:
  - Presence Detection
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@pnbruckner'
---

`life360` 통합구성요소로 [Life360](https://www.life360.com/)의 [unofficial API](#disclaimer)를 사용하여 현재 상태를 감지 할 수 있습니다.

## Life360 계정

먼저 [Life360 계정을 만드십시오](https://www.life360.com/websignup). 

그런 다음 홈어시스턴트 UI (사용자 인터페이스)에서 왼쪽 분할 창의 설정을 클릭 한 다음 통합구성요소를 클릭하고 오른쪽 하단 모서리의 노란색 원을 클릭하여 "새 통합 설정"을 수행하십시오. 목록을 스크롤하여 Life360을 클릭하십시오.

고급 옵션을 설정하려면 다음 섹션을 참조하십시오. UI에 Life360 계정 정보를 입력하기 전에 이 작업을 수행하거나 언제든지 변경할 수 있습니다. 아래 섹션에서 설정하려는 고급 옵션은 configuration.yaml 파일에서 수동으로 설정해야합니다. UI에서 설정할 수 없습니다. 원하는 경우 설정 파일 (UI 외에 또는 대신)에 계정 정보를 입력 할 수도 있습니다.

설정 후 Life360 통합구성요소 페이지에 "이 통합구성요소에는 장치가 없습니다"가 표시 될 것으로 예상됩니다. 상태 페이지에 새로운 Life360 장치 추적 엔티티가 표시됩니다. 그렇지 않은 경우 : 

- [device tracker documentation](/integrations/device_tracker), 특히 `new_device_defaults` 설정을 확인하십시오.
- `known_devices.yaml`을 확인하십시오; Life360 장치의 경우 `tracking`이 `true`이어야합니다.
- Life360 앱에서 위치 공유가 활성화되어 있어야합니다.

{% configuration %}
accounts:
  description: Life360 계정 정보.
  required: false
  type: [list, map]
  default: None
  keys:
    username:
      description: Life360 사용자 이름.
      required: true
      type: string
    password:
      description: Life360 비밀번호.
      required: true
      type: string
circles:
  description: 자세한 설명 은 [Filtering](#filtering) 을 참조하십시오. **include** 또는 **exclude를** 지정해야 하지 둘 다 지정 해서는 안됩니다.
  required: false
  type: map
  default: Include all Circles.
  keys:
    include:
      description: Circles to include.
      required: false
      type: [string, list]
    exclude:
      description: Circles to exclude.
      required: false
      type: [string, list]
driving_speed:
  description: 장치가 "driving"으로 간주되는 최소 속도 (홈어시스턴트의 MPH 또는 KPH 단위 시스템 설정에 따라 `driving` [attribute](#additional-attributes)을 `true`로 설정할 수도 있음) 
  required: false
  type: float
  default: "\"Driving\" determined strictly by Life360."
error_threshold:
  description: 자세한 내용은 [Communication Errors](#communication-errors)를 참조하십시오. description.
  required: false
  type: integer
interval_seconds:
  description: 이것은 Life360 서버가 얼마나 자주 쿼리되는지를 초 단위로 정의합니다. device_tracker 엔티티 결과정보는 실제로 Life360 서버가 각 구성원에 대해 새 위치 정보를 제공 할 때만 업데이트됩니다.
  required: false
  type: integer
  default: 12
max_gps_accuracy:
  description: 지정된 경우 보고 된 GPS 정확도가 더 높으면 (즉, *덜* 정확하면) 업데이트가 무시됩니다.
  required: false
  type: float
max_update_wait:
  description: Life360이 해당 최대 시간 내에 구성원에 대한 업데이트를 제공하지 않으면 `life360_update_overdue`라는 이벤트가 해당 device_tracker 엔티티의 `entity_id`와 함께 시작됩니다. 업데이트가 이루어지면 해당 life_tracker 엔터티의 entity_id 및 업데이트 대기에 소요된 시간을 나타내는 다른 데이터 항목인 `life360_update_restored`라는 이벤트가 시작됩니다. 자동화에서 이러한 이벤트를 사용하여 발생할 때 알림을받을 수 있습니다. 아래 [example automations](#example-overdue-update-automations)를 참조하십시오.  
  required: false
  type: time
members:
  description: 자세한 설명은 [Filtering](#filtering)을 참조하십시오. **include** 또는 **exclude**를 지정해야지 둘다는 아닙니다.
  required: false
  type: map
  default: 모든 서클의 모든 회원을 포함합니다.
  keys:
    include:
      description: 포함 할 회원.
      required: false
      type: [string, list]
    exclude:
      description: 제외 할 회원.
      required: false
      type: [string, list]
prefix:
  description: 장치 ID 접두사. 엔터티 ID는 `device_tracker.PREFIX_FIRST_LAST` 또는 회원 이름이 하나 인 경우 `device_tracker.PREFIX_NAME`의 형식입니다. 접두사를 쓰지 않고 사용할 경우 `''`를 쓰십시오.
  required: false
  type: string
  default: life360
show_as_state:
  description: 장치가 홈 어시스턴트 영역에 있지 않은 경우, 장치가 주행(driving)중 (동일한 이름의 속성 참조)으로 결정되고 `driving`이 지정되면 엔티티 상태가 `driving` 으로 설정됩니다. 장치가 구역(zone)에 있지 않은 경우 이동중인 것으로 판단되고 `moving`이 지정되면 엔티티 상태가 `moving`으로 설정됩니다.
  required: false
  type: [string, list]
warning_threshold:
  description: 자세한 설명은 [Communication Errors](#communication-errors)를 참조하십시오. description.
  required: false
  type: integer
{% endconfiguration %}

## 추가 속성 (Additional attributes)

Attribute | Description
-|-
address | 현재 위치의 주소, 혹은 `none`.
at_loc_since | 현재 위치에서 처음 날짜와 시간 ( UTC.)
battery_charging | 기기 충전 중 (`true`/`false`.)
driving | 장치의 움직임은 운전을 나타냅니다 (`true`/`false`.)
last_seen | Life360이 마지막으로 장치 위치를 업데이트 한 날짜 및 시간  ( UTC.)
moving | 장치가 움직입니다 (`true`/`false`.)
place | Life360의 이름 장치가있는 곳 또는 그 안에 있지 않은 곳 (`none`).
raw_speed | Life360 서버가 제공하는 "Raw"속도 값. (단위는 불명)
speed | 예상 장치 속도 (Home Assistant의 장치 시스템 구성에 따라 MPH 또는 KPH로)
wifi_on | 장치 WiFi가 켜져 있습니다 (`true`/`false`.)

## 필터링 (Filtering)

대부분의 사용자에게는 필터링이 필요하지 않으므로 이러한 경우 해당 구성 변수를 사용하지 않아야합니다.

그러나 어떤 상황에서는 사용되는 Life360 Circles 멤버를 제한하는 것이 도움이 될 수 있습니다. 이 경우 [**circles**](#circles), [**members**](#members)를 사용할 수 있습니다.

**circles**은 사용된 Life360 서클을 제한할 수 있습니다

**members**은 추적 할 Life360 회원을 제한할 수 있습니다.

특정 회원을 추적하려면 회원을 포함시켜야합니다 (또는 최소한 제외하지 않아야 함). 포함 된 서클 중 하나 이상에 포함되어야합니다. 아래 [example configuration](#circle-and-member-filtering-example) 를 참조하십시오. 

Life360의 앱 및 웹사이트는 일반적으로 회원의 이름만 표시합니다. 그러나 여기서는 _full_ 이름을 사용해야합니다. 
Life360에 회원의 성명 (이름 및 성)이 무엇인지 확실하지 않은 경우 정확히 확인하십시오. 또는 [`logger`](/integrations/logger/)를 `debug`로 설정하고 `home-assistant.log`를 볼 수 있습니다. 

## Home - Home Assistant vs. Life360

일반적으로 Home Assistant 장치 추적기는 `zone.home`에 들어가면 "홈"입니다. 또한 Life360은 일반적으로 집과 일치하는 장소에 들어갈 때 "Home"으로 간주합니다. 이러한 영역의 정의가 다를 수 있으므로 이로 인해 귀하가 "집"인지 아닌지에 대해 홈 어시스턴트와 Life360간에 불일치가 발생할 수 있습니다. 이를 피하려면이 두 영역을 동일하게 정의하십시오 (예 : 동일한 위치 및 반경). (다음 섹션을 참조하십시오.)

## Home Assistant Zones & Life360 Places

HA 영역을 정의하는 방법에 대한 자세한 내용은 [Zone documentation](/integrations/zone/#home-zone)를 참조하십시오. Life360 Places에서 HA 영역을 생성하려면 (예 : HA의 `zone.home`을 Life360의 "Home Place"와 동일하게) 로거가 `debug` 로 설정되어 있는지 확인하십시오. 예로서 다음과 같은 메시지를 볼 수 있습니다 : 

```text
2019-05-31 12:16:58 DEBUG (SyncWorker_3) [homeassistant.components.life360.device_tracker] My Family Circle: will be included, id=xxxxx
2019-05-31 12:16:58 DEBUG (SyncWorker_3) [homeassistant.components.life360.device_tracker] Circle's Places:
- name: Home
  latitude: XX.XXX
  longitude: YY.YYY
  radius: ZZZ
```

## 통신 에러 (Communication Errors)

Home Assistant와 Life360 서버간에 통신 오류가 발생하는 것은 드문 일이 아닙니다. 인터넷 연결 문제, Life360 서버로드 등 여러 가지 이유로 발생할 수 있습니다. 그러나 대부분의 경우 일시적인 것이며 device_tracker 엔티티를 최신 상태로 유지하는 기능에는 크게 영향을 미치지 않습니다. 

따라서, 비정상적인 오류 활동을 계속 기록하면서 결과적인 통신 오류가 로그를 채우지 않도록 선택적 필터링 메커니즘이 구현되었습니다. [**warning_threshold**](#warning_threshold) 및 [**error_threshold**](#error_threshold)의 두 임계 값이 정의되어있습니다. 연속 업데이트주기에서 특정 유형의 통신 오류가 발생하면 발생 횟수가 이러한 임계 값에 도달 할 때까지 기록되지 않습니다. 숫자가 **warning_threshold** 에 도달하면 (**error_threshold** 를 초과하지 않고 warning_threshold 가 정의 된 경우에만) 경고로 기록됩니다. 숫자가 **error_threshold** 에 도달 하면, 오류로 기록됩니다. 특정 유형의 연속된 두 개의 통신 오류만 오류로 기록되며, 그 후에는 더 이상 발생이 중지되고 다시 발생할 때까지 더 이상 기록되지 않습니다.

## 사례 (Examples)

### 전형적인 설정 (Typical configuration)

{% raw %}
```yaml
life360:
  # MPH, assuming imperial units.
  # If using metric (KPH), the equivalent would be 29.
  driving_speed: 18
  interval_seconds: 10
  max_gps_accuracy: 200
  max_update_wait:
    minutes: 45
  show_as_state:
    - driving
    - moving
  # Set comm error thresholds so first is not logged,
  # second is logged as a WARNING, and third and fourth
  # are logged as ERRORs.
  warning_threshold: 2
  error_threshold: 3
```
{% endraw %}

### 서클과 멤버의 필터링 설정 사례 (Circle and Member Filtering Example)

{% raw %}
```yaml
life360:
  # Only track Members that are in these Circles.
  circles:
    include: [My Family, Friends]
  # But do not track this Member.
  members:
    exclude: John Doe
```
{% endraw %}

### 계정 입력 설정(Entering accounts in configuration)

{% raw %}
```yaml
life360:
  accounts:
    - username: LIFE360_USERNAME
      password: LIFE360_PASSWORD
```
{% endraw %}

### 기한이 지난 업데이트 자동화 예 (Example overdue update automations)

{% raw %}
```yaml
automation:
  - alias: Life360 Overdue Update
    trigger:
      platform: event
      event_type: life360_update_overdue
    action:
      service: notify.email_me
      data_template:
        title: Life360 update overdue
        message: >
          Update for {{
            state_attr(trigger.event.data.entity_id, 'friendly_name') or
            trigger.event.data.entity_id
          }} is overdue.

  - alias: Life360 Update Restored
    trigger:
      platform: event
      event_type: life360_update_restored
    action:
      service: notify.email_me
      data_template:
        title: Life360 update restored
        message: >
          Update for {{
            state_attr(trigger.event.data.entity_id, 'friendly_name') or
            trigger.event.data.entity_id
          }} restored after {{ trigger.event.data.wait }}.
```
{% endraw %}

## 상기할 점 (Disclaimer)

Life360은 공식적으로 자체 앱 이외의 다른 용도로 REST API를 지원하는 것으로 보이지 않습니다. 이 통합은 오픈 소스 커뮤니티에서 수행 한 리버스 엔지니어링과 동일한 커뮤니티에서 어떻게 든 발견 된 API 토큰을 기반으로합니다. Life360은 언제든지 해당 토큰을 비활성화하거나 REST API를 변경하여이 통합이 더 이상 작동하지 않게 할 수 있습니다.