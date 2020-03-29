---
title: 승차공유(Lyft)
description: How to integrate Lyft in Home Assistant
logo: lyft.png
ha_category:
  - Transport
ha_iot_class: Cloud Polling
ha_release: 0.41
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/WauRZJ5vnzk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`lyft` 센서는 주어진 `start_latitude`와 `start_longitude`에서 사용 가능한 모든 [Lyft](https://lyft.com)에 대한 시간과 가격 추정치를 제공합니다. `ATTRIBUTES`는 차량 용량과 운임과 같은 서비스에 대한 추가 정보를 제공하는데 사용됩니다. `end_latitude`와 `end_longitude`가 지정되면 가격 추정치도 제공됩니다. 주어진 `start` 위치에서 픽업시간 동안 각 서비스에 대해 하나의 센서가 생성됩니다. 목적지가 지정되면 예상 가격에 대해 각 서비스에 대한 두 번째 센서가 작성됩니다. 센서는 공식 Lyft [API](https://developer.lyft.com/reference/)에 의해 구동됩니다.


`client_id`와 `client_secret`을 얻으려면 [여기](https://www.lyft.com/developers/manage) 응용 프로그램을 생성해야합니다.

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: lyft
    client_id: CLIENT_ID
    client_secret: CLIENT_SECRET
```

{% configuration %}
client_id:
  description: "A client id obtained from [developer.lyft.com](https://developer.lyft.com) after [creating an app](https://www.lyft.com/developers/manage)."
  required: true
  type: string
client_secret:
  description: "A client secret obtained from [developer.lyft.com](https://developer.lyft.com) after [creating an app](https://www.lyft.com/developers/manage)."
  required: true
  type: string
start_latitude:
  description: The starting latitude for a trip.
  required: false
  type: float
  default: "The latitude defined under the `homeassistant` key in `configuration.yaml`."
start_longitude:
  description: The starting longitude for a trip.
  required: false
  type: float
  default: "The longitude defined under the `homeassistant` key in `configuration.yaml`."
end_latitude:
  description: The ending latitude for a trip. While `end_latitude` is optional, providing an `end_latitude`/`end_longitude` allows price estimates as well as time.
  required: false
  type: float
end_longitude:
  description: The ending longitude for a trip. While `end_longitude` is optional, providing an `end_latitude`/`end_longitude` allows price estimates as well as time.
  required: false
  type: float
product_ids:
  description: A list of Lyft product IDs.
  required: false
  type: [list, string]
{% endconfiguration %}

전체 설정 항목은 아래 샘플과 같습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: lyft
    client_id: CLIENT_ID
    client_secret: CLIENT_SECRET
    start_latitude: 37.8116380
    start_longitude: -122.2648050
    end_latitude: 37.615223
    end_longitude: -122.389977
    product_ids:
      - 'lyft'
      - 'lyft_plus'
```
