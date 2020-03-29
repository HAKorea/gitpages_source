---
title: 파이오니아(Pioneer)
description: Instructions on how to integrate a Pioneer Network Receivers into Home Assistant.
logo: pioneer.png
ha_category:
  - Media Player
ha_release: 0.19
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/SyHCDhrr70g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`pioneer` 플랫폼을 사용하면 Pioneer 네트워크 리시버를 제어할 수 있습니다. 그러나 최신 Pioneer 모델은 [Onkyo](/integrations/onkyo) 플랫폼과 함께 작동합니다.

Pioneer 리시버를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: pioneer
    host: 192.168.0.10
```

{% configuration %}
host:
  description: The IP of the Pioneer device, e.g., `192.168.0.10`.
  required: true
  type: string
name:
  description: The name you would like to give to the receiver.
  required: false
  default: Pioneer AVR
  type: string
port:
  description: The port on which the Pioneer device listens, e.g., `23` or `8102`.
  required: false
  default: 23
  type: integer
timeout:
  description: Number of seconds (float) to wait for blocking operations like connect, write and read.
  required: false
  type: float
sources:
  description: A list of mappings from source friendly name to the source code (e.g. `TV:'05'`). Valid source codes depend on the receiver (some known codes can be found below). Codes must be defined as strings (between single or double quotation marks) so that `05` is not implicitly transformed to `5`, which wouldn't be valid source code.
  required: false
  default: Empty list (i.e. no source selection will be possible)
  type: list
{% endconfiguration %}

참고 :

- 일부 파이오니어 AVR은 기본 포트 23을 사용하고 일부는 8102를 사용하는 것으로 보고됩니다.
- `timeout`은 소켓 레벨 옵션이며 무엇을 하고 있는지 아는 경우에만 설정해야합니다.

### 입력 코드들(Source codes)

이 라인들 아래에서, 리시버 모델당 샘플 `sources` 목록을 찾을 수 있습니다. 여기서는 각 코드의 키(key)로 리모컨에 표시된 입력 이름을 사용합니다. 그러나 이는 표시 목적으로만 사용되므로 설정에 더 잘 맞도록 입력의 이름을 바꿀 수 있습니다 (예: `HDMI: '19'`~ `Kodi: '19'`).

`05`가 절대적으로 `5`로 변환되지 않도록 유효한 소스 코드가 아닌 코드는 문자열 (작은 따옴표 또는 큰 따옴표 사이)로 정의되어야합니다.

#### VSX-921

```yaml
sources:
  'PHONO': '00'
  'CD': '01'
  'CD-R/TAPE': '03'
  'DVD': '04'
  'TV/SAT': '05'
  'VIDEO 1(VIDEO)': '10'
  'VIDEO 2': '14'
  'DVR/BDR': '15'
  'iPod/USB': '17'
  'HDMI1': '19'
  'HDMI2': '20'
  'HDMI3': '21'
  'HDMI4': '22'
  'HDMI5': '23'
  'HDMI6': '24'
  'BD': '25'
  'HOME MEDIA GALLERY(Internet Radio)': '26'
```

#### VSX-822-K

```yaml
sources:
  'CD': '01'
  'Tuner': '02'
  'DVD': '04'
  'TV': '05'
  'Sat/Cbl': '06'
  'Video': '10'
  'DVR/BDR': '15'
  'iPod/USB': '17'
  'BD': '25'
  'Adapter': '33'
  'Netradio': '38'
  'Pandora': '41'
  'Media Server': '44'
  'Favorites': '45'
  'Game': '49'
```

#### VSX-824

```yaml
sources:
  'CD': '01'
  'Tuner': '02'
  'DVD': '04'
  'TV': '05'
  'Sat/Cbl': '06'
  'Video': '10'
  'DVR/BDR': '15'
  'iPod/USB': '17'
  'HDMI': '19'
  'BD': '25'
  'Adapter': '33'
  'Netradio': '38'
  'Media Server': '44'
  'Favorites': '45'
  'MHL': '48'
  'Game': '49'
```
