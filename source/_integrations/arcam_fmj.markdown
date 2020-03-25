---
title: Arcam FMJ 리시버
description: Instructions on how to integrate Arcam FMJ Receivers into Home Assistant.
logo: arcam.svg
ha_category: Media Player
ha_release: 0.96
ha_iot_class: Local Polling
ha_codeowners:
  - '@elupus'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/5cUe5ODnu5A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`arcam_fmj` 통합구성요소를 통해 Home Assistant에서 [Arcam FMJ Receveivers](https://www.arcam.co.uk/range/fmj.htm)를 제어할 수 있습니다.

지원 장치 :

- AVR 380
- AVR 450
- AVR 750
- Likely other AVRs

## 설정

Arcam FMJ를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Minimal example configuration.yaml entry
arcam_fmj:
  - host: HOSTNAME
    zone:
      1:
```

{% configuration %}
host:
  description: IP address or hostname of the device.
  required: true
  type: string
port:
  description: Port to connect to.
  required: false
  default: 50000
  type: integer
zone:
  description: Per zone specific configuration
  type: map
  keys:
    ZONE_INDEX:
      description: Zone index number.
      type: map
      keys:
        name:
          description: Name of zone
          required: false
          type: string
          default: Arcam FMJ - ZONE_INDEX
        turn_on:
          description: Service to use when turning on device when no connection is established
          required: false
          type: action
{% endconfiguration %}

```yaml
# Larger example configuration.yaml entry
media_player:
  - platform: arcam_fmj
    host: HOSTNAME
    zone:
      1:
        name: "Zone 1 name"
        turn_on:
          service: 'broadlink.send'
          data:
            host: BROADLINK_IR_IP
            packet: JgAVADodHTo6HR0dHR0dOh0dHR06Oh0dHQ0FAA==
      2:
        name: "Zone 2 name"
        turn_on:
          service: 'broadlink.send'
          data:
            host: BROADLINK_IR_IP
            packet: JgAYADodHTo6Oh0dHR0dHR0dHR06Oh0dHQALZw0FAAAAAAAAAAAAAAAAAAA=
```

## 전원 상태

Arcam FMJ 수신기는 대기상태일 때 네트워크 포트를 끄면 구성 요소가 5 초마다 수신기에 다시 연결을 시도합니다. 이는 내장 네트워크 연결을 통해 첫 번째 영역(zone)의 전원을 켤 수 없음을 의미합니다. 완벽한 전력 제어를 위한 두 가지 옵션이 있습니다. : IR 또는 Serial 게이트웨이.

### IR command

다음과 같은 discrete 코드를 사용하여 장치를 켜도록 명령을 보내려면 IR 블래스터를 사용하십시오.

 - Zone 1: Protocol: NEC1 Device: 16 Function: 123
 - Zone 2: Protocol: NEC1 Device: 23 Function: 123

### Serial 포트에서 network gateway로

네트워크를 serial 포트 게이트웨이에 사용하여 수신기의 serial 포트에 연결하십시오. serial 포트는 항상 사용 가능하며 장치의 전원을 켤 수 있습니다.
이는 가장 안정적인 통신 방법이기도합니다.
