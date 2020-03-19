---
title: 빅데이터플랫폼(Sigfox)
description: Display messages from Sigfox devices in Home Assistant.
logo: sigfox.png
ha_category:
  - Sensor
ha_iot_class: Cloud Polling
ha_release: 0.68
---

<iframe width="690" height="368" src="https://www.youtube.com/embed/A2iK_SQXrcQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[SigFox](https://www.sigfox.com/en) 통합 계정에 등록된 각 Sigfox 장치로 센서가 추가됩니다. 센서의 기본 이름은 `sigfox_ {DEVICE_ID}`입니다. 여기서 `DEVICE_ID`는 장치 Sigfox ID입니다. 추가된 Sigfox 센서의 상태는 해당 장치에서 게시한 마지막 메시지의 payload입니다. 또한 signal-to-noise ratio([snr](https://en.wikipedia.org/wiki/Signal-to-noise_ratio))는 물론 장치의 위도 및 경도 좌표에 대한 속성이 있습니다.

## 셋업

Note that `your_api_login` and `your_api_password` are your **API access credentials** which can be accessed by following:

1. Log into [Sigfox backend](https://backend.sigfox.com)
1. Select `GROUP`
1. Select `API ACCESS`
1. Click on `new` and create new access entry

## 설정

이 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sigfox
    api_login: your_api_login
    api_password: your_api_password
```

{% configuration %}
api_login:
  description: Your Sigfox API login.
  required: true
  type: string
api_password:
  description: Your Sigfox API password.
  required: true
  type: string
name:
  description: The name to prepend to the device ID.
  required: false
  default: "sigfox"
  type: string
{% endconfiguration %}
