---
title: 유비쿼티 비디오(Ubiquiti UniFi Video)
description: Instructions on how to integrate UVC cameras within Home Assistant.
logo: ubiquiti.png
ha_category:
  - Camera
ha_release: 0.13
ha_iot_class: Local Polling
---

`uvc` 카메라 플랫폼을 사용하면 [UniFi Video Camera (UVC)](https://www.ubnt.com/products/#unifivideo)를 Home Assistant에 연동할 수 있습니다.

이 플랫폼은 Unifi NVR 소프트웨어에 연결되며 NVR에 연결된 모든 카메라를 자동으로 감지/추가합니다.

### 셋업

NVR 소프트웨어에서 이 플랫폼에 대한 새 사용자를 생성하고 사용자에게 필요한 권한만 부여하는 것이 좋습니다.

- The API key is found in `User` -> `My account` -> `API Access` in the NVR software.
- The camera password is found in `Settings` -> `Camera Settings` -> `Camera Password` in the NVR software.

### 설정

활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: uvc
    nvr: IP_ADDRESS
    key: API_KEY
```

{% configuration %}
nvr:
  description: The IP or hostname of the NVR (Network Video Recorder) server.
  required: true
  type: string
port:
  description: The port number to use for accessing the NVR.
  required: false
  type: integer
  default: 7080
key:
  description: The API key available from the NVR web interface.
  required: true
  type: string
password:
  description: The camera password.
  required: false
  type: string
  default: ubnt
ssl:
  description: Should use SSL/TLS to connect to the NVR.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

<div class='note'>
API_KEY를 사용하여 Ubiquiti의 NVR 소프트웨어로 제어되는 카메라에 액세스하는 경우 새 카메라를 홈어시스턴트에 추가하려면 관련 사용자 계정에 NVR 소프트웨어 내에서 최소한 관리자 권한이 있어야합니다. Home Assistant에서 엔티티가 작성되면 사용자 계정에 대한 권한을 낮출 수 있습니다.
</div>
