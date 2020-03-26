---
title: TCP 직접 연결
description: Instructions on how to set up TCP within Home Assistant.
logo: tcp_ip.png
ha_category:
  - Binary Sensor
  - Sensor
ha_release: 0.14
ha_iot_class: Local Polling
---

TCP 통합구성요소를 통해 특정 Home Assistant 연동이 존재하지 않는 일부 서비스를 연동시킬 수 있습니다. 서비스가 간단한 요청/응답 메커니즘을 사용하여 TCP 소켓을 통해 통신하는 경우 이 통합구성요소로 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)

## Sensor

TCP 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: tcp
    host: IP_ADDRESS
    port: PORT
    payload: PAYLOAD
```

{% configuration %}
name:
  description: The name you'd like to give the sensor in Home Assistant.
  required: false
  type: string
host:
  description: The hostname/IP address to connect to.
  required: true
  type: string
port:
  description: The port to connect to the host on.
  required: true
  type: integer
payload:
  description: What to send to the host in order to get the response we're interested in.
  required: true
  type: string
timeout:
  description: How long in seconds to wait for a response from the service before giving up and disconnecting.
  required: false
  default: 10
  type: integer
value_template:
  description: Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the value. By default it's assumed that the entire response is the value.
  required: false
  type: template
unit_of_measurement:
  description: The unit of measurement to use for the value.
  required: false
  type: string
buffer_size:
  description: The size of the receive buffer in bytes. Set this to a larger value if you expect to receive a response larger than the default.
  required: false
  default: "`1024`"
  type: integer
{% endconfiguration %}

### 사례

본 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

#### EBUSd

[EBUSd](https://github.com/john30/ebusd/wiki) 서비스를 통해 일부 가정집의 난방/냉각 시스템의 EBUS 직렬 버스에 연결할 수 있습니다. 이 서비스를 사용하면 홈어시스턴트에 유용한 다양한 메트릭(Metrics)을 추출할 수 있습니다. EBUSd를 사용하려면 TCP 소켓을 사용하여 EBUSd에 연결하고 명령을 보내십시오. 서비스는 EBUS로부터 받은 값으로 응답합니다. Commnad line에서 다음과 같이 보일 것입니다.

```bash
$ echo "r WaterPressure" | nc 10.0.0.127 8888
0.903;ok
```

서비스의 출력은 단일값이 아닙니다(";ok"도 포함합니다). 우리가 관심있는 값을 얻기 위해 Jinja2 템플릿을 사용할 수 있습니다. 수신된 응답은 템플릿에 `value` 변수로 주입됩니다. Home Assistant 내에서 이 값을 사용하려면 다음 설정을 사용하십시오.

```yaml
sensor:
# Example configuration.yaml entry
  - platform: tcp
    name: Central Heating Pressure
    host: 10.0.0.127
    port: 8888
    timeout: 5
    payload: "r WaterPressure\n"
    value_template: "{% raw %}{{ value.split(';')[0] }}{% endraw %}"
    unit_of_measurement: Bar
```

#### hddtemp

`hddtemp` 툴은 하드 디스크의 온도를 수집합니다.

```bash
$ hddtemp
/dev/sda: SAMSUNG MZMTE256HMHP-000L1: 39°C
```

`hddtemp -d`를 사용하면 포트 7634에서 TCP/IP 데몬 모드로 도구를 실행하여 네트워크를 통해 데이터를 가져올 수 있습니다.

```bash
$ telnet localhost 7634
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
|/dev/sda|SAMSUNG MZMTE256HMHP-000L1|38|C|Connection closed by foreign host.
```

`hddtemp` 센서의 `configuration.yaml` 파일에 대한 항목은 아래 예와 유사합니다.

```yaml
sensor:
# Example configuration.yaml entry
  - platform: tcp
    name: HDD temperature
    host: 127.0.0.1
    port: 7634
    timeout: 5
    payload: "\n"
    value_template: "{% raw %}{{ value.split('|')[3] }}{% endraw %}"
    unit_of_measurement: "°C"
```

## Binary Sensor

TCP 바이너리 센서는 "off" 또는 "on"인 [TCP Sensor](#sensor) 유형입니다. 이 센서 유형을 사용하려면 TCP 센서 설정 외에도 장치를 켤 때 리턴되는 값을 표시하는 `value_on` 값을 제공해야합니다.

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: tcp
    host: IP_ADDRESS
    port: PORT
    payload: PAYLOAD
    value_on: 1
```

{% configuration %}
name:
  description: The name you'd like to give the sensor in Home Assistant.
  required: false
  type: string
  default: TCP Sensor
host:
  description: The hostname/IP address to connect to.
  required: true
  type: string
port:
  description: The port to connect to the host on.
  required: true
  type: integer
payload:
  description: What to send to the host in order to get the response we're interested in.
  required: true
  type: string
value_on:
  description: The value returned when the device is "on".
  required: true
  type: string
value_template:
  description: Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract the value.
  required: false
  type: template
  default: entire response is the value
buffer_size:
  description: The size of the receive buffer in bytes. Set this to a larger value if you expect to receive a response larger than the default.
  required: false
  type: integer
  default: 1024
timeout:
  description: How long in seconds to wait for a response from the service before giving up and disconnecting.
  required: false
  type: integer
  default: 10
{% endconfiguration %}
