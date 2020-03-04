---
title: 애플 iTunes
description: Instructions on how to integrate iTunes into Home Assistant.
logo: itunes.png
ha_category:
  - Media Player
ha_release: 0.7.3
ha_iot_class: Local Polling
---

`itunes` 미디어 플레이어 플랫폼을 사용하면 Home Assistant에서 [iTunes](https://apple.com/itunes/)를 제어 할 수 있습니다. [itunes-api](https://github.com/maddox/itunes-api)라는 Mac에서 실행하는 타사 서버를 사용합니다. Mac에서 실행되는 iTunes에서 원격으로 노래를 재생, 일시 정지 또는 건너뜁니다.

iTunes를 제어할 뿐만 아니라 사용 가능한 AirPlay 엔드 포인트도 미디어 플레이어로 추가됩니다. 그런 다음 개별적으로 주소를 지정하고 켜거나 끄거나 볼륨을 조정할 수 있습니다.

## 설정

iTunes를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: itunes
    host: 192.168.1.50
```

{% configuration %}
host:
  description: "itunes-api API의 IP (예 : 192.168.1.50)"
  required: true
  type: string
port:
  description: "itunes-api에 액세스 할 수 있는 포트 (예 : 8181)"
  required: false
  default: 8181
  type: integer
{% endconfiguration %}
