---
title: 리눅스 밧데리(Linux Battery)
description: Instructions on how to integrate Linux Battery information into Home Assistant.
logo: linux_battery.png
ha_category:
  - System Monitor
ha_release: 0.28
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

노트북, 태블릿, 휴대폰 등 배터리를 사용하는 기기에서 아주 유용하게 쓰일 수 있는 통합구성요소입니다. 

사례로는 HA 네이버 카페의 [**그렉하우스님께서 알려주신 팁**](https://cafe.naver.com/koreassistant/928)을 참조하십시오. 

`linux_battery` 센서 플랫폼은 로컬 Linux 시스템의 `/sys/class/power_supply/`에 저장된 정보를 사용하여 배터리의 현재 상태에 대한 세부 사항을 표시합니다.

배터리 센서를 설치에 설치하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: linux_battery
```

{% configuration %}
name:
  description: Friendly name to use for the frontend.
  required: false
  default: Battery
  type: string
battery:
  description: Number of the battery.
  required: false
  default: 1
  type: integer
system:
  description: "The local system type. Support `linux` and `android`."
  required: false
  default: linux
  type: string
{% endconfiguration %}
