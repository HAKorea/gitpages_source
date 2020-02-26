---
title: RESTful
description: Instructions on how to integrate REST sensors into Home Assistant.
logo: restful.png
ha_category:
  - Sensor
ha_release: 0.7.4
ha_iot_class: Local Polling
---

`rest` 센서 플랫폼은 장치, 애플리케이션 또는 웹서비스의 [RESTful API](https://en.wikipedia.org/wiki/Representational_state_transfer)에 의해 노출되는 지정된 엔드 포인트를 연결(consuming)해줍니다. 

이 센서를 활성화하려면 GET 요청을 위해 `configuration.yaml` 파일에 다음 라인을 추가하십시오. :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: rest
    resource: http://IP_ADDRESS/ENDPOINT
```

또는 POST 요청의 경우 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: rest
    resource: http://IP_ADDRESS/ENDPOINT
    method: POST
    payload: '{ "device" : "heater" }'
```

또는 템플릿 기반 요청 :

{% raw %}

```yaml
# Example configuration.yaml entry
sensor:
  - platform: rest
    resource_template: http://IP_ADDRESS/{{ now().strftime('%Y-%m-%d') }}
```

{% endraw %}

{% configuration %}
resource:
  description: 값이 포함된 자원 또는 엔드 포인트.
  required: true
  type: string
resource_template:
  description: 템플리트 지원값이 포함된 자원 또는 엔드 포인트.
  required: true
  type: template
method:
  description: 요청 방법. `POST` 혹은 `GET` 둘 중 하나.
  required: false
  type: string
  default: GET
name:
  description: REST 센서의 이름.
  required: false
  type: string
  default: REST Sensor
device_class:
  description: 프론트 엔드에 표시되는 디바이스 상태 및 아이콘을 변경하여 [class of the device](/integrations/sensor/)를 설정.
  required: false
  type: string
value_template:
  description: "값을 추출 할 [template](/docs/configuration/templating/#processing-incoming-data) 을 정의"
  required: false
  type: template
payload:
  description: POST 요청과 함께 보낼 페이로드. 서비스에 따라 다르지만 일반적으로 JSON으로 구성.
  required: false
  type: string
verify_ssl:
  description: 엔드 포인트의 SSL 인증서를 확인.
  required: false
  type: boolean
  default: True
timeout:
  description: 엔드 포인트에서 데이터를 기다리는 최대 시간을 정의.
  required: false
  type: integer
  default: 10
unit_of_measurement:
  description: 센서의 측정 단위를 정의, 있을 경우.
  required: false
  type: string
authentication:
  description: HTTP 인증의 유형. `basic` 혹은 `digest`.
  required: false
  type: string
username:
  description: REST 엔드 포인트에 액세스하기위한 사용자 이름.
  required: false
  type: string
password:
  description: REST 엔드 포인트에 액세스하기위한 비밀번호.
  required: false
  type: string
headers:
  description: 요청에 대한 헤더.
  required: false
  type: [string, list]
json_attributes:
  description: JSON 사전(dictinary) 결과에서 값을 추출한 후 센서 속성으로 설정하는 키 목록.
  reqired: false
  type: [string, list]
force_update:
  description: 값이 변경되지 않은 경우에도 업데이트 이벤트를 보냅니다. 히스토리에 유의미한 값들의 그래프를 원할 때 유용합니다.
  reqired: false
  type: boolean
  default: false
{% endconfiguration %}

<div class='note warning'>
URL이 엔드 포인트 또는 리소스와 정확히 일치하는지 확인.
</div>

<div class='note'>

`resource` 혹은 `resource_template` 을 사용하십시오.

</div>

`curl`은 홈어시스턴트 프론트 엔드에 표시하려는 변수를 식별하는 데 도움이됩니다. 아래 예는 [aREST](https://arest.io/)로 실행중인 장치의 JSON 응답을 보여줍니다.

```bash
$ curl -X GET http://192.168.1.31/temperature/
{"temperature": 77, "id": "sensor02", "name": "livingroom", "connected": true}
```

응답은 사전(dictionary)이거나 0 번째 요소 인 사전(dictionary)이 있는 목록 일 것으로 예상됩니다.

## 사례 

이 섹션에는이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 외부 IP 주소

[http://ip.jsontest.com/](http://ip.jsontest.com/) URL에서 서비스 [JSON Test](https://www.jsontest.com/)를 사용하여 외부 IP 주소를 찾을 수 있습니다. 

```yaml
sensor:
  - platform: rest
    resource: http://ip.jsontest.com
    name: External IP
    value_template: '{% raw %}{{ value_json.ip }}{% endraw %}'
```

###  로컬 GLANCES 인스턴스의 단일값 (Single value from a local Glances instance)

[glances](/integrations/glances) 센서는 모든 노출 된 값에 대해 똑같은 일을합니다.

```yaml
sensor:
  - platform: rest
    resource: http://IP_ADRRESS:61208/api/2/mem/used
    name: Used mem
    value_template: '{% raw %}{{ value_json.used| multiply(0.000000954) | round(0) }}{% endraw %}'
    unit_of_measurement: MB
```

### 다른 홈 어시스턴트 인스턴스의 값 (Value from another Home Assistant instance)

홈어시스턴트 [API](/developers/rest_api/)는 연결된 센서에서 데이터를 노출합니다. [connected](/developers/architecture/#multiple-connected-instances) 가 아닌 여러 Home Assistant 인스턴스를 실행중인 경우에도 해당 정보를 얻을 수 있습니다.

자원 변수에서 홈어시스턴트 인스턴스가 API 비밀번호로 보호되는 경우, `? api_password = YOUR_PASSWORD`를 자원 URL에 추가하여 `headers:`를 인증하거나 사용할 수 있습니다.

```yaml
sensor:
  - platform: rest
    resource: http://IP_ADDRESS:8123/api/states/sensor.weather_temperature
    name: Temperature
    value_template: {% raw %}'{{ value_json.state }}'{% endraw %}
    unit_of_measurement: "°C"
```

### HTTP 인증으로 보호 된 엔드 포인트에 액세스 (Accessing an HTTP authentication protected endpoint)

REST 센서는 HTTP 인증 및 사용자 정의된 헤더를 지원.

```yaml
sensor:
  - platform: rest
    resource: http://IP_ADDRESS:5000/sensor
    username: ha1
    password: test1
    authentication: basic
    headers:
      User-Agent: Home Assistant
      Content-Type: application/json
```

헤더에는 모든 관련 세부 사항이 포함. 또한 토큰으로 보호되는 엔드 포인트에 액세스 할 수 있습니다.

```bash
Content-Length: 1024
Host: IP_ADDRESS1:5000
Authorization: Basic aGExOnRlc3Qx
Accept-Encoding: identity
Content-Type: application/json
User-Agent: Home Assistant
```

`Authorization` 헤더의 `Bearer` 토큰으로 보호되는 리소스에 액세스하는 경우 센서 설정의 헤더 필드에 토큰을 넣거나 (권장하지 않음) [`secrets.yaml`](/docs/configuration/secrets/) 파일에 토큰을 저장할 수 있습니다. 
이 경우,`secrets` 파일에 `Bearer`라는 단어를 포함 시키십시오.

```yaml
sensor:
  - platform: rest
    resource: http://IP_ADDRESS:5000/sensor
    headers:
      Authorization: !secret my_sensor_secret_token
```

`secrets.yaml`파일 항목 예 :

```yaml
my_sensor_secret_token: Bearer gh_DHQIXKVf6Pr4H8Yqz8uhApk_mnV6Zje6Pr4H8Yqz8A8nCxz6SBghQdS51
```

### GITHUB를 사용하여 홈어시스턴트 최신 릴리스 확인

이 샘플은 [`updater`](/integrations/updater/) 통합구성요소와 매우 유사 하지만 정보는 GitHub에서 수신됩니다.

```yaml
sensor:
  - platform: rest
    resource: https://api.github.com/repos/home-assistant/home-assistant/releases/latest
    username: YOUR_GITHUB_USERNAME
    password: YOUR_GITHUB_ACCESS_TOKEN
    authentication: basic
    value_template: '{% raw %}{{ value_json.tag_name }}{% endraw %}'
    headers:
      Accept: application/vnd.github.v3+json
      Content-Type: application/json
      User-Agent: Home Assistant REST sensor
```

### 여러 JSON 값을 가져 와서 속성으로 표시

[JSON Test](https://www.jsontest.com/) 는 [http://date.jsontest.com/](http://date.jsontest.com/) 에서 유닉스시간 이래 현재 시간, 날짜 및 밀리 초를 반환합니다.

{% raw %}
```yaml
sensor:
  - platform: rest
    name: JSON time
    json_attributes:
      - date
      - milliseconds_since_epoch
    resource: http://date.jsontest.com/
    value_template: '{{ value_json.time }}'
  - platform: template
    sensors:
      date:
        friendly_name: 'Date'
        value_template: '{{ states.sensor.json_time.attributes["date"] }}'
      milliseconds:
        friendly_name: 'milliseconds'
        value_template: '{{ states.sensor.json_time.attributes["milliseconds_since_epoch"] }}'
```
{% endraw %}

이 샘플은 [OpenWeatherMap](https://openweathermap.org/)에서 날씨 보고서를 가져 와서 결과 데이터를 RESTful 센서의 속성에 맵핑 한 후 속성을 모니터링하는 [template](/integrations/template) 센서 세트를 작성하고 해당 값을 사용 가능한 형식으로 나타냅니다. 

{% raw %}
```yaml
sensor:
  - platform: rest
    name: OWM_report
    json_attributes:
      - main
      - weather
    value_template: '{{ value_json["weather"][0]["description"].title() }}'
    resource: https://api.openweathermap.org/data/2.5/weather?zip=80302,us&APPID=VERYSECRETAPIKEY
  - platform: template
    sensors:
      owm_weather:
        value_template: '{{ state_attr('sensor.owm_report', 'weather')[0]["description"].title() }}'
        entity_picture_template: '{{ "https://openweathermap.org/img/w/"+state_attr('sensor.owm_report', 'weather')[0]["icon"].lower()+".png" }}'
        entity_id: sensor.owm_report
      owm_temp:
        friendly_name: 'Outside temp'
        value_template: '{{ state_attr('sensor.owm_report', 'main')["temp"]-273.15 }}'
        unit_of_measurement: "°C"
        entity_id: sensor.owm_report
      owm_pressure:
        friendly_name: 'Outside pressure'
        value_template: '{{ state_attr('sensor.owm_report', 'main')["pressure"] }}'
        unit_of_measurement: "hP"
        entity_id: sensor.owm_report
      owm_humidity:
        friendly_name: 'Outside humidity'
        value_template: '{{ state_attr('sensor.owm_report', 'main')["humidity"] }}'
        unit_of_measurement: "%"
        entity_id: sensor.owm_report
```
{% endraw %}

이 설정은 `json_attributes`와`template`을 사용하여 사전(dictionary)에서 여러 값을 추출하는 방법을 보여줍니다. REST 서비스의 플러딩(flooding)을 피하고 결과를 한 번만 요청하고 이를 참조하는 여러 템플리트로 분리합니다. (REST 센서에서 특정 상태가 필요하지 않으며 기본 상태는 전체 JSON 값이며 최대 255 길이보다 깁니다. 우리가 정적인 값을 사용하는 이유입니다)

{% raw %}
```json
{
    "bedroom1": {
        "temperature": 15.79,
        "humidity": 55.78,
        "battery": 5.26,
        "timestamp": "2019-02-27T22:21:37Z"
    },
    "bedroom2": {
        "temperature": 18.99,
        "humidity": 49.81,
        "battery": 5.08,
        "timestamp": "2019-02-27T22:23:44Z"
    },
    "bedroom3": {
        "temperature": 18.58,
        "humidity": 47.95,
        "battery": 5.15,
        "timestamp": "2019-02-27T22:21:22Z"
    }
}
```
{% endraw %}

{% raw %}
```yaml
sensor:
  - platform: rest
    name: room_sensors
    resource: http://<address_to_rest_service>
    json_attributes:
      - bedroom1
      - bedroom2
      - bedroom3
    value_template: 'OK'
  - platform: template
    sensors:
      bedroom1_temperature:
        value_template: '{{ states.sensor.room_sensors.attributes["bedroom1"]["temperature"] }}'
        device_class: temperature
        unit_of_measurement: '°C'
      bedroom1_humidity:
        value_template: '{{ states.sensor.room_sensors.attributes["bedroom1"]["humidity"] }}'
        device_class: humidity
        unit_of_measurement: '%'
      bedroom1_battery:
        value_template: '{{ states.sensor.room_sensors.attributes["bedroom1"]["battery"] }}'
        device_class: battery
        unit_of_measurement: 'V'
      bedroom2_temperature:
        value_template: '{{ states.sensor.room_sensors.attributes["bedroom2"]["temperature"] }}'
        device_class: temperature
        unit_of_measurement: '°C'
```
{% endraw %}
