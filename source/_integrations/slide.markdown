---
title: 슬라이드 커튼(Slide Curtain)
description: Instructions on how to integrate the Innovation in Motion Slide covers with Home Assistant.
logo: slide.png
ha_category:
  - Hub
  - Cover
ha_iot_class: Cloud Polling
ha_release: 0.99
ha_codeowners:
  - '@ualex73'
---

<iframe width="692" height="388" src="https://www.youtube.com/embed/fcofNbbm1OQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`slide` 구현을 통해 [official API](https://documenter.getpostman.com/view/6223391/S1Lu2pSf?version=latest)를 사용하여 홈어시스턴트에서 [slide.store](https://slide.store/) 장치를 연동할 수 있습니다.


### 설정

```yaml
# Example configuration.yaml entry
slide:
  username: YOUR_SLIDE_APP_USERNAME
  password: YOUR_SLIDE_APP_PASSWORD
```

{% configuration %}
username:
  description: Username needed to log in to Slide App.
  required: true
  type: string
password:
  description: Password needed to log in to Slide App.
  required: true
  type: string
scan_interval:
  description: "Minimum time interval between updates."
  required: false
  default: 30 seconds
  type: integer
{% endconfiguration %}
