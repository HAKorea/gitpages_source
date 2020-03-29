---
title: 3D프린터 관리(OctoPrint)
description: Instructions on how to setup the OctoPrint in Home Assistant.
logo: octoprint.png
ha_category:
  - Hub
  - Binary Sensor
  - Sensor
ha_release: 0.19
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/LCFdcDvUjcg?list=PLWlpiQXaMerTyzl_Pe1PEloZTj9MoU5cl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[OctoPrint](https://octoprint.org/)는 3D 프린터를 위한 웹인터페이스입니다. 이는 OctoPrint 센서를 연동하기위한 주요 통합구성요소입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)

<div class='note'>
센서와 이진 센서를 사용하려면 <a href="#configuration">OctoPrint 구성 요소</a>가 아래에 설정되어 있어야합니다. 해당 구성 요소를 설정하면 센서와 이진 센서가 자동으로 나타납니다.
</div>

## 설정

OctoPrint API를 시작하려면 [site](https://docs.octoprint.org/en/master/api/general.html)의 지시 사항을 따르십시오. OctoPrint가 설정되면 API 키와 호스트를 `configuration.yaml`에 추가해야합니다.

```yaml
octoprint:
  host: YOUR_OCTOPRINT_HOST
  api_key: YOUR_API_KEY
```

{% configuration %}
host:
  description: IP address or hostname of Octoprint host.
  required: true
  type: string
api_key:
  description: The retrieved API key.
  required: true
  type: string
name:
  description: The name for this printer, must be unique if multiple printers are defined.
  required: false
  type: string
  default: OctoPrint
port:
  description: The port of the Octoprint server.
  required: false
  type: integer
  default: 80
path:
  description: The URL path of the Octoprint instance.
  required: false
  type: string
  default: /
ssl:
  description: Enable or disable SSL/TLS.
  required: false
  type: boolean
  default: false
bed:
  description: If the printer has a heated bed.
  required: false
  type: boolean
  default: false
number_of_tools:
  description: Number of temperature adjustable tools, e.g., nozzle.
  required: false
  type: integer
  default: 0
sensors:
  description: Configuration for the sensors.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: The sensors to activate.
      type: list
      default: all (`Current State`, `Temperatures`, `Job Percentage`, `Time Elapsed`, `Time Remaining`)
      keys:
        "Current State":
          description: Text of current state.
        "Temperatures":
          description: Temperatures of all available tools, e.g., `print`, `head`, `print bed`, etc. These will be displayed as `tool0`, `tool1`, or `toolN` please refer to your OctoPrint frontend to associate the tool number with an actual device.
        "Job Percentage":
          description: Percentage of the job.
        "Time Elapsed":
          description: Time elapsed on current print job, in seconds.
        "Time Remaining":
          description: Time remaining on current print job, in seconds.
binary_sensors:
  description: Configuration for the binary sensors.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: The sensors to activate.
      type: list
      default: all (`Printing`, `Printing Error`)
      keys:
        "Printing":
          description: State of the printer.
        "Printing Error":
          description: Error while printing.
{% endconfiguration %}

<div class='note'>

온도를 추적하는 경우 octoprint 설정에서 `bed` 및/또는 `number_of_tools`를 설정하는 것이 좋습니다. 홈어시스턴트 시작중에 프린터가 오프라인인 경우 octoprint 센서를 로드할 수 있습니다.

</div>

여러 프린터를 사용한 예 :

```yaml
octoprint:
  - host: YOUR_OCTOPRINT_HOST
    api_key: YOUR_API_KEY
    name: PRINTER_NAME_1
    number_of_tools: 2
    sensors:
      monitored_conditions:
        - 'Current State'
        - 'Job Percentage'
  - host: YOUR_OCTOPRINT_HOST
    api_key: YOUR_API_KEY
    name: PRINTER_NAME_2
    number_of_tools: 1
```

OctoPrint 호스트에 웹카메라가 장착되어 있으면 이를 추가할 수도 있습니다.

```yaml
camera:
  - platform: mjpeg
    name: OctoPrint
    still_image_url: http://YOUR_OCTOPRINT_HOST_IP/webcam/?action=snapshot
    mjpeg_url: http://YOUR_OCTOPRINT_HOST_IP/webcam/?action=stream
```

## Binary Sensor

`octoprint` 이진 센서 플랫폼을 사용하면 3D 프린터가 인쇄중인지 또는 인쇄오류가 있는지 모니터링 할 수 있습니다.

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
binary_sensor:
  - platform: octoprint
    monitored_conditions:
      - Printing
      - Printing Error
```

{% configuration %}
monitored_conditions:
  description: States to monitor.
  required: true
  type: list
  keys:
    printing:
      description: State of the printer.
    printing error:
      description: Error while printing.
name:
  description: The name of the sensor.
  required: false
  type: string
  default: OctoPrint
{% endconfiguration %}

## Sensor

`octoprint` 센서 플랫폼을 사용하면 3D 프린터의 다양한 상태와 인쇄 작업을 모니터링할 수 있습니다.