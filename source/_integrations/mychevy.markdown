---
title: 쉐보레차량관리(myChevrolet)
description: Instructions on how to integrate Chevy Bolt car into Home Assistant.
logo: chevy.png
ha_category:
  - Car
ha_release: 0.62
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/1tVOzsOUo9o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`mychevy` 통합은 웹 사이트에서 사용하는 자바 스크립트 API (2018 년 12 월 기준)를 사용하여 [my.chevrolet] (https://my.chevrolet.com) 웹 사이트와 통신합니다. MyChevy 웹 사이트는 불안정하고 (인터페이스가 다소 변경 될 수 있음) 알려져 있으며 상당한 중단이 있습니다. 따라서이 구성 요소 사용에 주의하십시오.

이 통합구성요소는 다음 플랫폼을 제공합니다.

- Binary sensors: if the car is plugged in
- Sensors: Battery Level, Charge Mode, EST Range, Total Distance Traveled

## 설정

설치에서 MyChevy를 사용하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
mychevy:
  username: YOUR_E_MAIL_ADDRESS
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The email address associated with your my.chevrolet account.
  required: true
  type: string
password:
  description: The password for your given my.chevrolet account.
  required: true
  type: string
country:
  description: Which country's servers to contact. Supports 'us' or 'ca'.
  required: false
  default: us
  type: string
{% endconfiguration %}

### 제한사항

The architecture of the GM automotive networking imposes some limitations on the functionality of the component.

The OnStar network link is very slow, and takes 1 - 3 minutes to get information back from the car. As such the `mychevy` integration only polls every 30 minutes to not overwhelms that connection.

The OnStar network (or more specifically the gateway used by the my.chevrolet website) appears to suffer more than most networks when the car is a) in a garage, and b) it's cold outside (like < 15 degrees F). One of the provided sensors is a status sensor which indicates if we got connectivity with the car on the last polling cycle or not.

The "API" for this is written through using some existing API calls from the Javascript web user interface. As such, it only currently is known to work if you have a Chevy Bolt EV or a Chevy Volt, and only 1 Chevy car connected to OnStar. Patches for extended support should go to the [https://github.com/sdague/mychevy](https://github.com/sdague/mychevy) project first, then Home Assistant can be extended.
