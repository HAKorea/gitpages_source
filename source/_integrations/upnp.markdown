---
title: UPnP
description: Internet Gateway Device (IGD) Protocol for Home Assistant.
logo: upnp.png
ha_category:
  - Network
  - Sensor
ha_release: 0.18
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@robbiet480'
---

`upnp` 통합구성요소를 사용하면 bytes in/out 및 packets in/out과 같은 라우터에서 네트워크 통계를 수집할 수 있습니다. 이 정보는 [UPnP](https://en.wikipedia.org/wiki/Universal_Plug_and_Play)/ [Internet Gateway Device (IGD) Protocol](https://en.wikipedia.org/wiki/Internet_Gateway_Device_Protocol)에서 제공합니다. 라우터에서 활성화하십시오.

IGD는 라우터에 홈어시스턴 용 포트 전달 맵핑(port forwarding mappings)을 자동으로 작성하여 설치를 인터넷에 노출시킵니다. 매핑은 자동으로 만료되지 않습니다. 홈어시스턴트를 중지하면 라우터에서 매핑이 제거됩니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- **Sensor** - bytes in/out 및 packets in/out과 같은 라우터에서 네트워크 통계를 가져올 수 있습니다.

본 통합구성요소가 작동하려면 라우터에서 UPnP 또는 NAT-PMP를 활성화해야합니다.

## 설정

이를 홈어시스턴트로 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry with custom external portal
upnp:
  port_mapping: true
  ports:
    hass: 8000
    8080: 8080
```

기본 설정을 사용하면 통계에 센서만 추가됩니다. IGD를 통해 포트 매핑을 수행하려면 **port_mapping** 및 **ports** 옵션을 추가하십시오.

{% configuration %}
port_mapping:
  description: If the integration should try to map ports.
  required: false
  type: boolean
  default: false
sensors:
  description: If the integration should enable the UPNP sensors.
  required: false
  type: boolean
  default: true
local_ip:
  description: The local IP address of the computer running Home Assistant.
  required: false
  type: string
  default: Try to auto-detect IP of host.
ports:
  description: Map of ports to map from internal to external. Pass 'hass' as internal port to use the port Home Assistant runs on. Note that you have to enable port_mapping if you wish to map ports.
  required: false
  type: map
  default: Open same port on external router as that Home Assistant runs locally and forwards it.
{% endconfiguration %}

## 문제 해결

홈어시스턴트가 UPnP 센서를 감지할 수 없는 경우 로컬 IP 주소가 올바르게 자동 감지되지 않았기 때문일 수 있습니다. 이를 막기 위해 UPnP 설정에 `local_ip` 옵션을 추가할 수 있습니다 :

```yaml
# Example configuration.yaml with UPnP sensors enabled and local_ip set
upnp:
  sensors: true
  local_ip: 192.168.1.2
```
