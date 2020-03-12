---
title: 루트론 카세타(Lutron Caseta)
description: Instructions on how to use Lutron Caseta devices with Home Assistant.
logo: lutron.png
ha_category:
  - Hub
  - Cover
  - Light
  - Scene
  - Switch
  - Fan
ha_release: 0.41
ha_iot_class: Local Polling
---

[Lutron](http://www.lutron.com/)은 미국 조명 제어 회사입니다. 여기에는 light switches, dimmers, occupancy sensors, HVAC controls 등을 관리하는 여러 홈자동화 장치 라인이 있습니다. 홈어시스턴트의 `lutron_caseta` 통합구성요소는 dimmers, switches, shades의 [Caseta](https://www.casetawireless.com/) 제품 라인을 위해 Lutron Caseta Smart Bridge와 통신하는 역할을 합니다.

이 통합은구성요소는 [Caseta](https://www.casetawireless.com/) 제품군만 지원합니다. Smart Bridge (L-BDG2-WH) 및 Smart Bridge PRO (L-BDGPRO2-WH) 모델이 모두 지원됩니다. RadioRA 2 제품군의 경우 [Lutron component](/integrations/lutron/)를 참조하십시오.

현재 지원되는 Caseta 장치는 다음과 같습니다.

- Wall and plug-in dimmers as [lights](#light)
- Wall switches as [switches](#switch)
- Scenes as [scenes](#scene)
- Lutron shades as [covers](#cover)
- Lutron smart [fan](#fan) speed control

`lutron_caseta` 통합구성요소는 Lutron Smart Bridge에서 설정으로 현재 지원되는 장치를 자동으로 검색합니다. Lutron 모바일 앱에 지정된 이름은 홈어시스턴트에서 사용되는 `entity_id`를 형성하는 데 사용됩니다. 예를 들어 `Bedroom`이라는 방에 `Lamp`라는 dimmer는 Home Assistant에서 `light.bedroom_lamp`가 됩니다.

설치시 Lutron Caseta 장치를 사용하려면 먼저 Lutron 계정에 로그인하고 Home Assistant가 브리지에 연결할 수 있는 인증서를 생성해야합니다. [get_lutron_cert.py](https://github.com/gurumitts/pylutron-caseta/blob/master/get_lutron_cert.py)를 다운로드하여 실행하면 다음 세 가지 파일이 생성됩니다. : caseta.key, caseta.crt, caseta-bridge.crt. 자세한 내용은 스크립트 상단의 지침을 참조하십시오.


필요한 파일이 3개 생겼으면 설정 디렉토리에 넣고 `configuration.yaml`에 다음을 추가하십시오. : 

```yaml
# Example configuration.yaml entry
lutron_caseta:
    host: IP_ADDRESS
    keyfile: caseta.key
    certfile: caseta.crt
    ca_certs: caseta-bridge.crt
```

{% configuration %}
  host:
    required: true
    description: The IP address of the Lutron Smart Bridge.
    type: string
  keyfile:
    required: true
    description: The private key that Home Assistant will use to authenticate to the bridge.
    type: string
  certfile:
    required: true
    description: The certificate chain that Home Assistant will use to authenticate to the bridge.
    type: string
  ca_certs:
    required: true
    description: The list of certificate authorities (usually only one) that Home Assistant will expect when connecting to the bridge.
    type: string
{% endconfiguration %}

<div class='note'>

Lutron Smart Bridge에 고정 IP 주소를 할당하는 것이 좋습니다. 이렇게하면 IP 주소가 변경되지 않으므로 호스트가 재부팅되고 다른 IP 주소가 나오는 경우 호스트를 변경할 필요가 없습니다.

<br>
라우터에서 DHCP 예약을 사용하여 주소를 예약하거나 Smart Bridge의 PRO 모델에서 모바일 앱의 Advanced / Integration 메뉴에 있는 네트워크 설정에서 IP 주소를 설정하십시오.
</div>

Lutron Caseta roller, honeycomb shades, lights, scene 및 switch를 Home Assistant와 함께 사용하려면, 먼저 위의 일반적인 Lutron Caseta 통합 지침을 따르십시오.

## Cover

설정 후 Lutron 모바일 앱에 사용된 이름을 기반으로 `entity_id`를 사용하여 shades가 Home Assistant에 나타납니다. 예를 들어, 'Living Room Window'이라는 shades은 홈어시스턴트에 `cover.living_room_window`로 나타납니다.

Home Assistant에서 shades 작업에 대한 자세한 내용은 [Covers component](/integrations/cover/)를 참조하십시오.

사용 가능한 서비스 : `cover.open_cover`, `cover.close_cover` 및 `cover.set_cover_position`. 커버의 위치는 완전 폐쇄의 경우 0, 완전 개방의 경우 100까지입니다.

## Light

설정 후 벽 및 플러그인 dimmers를 포함한 디밍 가능 조명이 Lutron 모바일 앱에서 사용된 이름을 기반으로 `entity_id`를 사용하여 Home Assistant에 나타납니다. 예를 들어 'Bedroom Lamp'라는 조명은 홈 어시스턴트에 `light.bedroom_lamp`로 나타납니다.

디밍 불가능한 조명 또는 스위치로드에 대해서는 이 페이지의 스위치 섹션을 참조하십시오.

Home Assistant에서 조명 작업에 대한 자세한 내용은 [Lights component](/integrations/light/)를 참조하십시오.

사용 가능한 서비스 : `light.turn_on`, `light.turn_off`, `light.toggle`.  `light.turn_on` 서비스는 `brightness` 및 `brightness_pct` 속성을 지원합니다.

## 장면(Scene)

Lutron Caseta 장면 플랫폼을 사용하면 Lutron 모바일 앱에서 생성된 Smart Bridge 장면을 제어 할 수 있습니다.

설정 후 장면은 Lutron 모바일 앱에서 사용된 이름을 기반으로 `entity_id`를 사용하여 Home Assistant에 나타납니다. 예를 들어 `Entertain`이라는 장면은 Home Assistant에서 `scene.entertain`으로 나타납니다.

Home Assistant에서 장면 작업에 대한 자세한 내용은 [Scenes component](/integrations/scene/)를 참조하십시오.

사용가능한 서비스: `scene.turn_on`.

## Switch

설정 후 스위치는 Lutron 모바일 앱에서 사용되는 이름을 기반으로 `entity_id`를 사용하여 Home Assistant에 나타납니다. 예를 들어 'Master Bathroom Vanity'라는 전등 스위치는 홈어시스턴트에 `switch.master_bathroom_vanity`로 나타납니다.

벽 및 플러그인 디머를 포함한 디밍 가능 라이트에 대해서는 이 페이지의 라이트 섹션을 참조하십시오.

Home Assistant에서 스위치 작업에 대한 자세한 내용은 [Switches component](/integrations/switch/)를 참조하십시오.

사용가능한 서비스 : `switch.turn_on`, `switch.turn_off`.

## Fan

설정 후 팬은 Lutron 모바일앱에서 사용되는 이름을 기반으로 `entity_id`를 사용하여 Home Assistant에 나타납니다. 예를 들어 'Master Bathroom Vanity'라는 전등 스위치는 홈어시스턴트에 `fan.master_bedroom_ceiling_fan`으로 나타납니다.

홈어시스턴트에서 팬 작업에 대한 자세한 정보는 [Fans component](/components/fan/)를 참조하십시오.

사용가능한 서비스: `fan.turn_on`, `fan.turn_off`, `fan.set_speed`.
