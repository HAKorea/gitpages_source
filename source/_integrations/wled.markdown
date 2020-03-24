---
title: LED 스트립(WLED)
description: Instructions on how to integrate WLED with Home Assistant.
logo: wled.png
ha_category:
  - Light
  - Sensor
  - Switch
ha_release: 0.102
ha_iot_class: Local Polling
ha_config_flow: true
ha_quality_scale: platinum
ha_codeowners:
  - '@frenck'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/GLtzCijDUbw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[WLED](https://github.com/Aircoookie/WLED)는 NeoPixel (WS2812B, WS2811, SK6812, APA102 등) LED를 제어할 수 있는  빠르고 기능이 풍부한 ESP8266 / ESP32 웹서버 구현 장치입니다.

## 설정

이 통합구성요소는 Home Assistant 프론트 엔드의 연동을 사용하여 설정할 수 있습니다.

Menu: **설정** -> **통합구성요소**.

대부분의 경우 WLED 장치는 Home Assistant에서 자동으로 검색합니다. 자동 검색된 LED 장치는 통합구성요소 페이지에 표시됩니다.

어떤 이유로 (예 : 네트워크에서 mDNS 지원 부족으로 인해) WLED 장치가 검색되지 않으면 수동으로 추가 할 수 있습니다.

`+` 부호를 클릭하여 통합구성요소를 추가하고 **WLED**를 클릭하십시오. 설정 단계를 완료하면 WLED 통합구성요소를 사용할 수 있습니다.

## 조명 

이 통합구성요소로 WLED 장치가 Home Assistant의 조명으로 추가됩니다. 홈어시스턴트는 LED 스트립의 모든 세그먼트를 별도의 조명 개체로 취급합니다.

Home Assistant에서 조명의 기본 지원 기능 만 지원됩니다 (효과 포함).

## 센서	

이 통합구성요소는 WLED의 다음 정보에 대한 센서를 제공합니다.

- 예상 전류.
- 가동 시간.
- 사용 가능한 메모리

## 스위치

이 통합구성요소는 많은 스위치를 생성합니다 :

- Nightlight.
- Sync Receive.
- Sync Send.

## 서비스

이 통합구성요소는 현재 추가 서비스를 제공하지 않습니다.
