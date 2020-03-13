---
title: 고급오디오(KEF)
description: Instructions on how to integrate KEF Speakers into Home Assistant.
logo: kef.png
ha_category:
  - Media Player
ha_iot_class: Local Polling
ha_release: 0.104
ha_codeowners:
  - '@basnijholt'
---

`kef` 플랫폼을 사용하면 Home Assistant에서 [KEF LS50 Wireless](https://international.kef.com/products/ls50-wireless) 및 [KEF LSX](https://international.kef.com/products/lsx) 스피커를 제어 할 수 있습니다.

지원 장치 :

- KEF LS50 Wireless
- KEF LSX

KEF 스피커를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

## 설정

```yaml
# Example configuration.yaml entry
media_player:
 - platform: kef
   host: IP_ADDRESS
   type: LS50
```

{% configuration %}
host:
  description: "장치의 IP 주소 예: 192.168.1.32"
  required: true
  type: string
type:
  description: 스피커 유형. `LS50` 혹은 `LSX`.
  required: true
  type: string
name:
  description: 장치의 이름
  required: false
  default: KEF
  type: string
port:
  description: 장치의 포트
  required: false
  default: 50001
  type: integer
maximum_volume:
  description: 허용되는 최대 볼륨. 0과 1 사이의 숫자.
  required: false
  default: 0.5
  type: float
volume_step:
  description: 볼륨을 높일 때의 볼륨 단계.
  required: false
  default: 0.05
  type: float
inverse_speaker_mode:
  description: 채널을 L/R에서 R/L로 전환.
  required: false
  default: false
  type: boolean
standby_time:
  description: "`20` 또는 `60` 분 후에 스피커가 자동으로 대기 모드로 전환됩니다. 스피커가 대기 모드로 들어가지 않도록하십시오."
  required: false
  type: integer
supports_on:
  description: LS50W13074K24L/R2G 미만의 일련 번호를 가진 LS50 무선은 네트워크를 통한 스피커 켜기를 지원하지 않습니다. 구형 모델 인 경우 이 값을 false로 설정하십시오.
  default: true
  required: false
  type: integer
{% endconfiguration %}

## 고급 설정의 예

```yaml
# Example configuration.yaml entry
media_player:
 - platform: kef
   host: IP_ADDRESS
   type: LS50
   name: My KEF speakers
   maximum_volume: 0.6
   volume_step: 0.05
```

Notes:

- LS50 Wireless는 19-11-2019의 최신 펌웨어 :`p6.3001902221.105039422` 및 이전 펌웨어: `p6.2101809171.105039422`로 테스트되었습니다.
- LSX Wireless는 2019 년 10 월 10 일 v4.1의 최신 펌웨어로 테스트되었습니다 : `p20.4101909240.105243`

[KEF Speakers]: /integrations/kef/
