---
title: 로그공유(dweet.io)
description: Transfer events to Dweet.io.
logo: dweet.png
ha_category:
  - History
  - Sensor
ha_release: 0.19
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/Bb_HznYrShc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`dweet` 통합구성요소를 통해 Home Assistant로 수집한 세부 정보를 [Dweet.io] (https://dweet.io/)로 전송하고 [freeboard.io](https://freeboard.io)로 시각화 할 수 있습니다. 단, 귀하의 정보는 공개될 것임을 명심하십시오!

<p class='img'>
  <img src='{{site_root}}/images/screenshots/dweet-freeboard.png' />
</p>

<div class='note warning'>
게시 간격은 1 초로 제한됩니다. 즉, 빠른 변경 사항을 놓칠 수도 있습니다.
</div>

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Sensor](#sensor)

## 설정

설치시 `dweet` 통합구성요소를 사용하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
dweet:
  name: YOUR_UNIQUE_IDENTIFIER
  whitelist:
    - input_number.brightness
    - input_boolean.notify_home
    - sensor.weather_temperature
    - sensor.cpu
```

{% configuration %}
name:
  description: Home Assistant 인스턴스의 고유 식별자
  required: true
  type: string
whitelist:
  description: 퍼블리쉬하려는 엔티티 ID 목록
  required: true
  type: list
{% endconfiguration %}

## 센서

`dweet` 센서 플랫폼을 사용하면 [Dweet.io](https://dweet.io/)에 값을 게시하는 장치에서 세부 정보를 얻을 수 있습니다.

### 설정

설치시 Dweet.io 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: dweet
    device: THING_NAME
    value_template: '{{ value_json.VARIABLE }}'
```
{% endraw %}

{% configuration %}
device:
  description: "장치 식별자 (`thing`이라고도 함)."
  required: true
  type: string
value_template:
  description: 컨텐츠에서 값을 추출하는 변수.
  required: true
  type: template
name:
  description: 프런트 엔드에서 장치 이름을 덮어 씁니다.
  required: false
  default: Dweet.io Sensor
  type: string
unit_of_measurement:
  description: 센서의 측정 단위를 정의합니다 (있는 경우).
  required: false
  type: string
{% endconfiguration %}

### 전체 설정 사례

전체 설정 항목은 아래 샘플과 같습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: dweet
    name: Temperature
    device: THING_NAME
    value_template: '{{ value_json.VARIABLE }}'
    unit_of_measurement: "°C"
```
{% endraw %}

### Dweet.io와 상호 작용

`curl`로 센서를 테스트하기 위해 command line에서 dweets을 쉽게 보낼 수 있습니다.

```bash
$ curl -H 'Content-Type: application/json' -d '{"temperature": 40, "humidity": 65}' https://dweet.io/dweet/for/ha-sensor
```

다음과 같은 응답을 제공합니다.

```json
{"this":"succeeded","by":"dweeting","the":"dweet","with":{"thing":"ha-sensor","created":"2015-12-10T09:43:31.133Z","content":{"temperature":40,"humidity":65}}}
```

[dweepy](https://github.com/paddycarey/dweepy) 모듈은 [Dweet.io](https://dweet.io/)와 함께 사용할 수있는 다른 옵션을 제공합니다.

dweet을 보냅니다. 

```bash
$ python3
>>> import dweepy
>>> dweepy.dweet_for('ha-sensor', {'temperature': '23', 'humiditiy':'81'})
{'thing': 'ha-sensor', 'created': '2015-12-10T09:46:08.559Z', 'content': {'humiditiy': 81, 'temperature': 23}}
```

최신 dweet을 받습니다. 

```bash
>>> dweepy.get_latest_dweet_for('ha-sensor')
[{'thing': 'ha-sensor'', 'created': '2015-12-10T09:43:31.133Z', 'content': {'humidity': 65, 'temperature': 40}}]
```
