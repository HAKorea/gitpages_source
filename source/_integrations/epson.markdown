---
title: 엡슨(Epson)
description: Instructions on how to integrate Epson projector into Home Assistant.
logo: epson.png
ha_category:
  - Media Player
ha_release: 0.72
ha_iot_class: Local Polling
---

Assistant.
이 `epson` 플랫폼을 사용하면 Home Assistant에서 Epson 프로젝터를 제어할 수 있습니다.

add the following to your `configuration.yaml` file:
Epson을 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오. : 

```yaml
# Example configuration.yaml entry
media_player:
  - platform: epson
    host: 192.168.0.123
```

{% configuration %}
host:
  description: Epson 프로젝터의 호스트 이름 또는 주소
  required: true
  type: string
port:
  description: HTTP 포트 번호
  required: false
  type: integer
  default: 80
name:
  description: 프런트 엔드에 사용된 장치의 이름
  required: false
  type: string
  default: 'EPSON Projector'
ssl:
  description: "SSL을 활성화. **Feature not tested.**"
  required: false
  type: boolean
  default: false
{% endconfiguration %}

Epson 프로젝터의 지원되는 기능:

- 켜고 끄기
- 입력 설정
- 설정 / 색상 모드
- 볼륨 증가 / 감소
- 음소거 / 음소거 해제
- 다음 / 이전 트랙 전송

지원되는 장치:
- ESC / VP21 프로토콜을 지원하는 Epson 프로젝터.

테스트 된 장치 :
- Epson EH-TW5350

이 모듈을 작동 시키려면 프로젝터를 LAN에 연결해야합니다. Epson의 iProjection앱을 사용하여 작동하는지 테스트하는 것이 가장 좋습니다.
