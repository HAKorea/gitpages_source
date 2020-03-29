---
title: 필터(Filter)
description: Instructions on how to integrate Data Filter Sensors into Home Assistant.
ha_category:
  - Utility
ha_release: 0.65
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
ha_codeowners:
  - '@dgomes'
---

`filter` 플랫폼은 다른 엔티티의 상태가 조정된 센서로 만들어줍니다.

`filter`는 신호 처리 알고리즘을 센서, 이전과 현재 상태에 적용하고 선택한 알고리즘에 따라 `new state`를 생성합니다. 다음 이미지는 [History Graph]({{site_roor}}/integrations/history_graph/) 구성 요소를 사용하여 동일한 센서의 원래 센서와 필터 센서를 보여줍니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/filter-sensor.png' />
</p>

## 설정

설치시 필터 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: filter
    name: "filtered realistic humidity"
    entity_id: sensor.realistic_humidity
    filters:
      - filter: outlier
        window_size: 4
        radius: 4.0
      - filter: lowpass
        time_constant: 10
        precision: 2
  - platform: filter
    name: "filtered realistic temperature"
    entity_id: sensor.realistic_temperature
    filters:
      - filter: outlier
        window_size: 4
        radius: 2.0
      - filter: lowpass
        time_constant: 10
      - filter: time_simple_moving_average
        window_size: 00:05
        precision: 2
```

필터는 연결될 수 있으며 설정 파일에 있는 순서에 따라 적용됩니다.

{% configuration %}
entity_id:
  description: 필터링할 센서의 엔티티 ID.
  required: true
  type: string
name:
  description: 프론트 엔드에서 사용할 이름.
  required: false
  type: string
filters:
  description: Filters to be used.
  required: true
  type: list
  keys:
    filter:
      description: Algorithm to be used to filter data. Available filters are  `lowpass`, `outlier`, `range`, `throttle`, `time_throttle` and `time_simple_moving_average`.
      required: true
      type: string
    window_size:
      description: Size of the window of previous states. Time based filters such as `time_simple_moving_average` will require a time period (size in time), while other filters such as `outlier` will require an integer (size in number of states)
      required: false
      type: [integer, time]
      default: 1
    precision:
      description: See [_lowpass_](#low-pass) filter. Defines the precision of the filtered state, through the argument of round().
      required: false
      type: integer
      default: None
    time_constant:
      description: See [_lowpass_](#low-pass) filter. Loosely relates to the amount of time it takes for a state to influence the output.
      required: false
      type: integer
      default: 10
    radius:
      description: See [_outlier_](#outlier) filter. Band radius from median of previous states.
      required: false
      type: float
      default: 2.0
    type:
      description: See [_time_simple_moving_average_](#time-simple-moving-average) filter. Defines the type of Simple Moving Average.
      required: false
      type: string
      default: last
    lower_bound:
      description: See [_range_](#range) filter. Lower bound for filter range.
      required: false
      type: float
      default: negative infinity
    upper_bound:
      description: See [_range_](#range) filter. Upper bound for filter range.
      required: false
      type: float
      default: positive infinity
{% endconfiguration %}

## 필터들 

### Low-pass

Low-pass 필터 (`lowpass`)는 peaks와 valleys를 단축하여 데이터를 부드럽게하기 때문에 가장 일반적인 필터를 처리하는 신호 중 하나입니다.

포함된 Low-pass 필터는 매우 기본적이며 [exponential smoothing](https://en.wikipedia.org/wiki/Exponential_smoothing)를 기반으로 하며, 이전 데이터 포인트에 새 데이터 포인트가 가중됩니다.

```python
B = 1.0 / time_constant
A = 1.0 - B
LowPass(state) = A * previous_state + B * state
```

반환값은 (`precision`)에 정의된 소수로 반올림됩니다.

### Outlier

Outlier 필터 (`outlier`)는 특정범위 밖의 값을 잘라내기 때문에 기본 Band-pass 필터입니다.

포함된 Outlier 필터는 이전값의 중앙값을 중심으로하는 대역(band)을 넘어서서 값을 버리고 이전값의 중간값으로 대체합니다. 대역안에 있으면 다음과 같습니다. 

```python
distance = abs(state - median(previous_states))

if distance > radius:
    median(previous_states)
else:
    state
```

### Throttle

Throttle 필터 (`throttle`)는 window의 첫 번째 상태에 대한 센서 상태만 업데이트합니다. 이는 필터가 다른 모든 값을 건너 뛰는 것을 의미합니다.

비율을 조정하려면 window_size를 설정해야합니다. 센서를 10 %로 낮추려면 `window_size`를 10으로 설정해야하며 50 %는 2로 설정해야합니다.

이 필터는 매우 빠른 속도로 상태를 생성하는 센서가 있을 때 적합하며, 저장 또는 시각화 목적으로 조절할 수 있습니다.

### Time Throttle

Time Throttle 필터 (`time_throttle`)는 window의 첫 번째 상태에 대한 센서 상태만 업데이트합니다. 이는 필터가 다른 모든 값을 건너 뛰는 것을 의미합니다.

비율을 조정하려면 window_size를 설정해야합니다. 센서를 분당 1의 값으로 낮추려면 `window_size`를 00:01로 설정해야합니다.

이 필터는 매우 일정한 속도로 상태를 생성하는 센서가 있는 경우에 적합하며, 저장 또는 시각화 목적으로 일정한 속도로 조절할 수 있습니다.

### Time Simple Moving Average

Time SMA 필터(`time_simple_moving_average`)는 Andreas Eckner의 [Algorithms for Unevenly Spaced Time Series: Moving Averages and Other Rolling Operators](http://www.eckner.com/papers/Algorithms%20for%20Unevenly%20Spaced%20Time%20Series.pdf)에 대한 논문을 기반으로합니다.

이 논문은 SMA(Simple Moving Average)의 세 가지 유형/버전 : (*last*, *next* 및 *linear*)을 정의합니다. 현재 *last* 만 구현되었습니다.

논문에 기술된 바와 같이, Theta는 `window_size` 파라미터이며, 시간 표기법 (예를 들어, 5 분 시간 윈도우의 경우 00:05)을 사용하여 표현될 수 있습니다.

### Range


Range 필터(`range`)는 들어오는 데이터를 하한과 상한으로 지정된 범위로 제한합니다.

상한(upper bound)보다 큰 모든 값은 상한으로 대체되고 하한(lower bound)보다 낮은 모든 값은 하한으로 대체됩니다.
기본적으로 상한 또는 하한이 없습니다.

```python
if new_state > upper_bound:
    upper_bound
if new_state < lower_bound:
    lower_bound
new_state
```
