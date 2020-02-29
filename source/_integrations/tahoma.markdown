---
title: Tahoma(타호마)
description: Instructions on how to integrate Somfy Tahoma devices with Home Assistant.
logo: tahoma.png
ha_category:
  - Hub
  - Binary Sensor
  - Cover
  - Scene
  - Switch
  - Sensor
ha_release: 0.59
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@philklei'
---

`Tahoma` 통합 플랫폼은 [tahomalink.com](https://www.tahomalink.com) 웹 사이트의 인터페이스로 사용됩니다. Tahoma 플랫폼의 Cover, Scene 및 Sun 센서를 추가합니다. 

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Binary Sensor
- Sensor
- Cover
- Switch
- Scene

## 설정

설치시 Tahoma 장치를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
tahoma:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
  exclude: [BridgeHUEComponent, HueLampHUEComponent, PodComponent]
```

{% configuration %}
username:
  description: tahomalink.com의 사용자 이름.
  required: true
  type: string
password:
  description: tahomalink.com의 비밀번호.
  required: true
  type: string
exclude:
  description: 제외 할 장치 목록.
  required: false
  type: list
{% endconfiguration %}

이는 또한 Somfy Connexoon과 함께 작동합니다. 브리지 간의 차이점에 대해서는 [here](https://somfyhouse.freshdesk.com/nl/support/solutions/articles/14000058145-wat-is-het-verschil-tussen-de-tahoma-en-de-connexoon-) 를 확인 하십시오 .