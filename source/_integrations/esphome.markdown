---
title: ESPHome 만들기
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

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/soKuma8DJWQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[ESPHome](https://esphome.io) 장치를 통합구성요소로 사용할 시에는 [native ESPHome API](https://esphome.io/components/api.html)로 완벽하게 직접 연결되고 어떠한 상용 IOT제품보다 안정적으로 동작합니다. 

상용품의 펌웨어를 ESPHOME으로 변경해서 **더 많은 기능**을 넣을 수 있고 **로컬로 동작**하게 만들 수 있습니다. 한편 DIY 제작으로 직접 센서와 ESP칩(NodeMCU)을 구매해서 만들 경우 상용품 대비 최대 약 **10분의 1가격**에도 **신뢰도 높은 IOT기기**를 만들 수 있습니다. 

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

[HA카페 ESP 게시판](https://cafe.naver.com/ArticleList.nhn?search.clubid=29860180&search.menuid=14&search.boardtype=L)과 [ST카페 ESP 게시판](https://cafe.naver.com/ArticleList.nhn?search.clubid=29087792&search.menuid=117&search.boardtype=L)을 참조하십시오. 

## 유용한 ESPHOME 사례 

  * [5.5만원 통합실내환경 모니터 제작](https://cafe.naver.com/stsmarthome/9355) - 더니즈
  * [레고를 응용한 디자인 성능 다잡은 센서 제작](https://cafe.naver.com/koreassistant/1138) - 파르마

  * [0.6만원 보안카메라 제작](https://cafe.naver.com/stsmarthome/9612) - 민쇼 
  * [2.5만원 다기능 버튼식 3구스위치 펌웨어 변경](https://cafe.naver.com/stsmarthome/9947) - 민쇼
  * [제스처센서로 LED 스트립 제작](https://cafe.naver.com/stsmarthome/11127) - 검은별3
  * [반려동물 전용 카메라 제작](https://cafe.naver.com/stsmarthome/11740) - 검은별3 
  * [6.8만원 스마트 커튼 제작](https://cafe.naver.com/stsmarthome/13634) - 검은별3 
  * [0.6만원 1구 벽스위치 펌웨어 변경](https://cafe.naver.com/stsmarthome/12541) -민쇼 
  * [아나로그볼륨으로 원격가전음성조절기 제작](https://cafe.naver.com/stsmarthome/12756) - 민쇼
  * [1만원 RS485 월패드 제어기 제작](https://cafe.naver.com/stsmarthome/12973) - 깡스
  * [2.5만원 상용 3구스위치에 모션센서추가](https://cafe.naver.com/stsmarthome/13100) - 하얀가지
  * [변기 물내림 자동화 제작](https://cafe.naver.com/stsmarthome/13101) - 카라스테
  * [멀티플러그 스마트멀티탭 펌웨어 변경](https://cafe.naver.com/stsmarthome/13941) - 민쇼 
  * [3만원 꽃나무 자동관수시스템 펌웨어 변경](https://cafe.naver.com/koreassistant/82) - 민쇼
  * [버튼 하나로 다양한 명령 넣기](https://cafe.naver.com/koreassistant/188) - 은찬파
  * [1만원 배전반용 실시간 전력측정기 제작](https://cafe.naver.com/koreassistant/232) - 민쇼
  * [상용 LED 스트립에 디머스위치 추가](https://cafe.naver.com/koreassistant/288) - zeibis
  * [짬뽕형 센서 모듈](https://cafe.naver.com/koreassistant/830) - 검은별3
  * [Sonoff Basic 괴롭히기](https://cafe.naver.com/koreassistant/370) - 민쇼
  * [중성선 필요없는 스위치](https://cafe.naver.com/koreassistant/1316) - 민쇼 
  * [코로나19 국내 현황 모니터](https://cafe.naver.com/koreassistant/1304) - 민쇼
  * [4.2인치 실내외 날씨 예보기](https://cafe.naver.com/koreassistant/1291) - 민쇼 
  * [Scrape을 활용한 비예보 시스템](https://cafe.naver.com/koreassistant/1244) - 크리틱 
  * [현대통신 ESPHOME 월패드로 엘리베이터 호출 기능 넣기](https://cafe.naver.com/koreassistant/1227) - 준테크

## 통합 구성요소(Integrations)를 통한 기기 추가 방법 

Menu: *설정* > *통합 구성요소*

**ESPHome**을 클릭하시고 통합 구성요소 설정:

* 해당 기기의 포트와 주소를 넣으세요. 예를 들어 기기이름이 `livingroom`이면, 해당 주소는 `livingroom.local` 이 되고, 포트번호는 `6053` (default)이 됩니다.

홈어시스턴트는 기기에 접속을 시도할 겁니다. 만일 API 비밀번호를 설정하셨다면 홈어시스턴트는 비밀번호를 요청할것입니다. 그 이후에, 설정한 ESPHOME기기의 모든 entity들이 자동으로 홈어시스턴트에 나타나게 됩니다. 
