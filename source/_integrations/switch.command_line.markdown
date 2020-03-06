---
title: "컴맨드 라인 스위치"
description: "Instructions on how to have switches call command line commands."
logo: command_line.png
ha_category:
  - Switch
ha_release: pre 0.7
ha_iot_class: Local Polling
---

`command_line` 스위치 플랫폼은 켜거나 끌 때 특정 명령을 실행합니다. 다른 스크립트 호출을 포함하여 command line 에서 제어 할 수있는 모든 유형의 스위치를 Home Assistant에 통합 할 수 있으므로 가장 강력한 플랫폼이 될 수 있습니다!

이를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: command_line
    switches:
      kitchen_light:
        command_on: switch_command on kitchen
        command_off: switch_command off kitchen
```

{% configuration %}
switches:
  description: The array that contains all command switches.
  required: true
  type: map
  keys:
    identifier:
      description: Name of the command switch as slug. Multiple entries are possible.
      required: true
      type: map
      keys:
        command_on:
          description: The action to take for on.
          required: true
          type: string
        command_off:
          description: The action to take for off.
          required: true
          type: string
        command_state:
          description: "If given, this command will be run. Returning a result code `0` will indicate that the switch is on."
          required: false
          type: string
        value_template:
          description: "If specified, `command_state` will ignore the result code of the command but the template evaluating to `true` will indicate the switch is on."
          required: false
          type: string
        friendly_name:
          description: The name used to display the switch in the frontend.
          required: false
          type: string
{% endconfiguration %}

`friendly_name`에 대한 참고사항 :

설정하면 `friendly_name`은 이전에 `object_id`("identifier") 대신 API 호출 및 백엔드 설정에 사용되었지만 [this behavior is changing](https://github.com/home-assistant/home-assistant/pull/4343)을 사용하여 `friendly_name`을 표시용으로만 만듭니다. 이를 통해 사용자는 API 및 설정 목적에 대한 독창성과 예측 가능성을 강조하는 `identifier`를 설정할 수 있지만 UI에는 여전히 `friendly_name`이 더 예쁘게 표시됩니다. 

번역 의역 필요 

As an additional benefit, if a user wanted to change the `friendly_name` / display name (e.g., from "Kitchen Lightswitch" to "Kitchen Switch" or "Living Room Light", or remove the `friendly_name` altogether), he or she could do so without needing to change existing automations or API calls.


예제는 아래의 aREST 장치를 참조하십시오.

## 사례

이 섹션에는 이 스위치를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### aREST 장치

아래 예제는 [aREST 스위치](/integrations/arest#switch)와 동일합니다.
command line 도구로 [`curl`](https://curl.haxx.se/)은 REST를 통해 제어할 수 있는 핀을 토글하는데 사용됩니다.

```yaml
# Example configuration.yaml entry
switch:
  platform: command_line
  switches:
    arest_pin_four:
      command_on: "/usr/bin/curl -X GET http://192.168.1.10/digital/4/1"
      command_off: "/usr/bin/curl -X GET http://192.168.1.10/digital/4/0"
      command_state: "/usr/bin/curl -X GET http://192.168.1.10/digital/4"
      value_template: '{% raw %}{{ value == "1" }}{% endraw %}'
      friendly_name: Kitchen Lightswitch
```

번역 의역 필요 

Given this example, in the UI one would see the `friendly_name` of "Kitchen Light". However, the `identifier` is `arest_pin_four`, making the `entity_id` `switch.arest_pin_four`, which is what one would use in [`automation`](/integrations/automation/) or in [API calls](/developers/).

이 예제를 보면, UI에서 "Kitchen Light"의 "friendly_name"을 볼 수 있습니다. 그러나 `identifier`는 `arest_pin_four`이며 `entity_id` `switch.arest_pin_four`를 만들며, 이는 [`automation`](/integrations/automation/) 또는 [API calls](/developers/)에서 사용됩니다.

### 로컬 호스트 셧다운

이 스위치는 Home Assistant를 호스팅하는 시스템을 종료합니다.

<div class='note warning'>
이 스위치는 호스트를 즉시 종료하며 확인은 없습니다.
</div>

```yaml
# Example configuration.yaml entry
switch:
  platform: command_line
  switches:
    home_assistant_system_shutdown:
      command_off: "/usr/sbin/poweroff"
```

### VLC 플레이어 제어

이 스위치는 로컬 VLC 미디어 플레이어를 제어합니다. ([Source](https://community.home-assistant.io/t/vlc-player/106)).

```yaml
# Example configuration.yaml entry
switch:
  platform: command_line
  switches:
    vlc:
      command_on: "cvlc 1.mp3 vlc://quit &"
      command_off: "pkill vlc"
```

### FOSCAM 모션 센서 제어

이 스위치는 CGI 명령을 지원하는 Foscam Webcam의 모션 센서를 제어합니다 ([Source](http://www.ipcamcontrol.net/files/Foscam%20IPCamera%20CGI%20User%20Guide-V1.0.4.pdf)). 이 스위치는 현재 모션 감지 상태를 확인하는 statecmd를 지원합니다.

```yaml
# Example configuration.yaml entry
switch:
  platform: command_line
  switches:
    foscam_motion:
      command_on: 'curl -k "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=setMotionDetectConfig&isEnable=1&usr=admin&pwd=password"'
      command_off: 'curl -k "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=setMotionDetectConfig&isEnable=0&usr=admin&pwd=password"'
      command_state: 'curl -k --silent "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=getMotionDetectConfig&usr=admin&pwd=password" | grep -oP "(?<=isEnable>).*?(?=</isEnable>)"'
      value_template: {% raw %}'{{ value == "1" }}'{% endraw %}
```

- 관리자 및 비밀번호를 "admin" 권한이 있는 Foscam 사용자로 교체하십시오. 
- IP 주소를 Foscam의 로컬 IP 주소로 교체하십시오
