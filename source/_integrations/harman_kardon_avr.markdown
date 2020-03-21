---
title: 하만 카돈(Harman Kardon AVR)
description: Instructions on how to integrate Harman Kardon AVR Network Receivers into Home Assistant.
logo: harman_kardon.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.85
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/SAI-suh2aCY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`harman_kardon_avr` 플랫폼을 사용하면 Home Assistant에서 Harman Kardon 네트워크 수신기를 제어 할 수 있습니다.

지원되는 장치 :

- Harman Kardon AVR-151S
- Other Harman Kardon AVR receivers (untested)

Harman Kardon 네트워크 수신기를 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: harman_kardon_avr
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: "장치의 IP 주소 (예 : 192.168.1.32)"
  required: true
  type: string
name:
  description: 장치 이름 설정하지 않으면 Harman Kardon AVR이 사용됩니다.
  required: false
  default: Harman Kardon AVR
  type: string
port:
  description: 수신자와 통신 할 포트입니다. 설정하지 않으면 10025가 사용됩니다.
  required: false
  default: 10025
  type: integer
{% endconfiguration %}

몇 가지 참고 사항 :

 - 최신 펌웨어는 일정 시간이 지나면 AVR을 자동으로 종료합니다. 그러면 네트워크에서 AVR을 더 이상 사용할 수 없으므로 'on' 명령이 작동하지 않습니다.
 - AVR에는 볼륨, 음소거, 재생 등을 결정하는 엔드 포인트가 없으므로 리모콘을 사용하는 경우 HA는 장치의 새로운 상태를 알 수 없습니다.
