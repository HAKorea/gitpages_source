---
title: 벨룩스(Velux)
description: Instructions on how to integrate Velux KLF 200 integration with Home Assistant.
logo: velux.png
ha_category:
  - Scene
  - Cover
ha_release: 0.49
ha_iot_class: Local Polling
ha_codeowners:
  - '@Julius2342'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/0Yv8gcFaJL0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Home Assistant의 [Velux](https://www.velux.com/) 연동을 통해 Velux KLF 200 인터페이스에 연결하여 창 및 블라인드와 같은 [io-homecontrol](http://www.io-homecontrol.com) 장치를 제어 할 수 있습니다. 이 모듈을 사용하면 KLF 200 내에서 설정된 장면(scene)을 시작할 수 있습니다.

KLF 200 장치에는 2.0.0.0 이상의 펌웨어 버전이 필요합니다. 펌웨어 이미지는 [here](https://www.velux.com/api/klf200)에서 얻을 수 있으며 KLF 200의 웹 인터페이스를 통해 가져왔을 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Cover
- Scene

## 설정

`velux` 섹션은 `configuration.yaml` 파일에 있어야하며 필요에 따라 다음 옵션을 포함해야합니다.

```yaml
# Example configuration.yaml entry
velux:
  host: "192.168.1.23"
  password: "VELUX_PASSWORD"
```

{% configuration %}
host:
  description: The IP address or hostname of the KLF 200 to use.
  required: true
  type: string
password:
  description: The password of the KLF 200 interface. Note that this is the same as the WiFi password (in the upper box on the back), *not* the password for the web login.
  required: true
  type: string
{% endconfiguration %}
