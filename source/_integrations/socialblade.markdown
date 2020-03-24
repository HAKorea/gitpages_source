---
title: 유튜브 실시간 순위(Social Blade)
description: Instructions on how to set up Social Blade Sensor within Home Assistant.
logo: socialblade.png
ha_category:
  - Multimedia
ha_release: 0.69
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/Hb0ks2fcpbo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`socialblade` 센서 플랫폼을 사용하면 YouTube 채널 가입자수와 총조회수를 모니터링 할 수 있습니다. 센서는 [Social Blade website](https://socialblade.com)에서 데이터를 검색합니다.

## 셋업

YouTube 채널 ID를 얻으려면 [Social Blade website](https://socialblade.com)에서 채널을 검색하여 선택하십시오. 채널 ID는 소셜 블레이드 URL 끝에 있습니다 : `https://socialblade.com/youtube/channel/{channel_id}`

## 설정

센서를 활성화하려면 `configuration.yaml` 파일에 다음 라인을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: socialblade
    channel_id: YOUTUBE_CHANNEL_ID
```

{% configuration %}
channel_id:
  description: YouTube channel ID.
  required: true
  type: string
{% endconfiguration %}
