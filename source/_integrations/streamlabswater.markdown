---
title: 유량관리시스템(StreamLabs)
description: Instructions on how to integrate Streamlabs Water devices with Home Assistant.
logo: streamlabswater.png
ha_category:
  - Binary Sensor
  - Sensor
ha_release: '0.95'
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/ZkYEeiv3lHE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Streamlabs Water` 통합구성요소 플랫폼은 사용 정보를 검색하고 장치의 자리 비움 모드를 관리하기 위해 [Streamlabs water monitoring devices](https://www.streamlabswater.com/)와 상호작용하는데 사용됩니다. [Streamlabs Water API](https://developer.streamlabswater.com)는 현재 자리 비움 모드와 함께 매일, 매월 및 매년 물사용량을 검색하는데 사용됩니다.

현재 홈어시스턴트에는 다음 장치 유형이 지원됩니다.

- Binary Sensor
- Sensor

이 통합구성요소를 사용하려면 [Streamlabs API 시작하기 섹션](https://developer.streamlabswater.com/docs/getting-started.html)의 지침에 따라 API 키를 요청해야합니다. OAuth 토큰이 아닌 API 키를 요청하십시오.

## 설정

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
streamlabswater:
  api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your api_key for the Streamlabs API.
  required: true
  type: string
location_id:
  description: A specific monitor to use if you have multiple. By default the first found will be used.
  required: false
  type: string
{% endconfiguration %}

## `set_away_mode` 서비스

`streamlabswater.set_away_mode` 서비스를 사용하여 모드를 `home` 또는 `away`로 설정할 수 있습니다. 자리 비움 모드는 설정된 위치에 대해서만 변경됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `away_mode` | no | String, must be `away` or `home`.
