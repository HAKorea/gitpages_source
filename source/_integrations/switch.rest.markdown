---
title: "RESTful 스위치"
description: "Instructions on how to integrate REST switches into Home Assistant."
logo: restful.png
ha_category:
  - Switch
ha_release: 0.7.6
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/E99-17XyyUg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`rest` 스위치 플랫폼을 사용하면 [RESTful API](https://en.wikipedia.org/wiki/Representational_state_transfer)를 지원하는 지정된 엔드 포인트를 제어할 수 있습니다. 스위치는 GET을 통해 상태를 얻고 주어진 REST 리소스에서 POST를 통해 상태를 설정할 수 있습니다.

## 설정

이 스위치를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: rest
    resource: http://IP_ADDRESS/ENDPOINT
```

{% configuration %}
resource:
  description: The resource or endpoint that contains the value.
  required: true
  type: string
method:
  description: "The method of the request. Supported `post` or `put`."
  required: false
  type: string
  default: post
name:
  description: Name of the REST Switch.
  required: false
  type: string
  default: REST Switch
timeout:
  description: Timeout for the request.
  required: false
  type: integer
  default: 10
body_on:
  description: "The body of the POST request that commands the switch to become enabled. This value can be a [template](/topics/templating/)."
  required: false
  type: string
  default: ON
body_off:
  description: "The body of the POST request that commands the switch to become disabled. This value can also be a [template](/topics/templating/)."
  required: false
  type: string
  default: OFF
is_on_template:
  description: "A [template](/docs/configuration/templating/#processing-incoming-data) that determines the state of the switch from the value returned by the GET request on the resource URL. This template should compute to a boolean (True or False). If the value is valid JSON, it will be available in the template as the variable `value_json`. Default is equivalent to `'{% raw %}{{ value_json == body_on }}{% endraw %}'`. This means that by default, the state of the switch is on if and only if the response to the GET request matches."
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
  description: The headers for the request.
  required: false
  type: [string, list]
verify_ssl:
  description: Verify the SSL certificate of the endpoint.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

<div class='note warning'>
Make sure that the URL matches exactly your endpoint or resource.
URL이 엔드 포인트 또는 리소스와 정확히 일치하는지 확인하십시오.
</div>

## 사례

### 템플릿 값을 응용한 Switch

이 예는 [template](/topics/templating/)을 사용하여 Home Assistant가 상태를 확인할 수있는 스위치를 보여줍니다. 이 예제에서 REST 엔드 포인트는 스위치가 켜져 있음을 나타내는 `true`로 이 JSON 응답을 리턴합니다.

```json
{"is_active": "true"}
```

{% raw %}
```yaml
switch:
  - platform: rest
    resource: http://IP_ADDRESS/led_endpoint
    body_on: '{"active": "true"}'
    body_off: '{"active": "false"}'
    is_on_template: '{{ value_json.is_active }}'
    headers:
      Content-Type: application/json
    verify_ssl: true
```
{% endraw %}

`body_on` 및 `body_off`도 시스템 상태에 따라 달라질 수 있습니다. 예를 들어, 무선 온도 조절기에서 원격 온도 센서 추적을 사용하려면 원격 온도 센서의 현재 값을 보내야합니다. `{% raw %}'{"rem_temp":{{states('sensor.bedroom_temp')}}}'{% endraw %}` 템플릿을 사용하면됩니다.