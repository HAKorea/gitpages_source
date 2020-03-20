---
title: 데논 Network Receivers
description: Instructions on how to integrate Denon Network Receivers into Home Assistant.
logo: denon.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.7.2
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/jZInNxclqsU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`denon` 플랫폼을 사용하면 Home Assistant에서 [Denon Network Receivers](https://www.denon.co.uk/chg/product/compactsystems/networkmusicsystems/ceolpiccolo)를 제어할 수 있습니다. 장치가 [Denon AVR] 플랫폼에서 지원될 수 있습니다.

지원되는 장치 :

- Denon DRA-N5
- Denon RCD-N8 (untested)
- Denon RCD-N9 (partial support)
- Denon AVR receivers with integrated Network support (partial support)

Denon Network Receiver를 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

## Telnet 플랫폼

```yaml
# Example configuration.yaml entry
media_player:
  - platform: denon
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: "장치의 IP 주소. 예 : 192.168.1.32"
  required: true
  type: string
name:
  description: 장치의 이름
  required: false
  type: string
{% endconfiguration %}

플랫폼에 대한 몇 가지 참고 사항 : denon

- 수신기는 하나의 텔넷 연결 만 처리하고 다른 텔넷 연결은 거부.
- 음량에 주의하십시오. 100 % 또는 50 % 조차도 매우 소리가 큽니다.
- 수신기를 깨울수 있으려면 수신기 설정에서 "remote" 설정을 활성화하십시오.
- 재생 및 일시 정지가 지원되며, 토글링은 불가능합니다. 
- UI가 절대 위치를 전송하므로 Seeking을 구현할 수 없습니다. 시뮬레이션 된 버튼 누름을 통한 탐색 만 가능합니다.

[Denon AVR]: /integrations/denonavr/
