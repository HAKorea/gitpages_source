---
title: 컴맨드 라인 센서(Command Line Sensor)
description: "Instructions on how to integrate command line sensors into Home Assistant."
logo: command_line.png
ha_category:
  - Utility
ha_release: pre 0.7
ha_iot_class: Local Polling
---


데이터를 얻기 위해 특정 명령을 실행하는 `command_line` 센서 플랫폼. 모든 유형의 센서를 command line에서 데이터를 가져올 수 있는 Home Assistant에 연동할 수 있으므로 가장 강력한 플랫폼이 될 수 있습니다.

## 설정

이를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: command_line
    command: SENSOR_COMMAND
```

{% configuration %}
command:
  description: The action to take to get the value.
  required: true
  type: string
name:
  description: Name of the command sensor.
  required: false
  type: string
unit_of_measurement:
  description: Defines the unit of measurement of the sensor, if any.
  required: false
  type: string
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the payload."
  required: false
  type: string
scan_interval:
  description: Defines number of seconds for polling interval.
  required: false
  type: integer
  default: 60
command_timeout:
  description: Defines number of seconds for command timeout
  required: false
  type: integer
  default: 15
json_attributes:
  description: Defines a list of keys to extract values from a JSON dictionary result and then set as sensor attributes.
  required: false
  type: [string, list]
{% endconfiguration %}

## 사례

본 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 하드 드라이브 온도

하드 드라이브의 온도를 얻는 방법에는 여러 가지가 있습니다. 간단한 해결책은 [hddtemp](https://savannah.nongnu.org/projects/hddtemp/)를 사용하는 것입니다.

```bash
$ hddtemp -n /dev/sda
```

이 정보를 사용하기 위해 `configuration.yaml` 파일의 command-line 센서에 대한 항목은 다음과 같습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: command_line
    name: HD Temperature
    command: "hddtemp -n /dev/sda"
    # If errors occur, make sure configuration file is encoded as UTF-8
    unit_of_measurement: "°C"
```

### CPU 온도

[`proc`](https://en.wikipedia.org/wiki/Procfs) 파일 시스템 덕분에 시스템에 대한 다양한 세부 정보를 검색할 수 있습니다. 여기서 CPU 온도가 중요합니다. `configuration.yaml` 파일과 비슷한 것을 추가하십시오 :

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: command_line
    name: CPU Temperature
    command: "cat /sys/class/thermal/thermal_zone0/temp"
    # If errors occur, make sure configuration file is encoded as UTF-8
    unit_of_measurement: "°C"
    value_template: '{{ value | multiply(0.001) | round(1) }}'
```
{% endraw %}

### 홈어시스턴트에서 실패한 로그인 시도 모니터링

홈어시스턴트에 실패한 로그인 시도 횟수를 알고 싶다면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: command_line
    name: badlogin
    command: "grep -c 'Login attempt' /home/hass/.homeassistant/home-assistant.log"
```

적어도 `warning` 레벨에서 [http component](/integrations/http/)를 모니터하도록 [logger component](/integrations/logger)를 설정하십시오.

```yaml
# Example working logger settings that works
logger:
  default: critical
  logs:
    homeassistant.components.http: warning
```

### 업스트림 홈어시스턴트 릴리스에 대한 세부 사항 

실행중인 Home Assistant의 릴리스를 프론트 엔드 (**개발자 도구** -> **About**)에서 직접 확인할 수 있습니다. Home Assistant 릴리스는 [Python Package Index](https://pypi.python.org/pypi)에서 제공됩니다. 이를 통해 현재 릴리스를 얻을 수 있습니다.

```yaml
sensor:
  - platform: command_line
    command: python3 -c "import requests; print(requests.get('https://pypi.python.org/pypi/homeassistant/json').json()['info']['version'])"
    name: HA release
```

### 원격 텍스트 파일에서 값 읽기 

HTTP를 통해 액세스할 수 있는 텍스트 파일에 값을 저장하는 장치를 소유한 경우 이전 섹션에 표시된 것과 동일한 방법을 사용할 수 있습니다. JSON 응답을 보는 대신 센서값을 직접 가져옵니다.

```yaml
sensor:
  - platform: command_line
    command: python3 -c "import requests; print(requests.get('http://remote-host/sensor_data.txt').text)"
    name: File value
```

### 외부 스크립트 사용 

예는 [aREST sensor](/integrations/arest#sensor)와 동일하지만 외부 Python 스크립트를 사용합니다. RESTful API를 노출하는 장치와의 인터페이스에 대한 아이디어를 제공해야합니다.

값을 검색하는 한 줄짜리 스크립트는 다음과 같습니다. 물론 `configuration.yaml` 파일에서 직접 사용할 수도 있지만 따옴표에 대해서는 특별한 주의가 필요합니다.

```bash
$ python3 -c "import requests; print(requests.get('http://10.0.0.48/analog/2').json()['return_value'])"
```

사용되는 스크립트(`arest-value.py`로 저장)는 아래 예제와 같습니다.

```python
#!/usr/bin/python3
from requests import get

response = get("http://10.0.0.48/analog/2")
print(response.json()["return_value"])
```

스크립트를 사용하려면 `configuration.yaml` 파일에 다음과 같은 것을 추가해야합니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: command_line
    name: Brightness
    command: "python3 /path/to/script/arest-value.py"
```

### `command:` 에서 템플릿의 사용법

[Templates](/docs/configuration/templating/)은 `command:` 설정 변수에서 지원됩니다. 특정 센서의 상태를 외부 스크립트에 대한 인수로 포함하려는 경우 사용할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: command_line
    name: wind direction
    command: 'sh /home/pi/.homeassistant/scripts/wind_direction.sh {{ states('sensor.wind_direction') }}'
    unit_of_measurement: "Direction"
```
{% endraw %}


### command output에서 ​​JSON 속성 사용

이 예는 `value_json` 및 `json_attributes`를 사용하여 하나의 센서(추가가 속성인 경우)로 여러 값을 검색하는 방법을 보여줍니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: command_line
    name: JSON time
    json_attributes:
      - date
      - milliseconds_since_epoch
    command: 'python3 /home/pi/.homeassistant/scripts/datetime.py'
    value_template: '{{ value_json.time }}'
```
{% endraw %}
