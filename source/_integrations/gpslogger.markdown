---
title: GPS로거(gpslogger)
description: Instructions on how to use GPSLogger to track devices in Home Assistant.
logo: gpslogger.png
ha_category:
  - Presence Detection
ha_release: 0.34
ha_iot_class: Cloud Push
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/bZE10qMHcXA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 통합구성요소는 [GPSLogger](https://gpslogger.app/) 와의 연동을 설정합니다. GPSLogger는 사용자가 Home Assistant에서 위치를 업데이트 할 수 있는 Android용 오픈 소스 앱입니다.

참고사항 : [네이버 HA 카페 갓북왕님 GPSlogger 설정기](https://cafe.naver.com/koreassistant/730)

## 설정 

GPSLogger를 설정하려면 설정 화면의 통합 패널을 통해 GPSLogger를 설정해야합니다. 그러면 모바일 장치 설정중 사용할 웹후크 URL이 제공됩니다 (아래).

## 스마트폰 셋업

[GPSLogger for Android](https://play.google.com/store/apps/details?id=com.mendhak.gpslogger) 를 휴대폰에 설치하십시오. 


앱을 실행시킨 후, **General Options** 으로 이동. **Start on bootup** 과 **Start on app launch** 를 활성화. 

<p class='img'>
  <img width='300' src='/images/integrations/gpslogger/settings.png' />
  GPSLogger 설정
</p>

**Logging details**으로 이동 **Log to GPX**를 사용 안함으로 설정. **Log to custom URL**를 사용.

<p class='img'>
  <img width='300' src='/images/integrations/gpslogger/logging-details.png' />
  Logging details
</p>

활성화 한 직후, 앱에서 **Log to custom URL**으로 이동.

<p class='img'>
  <img width='300' src='/images/integrations/gpslogger/custom-url.png' />
  Log to custom URL details
</p>

해당 엔드 포인트는`/api/webhook/`로 시작하고 고유한 문자 시퀀스로 끝납니다. 이는 설정 화면(위와같이)의 통합 패널에서 제공합니다.

```text
https://YOUR.DNS.HOSTNAME:PORT/api/webhook/WEBHOOK_ID
```

- **URL** 필드에 위의 URL(your.DNS.HOSTNAME:PORT를 세부사항으로 업데이트)을 추가하십시오 .
- SSL/TLS을 사용을 강력 추천합니다. 
- 인터넷에서 Home Assistant가 사용 가능한 도메인 (또는 고정 IP 주소가 있는 경우 공용 IP 주소)을 사용하십시오.  모바일 장치에서 홈네트워크로 항상 VPN을 사용하는 경우 로컬 IP 주소가 될 수 있습니다.
- Home Assistant 인스턴스가 포트 443을 사용 하는 경우 `PORT`만 제거 하십시오. 그렇지 않으면 사용중인 포트로 설정하십시오.
- 다음 **HTTP Body**를 추가하십시오.
```text
latitude=%LAT&longitude=%LON&device=%SER&accuracy=%ACC&battery=%BATT&speed=%SPD&direction=%DIR&altitude=%ALT&provider=%PROV&activity=%ACT
```
- `&device=%SER`를 `&device=SOME_DEVICE_ID`로 바꾼뒤 휴대폰의 `device_id`를 변경할 수 있습니다. 그렇지 않으면 휴대폰의 `device_id`가 사용됩니다.
- **HTTP Header** 설정에 포함되어 있는지 확인하십시오
```text
Content-Type: application/x-www-form-urlencoded
```
- **HTTP Method**가 `POST`로 변경되어 있는지 확인하십시오

배터리가 너무 빨리 소모되면 **Performance**에서 GPSLogger의 성능을 조정할 수 있습니다.

<p class='img'>
  <img width='300' src='/images/integrations/gpslogger/performance.png' />
  Performance
</p>

모든 것이 제대로 작동하는지 테스트하도록 앱의 요청을 강제할 수 있습니다.