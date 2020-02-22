---
title: "집에 아무도 없을때 Foscam 카메라를 팬/틸트/줌 제어 및 모션감지로 사용"
description: "Example of how to set Foscam to only have Motion Detection Recording while no one is home. When users are home the Foscam will indicate it is not recording by pointing down and away from users"
ha_category: Automation Examples
---

이를 위해서는 PTZ (팬, 틸트, 줌) 및 CGI 기능이있는 [Foscam IP Camera](/integrations/foscam) 카메라 ([Source](https://www.foscam.es/descarga/Foscam-IPCamera-CGI-User-Guide-AllPlatforms-2015.11.06.pdf))가 필요합니다. 

Foscam 카메라는 여러 CGI 명령을 통해 Home Assistant에서 제어 할 수 있습니다. 다음은 동작 감지를 제어하는 ​​동안 2개의 사전 설정 대상간에 이동하는 데 필요한 스위치, 서비스 및 스크립트의 예를 간략히 설명하지만 위에 링크 된 Foscam CGI 사용 설명서에 다른 많은 이동 옵션이 ​​제공됩니다.

`switch.foscam_motion` 은 모션 감지의 켜짐 또는 꺼짐을 제어합니다. 이 스위치는 현재 동작 감지 상태를 확인하는 `statecmd`를 지원합니다.

```yaml
# Replace admin and password with an "Admin" privileged Foscam user
# Replace ipaddress with the local IP address of your Foscam
switch:
 platform: command_line
 switches:
   #Switch for Foscam Motion Detection
   foscam_motion:
     command_on: 'curl -k "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=setMotionDetectConfig&isEnable=1&usr=admin&pwd=password"'
     command_off: 'curl -k "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=setMotionDetectConfig&isEnable=0&usr=admin&pwd=password"'
     command_state: 'curl -k --silent "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=getMotionDetectConfig&usr=admin&pwd=password" | grep -oP "(?<=isEnable>).*?(?=</isEnable>)"'
     value_template: '{% raw %}{{ value == "1" }}{% endraw %}'
```

`shell_command.foscam_turn_off` 서비스는 카메라가 녹화중이 아님을 가리키도록 카메라를 아래로 향하게하고, `shell_command.foscam_turn_on`은 카메라가 내가 녹화하고 싶은 위치를 가리키도록 설정합니다. 이러한 서비스 중 카메라에 사전 설정 지점을 추가해야합니다. 추가 정보는 위의 소스를 참조하십시오.

```yaml
shell_command:
  #Created a preset point in Foscam Web Interface named Off which essentially points the camera down and away
  foscam_turn_off: 'curl -k "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=ptzGotoPresetPoint&name=Off&usr=admin&pwd=password"'
  #Created a preset point in Foscam Web Interface named Main which points in the direction I would like to record
  foscam_turn_on: 'curl -k "https://ipaddress:443/cgi-bin/CGIProxy.fcgi?cmd=ptzGotoPresetPoint&name=Main&usr=admin&pwd=password"'
```

`script.foscam_off` 및 `script.foscam_on`을 사용하여 모션 감지를 적절하게 설정한 다음 카메라를 이동할 수 있습니다. 이 스크립트는 Foscam에 대해 `home` 및 `not_home`모드를 설정하고 `home` 일때 모션 감지 녹화를 비활성화하는 `device_tracker` 트리거를 사용하여 자동화의 일부로 호출 할 수 있습니다.

```yaml
script:
 foscam_off:
   sequence:
   - service: switch.turn_off
     data:
       entity_id: switch.foscam_motion
   - service: shell_command.foscam_turn_off
 foscam_on:
   sequence:
   - service: switch.turn_off
     data:
       entity_id: switch.foscam_motion
   - service: shell_command.foscam_turn_on
   - service: switch.turn_on
     data:
       entity_id: switch.foscam_motion
```

Foscam이 "on"으로 설정되도록 (모션센서가 켜진 상태에서 올바른 방향으로) 자동화하기 위해 다음과 같은 간단한 자동화를 사용했습니다. :

```yaml
automation:
  - alias: Set Foscam to Away Mode when I leave home
    trigger:
      platform: state
      entity_id: group.family
      from: 'home'
    action:
      service: script.foscam_on
  - alias: Set Foscam to Home Mode when I arrive Home
    trigger:
      platform: state
      entity_id: group.family
      to: 'home'
    action:
      service: script.foscam_off
```

