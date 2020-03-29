---
title: 필립스 다이나라이트(Philips Dynalite)
description: Instructions on setting up Philips Dynalite within Home Assistant.
logo: dynalite.png
ha_category:
  - Hub
  - Light
ha_iot_class: Local Push
ha_release: 0.106
ha_codeowners:
  - '@ziv1234'
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/odgOY0Rt1sE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Philips Dynalite 지원은 라이트 플랫폼을 구동할 수있는 허브로 Home Assistant에 준비되어 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Lights

Philips Dynalite 허브는 areas, channels, 그리고 preset으로 구성된 Dynet 네트워크에 연결됩니다.

Dynalite area는 일반적으로 (필수는 아니지만) 방과 같은 물리적 영역을 정의합니다.

각 area에는 제어하는 ​​다른 장치에 해당하는 하나 이상의 채널이있을 수 있습니다. 채널은 조광(dimmable) 가능한 조명 또는 커버(Cover)와 같은 기타 장치와 관련될 수 있습니다.

또한 각 area에는 모든 채널의 동작을 결정하고 때로는 추가 작업을 트리거하는 하나 이상의 preset이 있을 수 있습니다. 일반적으로 area의 preset 1은 `on`을 의미하고 preset '4'는 `off`를 의미합니다. scenes과 조광(dimming)에 추가 preset을 사용할 수 있습니다.

## 설정

필립스 Dynalite에는 자동 검색 기능이 없으므로 `configuration.yaml` 파일을 통해 설정해야합니다.

```yaml
# Example configuration.yaml entry
dynalite:
  bridges:
    - host: DEVICE_IP_ADDRESS
```

{% configuration %}
host:
  description: "브리지의 IP 주소 (예 : 192.168.1.10)"
  required: true
  type: string
port:
  description: 브릿지의 포트 번호.
  required: false
  type: integer
  default: 12345
name:
  description: 브릿지의 이름.
  required: false
  type: string
  default: dynalite
active:
  description: "적극적으로 네트워크를 쿼리합니다. 시작시 모든 장치의 현재 상태를 쿼리하고 일부 변경이 진행 중일 때 (예: 조명이 어두워 지거나 이동하는 경우) 쿼리를 보냅니다. 많은 처리를 하긴하겠지만, Dynalite 네트워크에 더 많은 부하가 발생합니다."
  required: false
  type: boolean
  default: false
polltimer:
  description: "transition 중인 장치의 폴링 간격. 초 단위의 값입니다. 장치가 transition 중인 경우 (예: 조명 페이딩) 목표 레벨에 도달 할 때까지 X 초마다 새로운 상태를 요청합니다. 활성화 된 경우에만 관련이 있습니다."
  required: false
  type: float
  default: 1.0
autodiscover:
  description: 자동 검색을 활성화합니다. Dynalite는 자동 검색을 지원하지 않으므로 네트워크의 이벤트를 추적하므로 조명을 켜면 홈어시스턴트에 추가됩니다.
  required: false
  type: boolean
  default: false
default:
  description: 시스템의 전역 기본값
  required: false
  type: map
  keys:
    fade:
      description: Default fade
      required: false
      type: float
area:
  description: 다양한 Dynalite area에 대한 정의.
  required: true
  type: map
  keys:
    'AREA_NUMBER':
      description: Dynalite area 번호, 1-255
      required: true
      type: map
      keys:
        name:
          description: area의 이름.
          required: true
          type: string
        fade:
          description: 해당 area의 페이드 시간 (초)입니다.
          required: false
          type: float
          default: 2.0
        channel:
          description: 이 area의 채널지도.
          required: false
          type: map
          keys:
            'CHANNEL_NUMBER':
              description: 해당 area의 Dynalite 채널 번호 1-255
              required: true
              type: map
              keys:
                name:
                  description: 채널 이름
                  required: false
                  type: string
                  default: \"AREA_NAME Channel CHANNEL_NUMBER\"
                fade:
                  description: 채널의 페이드 시간 (초)입니다.
                  required: false
                  type: float
                  default: 2.0
{% endconfiguration %}

## 사례 

```yaml
# Example configuration.yaml entry specifying optional parameters
dynalite:
  bridges:
    - host: DEVICE_IP_ADDRESS
      port: 12345
      autodiscover: true
      polltimer: 1
      areacreate: auto
      log_level: debug
      area:
        '2':
          name: Living Room
          channel:
            '2': 
              name: Entrance Spot
              fade: 10.0
            '3': 
              name: Dining Table
```

## 초기 설정 및 검색

Dynalite 시스템에서 가장 어려운 점은 area와 채널 매핑을 찾는 것입니다. 소프트웨어가 있거나 Dynalite 소프트웨어 및 설정 파일에 액세스할 수 있으면 이 작업이 쉬울 수 있지만 시스템이 사업자에 의해 설치되었을 가능성이 있는 경우 직접 찾아야합니다.

여기서 `autodiscover` 옵션이 유용합니다. 켜져 있으면 구성 요소가 Dynet 네트워크를 추적하고 장치를 사용할 때마다 홈어시스턴트에 추가됩니다. 처음에는 "Area 123 Channel 7"로 표시되지만 자신에 맞는 설정으로 `configuration.yaml`에 추가할 수 있습니다.

예를 들어, 주방 조명으로 가서 켜십시오. 이제 홈어시스턴트로 로그인하여 채널이 무엇인지 확인하십시오. 둘 이상이 발견 된 경우 (예: 누군가 거실 조명 끄기) 홈어시스턴트에서 조명을 켜고 끄고 어떤 조명이 영향을 받는지 확인할 수 있습니다.

초기 프로세스는 시간이 많이 걸리고 지루할 수 있지만 한번만 수행하면됩니다. 시스템이 내부 통신에 사용하는 많은 "fake" 채널 및 영역(area)이 있으며 사용자가 보지 않기를 원하기 때문에 설정이 끝나면 자동 검색을 false로 설정하는 것이 좋습니다.