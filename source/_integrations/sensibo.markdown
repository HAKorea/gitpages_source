---
title: 센시보(Sensibo)
description: Instructions on how to integrate Sensibo A/C controller into Home Assistant.
logo: sensibo.png
ha_category:
  - Climate
ha_release: 0.44
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@andrey-git'
---

[Sensibo](https://sensibo.com) 에어컨 컨트롤러를 홈어시스턴트에 연동합니다.

이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
climate:
  - platform: sensibo
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your Sensibo API key (To get your API key visit <https://home.sensibo.com/me/api>).
  required: true
  type: string
id:
  description: A unit ID or a list of IDs. If none specified then all units accessible by the `api_key` will be used.
  required: false
  type: string
{% endconfiguration %}

<div class="note">
 서브 사용자(메인 사용자가 아닌)를 사용하여 API 키를 생성하면 Sensibo 앱 로그에서 앱에서 수행한 작업과 Home Assistant에서 수행한 작업을 구별 할 수 있습니다.
</div>

### Full config example
```yaml
climate:
  - platform: sensibo
    api_key: YOUR_API_KEY
    id:
      - id1
      - id2
```

### Quick Switch 추가 예제

"Quick Switch"로 AC를 켜거나 끄려면 다음 `Switch Template`을 사용하여 AC를 켜거나 끌 수 있습니다.

{% raw %}
```yaml
switch:
  - platform: template
    switches:
      ac:
        friendly_name: "AC"
        value_template: "{{ is_state('climate.ac', 'cool') or is_state('climate.ac', 'heat') or is_state('climate.ac', 'dry') or is_state('climate.ac', 'fan_only') }}"
        turn_on:
          service: climate.set_hvac_mode
          data:
            entity_id: climate.ac
            hvac_mode: cool
        turn_off:
          service: climate.set_hvac_mode
          data:
            entity_id: climate.ac
            hvac_mode: off
```
{% endraw %}
