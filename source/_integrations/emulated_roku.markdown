---
title: Roku 에뮬레이트
description: Instructions on how to set up Emulated Roku within Home Assistant.
logo: home-assistant.png
ha_category:
  - Hub
ha_release: 0.86
ha_iot_class: Local Push
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/GxePiWUQHy8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 통합구성요소는 에뮬레이트 된 Roku API를 Home Assistant에 연동하므로 Harmony 및 Android 앱과 같은 원격 장치는 마치 Roku 플레이어인 것처럼 WiFi를 통해 연결할 수 있습니다.
홈어시스턴트는 키의 눌림(presses) 및 앱실행을 이벤트로 보고 자동화의 트리거로 사용할 수 있습니다.
여러 서버 항목을 지정하여 버튼(buttons)이 부족하면 여러 Roku 서버가 시작될 수 있습니다.

<div class='note'>

홈어시스턴트는 UDP 소켓을 지원하지 않는 `ProactorEventLoop`을 사용하므로 Windows가 지원되지 않습니다.

</div>

<div class='note warning'>

이 통합구성요소는 호스트에서 인증되지 않은 API를 열어 에뮬레이트된 Roku를 트리거로 사용하여 생성한 자동화를 통해 로컬 네트워크의 모든 항목이 Home Assistant 인스턴스에 액세스 할 수 있도록합니다. 
허용된 IP 주소와 함께 프록시를 사용하는 것이 좋습니다. (`advertise_ip`를 프록시의 IP 또는 DNS 이름으로 설정)

</div>

## 설정

프런트 엔드를 통해 통합구성요소를 설정할 수 있습니다. (**설정** -> **통합구성요소** -> **Emulated Roku**)

고급 옵션을 설정하려면 `configuration.yaml`에 다음 항목을 추가 할 수 있습니다.

```yaml
# Example configuration.yaml entry
emulated_roku:
  servers:
    - name: Home Assistant
      listen_port: 8060
```

{% configuration %}
name:
  description: Name of the Roku that will be displayed as the serial number in Harmony.
  required: true
  type: string
listen_port:
  description: The port the Roku API will run on. This can be any free port on your system.
  required: true
  type: integer
host_ip:
  description: The IP address that your Home Assistant installation is running on. If you do not specify this option, the integration will attempt to determine the IP address on its own.
  required: false
  type: string
advertise_ip:
  description: If you need to override the IP address or DNS name used for UPnP discovery. (For example, using network isolation in Docker or using a proxy)
  required: false
  type: string
advertise_port:
  description: If you need to override the advertised UPnP port.
  required: false
  type: integer
upnp_bind_multicast:
  description: Whether or not to bind the UPnP (SSDP) listener to the multicast address (239.255.255.250) or instead to the (unicast) host_ip address specified above (or automatically determined). The default is true, which will work in most situations. In special circumstances, like running in a FreeBSD or FreeNAS jail, you may need to disable this.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

시작한 후 에뮬레이트 된 Roku가 Home Assistant 인스턴스의 지정된 포트에 도달할 수 있는지 확인할 수 있습니다 (예: `http://192.168.1.101:8060/`).

## Events

### `roku_command` 이벤트

모든 Roku commands는 `roku_command` events로 전송됩니다.

Field | Description
----- | -----------
`source_name` | Name of the emulated Roku instance that sent the event. Only required when using multiple instances to filter event sources.
`type` | The type of the event that was called on the API.
`key` | the code of the pressed key when the command `type` is `keypress`, `keyup` or `keydown`.
`app_id` | the id of the app that was launched when command `type` is `launch`.

Available key codes |
------------------- |
`Home`
`Rev`
`Fwd`
`Play`
`Select`
`Left`
`Right`
`Down`
`Up`
`Back`
`InstantReplay`
`Info`
`Backspace`
`Search`
`Enter`

## 자동화

다음은 자동화 구현 예입니다.

```yaml
# Example automation
- id: amp_volume_up
  alias: Increase amplifier volume
  trigger:
  - platform: event
    event_type: roku_command
    event_data:
      source_name: Home Assistant
      type: keypress
      key: Fwd
  action:
  - service: media_player.volume_up
    entity_id: media_player.amplifier
```

## 문제 해결 

이미 알려진 IP 또는 포트를 변경하면 앱에서 에뮬레이트된 Roku를 다시 추가해야합니다.
하모니를 사용할 때 장치에 도달할 수 없는 것으로 감지되면 앱은 UPnP 검색(`name`이 변경되지 않은 경우)을 통해 변경 사항을 자동으로 검색해야합니다. 또는 앱에서 연결할 수 없는 장치의 리모컨에 있는 버튼을 눌러 'Fix' 페이지를 트리거하고 10 초 정도 기다린 다음 'Fix it'을 클릭하십시오.

Known limitations:
* Some Android remotes send key up/down events instead of key presses.
* Functionality other than key presses and app launches are not implemented yet.
* App ids are limited between 1-10. (The emulated API reports 10 dummy apps)
* Harmony uses UPnP discovery (UPnP is not needed after pairing), which might not work in Docker. You can:
  * Change Docker to host networking temporarily, then revert after pairing.
  * Run the `advertise.py` helper script from the emulated_roku library directly somewhere else and point it to the emulated Roku API.
* Harmony cannot launch apps as it uses IR instead of the WiFi API and will not display the custom dummy app list.
* Home control buttons cannot be assigned to emulated Roku on the Harmony Hub Companion remote as they are limited to Hue (and possibly other APIs) within Harmony.
* Harmony will not set the name of the added emulated Roku device to the specified `name`.
