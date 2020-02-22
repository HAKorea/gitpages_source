---
title: "ManyThing을 이용하여 남는스마트폰 CCTV카메라로 만들기"
description: "Instructions on how to setup ManyThing support with IFTTT."
logo: manything.png
ha_category: Camera
redirect_from:
  /integrations/ifttt.manything/
---

[Manything](https://manything.com) 은 집, 애완 동물 등을 모니터링하기 위해 Android 기기, iPhone, iPod 또는 iPad를 WiFi 카메라로 바꾸는 스마트 앱입니다! 라이브 스트리밍, 모션 활성화 경고, 클라우드 비디오 녹화 등이 제공됩니다.

많은 지원을 받기 위해 HA는  [Webhooks Service](https://ifttt.com/maker_webhooks) 및 [ManyThing Service](https://ifttt.com/manything) 서비스를 사용 합니다. [IFTTT Setup instructions](/integrations/ifttt/)를 사용하여 IFTTT 플랫폼을 활성화합니다.

IFTTT, Maker Service 및 ManyThing Service를 설정 한 후 다음 예를 사용하여 Home Assistant에 설정 할 수 있습니다.

```yaml
# Example configuration.yaml entry
automation:
  - alias: 'ManyThing Recording ON'
    # This calls an IFTTT recipe to turn on recording of the ManyThing Camera
    # if we leave the house during the day.
    trigger:
      - platform: state
        entity_id: all
        to: 'not_home'
    condition:
      - platform: state
        entity_id: sun.sun
        state: 'above_horizon'
    action:
      service: ifttt.trigger
      data: {"event":"manything_on"}

  - alias: 'ManyThing Recording OFF'
    # This calls an IFTTT recipe to turn off recording of the ManyThing Camera
    # when we get home unless it's nighttime.
    trigger:
      - platform: state
        entity_id: all
        to: 'home'
    condition:
      - condition: state
        entity_id: sun.sun
        state: 'above_horizon'
    action:
      service: ifttt.trigger
      data: {"event":"manything_off"}
```

### 레시피 설정 

<p class='img'>
<img src='/images/integrations/ifttt/IFTTT_manything_trigger.png' />
IFTTT로 보낸 각 이벤트에 대해 고유한 트리거를 설정해야합니다.
ManyThing을 지원하려면 'on'및 'off'이벤트를 설정해야합니다.
</p>

### 트리거 테스트하기 

개발자 도구를 사용하여 [Maker Service](https://ifttt.com/maker_webhooks) 트리거를 테스트 할 수 있습니다. 이렇게 하려면 Home Assistant UI를 열고 사이드 바를 열고 개발자 도구에서 첫 번째 아이콘을 클릭하십시오. 'Call Service'화면이 나타납니다. 다음 값을 입력하십시오.

| Field        | Value                       |
| ------------ | --------------------------- |
| domain       | `ifttt`                     |
| service      | `trigger`                   |
| Service Data | `{"event": "manything_on"}` |

