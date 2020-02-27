---
title: ESPHome
description: Support for ESPHome devices using the native ESPHome API.
featured: true
logo: esphome.png
ha_category:
  - DIY
ha_release: 0.85
ha_iot_class: Local Push
ha_config_flow: true
ha_codeowners:
  - '@OttoWinter'
---

[ESPHome](https://esphome.io) 장치를 통합구성요소로 사용할 시에는 [native ESPHome API](https://esphome.io/components/api.html)로 완벽하게 직접 연결됩니다. 

### ESPHOME의 특징 ### 
  
[ESPHOME의 장점과 단점 그리고 가능성](https://cafe.naver.com/koreassistant/332)


### HA 네이버 카페 더니즈님의 ESPHOME 강좌 ###

  1. [ESPHome 설치하기](https://cafe.naver.com/koreassistant/754)
  2. [ESP32, ESP8266과 보드 타입 찾아보기](https://cafe.naver.com/koreassistant/755)
  3. [BUS를 이해하고 PIN 연결하기](https://cafe.naver.com/koreassistant/756)
  4. [기본 설정 및 센서 구성하기](https://cafe.naver.com/koreassistant/757)
  5. [필수 구문 이해하기](https://cafe.naver.com/koreassistant/758)
  6. [Homeassistant와 통합하기](https://cafe.naver.com/koreassistant/759)
  7. [멀티센서 만들기 Part 1](https://cafe.naver.com/koreassistant/760)
  8. [멀티센서 만들기 Part 2](https://cafe.naver.com/koreassistant/761)
  9. [멀티센서 만들기 Part 3](https://cafe.naver.com/koreassistant/762)
  10. [Nextion 이해하기](https://cafe.naver.com/koreassistant/763)


### Tuya Convert로 펌웨어 변경하기 ###

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/dt5-iZc4_qU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

### ESPHOME 활용 사례 ###

[HA 네이버 카페 ESPHOME 게시판](https://cafe.naver.com/ArticleList.nhn?search.clubid=29860180&search.menuid=14&search.boardtype=L)
 

## 통합 구성요소(Integrations)를 통한 기기 추가 방법 

Menu: *설정* > *통합 구성요소*

**ESPHome**을 클릭하시고 통합 구성요소 설정:

* 해당 기기의 포트와 주소를 넣으세요. 예를 들어 기기이름이 `livingroom`이면, 해당 주소는 `livingroom.local` 이 되고, 포트번호는 `6053` (default)이 됩니다.

홈어시스턴트는 기기에 접속을 시도할 겁니다. 만일 API 비밀번호를 설정하셨다면 홈어시스턴트는 비밀번호를 요청할것입니다. 그 이후에, 설정한 ESPHOME기기의 모든 entity들이 자동으로 홈어시스턴트에 나타나게 됩니다. 
