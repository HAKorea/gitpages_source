---
title: "템플릿 사용"
description: "Instructions on how to use the templating feature of Home Assistant."
redirect_from: /topics/templating/
---

홈어시스턴트의 고급 기능입니다. 다음에 대한 기본 이해가 필요합니다. :

- [홈어시스턴트 아키텍처](/developers/architecture/), 특히 상태(states).
- [상태(State) 객체](/topics/state_object/).

템플릿은 시스템으로 들어오고 나가는 정보를 제어할 수 있는 강력한 기능입니다. 다음 용도로 사용됩니다. :

- [notify](/integrations/notify/) platform, [alexa](/integrations/alexa/) component와 같은 발신 메시지 형식화 
- [MQTT](/integrations/mqtt/), [`rest` sensor](/integrations/rest/) 혹은 [`command_line` sensor](/integrations/sensor.command_line/) 같은 원시 데이터를 제공하는 소스의 데이터 처리.
- [자동화 템플릿 (Automation Templating))](/docs/automation/templating/).

## 템플릿 만들기

홈어시스턴트 템플릿은 [Jinja2](https://palletsprojects.com/p/jinja) 템플릿 엔진으로 구동됩니다. 이는 특정 문법을 사용하고 렌더링 중에 템플릿에 일부 사용자정의 홈어시스턴트 변수를 제공함을 의미합니다. Jinja2는 다양한 작업을 지원합니다.

- [Mathematical operation](https://jinja.palletsprojects.com/en/master/templates/#math)
- [Comparisons](https://jinja.palletsprojects.com/en/master/templates/#comparisons)
- [Logic](https://jinja.palletsprojects.com/en/master/templates/#logic)

Jinja2는 [templates documentation](https://jinja.palletsprojects.com/en/master/templates/)에서 이 작업을 훌륭하게 수행하므로 문법의 기본사항은 다루지 않습니다.

프런트엔드에는 템플릿 개발과 디버깅을 도와주는 템플릿 편집기 도구가 있습니다. <img src='/images/screenshots/developer-tool-templates-icon.png' alt='template developer tool icon' class="no-shadow" height="38" /> 아이콘을 클릭 하고 _템플릿 편집기_ 에서 템플릿을 생성한 다음 오른쪽의 결과를 확인하십시오.

템플릿은 매우 빠르게 커질 수 있습니다. 명확한 구성를 유지하려면 YAML 여러 줄 문자열을 사용하여 템플릿을 정의하십시오. :

{% raw %}
```yaml
script:
  msg_who_is_home:
    sequence:
      - service: notify.notify
        data_template:
          message: >
            {% if is_state('device_tracker.paulus', 'home') %}
              Ha, Paulus is home!
            {% else %}
              Paulus is at {{ states('device_tracker.paulus') }}.
            {% endif %}
```
{% endraw %}

##  홈어시스턴트 템플릿 확장

확장 기능을 통해 템플릿은 모든 홈어시스턴트 특정 상태에 액세스하고 다른 편리한 기능과 필터를 추가할 수 있습니다.

### 상태(States)

- 반복된 `states`는 entity ID별로 알파벳순으로 정렬된 각 상태를 생성시킵니다
- 반복된 `states.domain`는 해당 도메인의 각 상태가 entity ID별로 알파벳순으로 정렬됩니다.
- `sensor.temperature`에 대한 상태 객체를 `states.sensor.temperature`로 반환합니다. 
- `states('device_tracker.paulus')`는 해당 entity의 상태 문자열(객체가 아닌)을 반환하고, 혹은 값이 존재하지 않는 경우 `unknown`을 반환합니다.
- `is_state('device_tracker.paulus', 'home')`는 주어진 entity가 특정한 어떤 상태인지를 테스트합니다.
- `state_attr('device_tracker.paulus', 'battery')`는 속성값을 반환하거나 존재하지 않는 경우 None을 반환합니다.
- `is_state_attr('device_tracker.paulus', 'battery', 40)`는 주어진 entity 속성이 지정된 상태(이 경우 숫자값)인지 테스트합니다.

<div class='note warning'>

  `states('sensor.temperature')` 대체 방법으로 `states.sensor.temperature.state`를 사용하지 마십시오.
  entity가 아직 준비가 안되어있을 때, 오류와 오류 메시지가 나타나지 않도록 가능한한 `states()`, `is_state()`, `state_attr()`, `is_state_attr()` 를 사용하기를 권장합니다. (예를 들어 홈어시스턴트를 시작하는 동안)

</div>

정상적인 [state object methods and properties](/topics/state_object/) 외에, `states.sensor.temperature.state_with_unit`은 사용 가능한 경우 entity와 장치의 상태를 출력합니다.

#### 상태(State) 사례들

상태가 존재하면 다음 두 명령문의 값은 동일합니다. 상태가 존재하지 않으면 두 번째 사례은 오류가 발생합니다.

{% raw %}
```text
{{ states('device_tracker.paulus') }}
{{ states.device_tracker.paulus.state }}
```
{% endraw %}

모든 센서 상태 목록을 출력하기. :

{% raw %}
```text
{% for state in states.sensor %}
  {{ state.entity_id }}={{ state.state }},
{% endfor %}
```
{% endraw %}

다른 상태 사례 :
{% raw %}

```text
{% if is_state('device_tracker.paulus', 'home') %}
  Ha, Paulus is home!
{% else %}
  Paulus is at {{ states('device_tracker.paulus') }}.
{% endif %}

{{ states('sensor.temperature') | float + 1 }}

{{ (states('sensor.temperature') | float * 10) | round(2) }}

{% if states('sensor.temperature') | float > 20 %}
  It is warm!
{% endif %}

{{ as_timestamp(states.binary_sensor.garage_door.last_changed) }}

{{ as_timestamp(now()) - as_timestamp(states.binary_sensor.garage_door.last_changed) }}
```
{% endraw %}

### 속성 (Attributes)

상태가 정의된 경우 `state_attr`을 사용하여 속성을 출력할 수 있습니다.

#### 속성 사례들

{% raw %}
```text
{% if states.device_tracker.paulus %}
  {{ state_attr('device_tracker.paulus', 'battery') }}
{% else %}
  ??
{% endif %}
```
{% endraw %}

문자열의 경우 :

{% raw %}
```text
{% set tracker_name = "paulus"%}

{% if states("device_tracker." + tracker_name) != "unknown" %}
  {{ state_attr("device_tracker." + tracker_name, "battery")}}
{% else %}
  ??
{% endif %}
```
{% endraw %}

### 그룹 작업

`expand` 기능과 필터는 entity를 정렬하고 그룹을 확장하는데 사용할 수 있습니다. 중복되지 않은 정렬된 entity 배열을 출력합니다.

#### 예제 펼쳐보이기

{% raw %}
```text
{% for tracker in expand('device_tracker.paulus', 'group.child_trackers') %}
  {{ state_attr(tracker, 'battery') }}
  {%- if not loop.last %}, {% endif -%}
{% endfor %}
```
{% endraw %}

같은 것을 필터로 표현할 수 있습니다. :

{% raw %}
```text
{{ ['device_tracker.paulus', 'group.child_trackers'] | expand 
  | selectattr("attributes.battery", 'defined')
  | join(', ', attribute="attributes.battery") }}
```
{% endraw %}

### 시간

- `now()` 시간대의 현재 시간으로 렌더링됩니다.
  - 특정값의 경우: `now().second`, `now().minute`, `now().hour`, `now().day`, `now().month`, `now().year`, `now().weekday()`, `now().isoweekday()`
- `utcnow()` UTC 시간으로 렌더링됩니다.
  - 특정값의 경우: `utcnow().second`, `utcnow().minute`, `utcnow().hour`, `utcnow().day`, `utcnow().month`, `utcnow().year`, `utcnow().weekday()`, `utcnow().isoweekday()`.
- `as_timestamp()` datetime 객체 또는 문자열을 UNIX 타임 스탬프로 변환합니다. 이 기능은 필터로도 사용됩니다.
- `strptime(string, format)`은 [format](https://docs.python.org/3.6/library/datetime.html#strftime-and-strptime-behavior)에 따라 날짜/시간 문자열을 파싱합니다.
- `relative_time`은 날짜 시간 객체를 읽기쉬운 "age" 문자열로 변환합니다. age는 초, 분, 시, 일, 월 또는 연도일 수 있습니다 (그러나 가장 큰 단위만 고려됩니다 (예: 2 일 3 시간인 경우 "2 일"이 반환됨)). _지난 날짜_ 에 대해서만 작동한다는 것을 알아두십시오.
- 필터 `timestamp_local`은 UNIX 타임스탬프를 현지시간/데이터로 변환합니다.
- 필터 `timestamp_utc` 는 UNIX 타임스탬프를 UTC시간/데이터로 변환합니다.
- 필터 `timestamp_custom(format_string, local_boolean)`은 UNIX 타임스탬프를 사용자정의 형식으로 변환하며 로컬 타임스탬프 사용이 기본값입니다. [Python time formatting options](https://docs.python.org/3/library/time.html#time.strftime) 표준을 지원합니다.

### To/From JSON

`to_json` 필터는 JSON 문자열로 객체를 직렬화합니다(serialize). 경우에 따라 command line 유틸리티 또는 기타 여러 응용 프로그램의 매개 변수로 웹 후크와 함께 사용하기 위해 JSON 문자열을 형식화해야 할 수도 있습니다. 특히 특수 문자 이스케이프 처리시 템플릿에서 복잡할 수 있습니다. `to_json` 필터를 사용하면 자동으로 처리됩니다

`from_json` 필터는 유사하게 작동하지만 다른 방법으로, 객체로 JSON 문자열 등을 역직렬화(de-serialize) 시킬 수 있습니다.

### To/From JSON 예제들

본 예시에서 유효한 JSON을 생성하기 위해 특수 문자 '°'가 자동으로 이스케이프됩니다. 문자열화 된 객체와 실제 JSON의 차이점은 분명합니다.

*Template*

{% raw %}
```text
{% set temp = {'temperature': 25, 'unit': '°C'} %}
stringified object: {{ temp }}
object|to_json: {{ temp|to_json }}
```
{% endraw %}

*Output*

{% raw %}
```text
stringified object: {'temperature': 25, 'unit': '°C'}
object|to_json: {"temperature": 25, "unit": "\u00b0C"}
```
{% endraw %}

반대로 `from_json`을 사용하면 JSON 문자열을 객체로 역직렬화(de-serialize)하여 사용 가능한 데이터를 쉽게 추출할 수 있습니다.

*Template*

{% raw %}
```text
{% set temp = '{"temperature": 25, "unit": "\u00b0C"}'|from_json %}
The temperature is {{ temp.temperature }}{{ temp.unit }}
```
{% endraw %}

*Output*

{% raw %}
```text
The temperature is 25°C
```
{% endraw %}

### 거리

- `distance()` 집, entity, 좌표 사이의 거리를 킬로미터 단위로 측정합니다.
- `closest()` 가장 가까운 entity를 찾습니다.

#### distance 예시

하나의 위치만 전달하면 홈어시스턴트는 집과의 거리를 측정합니다.

{% raw %}
```text
Using Lat Lng coordinates: {{ distance(123.45, 123.45) }}

Using State: {{ distance(states.device_tracker.paulus) }}

These can also be combined in any combination:
{{ distance(123.45, 123.45, 'device_tracker.paulus') }}
{{ distance('device_tracker.anne_therese', 'device_tracker.paulus') }}
```
{% endraw %}

#### Closest 예시

가장 가까운 함수와 필터는 홈어시스턴트 위치에 가장 가까운 entity를 찾습니다. :

{% raw %}
```text
Query all entities: {{ closest(states) }}
Query all entities of a specific domain: {{ closest(states.device_tracker) }}
Query all entities in group.children: {{ closest('group.children') }}
Query all entities in group.children: {{ closest(states.group.children) }}
```
{% endraw %}

좌표 또는 다른 entity에 closest entity를 찾으십시오. 이전의 모든 인수는 여전히 두 번째 인수에 적용됩니다.

{% raw %}
```text
Closest to a coordinate: {{ closest(23.456, 23.456, 'group.children') }}
Closest to an entity: {{ closest('zone.school', 'group.children') }}
Closest to an entity: {{ closest(states.zone.school, 'group.children') }}
```
{% endraw %}

closest 상태를 반환하므로 distance와도 결합할 수 있습니다.

{% raw %}
```text
{{ closest(states).name }} is {{ distance(closest(states)) }} kilometers away.
```
{% endraw %}

closest 함수의 마지막 인수는 암시적(implicit) `expand`이며 반복 가능한 상태 또는 entity ID 시퀀스를 취할 수 있으며 그룹을 확장시킬 수 있습니다.

{% raw %}
```text
Closest out of given entities: 
    {{ closest(['group.children', states.device_tracker]) }}
Closest to a coordinate:  
    {{ closest(23.456, 23.456, ['group.children', states.device_tracker]) }}
Closest to some entity: 
    {{ closest(states.zone.school, ['group.children', states.device_tracker]) }}
```

이는 entity들과 group들의 또다른 반복 가능한 group에 대한 필터로 작동합니다. :

```text
Closest out of given entities: 
    {{ ['group.children', states.device_tracker] | closest }}
Closest to a coordinate:  
    {{ ['group.children', states.device_tracker] | closest(23.456, 23.456) }}
Closest to some entity: 
    {{ ['group.children', states.device_tracker] | closest(states.zone.school) }}
```

{% endraw %}

### 형식화 (Formatting)

- `float` 출력을 float으로 포맷합니다.

### 숫자형 함수와 핕터 (Numeric functions and filters)

이러한 함수중 일부는 [filter](https://jinja.palletsprojects.com/en/master/templates/#id11)에 사용할 수도 있습니다. 이는 `sqrt(2)` 같은 일반 함수로 혹은 `2|sqrt`와 같은 필터의 일부로 동작함을 의미합니다.

- `log(value, base)`는 입력 대수(로그)를 취합니다. 기본이 생략되면, `e` - 자연 대수(로그)로 기본값이 나타납니다. 
- `sin(value)` 은 사인 입력을 반환합니다. 필터로 사용할 수 있습니다.
- `cos(value)` 은 코사인 입력을 반환합니다. 필터로 사용할 수 있습니다.
- `tan(value)` 은 탄젠트 입력을 반환합니다. 필터로 사용할 수 있습니다.
- `asin(value)` 은 역사인 입력을 반환합니다. 필터로 사용할 수 있습니다.
- `acos(value)` 은 역코사인 입력을 반환합니다. 필터로 사용할 수 있습니다.
- `atan(value)` 은 역탄젠트 입력을 반환합니다. 필터로 사용할 수 있습니다.
- `atan2(y, x)` y/x의 4사분면 역탄젠트를 반환합니다. 필터로 사용할 수 있습니다.
- `sqrt(value)` 입력의 제곱근을 반환합니다. 필터로 사용할 수 있습니다.
- `e` 수학 상수, 약 2.71828
- `pi` 수학 상수, 약 3.14159
- `tau` 수학 상수, 약 6.28318.
- 필터 `round(x)`는 입력을 숫자로 변환하고 `x`를 소수로 반올림합니다. Round에는 네 가지 모드가 있으며 기본 모드(모드를 지정하지 않은 경우)는 [round-to-even](https://en.wikipedia.org/wiki/Rounding#Roundhalfto_even) 입니다.
  - `round(x, "floor")`는 `x`를 항상 소수점 이하로 내림
  - `round(x, "ceil")` 는 `x`를 항상 소수점 이하로 올림
  - `round(1, "half")` 항상 가장 가까운 0.5 값으로 반올림. `x`는 이 모드에서는 1이어야합니다
- 필터 `max` 는 가장 큰 항목을 순서대로 가져옵니다.
- 필터 `min` 는 가장 작은 항목을 순서대로 가져옵니다.
- 필터 `value_one|bitwise_and(value_two)` 는 두 가지 값으로 비트 단위 (&) 연산을 수행합니다.
- 필터 `value_one|bitwise_or(value_two)` 두 가지 값으로 비트 단위 또는 (|) 연산을 수행합니다.
- 필터 `ord` 는 인수가 유니코드 객체인 경우 문자의 유니코드 코드 포인트를 나타내는 정수 1의 길이의 문자열 또는 인수가 8 비트 문자열인 경우 바이트 값을 반환합니다.

### 정규식

- 필터 `string|regex_match(find, ignorecase=FALSE)`는 정규식을 사용하여 문자열의 시작 부분에서 찾기 표현식과 일치(match)시킵니다.
- 필터 `string|regex_search(find, ignorecase=FALSE)` 는 정규식을 사용하여 문자열의 어디에서나 찾기 표현식과 일치시킵니다.
- 필터 `string|regex_replace(find='', replace='', ignorecase=False)` 는 정규식을 사용하여 교체된 찾기 표현식을 바꿉니다.
- 필터 `string|regex_findall_index(find='', index=0, ignorecase=False)`는 문자열에서 찾기의 모든 정규식 match를 찾고 색인에서 match를 리턴합니다 (findall은 match 배열을 리턴함).

## 수신 데이터 처리

템플릿의 다른 부분은 들어오는 데이터를 처리합니다. 수신 데이터를 수정하고 관심있는 데이터만 추출할 수 있습니다. 이는 문서에서 이를 지원하는 플랫폼과 통합구성요소에서만 작동합니다.

통합구성요소 또는 플랫폼에 따라 다르지만, `value_template` 설정 키를 사용하여 템플릿을 정의하는 것이 일반적입니다. 새 값이 도착하면 일반적인 홈어시스턴트 확장 프로그램의 상단에 있는 다음 값에 액세스하면서 템플릿이 렌더링됩니다. :

| Variable     | Description                        |
|--------------|------------------------------------|
| `value`      | 들어오는 값.                |
| `value_json` | 들어오는 값은 JSON으로 파싱되었습니다. |

이는 들어오는 값이 아래 샘플과 같은 경우를 의미합니다 :

```json
{
  "on": "true",
  "temp": 21
}
```

템플릿 `on` 은 다음과 같습니다. :

{% raw %}
```yaml
'{{value_json.on}}'
```
{% endraw %}

응답시 Nested JSON(중첩 JSON)도 지원됩니다.:

```json
{
  "sensor": {
    "type": "air",
    "id": "12345"
  },
  "values": {
    "temp": 26.09,
    "hum": 56.73
  }
}
```

“스퀘어 브래킷 표기법”을 사용하여 값을 얻으십시오.

{% raw %}
```yaml
'{{ value_json['values']['temp'] }}'
```
{% endraw %}

다음 개요에는 필요한 값을 얻는 몇 가지 옵션이 있습니다. :

```text
# Incoming value:
{"primes": [2, 3, 5, 7, 11, 13]}

# Extract third prime number
{% raw %}{{ value_json.primes[2] }}{% endraw %}

# Format output
{% raw %}{{ "%+.1f" | value_json }}{% endraw %}

# Math
{% raw %}{{ value_json | float * 1024 }}{% endraw %}
{% raw %}{{ float(value_json) * (2**10) }}{% endraw %}
{% raw %}{{ value_json | log }}{% endraw %}
{% raw %}{{ log(1000, 10) }}{% endraw %}
{% raw %}{{ sin(pi / 2) }}{% endraw %}
{% raw %}{{ cos(tau) }}{% endraw %}
{% raw %}{{ tan(pi) }}{% endraw %}
{% raw %}{{ sqrt(e) }}{% endraw %}

# Timestamps
{% raw %}{{ value_json.tst | timestamp_local }}{% endraw %}
{% raw %}{{ value_json.tst | timestamp_utc }}{% endraw %}
{% raw %}{{ value_json.tst | timestamp_custom('%Y' True) }}{% endraw %}
```

응답으로 값을 받으려면, <img src='/images/screenshots/developer-tool-templates-icon.png' alt='template developer tool icon' class="no-shadow" height="38" /> 템플릿 개발자 도구로 이동하여, "템플릿"에서 출력을 작성한 후 결과를 확인하십시오.

{% raw %}
```yaml
{% set value_json=
    {"name":"Outside",
	 "device":"weather-ha",
     "data":
	    {"temp":"24C",
		 "hum":"35%"
		 }	}%}

{{value_json.data.hum[:-1]}}
```
{% endraw %}

## 명심해야 할 몇 가지 더

### 숫자로 시작하는 `entity_id`

템플릿이 (예: `states.device_tracker.2008_gmc`)와 같이 숫자로 시작하는 `entity_id`를 사용한다면, 렌더링하여 발생하는 오류를 피하려면 대괄호 구문을 사용해야합니다. 주어진 예에서 장치 추적기의 올바른 구문은 다음과 같습니다. : `states.device_tracker['2008_gmc']`

### NOW()를 사용하는 entity가 없는 템플릿

(`now()`)은 시간에 종속되어 entity를 사용하지 않는 템플릿은 entity 상태 변경에서만 발생하므로 업데이트되지 않습니다. 자세한 내용과 예는 [`template` sensor documentation](/integrations/template/#working-without-entities)를 참조하십시오. 

### 연산자 우선 순위

연산자의 기본 우선 순위는 필터 (`|`) 가 대괄호를 제외한 모든 것보다 우선 순위가 있다는 것입니다. 이는 다음을 의미합니다.

{% raw %}
```yaml
{{ states('sensor.temperature') | float / 10 | round(2) }}
```
{% endraw %}

`10` 을 소수점 이하 두 자리로 반올림 한 다음, `states('sensor.temperature')`를 해당값으로 나눕니다