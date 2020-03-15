---
title: 차고문(Garadget)
description: Instructions on how to integrate Garadget covers within Home Assistant.
logo: garadget.png
ha_category:
  - Cover
ha_release: 0.32
ha_iot_class: Cloud Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/--lLuR9o9QQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`garadget` Cover 플랫폼을 사용하면 Home Assistant를 통해 [Garadget](https://www.garadget.com/)의 garage door futurizers로 제어 할 수 있습니다.

## 설정

Garadget Covers를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry

 cover:
  - platform: garadget
    covers:
      first_garage:
        device: 190028001947343412342341
        username: YOUR_USERNAME
        password: YOUR_PASSWORD
        name: first_garage
      second_garage:
        device: 4c003f001151353432134214
        access_token: df4cc785ff818f2b01396c44142342fccdef
        name: second_garage

```

{% configuration %}
covers:
  description: 차고문 목록.
  required: true
  type: list
  covers:
      keys:
        device:
          description: This is the device id from your Garadget portal.
          required: true
          type: string
        username:
          description: Your Garadget account username.
          required: true
          type: string
        password:
          description: Your Garadget account password.
          required: true
          type: string
        access_token:
          description: A generated `access_token` from your Garadget account.
          required: true
          type: string
        name:
          description: me to use in the frontend, will use name configured in Garadget otherwise.
          required: false
          default: Garadget
          type: string
{% endconfiguration %}

제공되는 경우 **access_token** 이 사용되며, 그렇지 않으면 **username** 및 **password**가 시작시 자동으로 액세스 토큰을 생성하는 데 사용됩니다.

## Example

<p class='img'>
  <img src='{{site_root}}/images/integrations/garadget/cover_garadget_details.png' />
</p>

{% raw %}
```yaml
# Related configuration.yaml entry
cover:
  - platform: garadget
    covers:
      garadget:
        device: 190028001947343412342341
        access_token: !secret garadget_access_token
        name: Garage door

sensor:
  - platform: template
    sensors:
      garage_door_status:
        friendly_name: 'State of the door'
        value_template: "{{ states('cover.garage_door') }}"
      garage_door_time_in_state:
        friendly_name: 'Since'
        value_template: "{{ state_attr('cover.garage_door', 'time_in_state') }}"
      garage_door_wifi_signal_strength:
        friendly_name: 'WiFi strength'
        value_template: "{{ state_attr('cover.garage_door', 'wifi_signal_strength') }}"
        unit_of_measurement: 'dB'

group:
  garage_door:
    name: Garage door
    entities:
      - cover.garage_door
      - sensor.garage_door_status
      - sensor.garage_door_time_in_state
      - sensor.garage_door_wifi_signal_strength

customize:
  sensor.garage_door_time_in_state:
    icon: mdi:timer-sand
  sensor.garage_door_wifi_signal_strength:
    icon: mdi:wifi
```
{% endraw %}

Garadget 센서 중 일부는 로그북에 많은 혼란을 줄 수 있습니다. `configuration.yaml`에서 이 코드 섹션을 사용하여 해당 항목을 제외하십시오.

```yaml
logbook:
  exclude:
    entities:
      - sensor.garage_door_time_in_state
      - sensor.garage_door_wifi_signal_strength
```

펌웨어 릴리스 1.17부터 garadget 장치는 MQTT를 기본적으로 지원합니다. 이 옵션을 통해 최종 사용자는 '클라우드 만', '클라우드 및 MQTT' 또는 'MQTT 만'과 같은 방식으로 장치를 설정할 수 있습니다.

garadget을 MQTT Cover로 설정하려면 다음을 수행하십시오.

```yaml
cover:
  - platform: mqtt
    name: "Garage Door"
    command_topic: "garadget/device_name/command"
    state_topic: "garadget/device_name/status"
    payload_open: "open"
    payload_close: "close"
```
