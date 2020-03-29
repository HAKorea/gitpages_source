---
title: "조건(Conditions)"
description: "Documentation about all available conditions."
redirect_from: /getting-started/scripts-conditions/
---

스크립트 또는 자동화 내에서 조건을 사용하여 추가 실행을 방지할 수 있습니다. 조건이 true를 반환하지 않으면 스크립트 또는 자동화가 실행을 중지합니다. 조건은 그 순간에 시스템을 살펴볼 것입니다. 예를 들어, 스위치가 현재 켜져 있는지 여부를 테스트할 수 있습니다. 

트리거는 항상 `or`를 기준으로 동작하는 것과 달리, 조건은 `and`가 기본입니다. - 기본적으로 모든 조건이 충족되어야합니다.

### AND condition

하나의 조건문에서 여러 조건을 테스트하십시오. 모든 해당 조건이 유효한 경우 전달합니다.

```yaml
condition:
  condition: and
  conditions:
    - condition: state
      entity_id: 'device_tracker.paulus'
      state: 'home'
    - condition: numeric_state
      entity_id: 'sensor.temperature'
      below: 20
```

AND와 OR 조건을 결합하지 않으려는 경우 순차적으로 나열할 수 있습니다.

다음 설정은 위에 나열된 설정과 동일하게 작동합니다. :

```yaml
condition:
  - condition: state
    entity_id: 'device_tracker.paulus'
    state: 'home'
  - condition: numeric_state
    entity_id: 'sensor.temperature'
    below: 20
```

현재 [automations editor](/docs/automation/editor/)를 사용하여 조건을 편집할 수 있도록 조건을 형식화해야합니다.

### OR condition

하나의 조건문에서 여러 조건을 테스트하십시오. 해당 조건이 유효한 경우 전달합니다.

```yaml
condition:
  condition: or
  conditions:
    - condition: state
      entity_id: 'device_tracker.paulus'
      state: 'home'
    - condition: numeric_state
      entity_id: 'sensor.temperature'
      below: 20
```

### AND와 OR의 혼합 conditions

하나의 조건문에서 여러 AND와 OR 조건을 테스트하십시오. 임베드된 해당 조건이 유효한 경우 전달합니다. 이를 통해 여러 AND와 OR 조건을 혼합할 수 있습니다.

```yaml
condition:
  condition: and
  conditions:
    - condition: state
      entity_id: 'device_tracker.paulus'
      state: 'home'
    - condition: or
      conditions:
        - condition: state
          entity_id: sensor.weather_precip
          state: 'rain'
        - condition: numeric_state
          entity_id: 'sensor.temperature'
          below: 20
```

### 숫자 상태 조건 (Numeric state condition) 

이 유형의 조건은 지정된 entity의 상태를 숫자로 구문 분석하려고 시도하고 값이 임계값과 일치하는 경우 트리거합니다.

`below`와 `above`의 두 경우는 해당 두 테스트를 통과해야합니다.

선택적으로 `value_template`을 사용하여 테스트하기 전에 미리 상태값을 처리 할 수 ​​있습니다.

```yaml
condition:
  condition: numeric_state
  entity_id: sensor.temperature
  above: 17
  below: 25
  # If your sensor value needs to be adjusted
  value_template: {% raw %}'{{ float(state.state) + 2 }}'{% endraw %}
```

### 상태 조건 (State condition) 

entity가 지정된 상태인지 테스트합니다..

```yaml
condition:
  condition: state
  entity_id: device_tracker.paulus
  state: 'not_home'
  # optional: trigger only if state was this for last X time.
  for:
    hours: 1
    minutes: 10
    seconds: 5
```

### 태양 조건 (Sun condition)

#### 태양 상태 조건 (Sun state condition)

태양 상태는 태양이 지거나 뜨는지 테스트하는데 사용할 수 있습니다.

```yaml
condition:
  condition: state  # 'day' condition: from sunrise until sunset
  entity_id: sun.sun
  state: 'above_horizon'
```

```yaml
condition:
  condition: state  # from sunset until sunrise
  entity_id: sun.sun
  state: 'below_horizon'
```

#### 태양 고도 조건 (Sun elevation condition)

트리거가 발생했을 때 태양이 뜨거나 태양이 지는지, 밤이 되는지, 밤인지 등을 테스트하는데 태양 고도(elevation)를 사용할 수 있습니다. 태양 고도에 대한 자세한 설명은 [sun elevation trigger][sun_elevation_trigger]를 참조하십시오.

[sun_elevation_trigger]:/docs/automation/trigger/#sun-elevation-trigger

```yaml
condition:
  condition: and  # 'twilight' condition: dusk and dawn, in typical locations
  conditions:
    - condition: template
      value_template: {% raw %}'{{ state_attr("sun.sun", "elevation") < 0 }}'{% endraw %}
    - condition: template
      value_template: {% raw %}'{{ state_attr("sun.sun", "elevation") > -6 }}'{% endraw %}
```

```yaml
condition:
  condition: template  # 'night' condition: from dusk to dawn, in typical locations
  value_template: {% raw %}'{{ state_attr("sun.sun", "elevation") < -6 }}'{% endraw %}
```

#### 일몰/일출 조건 (Sunset/sunrise condition)

또한 태양 상태는 트리거가 발생할 때 태양이 이미 졌거나 떴는지 테스트할 수 있습니다. `before`와 `after` key들은 `sunset` 혹은 `sunrise`만 설정할 수 있습니다. [sun trigger][sun_trigger]와 유사하게 이 키들은 (`before_offset`, `after_offset`)라는 선택적인 오프셋값을 갖습니다. 

[sun_trigger]:/docs/automation/trigger/#sun-trigger

<div class='note warning'>
sunset/sunrise 조건은 극지방 내의 위치에서는 작동하지 않으며 현지 시간대가 치우친 곳에서는 작동하지 않습니다.

이러한 경우, before/after sunset/sunrise 조건 대신 태양 고도를 측정하는 조건을 사용하는 것이 좋습니다.
</div>

```yaml
condition:
  condition: sun
  after: sunset
  # Optional offset value - in this case it must from -1 hours relative to sunset, or after
  after_offset: "-01:00:00"
```

```yaml
condition:
  condition: or  # 'when dark' condition: either after sunset or before sunrise - equivalent to a state condition on `sun.sun` of `below_horizon`
  conditions:
    - condition: sun
      after: sunset
    - condition: sun
      before: sunrise
```

```yaml
condition:
  condition: and  # 'when light' condition: before sunset and after sunrise - equivalent to a state condition on `sun.sun` of `above_horizon`
  conditions:
    - condition: sun
      before: sunset
    - condition: sun
      after: sunrise
```

이러한 조건이 참인 경우의 예를 보여주는 시각적 타임 라인이 아래에 제공됩니다. 이 차트에서 일출 시간은 6:00이며 일몰 시간은 18:00 (6:00 PM)입니다. 차트의 녹색 영역은 지정된 조건이 참일 때를 나타냅니다.

<img src='/images/docs/scripts/sun-conditions.svg' alt='Graphic showing an example of sun conditions' />

### 템플릿 조건 (Template condition)

템플릿 조건은 주어진 템플릿 이 true와 같은 값을 렌더링하는지 테스트합니다. 이는 템플릿 결과가 실제 boolean 형식이 되거나 템플릿이 'true'로 렌더링되도록 함으로써 실현됩니다.

```yaml
condition:
  condition: template
  value_template: "{% raw %}{{ (state_attr('device_tracker.iphone', 'battery_level')|int) > 50 }}{% endraw %}"
```

자동화 내에서 템플릿 조건은 [여기 설명된 대로][automation-templating]`trigger` 변수에 액세스할 수도 있습니다 .

[template]:/topics/templating/
[automation-templating]:/getting-started/automation-templating/

### 시간 조건 (Time condition)

시간 조건은 지정된 시간 이후, 지정된 시간 전인지 혹은 특정 요일인지 테스트할 수 있습니다.

```yaml
condition:
  condition: time
  # At least one of the following is required.
  after: '15:00:00'
  before: '02:00:00'
  weekday:
    - mon
    - wed
    - fri
```

유효한 값은 `weekday`는 `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun` 입니다. 시간 조건 창은 자정 임계값에 걸쳐있을 수 있습니다. 위의 예에서 조건 창은 오후 3시부터 오전 2시입니다.

<div class='note tip'>

평일에 더 좋은 조건은 [Workday Binary Sensor](/integrations/workday/)를 사용하는 것 입니다.

</div>

### 영역 조건 (Zone condition)

영역 조건은 엔티티가 특정 영역에 있는지 테스트합니다.  영역 자동화가 작동하려면 GPS 좌표보고를 지원하는 장치 추적기 플랫폼을 설정해야합니다. 현재 이는 [OwnTracks platform](/integrations/owntracks/)과 [iCloud platform](/integrations/icloud/)으로 제한됩니다.

```yaml
condition:
  condition: zone
  entity_id: device_tracker.paulus
  zone: zone.home
```

### 사례 (Examples)

```yaml
condition:
  - condition: numeric_state
    entity_id: sun.sun
    value_template: '{{ state.attributes.elevation }}'
    below: 1
  - condition: state
    entity_id: light.living_room
    state: 'off'
  - condition: time
    before: '23:00:00'
    after: '14:00:00'
  - condition: state
    entity_id: script.light_turned_off_5min
    state: 'off'
```
