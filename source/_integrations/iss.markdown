---
title: 국제 우주 정거장(ISS)
description: Know if or when ISS will be above your home location
logo: nasa.png
ha_category:
  - Binary Sensor
ha_release: 0.36
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/0DXHAU223E8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`iss` 플랫폼은 [Open Notify API](http://open-notify.org/Open-Notify-API/ISS-Location-Now/)를 사용하여 스테이션이 우리집의 위에 위치해있는지 알려줍니다.
이는 ISS가 집의 수평선 위로 10도 위에 있다는 것을 의미합니다.

센서의 속성을 확인하여 스테이션의 다음 상승(rise)에 대한 타임 스탬프, 현재 좌표 및 공간에 있는 인원수를 확인할 수 있습니다.

## 설정

설치에 ISS 바이너리 센서를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: iss
```

{% configuration %}
name:
  description: The name for this sensor in the frontend.
  required: false
  type: string
  default: ISS
show_on_map:
  description: Option to show the position of the ISS on the map.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

<div class='note warning'>

`show_on_map: true`를 설정하면 위치 속성의 이름은 `latitude` 와 `longitude`입니다.
위치 속성의 기본 이름은 맵에 표시되지 않도록 `lat` 및 `long`입니다.

</div>

### 카메라 플랫폼으로 지도에 위치 표시

[generic camera platform](/integrations/mjpeg)은 OpenStreetMap에서 ISS의 위치를 ​​보여줄 수 있는 가능성을 제공합니다.

{% raw %}
```yaml
# Example configuration.yaml entry
camera:
  - platform: generic
    name: ISS
    still_image_url: http://staticmap.openstreetmap.de/staticmap.php?center={{ state_attr('binary_sensor.iss', 'lat') }},{{ state_attr('binary_sensor.iss', 'long') }}&zoom=4&size=865x512&maptype=mapnik&markers={{ state_attr('binary_sensor.iss', 'lat') }},{{ state_attr('binary_sensor.iss', 'long') }},lightblue
    limit_refetch_to_url_change: true
```
{% endraw %}
