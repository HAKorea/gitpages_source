---
title: 플릭(Flic)
description: Instructions on how to integrate flic buttons within Home Assistant.
logo: flic.png
ha_category:
  - Binary Sensor
ha_iot_class: Local Push
ha_release: 0.35
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/-Y7Rm6OcCMY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`flic` 플랫폼을 사용하면 [flic](https://flic.io) 스마트 버튼에서 클릭 이벤트를 수신할 수 있습니다.

플랫폼은 버튼과 직접 상호 작용하지 않지만 버튼을 관리하는 *flic service와 통신합니다.* 이 서비스는 Home Assistant 또는 다른 연결 가능한 컴퓨터와 동일한 인스턴스에서 실행될 수 있습니다.

#### 서비스 셋업

Hass.io를 사용하는 경우 [pschmitt's repository](https://github.com/pschmitt/hassio-addons)에서 flicd 애드온을 [installing](/hassio/installing_third_party_addons/)하여 서비스를 로컬로 실행할 수 있습니다.

서비스를 수동으로 설치하는 방법에 대한 지침은 [Linux](https://github.com/50ButtonsEach/fliclib-linux-hci), [OS X](https://github.com/50ButtonsEach/flic-service-osx) 또는 [Windows](https://github.com/50ButtonsEach/fliclib-windows) 서비스의 GitHub 저장소를 방문하십시오.

#### 설정

설치시 flic 버튼을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: flic
```

{% configuration %}
host:
  description: The IP or hostname of the flic service server.
  required: false
  type: string
  default: localhost
port:
  description: The port of the flic service.
  required: false
  type: integer
  default: 5551
discovery:
  description: If `true` then the integration is configured to constantly scan for new buttons.
  required: false
  type: boolean
  default: true
ignored_click_types:
  description: List of click types whose occurrence should not trigger a `flic_click` event. Click types are `single`, `double`, and `hold`.
  required: false
  type: list
timeout:
  description: The maximum time in seconds an event can be queued locally on a button before discarding the event.
  required: false
  type: integer
  default: 3
{% endconfiguration %}

#### Discovery

검색이 활성화된 경우 새 버튼을 7 초 이상 눌러 추가할 수 있습니다. 이 버튼은 파일 서비스와 페어링되어 홈어시스턴트에 추가됩니다. 그렇지 않으면 수동으로 파일 서비스와 페어링해야합니다. 홈어시스턴트 플랫폼은 새 버튼을 검색하지 않고 이미 페어링된 버튼에만 연결합니다.

#### Timeout

 Flic 서비스와의 연결이 끊어진 상태에서 Flic 버튼이 트리거되면 모든 이벤트를 대기열에 넣고 가능한 빨리 연결하고 전송하려고 시도합니다. 제한 시간 변수는 홈어시스턴트의 액션(action)와 ​​알림(notification) 사이에 너무 많은 시간이 경과한 경우 이벤트 트리거를 중지하는데 사용할 수 있습니다.

#### Events

flic 통합구성요소는 버스에서 `flic_click` 이벤트를 발생시킵니다. 이벤트를 캡처하여 다음과 같은 자동화 스크립트에서 응답할 수 있습니다.

```yaml
# Example configuration.yaml automation entry
automation:
  - alias: Turn on lights in the living room when flic is pressed once
    trigger:
      platform: event
      event_type: flic_click
      event_data:
        button_name: flic_81e4ac74b6d2
        click_type: single
    action:
      service: homeassistant.turn_on
      entity_id: group.lights_livingroom
```

이벤트 데이터:

- **button_name**: 이벤트를 트리거한 버튼의 이름.
- **button_address**: 이벤트를 트리거한 버튼의 Bluetooth 주소.
- **click_type**: 클릭 유형. 가능한 값은 `single`, `double`, `hold`.
- **queued_time**: 이 이벤트가 버튼에서 큐에 대기한 시간(초)입니다.

버튼 클릭을 감지하고 디버깅하는데 도움이 되도록 이 버튼을 사용하면 모든 버튼의 클릭 유형에 대한 알림을 보내는 자동화 기능을 사용할 수 있습니다. 이 예에서는 [HTML5 push notification platform](/integrations/html5)을 사용합니다. 알림 설정에 대한 자세한 내용은 [notification integration page](/integrations/notify/)를 방문하십시오.

```yaml
automation:
  - alias: FLIC Html5 notify on every click
    trigger:
      platform: event
      event_type: flic_click
    action:
      - service_template: notify.html5
        data_template:
          title: "flic click"
          message: {% raw %}"flic {{ trigger.event.data.button_name }} was {{ trigger.event.data.click_type }} clicked"{% endraw %}
```

##### 클릭 타입을 무시하기

상황에 따라 특정 클릭 유형을 클릭 이벤트 트리거에서 제외하는 것이 좋습니다. 예를 들어 더블 클릭을 무시할 때 버튼을 두 번 빠르게 누르면 `double` 클릭 이벤트 대신 두 개의 `single`이 발생합니다. 빠른 클릭을 원하는 응용 프로그램에 매우 유용합니다.