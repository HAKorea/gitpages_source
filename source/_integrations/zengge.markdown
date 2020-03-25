---
title: 젱게(Zengge)
description: Instructions on how to integrate Zengge Bluetooth bulbs into Home Assistant.
logo: zengge.png
ha_category:
  - Light
ha_iot_class: Local Polling
ha_release: 0.36
---

`zengge` 플랫폼을 사용하면 [Zengge Bluetooth 전구](http://www.zengge.com/)를 Home Assistant에 연동할 수 있습니다.

## 설정

조명을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
light:
  - platform: zengge
    devices:
      "C4:BE:84:51:54:8B":
        name: Living Room
```

{% configuration %}
devices:
  description: The list of your devices/bulbs.
  required: true
  type: list
  keys:
    mac_address:
      description: The MAC address of the bulb.
      required: true
      type: list
      keys:
        name:
          description: The friendly name for the frontend.
          required: false
          type: string
{% endconfiguration %}
