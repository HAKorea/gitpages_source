---
title: 마인크래프트 서버(Minecraft Server)
description: Instructions on how to integrate a Minecraft server into Home Assistant.
logo: minecraft.png
ha_release: 0.106
ha_category:
  - Binary Sensor
  - Sensor
ha_iot_class: Local Polling
ha_quality_scale: silver
ha_config_flow: true
ha_codeowners:
  - '@elmurato'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/eUZLqgVF7tk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Minecraft 서버를 통해 플레이어는 온라인 또는 다른 플레이어와의 로컬 네트워크를 통해 [Mojang AB](https://www.mojang.com)의 샌드 박스 비디오 게임 [Minecraft](https://www.minecraft.net)을 재생할 수 있습니다. `Minecraft Server` 통합구성요소를 통해 Home Assistant 내의 Minecraft 서버 (Java 에디션)에서 정보를 검색 할 수 있습니다.

<div class='note'>
이전 버전은 정보를 공개하지 않으므로 서버 버전은 1.7 이상이어야합니다
</div>

## 프론트엔드를 경유한 설정

설정에서 `통합구성요소`로 이동하여 `+`기호를 클릭하고 통합구성요소를 추가하고 **Minecraft Server**를 클릭하십시오. 설정 절차가 완료하면 Minecraft Server 연동을 사용할 수 있습니다.

## Binary sensors

이 통합구성요소는 Minecraft 서버에서 다음 정보에 대한 이진 센서를 제공합니다.

- 연결 상태

## Sensors

이 통합구성요소는 Minecraft 서버에서 다음 정보에 대한 센서를 제공합니다.

- Latency time
- Version
- Protocol version
- Number of online players (player names are available in state attributes)
- Number of maximum players
