---
title: 세계항공기추적(OpenSky Network)
description: Instructions on how to integrate OpenSky Network into Home Assistant.
logo: opensky.png
ha_category:
  - Transport
ha_release: 0.43
ha_iot_class: Cloud Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/dCX298FDky4?list=PLWlpiQXaMerTyzl_Pe1PEloZTj9MoU5cl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`opensky` 센서를 사용하면 특정 지역의 비행을 추적할 수 있습니다. [OpenSky Network](https://opensky-network.org/) 공개 API의 크라우드 소싱 데이터를 사용합니다. 항공편이 정의된 지역으로 들어오고 나갈 때 홈어시스턴트 이벤트도 시작합니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
sensor:
  - platform: opensky
    radius: 10
```

OpenSky Network 센서의 설정 옵션:

- **radius** (*Required*): 모니터링 할 영역의 반경 (킬로미터).
- **latitude** (*Optional*): 지역 위도. Home zone 위도가 기본값.
- **longitude** (*Optional*): 지역 경도. Home zone 경도가 기본값.
- **altitude** (*Optional*): 비행기를 감지 할 수있는 최대 고도 (미터), 0은 무제한입니다. 기본값은 0입니다.
- **name** (*Optional*): 센서 이름. 기본적값은 opensky.

## 이벤트

- **opensky_entry**: 비행이 지역에 들어 오면 시작.
- **opensky_exit**: 비행기가 지역을 나가면 시작.

두 이벤트 모두 세 가지 속성이 있습니다. 

- **sensor**: 이벤트를 시작한 `opensky` 센서의 이름
- **callsign**: 비행기의 Callsign.
- **altitude**: 미터 단위의 비행 고도.

[Home Assistant Companion App](https://companion.home-assistant.io/)을 사용하여 비행기에 대한 알림을 받으려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

{% raw %}
```yaml
automation:
  - alias: 'Flight entry notification'
    trigger:
      platform: event
      event_type: opensky_entry
    action:
      service: notify.mobile_app_<device_name>
      data_template:
        message : 'Flight entry of {{ trigger.event.data.callsign }} '
```
{% endraw %}
