---
title: 온쿄(Onkyo)
description: Instructions on how to integrate Onkyo and some Pioneer receivers into Home Assistant.
logo: onkyo.png
ha_category:
  - Media Player
ha_release: 0.17
ha_iot_class: Local Polling
---

`onkyo` 플랫폼을 사용하면 Home Assistant의 [Onkyo](http://www.onkyo.com/), [Integra](http://www.integrahometheater.com/) 및 일부 [Pioneer](http://www.pioneerelectronics.com) 리시버를 제어할 수 있습니다.
이 통합구성요소가 하드웨어에서 작동하려면 "Network Standby"를 활성화해야 합니다.

## 설정

설치에 Onkyo 또는 Pioneer 리시버를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: onkyo
    host: 192.168.1.2
    name: receiver
    sources:
      pc: 'HTPC'
```

 리시버에 두 번째 또는 세 번째 영역(zone)을 사용할 수 있는 경우 메인 영역과 동일한 기능을 가진 추가 미디어 플레이어로 표시됩니다.

{% configuration %}
host:
  description: "장치의 IP 주소. (예 :`192.168.1.2`). 지정하지 않으면 플랫폼은 자동찾기로 리시버를 로드합니다."
  required: false
  type: string
name:
  description: 장치 이름. (*호스트가 지정된 경우 필수*)
  required: false
  type: string
max_volume:
  description: 백분율로 표시되는 최대 볼륨입니다. 리시버의 최대 볼륨이 너무 큰 경우가 종종 있습니다. 이 설정을 하면 홈어시스턴트의 100 % 음량이 앰프의 설정이됩니다. 즉, 홈어시스턴트를 100 %로 설정할 때, 이 값을 50 %로 설정하면 리시버는 최대 볼륨의 50 %로 설정됩니다.
  required: false
  default: 100
  type: integer
receiver_max_volume:
  description: 리시버의 최대 볼륨. 구형 Onkyo 리시버의 경우이 값은 80이고 최신 Onkyo 리시버는 200을 사용합니다.
  required: false
  default: 80
  type: integer
sources:
  description: 소스에서 소스 이름으로의 맵핑 목록. 유효한 소스는 아래에서 찾을 수 있습니다. 소스 맵핑이 지정되지 않은 경우 기본 목록이 사용됩니다.
  required: false
  type: list
{% endconfiguration %}

List of source names:

- video1
- video2
- video3
- video4
- video5
- video6
- video7
- dvd
- bd-dvd
- tape1
- tv-tape
- tape2
- phono
- cd
- tv-cd
- fm
- am
- tuner
- dlna
- internet-radio
- usb
- network
- universal-port
- multi-ch
- xm
- sirius

소스가 위에 나열되어 있지 않고 소스 이름의 형식을 지정하여 항목을 매핑할 수 있는 방법을 찾으려면 `onkyo-eiscp` Python 모듈을 사용하여 필요한 정확한 이름을 찾을 수 있습니다. 먼저 리시버의 소스를 정의해야하는 소스로 변경 한 후 다음을 실행하십시오.

```bash
onkyo --host 192.168.0.100 source=query
```

리시버 최대 볼륨을 찾으려면 onkyo-eiscp python 모듈을 사용하여 리시버를 최대 볼륨으로 설정하십시오.
(뭔가를 하는 동안 이것을 하지 마십시오!) 그리고 다음을 실행합니다. : 

```bash
onkyo --host 192.168.0.100 volume=query
unknown-model: master-volume = 191
```

### `onkyo_select_hdmi_output` 서비스

수신기의 HDMI 출력을 변경합니다

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of a single `entity_id` that will change output.
| `hdmi_output` | no | The desired output code.

허용되는 값은 : 'no', 'analog', 'yes', 'out', 'out-sub', 'sub', 'hdbaset', 'both', 'up'은 모델에 따라 달라지는 것으로 보입니다, 시도 해봐야합니다. 
(TX-NR676E 모델의 경우 메인의 경우 'out', 서브의 경우 'out-sub', 둘다의 경우 'sub'인 것으로 보입니다.)


### `play_media` 스크립트 사례

스크립트에서 `play_media` 기능을 사용하여 사전 설정된 번호로 라디오 방송국을 재생할 수 있습니다.
NET 라디오에서 작동하지 않습니다.

```yaml
# Example play_media script
#
script:
 radio1:
    alias: "Radio 1"
    sequence:
      - service: media_player.turn_on
        data:
          entity_id: media_player.onkyo
      - service: media_player.play_media
        data:
          entity_id: media_player.onkyo
          media_content_type: "radio"
          media_content_id: "1"
```

### `onkyo_select_hdmi_output` 스크립트 사례

```yaml
# Example onkyo_select_hdmi_output script
#
script:
 hdmi_sub:
    alias: "Hdmi out projector"
    sequence:
      - service: media_player.onkyo_select_hdmi_output
        service_data:
          entity_id: media_player.onkyo
          hdmi_output: out-sub
```
