---
title: 시리얼(serial)
description: Instructions on how to integrate data from serial connected sensors into Home Assistant.
logo: home-assistant.png
ha_category:
  - Sensor
ha_release: 0.56
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

`serial` 센서 플랫폼은 Home Assistant가 실행중인 시스템의 직렬 포트에 연결된 장치가 제공한 데이터를 사용합니다. 
[`ser2net`](http://ser2net.sourceforge.net/) 및 [`socat`](http://www.dest-unreach.org/socat/)을 사용하면 원격 시스템에 연결된 센서에서도 작동합니다.

직렬 포트에 어떤 종류의 데이터가 도착하는지 확인하려면 Linux에서 `minicom` 또는 `picocom`과 같은 명령 줄 도구를 사용하십시오. macOS에서는 `screen` 또는 Windows `putty`를 사용할 수 있습니다.

```bash
sudo minicom -D /dev/ttyACM0
```

## 설정

시리얼 센서를 설치하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: serial
    serial_port: /dev/ttyACM0
```

{% configuration %}
serial_port:
  description: Local serial port where the sensor is connected and access is granted.
  required: true
  type: string
name:
  description: Friendly name to use for the frontend. Default to "Serial sensor".
  required: false
  type: string
baudrate:
  description: Baudrate of the serial port.
  required: false
  default: 9600 Bps
  type: integer
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to extract a value from the serial line."
  required: false
  type: template
{% endconfiguration %}

## 템플릿 센서를 위한 `value_template`

### TMP36

{% raw %}
```yaml
"{{ (((states('sensor.serial_sensor') | float * 5 / 1024 ) - 0.5) * 100) | round(1) }}"
```
{% endraw %}

## 사례

### Arduino

Arduino 제품군 컨트롤러의 경우 온도와 습도를 읽을 수 있는 스케치는 아래 샘플과 같습니다. 반환된 데이터는 JSON 형식이며 [template](/docs/configuration/templating/#processing-incoming-data)을 사용하여 개별 센서 값으로 분할할 수 있습니다.

```c
#include <ArduinoJson.h>

void setup() {
  Serial.begin(115200);
}

void loop() {
  StaticJsonDocument<100> jsonBuffer;

  jsonBuffer["temperature"] = analogRead(A0);
  jsonBuffer["humidity"] = analogRead(A1);

  serializeJson(jsonBuffer, Serial);
  Serial.println();
  
  delay(1000);
}
```

### 여러 센서를 텍스트 문자열로 반환하는 장치


구분기호(delimiter)를 사용하여 여러 센서를 연결된 값 문자열로 반환하는 장치의 경우 (즉, 반환된 문자열이 JSON 형식이 아님) 모두 동일한 직렬 응답을 사용하여 여러 템플릿 센서를 만들 수 있습니다. 예를 들어 [Sparkfun USB Weather Board](https://www.sparkfun.com/products/retired/9800)의 스트림에는 반환된 텍스트 문자열 내에 온도, 습도, 기압이 포함됩니다. 샘플 반환 데이터 :


```c
$,24.1,50,12.9,1029.83,0.0,0.00,*
$,24.3,51,12.8,1029.76,0.0,0.00,*
```

이를 개별 센서로 구문 분석하려면 쉼표 구분기호(delimiter)를 사용하여 분할한 다음 관심있는 각 항목에 대한 템플리트 센서를 작성하십시오.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: serial
    serial_port: /dev/ttyUSB0
    baudrate: 9600

  - platform: template
    sensors:
      my_temperature_sensor:
        friendly_name: Temperature
        unit_of_measurement: "°C"
        value_template: "{{ states('sensor.serial_sensor').split(',')[1] | float }}"
      my_humidity_sensor:
        friendly_name: Humidity
        unit_of_measurement: "%"
        value_template: "{{ states('sensor.serial_sensor').split(',')[2] | float }}"
      my_barometer:
        friendly_name: Barometer
        unit_of_measurement: "mbar"
        value_template: "{{ states('sensor.serial_sensor').split(',')[4] | float }}"
```
{% endraw %}

### Digispark USB Development Board

이 [blog post](/blog/2017/10/23/simple-analog-sensor/)은 Digispark USB 개발 보드를 사용한 설정에 대해 설명합니다.