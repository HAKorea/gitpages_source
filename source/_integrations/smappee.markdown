---
title: 스매피(Smappee)
description: Instructions on how to setup Smappee within Home Assistant.
logo: smappee.png
ha_release: 0.64
ha_category:
  - Hub
  - Energy
  - Sensor
  - Switch
ha_iot_class: Local Push
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/ewIIZ4f2iMk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`smappee` 통합구성요소는 에너지 모니터링 및 Comport 플러그 스위치를 위한 [Smappee](https://www.smappee.com/) 컨트롤러에 대한 지원을 추가합니다.

현재 홈어시스턴트에는 다음 장치 유형이 지원됩니다.

- Sensor
- Switch

Smappee 컨트롤러에 연결하면 자동으로 추가됩니다.

smappee 통합구성요소는 [Smappee API](https://smappee.atlassian.net/wiki/spaces/DEVAPI/overview)에서 정보를 얻습니다. 참고: 클라우드 API는 이제 Smappee Energy/Solar의 경우 월 €2.50 또는 Smappee Plus의 경우 월 €3의 구독 요금이 필요합니다.

## 설정

API 액세스를 얻는 방법에 대한 정보는 [smappy wiki](https://github.com/EnergieID/smappy/wiki)에 설명되어 있습니다.

설치에서 `smappee` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
smappee:
  host: 10.0.0.5
  client_id: YOUR_CLIENT_ID
  client_secret: YOUR_CLIENT_SECRET
  username: YOUR_MYSMAPPEE_USERNAME
  password: YOUR_MYSMAPPEE_PASSWORD
```

```yaml
# Minimal example configuration.yaml entry
smappee:
  host: 10.0.0.5
```

```yaml
# Cloud only example configuration.yaml entry
smappee:
  client_id: YOUR_CLIENT_ID
  client_secret: YOUR_CLIENT_SECRET
  username: YOUR_MYSMAPPEE_USERNAME
  password: YOUR_MYSMAPPEE_PASSWORD
```

{% configuration %}
host:
  description: Your Local Smappee unit IP.
  required: false
  type: string
host_password:
  description: Your Local Smappee password.
  required: false
  type: string
client_id:
  description: Your Smappee API client ID.
  required: false
  type: string
client_secret:
  description: Your Smappee API client secret.
  required: false
  type: string
username:
  description: Your My Smappee username.
  required: false
  type: string
password:
  description: Your My Smappee password.
  required: false
  type: string
{% endconfiguration %}
