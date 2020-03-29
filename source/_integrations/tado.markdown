---
title: 온도조절기(Tado)
description: Instructions on how to integrate Tado devices with Home Assistant.
logo: tado.png
ha_category:
  - Hub
  - Climate
  - Presence Detection
  - Sensor
ha_release: 0.41
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@michaelarnauts'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/fokYFEWo4HA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`tado` 통합구성요소 플랫폼은 [my.tado.com](https://my.tado.com/) 웹 사이트의 인터페이스로 사용됩니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Climate - for every tado zone.
- [Presence Detection](#presence-detection)
- Sensor - for some additional information of the zones.

## 설정

설치시 tado 온도조절기를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
tado:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Your username for [my.tado.com](https://my.tado.com/).
  required: true
  type: string
password:
  description: Your password for [my.tado.com](https://my.tado.com/).
  required: true
  type: string
fallback:
  description: Indicates if you want to fallback to Smart Schedule on the next Schedule change, or stay in Manual mode until you set the mode back to Auto.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

tado 온도조절기는 인터넷 연결 온도조절기입니다. [my.tado.com](https://my.tado.com/)에는 비공식 API가 있으며 이 웹사이트는 현재 해당 구성 요소에서 사용합니다.

현재 온도, 설정 온도 및 현재 작동 모드를 나타내는 것을 지원합니다. 모드 전환도 지원됩니다. 더이상 집에 사용자가 없으면 장치가 away-state를 표시합니다. away-mode로의 전환은 지원되지 않습니다.

## 재실 감지

`tado` 장치 추적기는 [Tado Smart Thermostat](https://www.tado.com/)와 지오펜싱(geofencing)을 통한 스마트폰 기반 위치 감지 지원을 사용하고 있습니다.

이 추적기는 Tado API를 사용하여 모바일 장치가 집에 있는지 확인합니다. Tado가 알고있는 가정의 모든 장치를 추적합니다.

설치에서 Tado 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry for Tado
device_tracker:
  - platform: tado
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    home_id: YOUR_HOME_ID
```

{% configuration %}
username:
  description: The username for your Tado account.
  required: true
  type: string
password:
  description: The password for your Tado account.
  required: true
  type: string
home_id:
  description: The id of your home of which you want to track devices. If provided, the Tado device tracker will tack *all* devices known to Tado associated with this home. See below how to find it.
  required: false
  type: integer
{% endconfiguration %}

설정 후, 장치는 *home* 또는 *away*로 표시되기 전에 최소한 한 번은 집에 있어야합니다.
Polling Tado Presence API는 최대 30 초마다 한 번씩 발생합니다.

추적할 사람을 설정하는 방법에 대한 지시 사항은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오. Tado (v2) API가 장치에 GPS 위치를 제공하지 않고 방향만 제공하는 Beado는 홈어시스턴트가 `home`/`not-home` 상태만 사용합니다.

### `home_id` 찾기

`https://my.tado.com/api/v2/me?username=YOUR_USERNAME&password=YOUR_PASSWORD`로 이동하여 `home_id`를 찾으십시오. 다음과 같은 것이 있을 것입니다 :

```json
{
  "name": "Mark",
  "email": "your@email.tld",
  "username": "your@email.tld",
  "homes": [
    {
      "id": 12345,
      "name": "Home Sweet Home"
    }
  ],
  "locale": "en_US",
  "mobileDevices": []
}
```

이 예에서 `12345`는 설정해야 할 `home_id`입니다.