---
title: "Google지도를 카드로 표시"
description: "Example how to show a Google Map as a Google card."
ha_category: User Interface
---

[generic camera platform]을 사용하면 인터넷에서 모든 이미지를 카메라로 제공 할 수 있습니다. 릴리스 0.27부터이 URL은 템플릿을 기반으로 할 수도 있습니다. 이 예에서는이 기능을 사용하여 Google Maps 정적 이미지 API에서 일반 카메라를 가리키고 기기 위치를 전달합니다.

2018 년 6 월 현재 Google은 정적지도에 대한 API 제한을 변경했습니다. 이제 Google Maps API 키가 필요합니다. 키 등록 방법은 [here](https://github.com/googlemaps/google-maps-services-python#api-keys)를 참조하십시오 . `YOUR_API_KEY`를 등록한 키로 교체하십시오 .

또한 Google Maps API에 많은 요청을하지 않도록 하는 `limit_refetch_to_url_change`옵션을 활용합니다.

```yaml
# Example configuration.yaml entry.
# Shows device_tracker.demo_paulus on a map.
camera:
  name: Paulus
  platform: generic
  still_image_url: {% raw %}https://maps.googleapis.com/maps/api/staticmap?center={{ state_attr('device_tracker.demo_paulus', 'latitude') }},{{ state_attr('device_tracker.demo_paulus', 'longitude') }}&zoom=13&size=500x500&maptype=roadmap&markers=color:blue%7Clabel:P%7C{{ state_attr('device_tracker.demo_paulus', 'latitude') }},{{ state_attr('device_tracker.demo_paulus', 'longitude') }}{% endraw %}&key=YOUR_API_KEY
  limit_refetch_to_url_change: true
```

<p class='img'>
  <img src='/images/integrations/camera/generic-google-maps.png' alt='Screenshot showing Google Maps integration in Home Assistant front end.'>
</p>

[generic camera platform]: /integrations/generic_ip_camera
