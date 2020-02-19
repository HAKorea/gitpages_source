---
title: Alert
description: Instructions on how to setup automatic alerts within Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.38
ha_quality_scale: internal
---

`alert` 통합구성요소는 문제되는 이슈가 발생할 때 통지하도록 설계되었습니다. 예를 들어, 차고 문이 열린 상태로 유지되면 `alert` 통합구성요소를 사용하여 사용자 정의 가능한 간격으로 반복 알림을 보내 이를 상기시켜줍니다. 
또한 배터리 부족 센서, 누수 센서 또는 주의가 필요한 모든 조건에 사용됩니다.

경고는 엔티티가 시작될 때만 프런트 엔드에 엔티티를 추가합니다. 이 엔티티를 사용하면 해결 될 때까지 경고를 무음으로 설정할 수 있습니다.

### 기본 사례 

`alert` 통합구성요소는 모두 `notifications` 통합구성요소를 사용합니다. `alert` 통합구성요소를 설정하려면 먼저 `notification` 통합구성요소를 설정해야합니다. 그런 다음 설정 파일에 다음을 추가하십시오 : 

```yaml
# Example configuration.yaml entry
alert:
  garage_door:
    name: Garage is open
    done_message: Garage is closed
    entity_id: input_boolean.garage_door
    state: 'on'
    repeat: 30
    can_acknowledge: true
    skip_first: true
    notifiers:
      - ryans_phone
      - kristens_phone
```

{% configuration %}
name:
  description: 친숙한 경고 이름입니다.
  required: true
  type: string
entity_id:
  description: 감시할 엔티티 ID입니다.
  required: true
  type: string
title:
  description: >
    알리미가 [template](/docs/configuration/templating/)을 지원하는 경우 알림에 사용되는 제목.
  required: false
  type: template
state:
  description: 엔티티의 문제점 조건.
  required: false
  type: string
  default: on
repeat:
  description: >
    알림을 반복하기까지의 시간 (분)입니다.
    숫자 또는 숫자 목록 일 수 있습니다.
  required: true
  type: [integer, list]
can_acknowledge:
  description: 경고를 승인 할 수 없습니다.
  required: false
  type: boolean
  default: true
skip_first:
  description: >
    알림을 즉시 또는 첫 번째 지연 후에 전송할지 여부를 제어합니다.
  required: false
  type: boolean
  default: false
message:
  description: >
    A message to be sent after an alert transitions from `off` to `on`
    with [template](/docs/configuration/templating/) support.
  required: false
  type: template
done_message:
  description: >
    A message sent after an alert transitions from `on` to `off` with
    [template](/docs/configuration/templating/) support. Is only sent if an alert notification
    was sent for transitioning from `off` to `on`.
    [template](/docs/configuration/templating/)지원을 통해 경고가 `on`에서 `off`로 전환된 후 전송 된 메시지입니다. 
    `off`에서`on`으로 전환하기 위해 경고 알림이 전송 된 경우에만 전송됩니다.
  required: false
  type: template
notifiers:
  description: "경고에 사용할 `notifications` 통합구성요소 목록입니다."
  required: true
  type: list
data:
  description: "알리미에게 보낼 추가 매개 변수 사전(dictionary)입니다."
  required: false
  type: list  
{% endconfiguration %}

이 예에서는 차 고문 상태 (`input_boolean.garage_door`)가 감시되고 상태가 `on`인 경우 이 경고가 트리거됩니다.
이는 문이 열렸음을 나타냅니다. `skip_first` 옵션이 `true`로 설정되었으므로 첫 번째 알림이 즉시 전달되지 않습니다.
그러나 30 분마다 `input_boolean.garage_door`가 더 이상 `on`상태가 아니거나 홈어시스턴트 프론트 엔드를 사용하여 경보가 승인 될 때까지 알림이 전달됩니다.

다른 매개 변수가 필요한 알리미 (예 : 알림을 보낼 때 `target `매개 변수를 지정해야하는`twilio_sms`)의 경우 `group` 알림을 사용하여 알림에 래핑 할 수 있습니다.

`alert` 컴포넌트가 제공하는`message` 이외의 필수 매개 변수를 지정하여 단일 알림 멤버 (예 :`twilio_sms`)로 `group` 알림 유형을 작성하십시오.

```yaml
- platform: group
  name: john_phone_sms
  services:
    - service: twilio_sms
      data:
        target: !secret john_phone
```

```yaml
alert:
  freshwater_temp_alert:
    name: "Warning: I have detected a problem with the freshwater tank temperature"
    entity_id: binary_sensor.freshwater_temperature_status
    state: 'on'
    repeat: 5
    can_acknowledge: true
    skip_first: false
    notifiers:
      - john_phone_sms
```

### 복잡한 경고 기준 (Complex Alert Criteria)

By design, the `alert` integration only handles very simple criteria for firing.
That is, it only checks if a single entity's state is equal to a value. At some point, it may be desirable to have an alert with a more complex criteria.
Possibly, when a battery percentage falls below a threshold. Maybe you want to disable the alert on certain days. Maybe the alert firing should depend on more than one input. For all of these situations, it is best to use the alert in conjunction with a `Template Binary Sensor`. The following example does that.
설계 상 `alert` 통합구성요소는 매우 간단한 실행 기준 만 처리합니다. 
즉, 단일 엔티티의 상태가 값과 같은지 확인합니다. 일부 더 복잡한 기준을 가진 경고를 갖는 것이 바람직 할 수 있습니다. 배터리 백분율이 임계값 아래로 떨어질 때. 특정 날짜에는 알림을 사용 중지하고자 하는 경우가 있습니다. 경보 발생은 하나 이상의 입력에 의존해야합니다. 이러한 모든 상황에서 `Template Binary Sensor`와 함께 경고를 사용하는 것이 가장 좋습니다. 다음 예제의 내용입니다.

{% raw %}
```yaml
binary_sensor:
  - platform: template
    sensors:
      motion_battery_low:
        value_template: "{{ state_attr('sensor.motion', 'battery') < 15 }}"
        friendly_name: 'Motion battery is low'

alert:
  motion_battery:
    name: Motion Battery is Low
    entity_id: binary_sensor.motion_battery_low
    repeat: 30
    notifiers:
      - ryans_phone
      - kristens_phone
```
{% endraw %}

이 예제는 엔티티`sensor.motion`의`battery` 속성이 15 아래로 떨어지자마자 시작됩니다. 배터리 속성이 15를 초과하거나 프론트 엔드에서 경고가 확인 될 때까지 계속 작동합니다.

### 동적 지연 시간 알림 (Dynamic Notification Delay Times)

경고가 계속 발생하면 경고 알림 사이의 지연이 동적으로 변경되는 것이 바람직 할 수 있습니다. 
`repeat` 설정 키를 단일 숫자가 아닌 숫자 목록으로 설정하면됩니다. 첫 번째 예를 변경하면 다음과 같습니다.

```yaml
# Example configuration.yaml entry
alert:
  garage_door:
    name: Garage is open
    entity_id: input_boolean.garage_door
    state: 'on'   # Optional, 'on' is the default value
    repeat:
      - 15
      - 30
      - 60
    can_acknowledge: true  # Optional, default is true
    skip_first: true  # Optional, false is the default
    notifiers:
      - ryans_phone
      - kristens_phone
```

이제 첫 번째 메시지는 15분 지연 후 전송되고 두 번째 메시지는 30 분 후에 전송되며 60 분 지연은 다음 알림마다 발생합니다.
예를 들어, 차고 문이 2:00에 열리면 60 분마다 2시 15 분, 2시 45 분, 3시 45 분, 4시 45 분 등으로 알림이 전송됩니다.

### Message Templates

경보 통지에 엔티티의 상태에 관한 정보를 포함시키는 것이 바람직 할 수 있습니다. [Templates][template]은 메시지 또는 경고의 이름에 사용하여 보다 관련성을 높일 수 있습니다. 다음은 식물에서 개체의 '속성'을 포함시키는 방법을 보여줍니다.

{% raw %}
```yaml
# Example configuration.yaml entry
alert:
  office_plant:
    name: Plant in office needs help
    entity_id: plant.plant_office
    state: 'problem'
    repeat: 30
    can_acknowledge: true
    skip_first: true
    message: "Plant {{ states.plant.plant_office }} needs help ({{ state_attr('plant.plant_office', 'problem') }})"
    done_message: Plant in office is fine
    notifiers:
      - ryans_phone
      - kristens_phone
```
{% endraw %}

그 결과 메시지는 `사무실 식물에 도움이 필요함 (수분 부족)`일 수 있습니다.

### 알리미에 대한 추가 매개 변수 (Additional parameters for notifiers) 

일부 알리미는 더 많은 매개 변수를 지원합니다 (예 : 텍스트 색상 또는 동작 버튼 설정). 이들은 `data` 매개 변수를 통해 제공 될 수 있습니다 :

```yaml
# Example configuration.yaml entry
alert:
  garage_door:
    name: Garage is open
    entity_id: input_boolean.garage_door
    state: 'on'   # Optional, 'on' is the default value
    repeat:
      - 15
      - 30
      - 60
    can_acknowledge: True  # Optional, default is True
    skip_first: True  # Optional, false is the default
    data:
      inline_keyboard:
        - 'Close garage:/close_garage, Acknowledge:/garage_acknowledge'
    notifiers:
      - frank_telegram
```
이 특정 예는 Telegram의 `inline_keyboard` 기능에 의존합니다. 여기서 사용자에게는 특정 작업을 실행하는 버튼이 표시됩니다

[template]: /docs/configuration/templating/
