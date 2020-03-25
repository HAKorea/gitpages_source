---
title: 어웨어(Awair)
description: Instructions on how to setup Awair devices in Home Assistant.
logo: awair.jpg
ha_category:
  - Health
ha_release: 0.84
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@danielsjf'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/QLA5B0yiuMQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`awair` 센서 플랫폼은 [Awair device(s)](https://getawair.com) 데이터를 연동 시킵니다.

Awair API에 대한 액세스를 요청하고 [Developer Console](https://developer.getawair.com/)에서 액세스 토큰을 확보해야합니다 .

*Note* : Awair 제품을 **로컬로 연결하는 방식**은 HA카페의 크리틱님의 [설정기](https://cafe.naver.com/koreassistant/729)를 참조하십시오. 

## 플랫폼 설정

센서를 활성화하려면, `configuration.yaml` 파일에 다음 행을 추가 하십시오.:

```yaml
sensor:
  - platform: awair
    access_token: ACCESS_TOKEN
```

Awair API에는 엄격한 사용 할당량이 있습니다. 계정에서 기기를 검색하는 API 방법은 24 시간당 6 건으로 제한됩니다. 이 할당량을 초과한 경우 선택적으로 호출을 무시하도록 장치 정보를 설정에 추가 할 수 있습니다. :

```yaml
sensor:
  - platform: awair
    access_token: ACCESS_TOKEN
    devices:
      - uuid: UUID
```

{% configuration %}
access_token:
  description: Awair API의 액세스 토큰.
  required: true
  type: string
devices:
  description: API 검색에 의존하지 않고 수동으로 장치를 설정하기위한 선택 옵션입니다.
  required: false
  type: list
  keys:
    uuid:
      description: 모니터링할 Awair 센서의 UUID.
      required: true
      type: string
{% endconfiguration %}

## 사용 가능한 센서

플랫폼은 계정에 연결된 각 Awair 장치에서 사용 가능한 모든 센서를 가져옵니다. 지원되는 센서 :

  * Temperature
  * Humidity
  * CO2
  * VOC
  * Dust, PM2.5, PM10: varies according to Awair model

이 플랫폼은 하루 300 번의 API 호출 할당량과 설정한 장치 수에 따라 간격을 두고 갱신합니다.
