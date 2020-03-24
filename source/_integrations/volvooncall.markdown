---
title: 볼보(Volvo On Call)
logo: volvo.png
ha_category:
  - Car
ha_release: 0.39
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/xMfWSgJWy5w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`volvooncall` 통합구성요소는 [Volvo On Call](https://www.volvocars.com/intl/why-volvo/human-innovation/future-of-driving/connectivity/volvo-on-call) 클라우드와의 통합을 제공합니다 서비스, 존재 감지, 주행 거리계 및 연료 레벨과 같은 센서를 제공합니다.

혹시 우리나라에서 지원되는지 볼보 사용자분들께서는 확인 부탁드립니다.

## 설정

설비에서 Volvo On Call을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
volvooncall:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

북미 또는 중국에서 볼보에 등록된 사용자는 지역을 지정해야합니다.

```yaml
# North America
volvooncall:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
  region: na
```

혹은

```yaml
# China
volvooncall:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
  region: cn
```

{% configuration %}
username:
  description: The username associated with your Volvo On Call account.
  required: true
  type: string
password:
  description: The password for your given Volvo On Call account.
  required: true
  type: string
region:
  description: The region where the Volvo is registered. Needs to be set for users in North America or China.
  required: false
  type: string
service_url:
  description: The service URL to use for Volvo On Call. Normally not necessary to specify.
  required: false
  type: string
mutable:
  description: If set to true, include components that can make changes to the vehicle (unlock, start engine, start heater etc).
  required: false
  default: true
  type: boolean
name:
  description: "Make it possible to provide a name for the vehicles. Note: Use all lower case letters when inputing your VIN number."
  required: false
  type: string
resources:
  description: A list of resources to display (defaults to all available).
  required: false
  type: list
scandinavian_miles:
  description: If set to true, Scandinavian miles ("mil") are used for distances and fuel range.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

### 사용가는한 리소스들

현재 사용 가능한 리소스 목록 :

- `position`
- `lock`
- `heater`
- `odometer`
- `trip_meter1`
- `trip_meter2`
- `fuel_amount`
- `fuel_amount_level`
- `average_fuel_consumption`
- `distance_to_empty`
- `washer_fluid_level`
- `brake_fluid`
- `service_warning_status`
- `bulb_failures`
- `battery_range`
- `battery_level`
- `time_to_fully_charged`
- `battery_charge_status`
- `engine_start`
- `last_trip`
- `is_engine_running`
- `doors.hood_open`
- `doors.front_left_door_open`
- `doors.front_right_door_open`
- `doors.rear_left_door_open`
- `doors.rear_right_door_open`
- `windows.front_left_window_open`
- `windows.front_right_window_open`
- `windows.rear_left_window_open`
- `windows.rear_right_window_open`
- `tyre_pressure.front_left_tyre_pressure`
- `tyre_pressure.front_right_tyre_pressure`
- `tyre_pressure.rear_left_tyre_pressure`
- `tyre_pressure.rear_right_tyre_pressure`
- `any_door_open`
- `any_window_open`

## 고급 예시

차량 이름을 설정하고 표시할 리소스를 선택하는 고급 예 :

```yaml
# Example configuration.yaml entry
volvooncall:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
  name:
    YOUR_VIN_NUMBER: 'NEW_NAME'
  resources:
    - odometer
    - lock
    - heater
```
