---
title: "자동화 트리거"
description: "All the different ways how automations can be triggered."
redirect_from: /getting-started/automation-trigger/
---

트리거는 자동화 규칙 처리를 시작하는데 쓰입니다. 동일한 규칙에 대해 [multiple triggers](/docs/automation/trigger/#multiple-triggers)를 지정할 수 있습니다. - 트리거 중 _하나 라도_ 적용되면 자동화가 시작됩니다. 트리거가 시작되면 홈어시스턴트는 조건을 검증하고 해당되는 경우 액션를 호출합니다. 

### 이벤트 트리거

이벤트가 처리될 때 트리거됩니다. 이벤트는 홈어시스턴트의 기본 구성 요소입니다. 이벤트 이름만으로 이벤트를 일치시키거나 특정 이벤트 데이터가 있어야 할 수도 있습니다.

연동 또는 API를 통해 이벤트를 시작할 수 있습니다. 유형에는 제한이 없습니다. 내장 이벤트 목록은 [here](/docs/configuration/events/) 에서 찾을 수 있습니다 .

```yaml
automation:
  trigger:
    platform: event
    event_type: MY_CUSTOM_EVENT
    # optional
    event_data:
      mood: happy
```

<div class='note warning'>

0.42부터는 더 이상 `homeassistant_start`이벤트를 쓸 수 없습니다. 대신 'homeassistant' 플랫폼을 사용하십시오.

</div>

### 홈어시스턴트 트리거

홈어시스턴트가 시작되거나 종료될 때 트리거됩니다.

```yaml
automation:
  trigger:
    platform: homeassistant
    # Event can also be 'shutdown'
    event: start
```

### MQTT 트리거

특정 topic에 대해 특정 message가 수신되면 트리거됩니다. 경우에따라 topic를 통해 전송되는 payload와 일치시킬 수 있습니다. 기본 payload 인코딩은 'utf-8'입니다. 이미지 및 기타 바이트 payload들은 payload 디코딩을 완전히 비활성화하기 위해 `encoding: ''`를 사용합니다.   

```yaml
automation:
  trigger:
    platform: mqtt
    topic: living_room/switch/ac
    # Optional
    payload: "on"
    encoding: "utf-8"
```

### 숫자 상태 트리거

entity 상태의 숫자값이 지정된 임계값을 초과할 때 트리거됩니다. 지정된 entity의 상태 변경시 상태를 숫자로 파싱하려고 시도하고 값이 지정된 임계값 위에서 아래로 또는 아래에서 아래로 변경되면 한 번 트리거됩니다.

{% raw %}

```yaml
automation:
  trigger:
    platform: numeric_state
    entity_id: sensor.temperature
    # Optional
    value_template: "{{ state.attributes.battery }}"
    # At least one of the following required
    above: 17
    below: 25

    # If given, will trigger when condition has been for X time, can also use days and milliseconds.
    for:
      hours: 1
      minutes: 10
      seconds: 5
```

{% endraw %}

<div class='note'>
위와 아래를 함께 모두 numeric_state가 두 값 사이에 있어야 함을 의미합니다.
위의 예에서 17.1-24.9 (17 이하 또는 25 이상) 인 numeric_state는 이 트리거를 발생시킵니다.
</div>

`for:` 구문은 `HH:MM:SS` 와 같이도 지정할 수 있습니다. :

{% raw %}

```yaml
automation:
  trigger:
    platform: numeric_state
    entity_id: sensor.temperature
    # Optional
    value_template: "{{ state.attributes.battery }}"
    # At least one of the following required
    above: 17
    below: 25

    # If given, will trigger when condition has been for X time.
    for: "01:10:05"
```

{% endraw %}

`for` 옵션에서 템플릿을 사용할 수 있습니다. 

{% raw %}

```yaml
automation:
  trigger:
    platform: numeric_state
    entity_id:
      - sensor.temperature_1
      - sensor.temperature_2
    above: 80
    for:
      minutes: "{{ states('input_number.high_temp_min')|int }}"
      seconds: "{{ states('input_number.high_temp_sec')|int }}"
  action:
    service: persistent_notification.create
    data_template:
      message: >
        {{ trigger.to_state.name }} too high for {{ trigger.for }}!
```

{% endraw %}

지정된 entity가 변경된 경우 `for` 템플릿이 평가하여 계산됩니다.

### 상태 트리거

주어진 엔티티의 상태가 변경될 때 트리거됩니다. 만약 `entity_id` 만이 주어지면 상태 속성만 변경되더라도 모든 상태 변경에 대해 트리거가 활성화됩니다. 

```yaml
automation:
  trigger:
    platform: state
    entity_id: device_tracker.paulus, device_tracker.anne_therese
    # Optional
    from: "not_home"
    # Optional
    to: "home"

    # If given, will trigger when state has been the to state for X time.
    for: "01:10:05"
```

`for` 옵션에서 템플릿을 사용할 수 있습니다. 

{% raw %}

```yaml
automation:
  trigger:
    platform: state
    entity_id: device_tracker.paulus, device_tracker.anne_therese
    to: "home"
    for:
      minutes: "{{ states('input_number.lock_min')|int }}"
      seconds: "{{ states('input_number.lock_sec')|int }}"
  action:
    service: lock.lock
    entity_id: lock.my_place
```

{% endraw %}

특정 entity가 변경된 경우 `for` 템플릿이 평가하여 계산됩니다.

<div class='note warning'>

YAML 파서가 booleans로 값을 해석하여 파싱하는 것을 피하기 위해 `from`과 `to` 같이 값에 따옴표를 사용하십시오. 

</div>

### 태양 트리거

#### 일몰 / 일출 트리거

태양이지고 있거나 뜰 때, 즉 태양 고도가 0 °에 도달하면 트리거됩니다.

선택적으로 시간 오프셋은 태양(Sun) 이벤트 전후에 설정된 시간을 트리거하도록 할 수 있습니다 (예: 일몰 45분 전).

<div class='note'>

황혼의 지속 시간은 일년 내내 다르므로, 황혼 또는 새벽 동안 자동화를 트리거하기 위해 시간 오프셋인 `sunset` ,`sunrise` 대신 [sun elevation triggers][sun_elevation_trigger] 를 사용하는 것이 좋습니다

</div>

```yaml
automation:
  trigger:
    platform: sun
    # Possible values: sunset, sunrise
    event: sunset
    # Optional time offset. This example will trigger 45 minutes before sunset.
    offset: "-00:45:00"
```

#### 태양 고도 트리거

때로는 단순히 일몰이나 일출보다 자동화를 보다 세밀하게 제어하고 정확한 태양 고도를 지정할 수 있습니다. 이것은 수평선에서 해가 낮아지거나 수평선 아래로 내려간 후에도 발생하는 자동화를 계층화하는 데 사용할 수 있습니다. 이것은 "일몰" 이벤트가 외부에서 충분히 어두워지지 않을 때 유용하며 외부 조명 켜기와 같은 시간 오프셋 대신 정확한 태양 각도에서 자동화를 나중에 실행하고자 할 때 유용합니다. 황혼이나 새벽에 트리거하려는 대부분의 경우 0 °와 -6 ° 사이의 숫자가 적합합니다. 다음 예에서는 -4 °가 사용됩니다. :

{% raw %}

```yaml
automation:
  alias: "Exterior Lighting on when dark outside"
  trigger:
    platform: numeric_state
    entity_id: sun.sun
    value_template: "{{ state_attr('sun.sun', 'elevation') }}"
    # Can be a positive or negative number
    below: -4.0
  action:
    service: switch.turn_on
    entity_id: switch.exterior_lighting
```

{% endraw %}

보다 정확한 정보를 얻으려면 미국 해군 관측소 [tool](https://aa.usno.navy.mil/data/docs/AltAz.php)로 시작하십시오. 이 툴은 특정 시간에 태양 고도가 무엇인지 추정하는 데 도움이됩니다. 그런 다음 이로부터 정의된 황혼 수치를 선택할 수 있습니다.

실제 빛의 양은 날씨, 지형 및 지표면에 따라 다르지만 다음과 같이 정의됩니다. :

- 민간 황혼: 0° > 태양 각도 > -6°

  이는 일반인에게 황혼의 의미입니다. 맑은 날씨 조건에서 민간 황혼은 태양 조명이 사람의 눈으로 지상 물체를 명확하게 구별하기에 충분한 값에 가깝습니다. 충분한 조명은 대부분의 야외 활동에 인공 조명을 불필요하게 만듭니다.

- 해상 황혼: -6° > 태양 각도 > -12°
- 천문 황혼: -12° > 태양 각도 > -18°

이에 대한 자세한 설명은 Wikipedia [Twilight](https://en.wikipedia.org/wiki/Twilight)기사에서 볼 수 있습니다.

### 템플릿 트리거

템플릿 트리거 는 인식된 모든 entity에 대한 모든 상태(state) 변경에 대한 [template](/docs/configuration/templating/)을 측정하여 동작합니다. 상태 변경으로 인해 템플릿이 'true'로 렌더링되면 트리거가 발생합니다. 이는 템플릿 결과가 실제 부울식 (`{% raw %}{{ is_state('device_tracker.paulus', 'home') }}{% endraw %}`)이 되거나 템플릿이 'true'(아래 예)로 렌더링되도록 함으로써 달성됩니다. 부울 표현식이므로 템플리트가 다시 실행되기 전에 false (또는 true 이외의 것)로 판별되어야 합니다. 템플릿 트리거를 쓰면, is_state_attr (`{% raw %}{{ is_state_attr('climate.living_room', 'away_mode', 'off') }}{% endraw %}`)를 사용하여 속성 변경을 판별할 수도 있습니다 
{% raw %}

```yaml
automation:
  trigger:
    platform: template
    value_template: "{% if is_state('device_tracker.paulus', 'home') %}true{% endif %}"

    # If given, will trigger when template remains true for X time.
    for: "00:01:00"
```

{% endraw %}

`for` 옵션에서 템플릿을 사용할 수 있습니다.

{% raw %}

```yaml
automation:
  trigger:
    platform: template
    value_template: "{{ is_state('device_tracker.paulus', 'home') }}"
    for:
      minutes: "{{ states('input_number.minutes')|int(0) }}"
```

{% endraw %}

`for` 템플릿들이 `value_template` 이 `true`가 될 때 판별할 것입니다.

<div class='note warning'>
트리거 템플릿은 entity 상태 변경에 따라 업데이트되므로 시간 (`now ()`)이있는 렌더링 템플릿은 위험할 수 있습니다.
</div>

대안으로 설정에 센서의 [time](/integrations/time_date/) 을 포함 시키면 다음과 같은 템플릿을 사용할 수 있습니다. :

{% raw %}

```yaml
automation:
  trigger:
    platform: template
    value_template: "{{ (as_timestamp(states.sensor.time.last_changed) - as_timestamp(states.YOUR.ENTITY.last_changed)) > 300 }}"
```

{% endraw %}

만일 `YOUR.ENTITY` 가 300초 이상이 지나기 전에 변경되었다면, 이는 `True`로 평가 될 것입니다. 

### 시간 트리거

시간 트리거는 매일 특정 시점에 한 번 실행되도록 설정됩니다.

```yaml
automation:
  trigger:
    platform: time
    # Military time format. This trigger will fire at 3:32 PM
    at: "15:32:00"
```

### 시간 패턴 트리거

시간 패턴 트리거를 사용하면 현재 시간의 시, 분 또는 초가 특정값과 일치하는 경우 일치시킬 수 있습니다. 값을 해당 숫자로 나눌 수있을 때마다 값 앞에 `/` 접두사를 붙일 수 있습니다. 모든 값과 일치하도록 `*`를 지정할 수 있습니다 (웹 인터페이스를 사용하는 경우 필드를 비워 둘 수 없음).

```yaml
automation:
  trigger:
    platform: time_pattern
    # Matches every hour at 5 minutes past whole
    minutes: 5

automation 2:
  trigger:
    platform: time_pattern
    # Trigger once per minute during the hour of 3
    hours: "3"
    minutes: "*"

automation 3:
  trigger:
    platform: time_pattern
    # You can also match on interval. This will match every 5 minutes
    minutes: "/5"
```

<div class='note warning'>

숫자 앞에 0을 붙이지 마십시오 - 예를 들어 '0' 대신 `'00'`을 사용하면 오류가 발생합니다. 

</div>

### 웹훅 트리거

웹훅 트리거는 웹훅 엔드 포인트에 대한 웹 요청에 의해 트리거됩니다 : `/api/webhook/<webhook_id>`. 이 엔드 포인트는 웹훅 ID를 아는 것 외에 인증이 필요하지 않습니다. 템플릿에서 `trigger.json` 혹은 `trigger`으로 사용 가능한 인코딩된 양식 또는 JSON 데이터를 보낼 수 있습니다. URL 쿼리 매개 변수는 템플릿에서 `trigger.query` 로 사용할 수 있습니다.

```yaml
automation:
  trigger:
    platform: webhook
    webhook_id: some_hook_id
```

POST HTTP 요청을 `http://your-home-assistant:8123/api/webhook/some_hook_id`로 보내 위의 자동화 트리거링을 테스트 할 수 있습니다. SSL/TLS 보안 설치로 전송되지 않고 command line curl 프로그램을 사용하는 데이터가 없는 예는 다음과 같습니다 

`curl -d "" https://your-home-assistant:8123/api/webhook/some_hook_id`.

### 영역(Zone) 트리거

영역 트리거는 entity가 영역에 들어오거나 영역을 벗어날 때 트리거될 수 있습니다. 영역 자동화가 작동하려면 GPS 좌표 보고를 지원하는 장치 추적기 플랫폼을 설정해야합니다. 여기에는 [GPS Logger](/integrations/gpslogger/), [OwnTracks platform](/integrations/owntracks/) 그리고 [iCloud platform](/integrations/icloud/)이 있습니다 .

```yaml
automation:
  trigger:
    platform: zone
    entity_id: device_tracker.paulus
    zone: zone.home
    # Event is either enter or leave
    event: enter # or "leave"
```

### 지리적 위치 트리거

지리적 위치 트리거는 entity가 영역에 나타나거나 영역에서 사라질 때 트리거 할 수 있습니다. [Geolocation](/integrations/geo_location/) 플랫폼 으로 생성된 entity는 GPS 좌표 보고를 지원합니다. entity는 이러한 플랫폼에 의해 자동으로 생성 및 제거되므로 entity ID는 일반적으로 예측할 수 없습니다. 대신 이 트리거에는 Geolocation 플랫폼 중 하나에 직접 연결된 `source`의 정의가 필요로 합니다. 

```yaml
automation:
  trigger:
    platform: geo_location
    source: nsw_rural_fire_service_feed
    zone: zone.bushfire_alert_zone
    # Event is either enter or leave
    event: enter # or "leave"
```

### 멀티플 트리거

자동화 규칙에 여러 트리거가 포함되도록 하려면 각 트리거의 첫 번째 줄 앞에 대시 (-)를 붙이고 그에 따라 다음 줄을 들여 쓰기하면됩니다. 트리거 중 하나가 실행될 때마다 규칙이 실행됩니다.

```yaml
automation:
  trigger:
    # first trigger
    - platform: time_pattern
      minutes: 5
      # our second trigger is the sunset
    - platform: sun
      event: sunset
```
