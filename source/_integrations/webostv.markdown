---
title: LG webOS 스마트 TV
description: Instructions on how to integrate a LG webOS Smart TV within Home Assistant.
logo: webos.png
ha_category:
  - Media Player
  - Notifications
ha_iot_class: Local Polling
ha_release: 0.18
ha_codeowners:
  - '@bendavid'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/f0i2R1cMWBg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 webostv플랫폼을 사용하면 [LG](https://www.lg.com/) webOS 스마트 TV 를 제어 할 수 있습니다 .

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :


- [미디어플레이어](#media-player)
- [알림](#notifications)

TV [instructions](https://www.lg.com/uk/support/product-help/CT00008334-1437131798537-others)의 *네트워크* 설정 에서 *LG Connect 앱* 기능을 활성화해서 시작 하십시오 .

기본 설정이 configuration.yaml파일에 추가되면 프런트 엔드의 **알림**섹션에 페어링 정보가 표시되어야합니다. 지침에 따라 TV에서 페어링 요청을 수락하십시오.

페어링 정보는 `webostv.conf` Home Assistant 설정 디렉토리의 설정 파일에 저장됩니다 . 이 과정은 나중에 TV의 IP 주소가 변경 될 경우 IP 주소에 설정에 주의하십시오.

## 설정

TV를 설치에 추가하려면 `configuration.yaml`파일에 다음을 추가 하십시오. :

```yaml
# Example configuration.yaml entry
webostv:
```

{% configuration %}
host:
  description: "LG webOS 스마트 TV의 IP 주소 예: `192.168.0.10`."
  required: true
  type: string
name:
  description: LG webOS 스마트 TV에 부여하려는 이름입니다.
  required: false
  type: string
turn_on_action:
  description: TV를 켜는 [action](/docs/automation/action/)을 정의합니다. 
  required: false
  type: string
customize:
  description: 사용자 정의할 옵션 목록.
  required: false
  type: map
  keys:
    sources:
      description: 하드웨어 및 webOS 앱 입력 목록.
      required: false
      type: list
{% endconfiguration %}

### 전체 설정 예시

전체 설정 예는 아래 샘플과 같습니다. :

```yaml
# Example configuration.yaml entry
webostv:
  host: 192.168.0.10
  name: Living Room TV
  turn_on_action:
    service: persistent_notification.create
    data:
      message: "Turn on action"
  customize:
    sources:
      - livetv
      - youtube
      - makotv
      - netflix

media_player:

notify:
```

장치의 `name :`에서 `[]`를 사용하지 마십시오.


### 다수의 TV 사용 

이 통합구성요소로 다수의 TV를 사용할 수도 있습니다.

```yaml
# Example configuration.yaml entry with multiple TVs
webostv:
  - name: Living Room TV
    host: 192.168.1.100
  - name: Bedroom TV
    host: 192.168.1.101
```

위의 예제는 최소 내용의 샘플이지만 모든 옵션을 각 TV에서 사용할 수 있습니다.

## 켜기 동작 (Turn on action)

HDMI-CEC 또는 WakeOnLan과 같은 동작을 지정하면 Home Assistant에서 LG webOS 스마트 TV를 켤 수 있습니다.

webOS 3.0 이상에서는 WakeOnLan 기능을 사용하는 것이 일반적입니다. 이 기능을 사용하려면 TV가 무선이 아닌 이더넷을 통해 네트워크에 연결되어 있어야하며 *네트워크* TV 설정[instructions](https://www.lg.com/uk/support/product-help/CT00008334-1437131798537-others)에서 *LG Connect Apps* 기능을 활성화해야합니다. (구형 모델은 *모바일앱*에서 *일반* 설정)

최신 모델 (2017+)의 경우 설정> 일반> 모바일 TV 켜기> WiFi를 통해 켜기 [instructions](https://support.quanticapps.com/hc/en-us/articles/115005985729-How-to-turn-on-my-LG-Smart-TV-using-the-App-WebOS-)로 이동하여 TV 설정에서 WakeOnLan을 활성화해야 할 수 있습니다.

```yaml
# Example configuration.yaml entry
wake_on_lan: # enables `wake_on_lan` domain

webostv:
  host: 192.168.0.10
  #other settings
  turn_on_action:
    service: wake_on_lan.send_magic_packet
    data:
      mac: "B4:E6:2A:1E:11:0F"

media_player:

notify:
```

장치 전원을 켜기위한 다른 모든 [actions](/docs/automation/action/)을 설정할 수 있습니다.

## Sources

현재 TV에 설정된 사용 가능한 소스의 전체 목록을 얻으려면 webOS TV를 설정하고 전원을 켠 상태에서 **개발자 도구**> **상태**에서 `media_player.name`을 찾아 `source_list :`의 각 줄의 나타난 입력(소스)들을 기억해두고 `source:`에  해당 입력을 배치시켜 사용하십시오.

## play_media 서비스를 통한 채널 변경

`play_media` 서비스는 스크립트에서 지정된 TV 채널로 전환하는 데 사용될 수 있습니다. `media_content_id` 매개 변수에 따라 가장 일치하는 채널을 선택합니다. : 

 1. 채널 번호 *(예: '1' or '6')*
 2. 정확한 채널 이름 *(예: 'France 2' or 'CNN')*
 3. 채널 이름 하위 문자열 *(예: 'BFM' in 'BFM TV')*

```yaml
# Example action entry in script to switch to channel number 1
service: media_player.play_media
data:
  entity_id: media_player.lg_webos_smart_tv
  media_content_id: 1
  media_content_type: "channel"

# Example action entry in script to switch to channel including 'TF1' in its name
service: media_player.play_media
data:
  entity_id: media_player.lg_webos_smart_tv
  media_content_id: "TF1"
  media_content_type: "channel"
```

## Next/Previous buttons

다음 및 이전 버튼의 동작은 활성 입력에 따라 다릅니다. :

- 입력이 'LiveTV'(텔레비전) 인 경우 : 다음/이전 버튼이 채널 위/아래로 작동
- 그렇지 않으면 다음/이전 버튼이 다음/이전 트랙으로 작동합니다.

### 사운드 출력 (Sound output)

TV의 현재 사운드 출력은 상태 속성에서 찾을 수 있습니다.
사운드 출력을 변경하려면 다음 서비스를 이용할 수 있습니다. :

#### `webostv.select_sound_output` 서비스

| Service data attribute | Optional | Description                             |
| ---------------------- | -------- | --------------------------------------- |
| `entity_id`            | no       | 특정 webostv 미디어 플레이어를 대상으로합니다. |
| `sound_output`         | no       | 전환 할 사운드 출력의 이름입니다.  |

### 일반 명령 및 버튼

사용가능한 서비스 : `button`, `command`

### `webostv.button` 서비스

| Service data attribute | Optional | Description                                                                                                                                                                                                                                                                            |
| ---------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `entity_id`            | no       | 특정 webostv 미디어를 대상                                                                                                                                                                                                                                                 |
| `button`               | no       | 버튼 이름. 알려진 가능한 값은 `LEFT`, `RIGHT`, `DOWN`, `UP`, `HOME`, `BACK`, `ENTER`, `DASH`, `INFO`, `ASTERISK`, `CC`, `EXIT`, `MUTE`, `RED`, `GREEN`, `BLUE`, `VOLUMEUP`, `VOLUMEDOWN`, `CHANNELUP`, `CHANNELDOWN`, `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9` |

### `webostv.command` 서비스

| Service data attribute | Optional | Description                                                                                                                                                                          |
| ---------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `entity_id`            | no       | 특정 webostv 미디어를 대상.                                                                                                                                              |
| `command`              | no       | 엔드포인트 명령  예: `media.controls/rewind`.   <https://github.com/bendavid/aiopylgtv/blob/master/aiopylgtv/endpoints.py>에서 알려진 엔드포인트 명령의 전체 목록을 사용할 수 있습니다 |

### 사례 (Example)

```yaml
script:
  home_button:
    sequence:
      - service: webostv.button
        data:
          entity_id:  media_player.lg_webos_smart_tv
          button: "HOME"

  rewind_command:
    sequence:
      - service: webostv.command
        data:
          entity_id:  media_player.lg_webos_smart_tv
          command: "media.controls/rewind"
```

## 알림 (Notifications)

`webostv` 알림 플랫폼을 통해 LG webOS 스마트 TV에 알림을 보낼 수 있습니다.

사용할 대체 아이콘 이미지에 대한 경로를 제공하여 개별 알림에 대해 아이콘을 대체 할 수 있습니다. :

```yaml
automation:
  - alias: Front door motion
    trigger:
      platform: state
      entity_id: binary_sensor.front_door_motion
      to: 'on'
    action:
      service: notify.livingroom_tv
      data:
        message: "Movement detected: Front Door"
        data:
          icon: "/home/homeassistant/images/doorbell.png"
```
