---
title: 전력선스마트홈플랫폼(myStrom)
description: Instructions on how to integrate myStrom WiFi Bulbs into Home Assistant.
logo: mystrom.png
ha_category:
  - Light
  - Binary Sensor
  - Switch
ha_release: 0.43
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/M-Wr8bX12WM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`mystrom` 라이트 플랫폼을 사용하면 [myStrom](https://mystrom.ch/en/) WiFi 전구를 제어 할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Light](#light)
- [Binary Sensor](#binary-sensor)
  - [Setup of myStrom Buttons](#setup-of-mystrom-buttons)
- [Switch](#switch)
  - [Setup](#setup)
  - [Get the current power consumption](#get-the-current-power-consumption)

## Light

설치시 myStrom WiFi Bulb를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: mystrom
    host: IP_ADDRESS
    mac: MAC_ADDRESS
```

{% configuration %}
host:
  description: "The IP address of your myStrom WiFi Bulb, e.g., `192.168.1.32`."
  required: true
  type: string
mac:
  description: "The MAC address of your myStrom WiFi Bulb, e.g., `5AAC8CA542F3`."
  required: true
  type: string
name:
  description: The name to use when displaying this bulb.
  required: false
  type: string
  default: myStrom Bulb
{% endconfiguration %}

`IP_ADRRESS`에 있는 조명에 액세스 할 수 있는지 확인하십시오. 조명에 대한 세부 사항은 JSON 응답으로 제공됩니다.

```bash
$ curl http://[IP_ADDRESS]/api/v1/device/[MAC_ADDRESS]

{
  "MAC_ADDRESS": {
    "type": "rgblamp",
    "battery": false,
    "reachable": true,
    "meshroot": false,
    "on": true,
    "color": "0;0;100",
    "mode": "hsv",
    "ramp": 409,
    "power": 5.1,
    "fw_version": "2.25"
  }
}
```

## Binary Sensor

`mystrom` 바이너리 센서 플랫폼을 사용하면 [myStrom Wifi Buttons](https://mystrom.ch/wifi-button/)을 홈어시스턴트와 함께 사용할 수 있습니다. myStrom Wifi 버튼은 세개의 버튼을 지원하고, myStrom WiFi 버튼까지 포함하여 네 가지 푸시 패턴을 지원합니다.

- `single`: Short push (approx. 1/2 seconds)
- `double`: 2x sequential short pushes (within 2 seconds)
- `long`: Long push (approx. 2 seconds)
- `touch`: Touch of the button's surface (only affective for WiFi Button +)

패턴을 처음 사용하면 패턴에 대한 이진 센서가 생성됩니다. WiFi 버튼을 한 번 누르면 `single` 패턴에 대한 이진 센서가 생성됩니다. 다른 패턴에도 동일하게 적용됩니다. 패턴을 두 번째로 사용하면 이진 센서가 완전히 작동합니다.

버튼은 내장 LED에 대한 피드백을 제공합니다. : 

- white then green: 패턴이 성공적으로 제출되었습니다
- white then red: 통신에 문제가 있습니다

설치시 myStrom WiFi 버튼을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: mystrom
```

<div class='note'>
펌웨어 버전 2.56은 TLS/SSL을 지원하지 않습니다. 즉, 홈 어시스턴트와 클라이언트/엔터티 간에 일반 텍스트 통신을 사용하는 경우에만 WiFi 버튼을 사용할 수 있습니다.
</div>

### myStrom 버튼 설정

Home Assistant에서 작동하도록 모든 버튼을 설정해야합니다. 먼저 Wi-Fi 버튼을 무선 네트워크에 연결하십시오. 버튼이 연결되면 버튼이 충전되지 않은 경우 3 분 동안 푸시 패턴의 동작을 설정할 수 있습니다. 가장 빠른 방법은 `curl`을 사용하는 것입니다. 구현에 대한 자세한 내용은 WiFi 버튼의 [documentation](https://mystrom.ch/wp-content/uploads/REST_API_WBP.txt)을 확인하십시오 (`http://`는 `get://` 또는 `post://`로 대체됨). `action`은 해당 푸시 패턴의 이름입니다 (위 참조).

데이터를받는 엔드 포인트는 `http://[IP address Home Assistant]:8123/api/mystrom`입니다. [`api_password`](/integrations/http/)를 설정한 경우 URL에 포함해야합니다.

`api_password:`를 사용할 경우 : 

```bash
$ curl -d "[action]=get://[IP address Home Assistant]:8123/api/mystrom?api_password%3D[api_password]%26[action]%3D[ID of the button]" \
    http://[IP address of the button]/api/v1/device/[MAC address of the button]
```

`api_password`를 사용 안할 경우:

```bash
$ curl -d "[action]=get://[IP address Home Assistant]:8123/api/mystrom?[action]%3D[ID of the button]" \
    http://[IP address of the button]/api/v1/device/[MAC address of the button]
{
  "[MAC address of the button]": {
    "type": "button",
    "battery": true,
    "reachable": true,
    "meshroot": false,
    "charge": true,
    "voltage": 4.292,
    "fw_version": "2.56",
    "single": "get://[IP address Home Assistant]:8123/api/mystrom?single=[id of the button]",
    "double": "",
    "long": "",
    "touch": ""
  }
}
```

두 번 클릭으로 URL을 설정하는 전체 명령은 다음 예와 같습니다. : 

```bash
$ curl -d "double=get://192.168.1.3:8123/api/mystrom?double%3DButton1" http://192.168.1.12/api/v1/device/4D5F5D5CD553
```

`api_password` 사용할 경우 :

```bash
curl -d "double=get://192.168.1.3:8123/api/mystrom?api_password%3Dapi_password%26double%3DButton1" http://192.168.1.12/api/v1/device/4D5F5D5CD553
```

command-line tool [`mystrom`](https://github.com/fabaff/python-mystrom)은 myStrom 버튼을 설정하는 도우미입니다.

[`login_attempts_threshold`](/integrations/http/)를 설정하고 액션에 대해 `api_password`를 포함시키지 않고 액션이 트리거 된 경우 임계값에 도달 한 후에는 버튼동작인 차단되어 더 이상 작동하지 않습니다. 차단을 되돌리는 방법에 대해서는 [IP filtering and banning](/integrations/http/#ip-filtering-and-banning)을 참조하십시오.

## Switch

`mystrom` 스위치 플랫폼을 사용하면 [myStrom](https://mystrom.ch/en/) 스위치의 상태를 제어할 수 있습니다. 내장 센서가 스위치가 켜져있는 동안 전력 소비를 측정하고 있습니다.

### 셋업

스위치의 웹 프런트 엔드에서 **Advanced**에서 REST API를 사용하도록 설정했는지 확인하십시오.

<p class='img'>
  <img src='{{site_root}}/images/integrations/mystrom/switch-advanced.png' />
</p>

설치시 myStrom 스위치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: mystrom
    host: IP_ADRRESS
```

{% configuration %}
host:
  description: "The IP address of your myStrom switch, e.g., `http://192.168.1.32`."
  required: true
  type: string
name:
  description: The name to use when displaying this switch.
  required: false
  type: string
  default: myStrom Switch
{% endconfiguration %}

Check if you are able to access the device located at `http://IP_ADRRESS`. The details about your switch is provided as a JSON response.
`http://IP_ADRRESS`에있는 장치에 액세스 할 수 있는지 확인하십시오. 스위치에 대한 세부 사항은 JSON 응답으로 제공됩니다.

```bash
$ curl -X GET -H "Content-Type: application/json" http://IP_ADDRESS/report
{
  "power": 0,
  "relay": false
}
```

또는 상태를 변경하십시오. : 

```bash
curl -G -X GET http://IP_ADDRESS/relay -d 'state=1'
```

### 현재 전력 소비량 확인하기

스위치가 현재 전력 소비를 측정하고 있습니다. 이를 센서로 노출 시키려면 [`template` sensor](/integrations/template)를 사용하십시오.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: template
    sensors:
      power:
        friendly_name: "Current Power"
        unit_of_measurement: "W"
        value_template: "{{ state_attr('switch.office', 'current_power_w') }}"
```
{% endraw %}
