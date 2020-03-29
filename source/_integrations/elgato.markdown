---
title: 엘가토 Key Light(Elgato Key Light)
description: Instructions on how to integrate an Elgato Key Light with Home Assistant.
logo: elgato.jpg
ha_category:
  - Light
ha_release: 0.104
ha_iot_class: Local Polling
ha_qa_scale: platinum
ha_config_flow: true
ha_codeowners:
  - '@frenck'
ha_quality_scale: platinum
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/OkZHgBS_ZLU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Elgato Key Light](https://www.elgato.com/en/gaming/key-light)는 고급 스튜디오 조명의 기준을 제시합니다. 80 개의 LED를 사용하면 2500 루멘을 대량으로 방출할 수 있으며 색온도도 변경할 수 있습니다.

LED 조명 패널은 특별히 제작되었으며 스트리머 및 콘텐츠 제작자를 위해 설계되었으며 대부분 YouTube 및 Twitch와 같은 플랫폼에서 운영해서 많이들 쓰고 있습니다.

## 설정

이 장치는 Home Assistant 프론트 엔드의 통합구성요소를 사용하여 설정할 수 있습니다.

메뉴: **설정** -> **통합구성요소**.

대부분의 경우 Elgato Key Lights 장치는 Home Assistant에서 자동으로 검색합니다. 자동 검색된 장치는 통합구성요소 페이지에 나열됩니다.

어떤 이유로 (예: 네트워크에서 mDNS 지원 부족으로 인해) Elgato Key Light가 검색되지 않으면 수동으로 추가할 수 있습니다.

`+` 부호를 클릭하여 통합구성요소를 추가하고 **Elgato Key Light**를 클릭하십시오. 설정 절차를 완료하면 Key Light 통합구성요소를 사용할 수 있습니다.

## 조명

이 통합구성요소로 Key Assistant 장치가 Home Assistant의 조명으로 추가되고 색온도, 밝기 및 켜짐/꺼짐 상태를 제어할 수 있습니다.