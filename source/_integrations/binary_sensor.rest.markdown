---
title: "RESTful Binary Sensor"
description: "Instructions on how to integrate REST binary sensors into Home Assistant."
logo: restful.png
ha_category:
  - Binary Sensor
ha_release: "0.10"
ha_iot_class: Local Polling
---

`rest` 바이너리 센서 플랫폼은 장치, 애플리케이션 또는 웹 서비스의 [RESTful API](https://en.wikipedia.org/wiki/Representational_state_transfer)에 의해 노출되는 주어진 엔드 포인트를 연관하고 있습니다.
이진 센서는 GET 및 POST requests를 지원합니다.

JSON 메시지는 `1`,` "1"`, `TRUE`, `true`, `on` 혹은 `open`과 같은 다른 값을 포함 할 수 있습니다. 값이 중첩된 경우 [template](/docs/configuration/templating/#processing-incoming-data)을 사용하십시오.

```json
{
    "name": "Binary sensor",
    "state": {
        "open": "true",
        "timestamp": "2016-06-20 15:42:52.926733"
    }
}
```

## 설정

이 센서를 활성화하려면 GET requests을 위해 `configuration.yaml` 파일에 다음 라인을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: rest
    resource: http://IP_ADDRESS/ENDPOINT
```

POST request 의 경우:

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: rest
    resource: http://IP_ADDRESS/ENDPOINT
    method: POST
```

{% configuration %}
resource:
  description: The resource or endpoint that contains the value.
  required: true
  type: string
  default: string
method:
  description: The method of the request.
  required: false
  type: string
  default: GET
name:
  description: Name of the REST binary sensor.
  required: false
  type: string
  default: REST Binary Sensor
device_class:
  description: Sets the [class of the device](/integrations/binary_sensor/), changing the device state and icon that is displayed on the frontend.
  required: false
  type: string
value_template:
  description: >
    Defines a [template](/docs/configuration/templating/#processing-incoming-data)
    to extract the value.
  required: false
  type: template
payload:
  description: The payload to send with a POST request. Usually formed as a dictionary.
  required: false
  type: string
verify_ssl:
  description: Verify the certification of the endpoint.
  required: false
  type: boolean
  default: true
timeout:
  description: Defines max time to wait data from the endpoint.
  required: false
  type: integer
  default: 10
authentication:
  description: "Type of the HTTP authentication. `basic` or `digest`."
  required: false
  type: string
username:
  description: The username for accessing the REST endpoint.
  required: false
  type: string
password:
  description: The password for accessing the REST endpoint.
  required: false
  type: string
headers:
  description: The headers for the requests.
  required: false
  type: [list, string]
{% endconfiguration %}

<div class='note warning'>
URL이 엔드 포인트 또는 리소스와 정확히 일치하는지 확인하십시오.
</div>

## 사례

이 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### aREST sensor

[aREST](/integrations/arest#binary-sensor) 이진 센서를 사용하는 대신 REST 이진 센서로 직접 aREST를 지원하는 장치의 값을 검색 할 수 있습니다.

```yaml
binary_sensor:
  - platform: rest
    resource: http://192.168.0.5/digital/9
    method: GET
    name: Light
    device_class: light
    value_template: {% raw %}'{{ value_json.return_value }}'{% endraw %}
```

### HTTP 인증으로 보호된 엔드 포인트에 액세스

REST 센서는 HTTP 인증 및 사용자 정의된 헤더를 지원합니다.

```yaml
binary_sensor:
  - platform: rest
    resource: http://IP_ADDRESS:5000/binary_sensor
    username: ha1
    password: test1
    authentication: basic
    headers:
      User-Agent: Home Assistant
      Content-Type: application/json
```

헤더에는 모든 관련 세부 사항이 포함됩니다. 또한 토큰으로 보호되는 엔드 포인트에 액세스 할 수 있습니다.

```bash
Content-Length: 1024
Host: IP_ADDRESS1:5000
Authorization: Basic aGExOnRlc3Qx
Accept-Encoding: identity
Content-Type: application/json
User-Agent: Home Assistant
```
