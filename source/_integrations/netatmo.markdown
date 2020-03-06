---
title: 네타모(Netatmo)
description: Instructions on how to integrate Netatmo integration into Home Assistant.
logo: netatmo.png
ha_category:
  - Hub
  - Environment
  - Weather
  - Binary Sensor
  - Sensor
  - Climate
  - Camera
ha_release: '0.20'
ha_iot_class: Cloud Polling
---

`netatmo` 통합 플랫폼은 모든 Netatmo 관련 플랫폼을 연동하는 주요 통합구성요소입니다.

현재 홈 어시스턴트에는 다음 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Camera](#camera)
- [Climate](#climate)
- [Sensor](#sensor)

## 설정

Netatmo 구성 요소를 활성화하려면 `configuration.yaml`에 다음 행을 추가하십시오.

```yaml
# Example configuration.yaml entry
netatmo:
  client_id: YOUR_CLIENT_ID
  client_secret: YOUR_CLIENT_SECRET
```

{% configuration %}
client_id:
  description: The `client id` from your Netatmo app.
  required: true
  type: string
client_secret:
  description: The `client secret` from your Netatmo app.
  required: true
  type: integer
{% endconfiguration %}

일단 설정되면 통합구성요소 페이지에서 이를 사용할 수 있습니다.

### API 와 Secret Key 받기 

API 자격 증명을 얻으려면 [Netatmo Developer Page](https://dev.netatmo.com/)에서 새 응용 프로그램을 선언해야합니다. 일반 Netatmo 계정에서 사용자 이름과 비밀번호를 사용하여 로그인하십시오. 
[app creator](https://dev.netatmo.com/apps/createanapp#form) 양식을 여십시오.

<p class='img'>
<img src='/images/screenshots/netatmo_create.png' />
</p>
양식을 작성해야하지만 두 개의 필드 만 필요합니다 : 이름과 설명. 무엇을 넣었는지는 중요하지 않습니다. 당신에게 맞는 것을 쓰십시오. 새 앱을 제출하려면 양식 하단에서 작성(create)을 클릭하십시오.

<p class='img'>
<img src='/images/screenshots/netatmo_app.png' />
</p>

설정 예에서 위에 설명한대로 홈어시스턴트 설정 파일에 새 `client id` 및 `client id`을 복사하여 붙여넣을 수 있습니다.

<p class='img'>
<img src='/images/screenshots/netatmo_api.png' />
</p>

## Binary Sensor

이 연동을 통해 카메라에서 가장 최신 이벤트를 볼 수 있습니다.

여러 대의 카메라를 사용할 수 있는 경우 모니터링 되는 각 조건은 각 카메라에 대한 특정 센서를 생성합니다

## Camera

`netatmo` 카메라 플랫폼은 [Netatmo](https://www.netatmo.com) 카메라가 제공하는 정보를 사용하고 있습니다. 
이 연동을 통해 카메라에서 생성한 현재 라이브 스트림을 볼 수 있습니다.

## Climate

`netatmo` 온도 조절기 플랫폼은 [Netatmo Smart Thermostat](https://www.netatmo.com/product/energy/thermostat) 온도 조절기에서 제공하는 정보를 사용합니다. 이 연동을 통해 현재 온도 및 설정지점(setpoint)을 볼 수 있습니다.

## Sensor

`netatmo` 센서 플랫폼은 [Netatmo Weather Station](https://www.netatmo.com/en-us/weather/weatherstation) 또는 [Netatmo Home Coach](https://www.netatmo.com/en-us/aircare/homecoach), [Netatmo](https://www.netatmo.com) 장치에서 제공하는 정보를 사용합니다.