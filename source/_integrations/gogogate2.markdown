---
title: 차고문(Gogogate2)
description: Instructions on how to integrate Gogogate2-Enabled garage door covers into Home Assistant.
logo: gogogate2.png
ha_category:
  - Cover
ha_release: 0.67
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/u64zBLsoFcI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`gogogate2` 커버 플랫폼을 사용하면 홈어시스턴트를 통해 Gogogate2 지원 차고문을 제어할 수 있습니다. 홈어시스턴트의 장치 이름은 Gogogate2 모바일앱에 정의된 이름을 기반으로 생성됩니다.

## 설정

설치시 Gogogate2 커버를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
cover:
  - platform: gogogate2
    username: email@email.com
    password: password
    ip_address: 192.168.1.200
```

{% configuration %}
username:
  description: Your Gogogate2 account username.
  required: true
  type: string
password:
  description: Your Gogogate2 account password.
  required: true
  type: string
ip_address:
  description: The IP Address of your Gogogate2 device.
  required: true
  type: string
name:
  description: Allows you to override the default name.
  default: gogogate2
  required: false
  type: string
{% endconfiguration %}
