---
title: 레비톤 데코라(Leviton Decora)
description: Instructions on how to setup Leviton Decora Bluetooth dimmers within Home Assistant.
ha_category:
  - Light
ha_iot_class: Local Polling
logo: leviton.png
ha_release: 0.37
---

Decora Bluetooth dimmer 스위치 지원 [Leviton](https://www.leviton.com/en/products/residential/dimmers/automation-smart-home/decora-digital-with-bluetooth-dimmers#t=Products&sort=%40wcs_site_tree_rank%20ascending&layout=card)

API 키는 [this git repository](https://github.com/mjg59/python-decora)를 다운로드하고 스위치의 Bluetooth 주소를 첫 번째 인수로 사용하여 `read_key.py` 스크립트를 실행하여 얻을 수 있습니다. 스크립트를 실행하기 전에 녹색 상태 LED가 깜박일때까지 스위치를 꺼짐 위치로 유지하십시오. output은 API 키입니다.

이 조명을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: decora
    devices:
      00:21:4D:00:00:01:
        api_key: YOUR_API_KEY
```

{% configuration %}
devices:
  description: A list of lights to use.
  required: true
  type: map
  keys:
    mac_address:
      required: true
      description: The bluetooth address of the switch.
      type: list
      keys:
        name:
          description: The name to use in the frontend.
          required: false
          default: "`mac_address` of this switch"
          type: string
        api_key:
          description: The API key to access the device.
          required: true
          type: string
{% endconfiguration %}

<div class='note'>

다음과 같은 오류가 발생하면 :

```txt
Jun 20 19:41:18 androlapin hass[29588]: ERROR:homeassistant.components.light:Error while setting up platform decora
[...]
Jun 20 19:41:18 androlapin hass[29588]:   File "/usr/lib/python3.6/concurrent/futures/thread.py", line 55, in run
Jun 20 19:41:18 androlapin hass[29588]:     result = self.fn(*self.args, **self.kwargs)
Jun 20 19:41:18 androlapin hass[29588]:   File "/opt/homeassistant/custom_components/light/decora.py", line 68, in setup_platform
Jun 20 19:41:18 androlapin hass[29588]:     light = DecoraLight(device)
[...]
Jun 20 19:41:18 androlapin hass[29588]: OSError: [Errno 8] Exec format error
```

1. Go to your `.homeassistant` folder
2. Then go to `deps/bluepy` subfolder.
3. Then run `make all`
4. Restart Home Assistant

</div>
