---
title: aREST
description: Instructions on how to integrate aREST within Home Assistant.
logo: arest.png
ha_category:
  - DIY
  - Binary Sensor
  - Sensor
  - Switch
ha_iot_class: Local Polling
ha_release: 0.9
ha_codeowners:
  - '@fabaff'
---

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다 :

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)
- [Switch](#switch)

## Binary Sensor

`arest` 바이너리 센서 플랫폼을 사용하면 [aREST] (https://arest.io/) RESTful 프레임 워크를 실행하는 장치
(이더넷 / Wi-Fi 연결이있는 Arduinos, ESP8266 및 Raspberry Pi와 같은)에서 모든 데이터를 가져올 수 있습니다.

설치시 aREST 이진 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오. 

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: arest
    resource: http://IP_ADDRESS
    pin: 8
```

{% configuration %}
resource:
  description: aREST API를 노출하는 장치의 IP 주소 및 스키마 (예를들면 `http://192.168.1.10`) 
  required: true
  type: string
pin:
  description: 모니터링 할 핀 번호.
  required: true
  type: integer
name:
  description: 장치 이름을 덮어 씁니다. 기본적으로 장치의 *이름* 이 사용됨.
  required: false
  type: string
{% endconfiguration %}

URL `http://IP_ADDRESS/digital/PIN_NUMBER`에 액세스하면 JSON 응답 내부의 핀 상태를 `return_value`로 제공해야 합니다.

```bash
$ curl -X GET http://192.168.0.5/digital/9
{"return_value": 0, "id": "office1", "name": "Office", "connected": true}
```

위 명령에서 전달한 핀 9의 예는 다음과 같습니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: arest
    resource: http://192.168.0.5/digital/9
    pin: 9
    name: Office
```

<div class='note'>
이 센서는 두 번의 업데이트주기 사이에 변경이 발생할 가능성이 높기 때문에 빠른 상태 변경에는 적합하지 않습니다.
</div>

## Sensor

`arest` 센서 플랫폼을 사용하면 [aREST](https://arest.io/) RESTful 프레임 워크를 실행하는 장치 (이더넷 / Wi-Fi 연결이있는 Arduino, ESP8266 및 Raspberry Pi 등)에서 모든 데이터를 가져올 수 있습니다.

설치시 aREST 지원 장치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: arest
    resource: https://IP_ADDRESS
    monitored_variables:
      temperature:
        name: temperature
    pins:
      A0:
        name: Pin 0 analog
```

{% configuration %}
resource:
  description: "aREST API를 노출하는 장치의 IP 주소 및 스키마 (예를들어 `https : // 192.168.1.10`)"
  required: true
  type: string
name:
  description: 장치 이름을 덮어 씁니다.
  required: false
  default: aREST sensor
  type: string
pins:
  description: 모니터링 할 핀 목록. 아날로그 핀 은 핀 번호에 선행 **A** 가 필요합니다. 
  required: false
  type: list
  keys:
    pin:
      description: 사용할 핀 번호.
      required: true
      type: list
      keys:
        name:
          description: 모니터링하려는 변수의 이름.
          required: true
          type: string
        unit_of_measurement:
          description: 센서의 측정 단위를 정의 (있는 경우).
          required: false
          type: string
        value_template:
          description: 페이로드에서 값을 추출하기 위해 [template](/docs/configuration/templating/#processing-incoming-data)을 정의.
          required: false
          type: template
monitored_variables:
  description: 노출 된 변수 목록.
  required: false
  type: list
  keys:
    variable:
      description: 모니터 할 변수의 이름.
      required: true
      type: list
      keys:
        name:
          description: 프런트 엔드에 사용할 이름.
          required: false
          type: string
        unit_of_measurement:
          description: 센서의 측정 단위를 정의 (있는 경우).
          required: false
          type: string
        value_template:
          description: 페이로드에서 값을 추출하기 위해 [template](/docs/configuration/templating/#processing-incoming-data)을 정의
          required: false
          type: template
{% endconfiguration %}

`monitored_variables` 배열의 변수는 장치의 응답으로 사용 가능해야 합니다. 이더넷 기능이있는 Arduino에 대한 스케치 (예 : [Ethernet](https://raw.githubusercontent.com/marcoschwartz/aREST/master/examples/Ethernet/Ethernet.ino)) 중 하나를 사용할 수 있습니다. 이 스케치에서는 endpoint 역할을 하는 두 가지 변수 (`온도` 및 `습도`)를 사용할 수 있습니다.

엔드 포인트 중 하나에 액세스하면 (예를 들면 `http://192.168.1.10/temperature`) JSON 응답 내부의 값을 제공합니다.

```json
{"temperature": 23, "id": "sensor01", "name": "livingroom", "connected": true}
```

루트는 모든 변수 및 현재 값과 일부 장치 세부 정보가 포함 된 JSON 응답을 제공합니다.

```json
{
   "variables" : {
      "temperature" : 23,
      "humidity" : 82
   },
   "id" : "sensor01",
   "name" : "livingroom",
   "connected" : true
}
```

`return_value`는 주어진 핀에 대한 JSON 응답의 센서 데이터를 포함합니다. (예: `http://192.168.1.10/analog/2/` 혹은  `http://192.168.1.10/digital/7/`).

```json
{"return_value": 34, "id": "sensor02", "name": "livingroom", "connected": true}
```

## 스위치 (Switch)

`arest` 스위치 플랫폼을 사용하면 [aREST](https://arest.io/) RESTful 프레임 워크를 실행하는 장치(이더넷 / Wi-Fi 연결이있는 Arduino 보드, ESP8266 기반 장치 및 Raspberry Pi와 같은)에서 핀을 토글 할 수 있습니다.

설치시 핀이있는 aREST 지원 장치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오. :

```yaml
# Example configuration.yaml entry
switch:
  - platform: arest
    resource: http://IP_ADDRESS
    pins:
      11:
        name: Fan
      13:
        name: Switch
        invert: true
```

커스텀 함수를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: arest
    resource: http://IP_ADDRESS
    name: Office
    functions:
      function1:
        name: Light Desk
```

{% configuration %}
resource:
  description: aREST API를 노출하는 장치의 IP 주소 및 스키마 (예를들어 `http://192.168.1.10` 슬래시 없음) 
  required: true
  type: string
name:
  description: 장치 이름을 덮어 씀. 기본적으로 장치의 *name*이 사용됨.
  required: false
  type: string
pins:
  description: 사용 된 핀이 모두있는 배열.
  required: false
  type: map
  keys:
    name:
      description: 프론트 엔드에서 사용할 핀의 이름.
      required: true
      type: string
    invert:
      description: 온/오프 로직이 반전되어야하는 경우.
      required: false
      type: boolean
      default: false
functions:
  description: 사용 된 모든 함수가있는 배열.
  required: false
  type: map
  keys:
    name:
      description: 프론트 엔드에서 사용할 이름.
      required: true
      type: string
{% endconfiguration %}

웹 브라우저 또는 명령 행 도구를 사용하여 핀을 계속 전환 할 수 있습니다. URL `http://192.168.1.10/digital/8/1`을 사용하여 핀 8을 high/on으로 설정하면 JSON 응답이 피드백을 제공합니다.

```json
{"message": "Pin D8 set to 1", "id": "sensor02", "name": "livingroom", "connected": true}
```
