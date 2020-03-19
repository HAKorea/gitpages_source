---
title: 하드디스크온도(hddtemp)
description: Instructions on how to integrate hard drive temperature information into Home Assistant.
ha_category:
  - System Monitor
ha_release: 0.32
ha_iot_class: Local Polling
---

`hddtemp` 센서 플랫폼은 [HDDTemp](https://savannah.nongnu.org/projects/hddtemp)에서 제공한 데이터를 사용하고 있습니다.

로컬 또는 원격 시스템에서 `hddtemp`가 시작되거나 데몬 모드로 실행되어야 합니다.

```bash
$ hddtemp -dF
```

HDDTemp를 설치에 설정하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: hddtemp
    disks:
      - /dev/sda1
```

{% configuration %}
name:
  description: Friendly name to use for the frontend.
  required: false
  default: HD Temperature
  type: string
host:
  description: Host where `hddtemp` is running.
  required: false
  default: localhost
  type: string
port:
  description: Port that is used by `hddtemp`.
  required: false
  default: 7634
  type: integer
disks:
  description: "Disk to be monitored. Example: `/dev/sda1`."
  required: false
  type: list
{% endconfiguration %}
