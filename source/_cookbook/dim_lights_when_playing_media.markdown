---
title: "미디어를 재생할 때 조명을 희미하게"
description: "Dim lights up or down when playing media"
ha_category: Automation Examples
---

영화관에서 조명이 어두워지는 방식처럼 집에서도 적용해보십시오!

이 예에서는 [media player](/integrations/media_player/), [lights](/integrations/light/) (transitions), [sun](/integrations/sun/) 통합구성요소를 사용합니다. 미디어 플레이어 상태 변화와 [scenes](/integrations/scene/)을 감지하여 여러 조명과 씬(scene)간의 transition을 제어하는 ​​작업을 사용합니다.

#### 씬 (Scenes)
일반 조명의 경우 한 씬, 영화가 켜졌을 때의 씬. 2초 전환은 스위치에 좋은 '느낌'을 줍니다.

```yaml
scene:
  - name: Livingroom normal
    entities:
        light.light1:
            state: on
            transition: 2
            brightness_pct: 60
        light.light2:
            state: on
            transition: 2
            brightness_pct: 85
  - name: Livingroom dim
    entities:
        light.light1:
            state: on
            transition: 2
            brightness_pct: 30
        light.light2:
            state: on
            transition: 2
            brightness_pct: 55
```


#### 자동화
일시중지/중지 상태는 "from: 'playing'"을 사용하는 것이 가장 좋습니다. 보통 어두울 때만 동작하기 원하기때문에 태양(sun)을 상태에 추가합니다. 

```yaml
automation:
  - alias: "Media player paused/stopped"
    trigger:
      - platform: state
        entity_id: media_player.htpc
        from: 'playing'
        to: 'idle'
    condition:
      - condition: state
        entity_id: sun.sun
        state: 'below_horizon'
    action:
        service: scene.turn_on
        entity_id: scene.livingroom_normal

  - alias: "Media player playing"
    trigger:
      - platform: state
        entity_id: media_player.htpc
        to: 'playing'
        from: 'idle'
    condition:
      - condition: state
        entity_id: sun.sun
        state: 'below_horizon'
    action:
        service: scene.turn_on
        entity_id: scene.livingroom_dim
```

