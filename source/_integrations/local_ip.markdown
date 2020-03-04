---
title: 로컬 IP 주소
description: Instructions on how to integrate the Local IP Address sensor into Home Assistant.
logo: home-assistant.png
ha_category:
  - Network
ha_iot_class: Local Polling
ha_release: 0.104
ha_config_flow: true
ha_codeowners:
  - '@issacg'
---

`local_ip` 센서는 홈어시스턴트 인스턴스의 로컬 (LAN) IP 주소를 노출합니다. 이는 인스턴스에 정적 퍼블릭 호스트 이름 (예 : Nabu Casa 서비스를 사용하는 경우)도 있지만 동적으로 할당된 로컬 LAN 주소 (예 : DHCP를 통해 구성)가 있는 경우 유용 할 수 있습니다.

센서는 사용자 인터페이스 또는 `configuration.yaml` 파일을 통해 추가 할 수 있습니다. 이 센서를 활성화하려면 `configuration.yaml` 파일을 통해 다음과 같은 최소 설정을 추가하십시오.

```yaml
# Example configuration.yaml entry
local_ip:
```

사용자 인터페이스를 통해 설정하려면 `Local IP Address` 통합구성요소를 선택하십시오.

{% configuration %}
name:
  description: 센서의 친숙한 이름.
  required: false
  type: string
  default: local_ip
{% endconfiguration %}
