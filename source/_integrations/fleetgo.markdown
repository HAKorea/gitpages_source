---
title: 차량관리시스템(FleetGO)
description: Instructions on how to use a FleetGO as a device tracker.
logo: fleetgo.png
ha_category:
  - Car
ha_iot_class: Cloud Polling
ha_release: 0.76
---

<iframe width="690" height="414" src="https://www.youtube.com/embed/MX--wCghpqE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`fleetgo` 장치 추적기 플랫폼을 사용하면 [FleetGO](https://fleetgo.com) 하드웨어가 장착된 차량을 Home Assistant에 연동할 수 있습니다. 이는 당신의 차량에 대한 특정 세부 사항을 보고 지도에 차량까지 보여줍니다.

## 셋업

이 구성 요소를 사용하려면 [info@fleetgo.com](mailto:info@fleetgo.com?subject=API%20Key)에 문의하여 요청할 수 있는 **API key** 및 **API secret**이 필요합니다. .

## 설정

이 장치 추적기를 설치시 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: fleetgo
    client_id: YOUR_CLIENT_ID
    client_secret: YOUR_CLIENT_SECRET
    username: YOUR_FLEETGO_USERNAME
    password: YOUR_FLEETGO_PASSWORD
    include:
        - LICENSE_PLATE
```

{% configuration %}
client_id:
  description: The client ID used to connect to the FleetGO API.
  required: true
  type: string
client_secret:
  description: The client secret used to connect to the FleetGO API.
  required: true
  type: string
username:
  description: Your FleetGO username.
  required: true
  type: string
password:
  description: Your FleetGO password.
  required: true
  type: string
include:
  description: A list of license plates to include, if this is not specified, all vehicles will be added.
  required: false
  type: list
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.

## 사용가능한 속성 

| Attribute           | Description                                                                                                                        |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| latitude            | The latitude of your vehicle                                                                                                       |
| longitude           | The longitude of your vehicle                                                                                                      |
| altitude            | Altitude of your vehicle                                                                                                           |
| id                  | Identifier used to identify your vehicle                                                                                           |
| make                | The make of the vehicle                                                                                                            |
| model               | Model of your vehicle                                                                                                              |
| license_plate       | License plate number                                                                                                               |
| active              | If the engine is currently active or not                                                                                           |
| odo                 | The odometer in kilometers                                                                                                         |
| speed               | The current speed of your vehicle, in KM/h                                                                                         |
| last_seen           | The date and time when your vehicle last communicated with the API                                                                 |
| fuel_level          | Fuel level of the vehicle [1]                                                                                                      |
| malfunction_light   | Are any malfunction lights burning [1]                                                                                             |
| coolant_temperature | Temperature of the coolant [1]                                                                                                     |
| power_voltage       | Power voltage measured by the hardware [1]                                                                                         |
| distance_from_home  | How far is your vehicle located from your Home Assistant Home location                                                             |
| current_max_speed   | The maximum speed on the road the device is currently on (if available)                                                            |
| current_address     | Object with address information the device is currently on. This resolves to the closest address to the coordinates of the device. |


[1] 특정 자동차 및 하드웨어 개정판에서만 사용 가능합니다.