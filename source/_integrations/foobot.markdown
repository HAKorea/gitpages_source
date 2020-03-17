---
title: 공기측정기(Foobot)
description: Instructions on how to setup Foobot Air Quality sensor in Home Assistant.
logo: foobot.png
ha_category:
  - Health
ha_release: 0.66
ha_iot_class: Cloud Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/DCuYVf1ii3A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`foobot` 센서 플랫폼은 [Foobot device(s)](https://foobot.io/features/)에서 공기측정 데이터를 가져옵니다

이 센서에는 API 토큰이 필요합니다. [Foobot API 사이트](https://api.foobot.io/apidoc/index.html)에서 구하십시오.

## 플랫폼 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
sensor:
  - platform: foobot
    token: FOOBOT_SECRET_KEY
    username: FOOBOT_USERNAME
```

{% configuration %}
  token:
    description: Foobot API의 토큰
    required: true
    type: string
  username:
    description: 계정과 연결된 기기를 가져 오는데 사용되는 Foobot 사용자 이름.
    required: true
    type: string
{% endconfiguration %}

## 사용가능한 지표

10 분마다 다음 측정 값의 마지막 10 분 평균을 가져옵니다.

  * Temperature
  * Humidity
  * Co2
  * VOC
  * PM2.5
  * [Index](https://help.foobot.io/hc/en-us/articles/204814371-What-does-central-number-mean-)
