---
title: 트랙알(TrackR)
description: Instructions on how to use TrackR to track devices in Home Assistant.
logo: trackr.png
ha_release: 0.36
ha_category:
  - Presence Detection
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/TDpCGovEjW8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`trackr` 플랫폼에서는 [TrackR](https://www.thetrackr.com/) 장치를 사용하여 재실을 감지 할 수 있습니다.

공식 TrackR 모바일 앱은 휴대폰의 Bluetooth 및 GPS를 사용하여 TrackR 장치의 추적을 처리합니다.

Home Assistant에 TrackR을 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  platform: trackr
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The email address for the TrackR account.
  required: true
  type: string
password:
  description: The password for your given username.
  required: true
  type: string
{% endconfiguration %}
