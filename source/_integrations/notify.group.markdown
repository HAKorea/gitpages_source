---
title: 그룹 알림(notify group)
description: "Instructions on how to setup the notify group platform."
logo: home-assistant.png
ha_category:
  - Notifications
ha_release: 0.26
ha_quality_scale: internal
---

`group` 알림 플랫폼을 사용하면 여러 `notify` 플랫폼을 단일 서비스로 결합 할 수 있습니다.

## 설정

```yaml
# Example configuration.yaml entry
notify:
  - name: NAME_OF_NOTIFIER_GROUP
    platform: group
    services:
      - service: html5
        data:
          target: "macbook"
      - service: html5_nexus
```

{% configuration %}
name:
  description: "`name` 파라미터를 설정하면 그룹의 이름이 설정됩니다."
  required: true
  type: string
services:
  description: 그룹에 포함할 모든 서비스 목록.
  required: true
  type: list
  keys:
    service:
      description: "엔티티 ID의 서비스 부분 (예: `notify.html5`를 정상적으로 사용하려면 `html5`를 넣습니다.). 여기에 모든 것을 소문자로 입력해야합니다. 실제 알림 서비스에 대문자를 쓸 수도 있습니다!"
      required: true
      type: string
    data:
      description: 모든 notify 페이로드에 추가할 매개 변수가 포함 된 사전(dictionary). 이는 `data`, `message`, `target` 혹은 `title`과 같이 페이로드에 사용하기에 유효한 모든 것이 될 수 있습니다.
      required: false
      type: string
{% endconfiguration %}

## 사례

An example on how to use it in an automation:
자동화에서 사용하는 방법에 대한 예 :

{% raw %}
```yaml
action:
  service: notify.NAME_OF_NOTIFIER_GROUP
  data:
    message: "The sun is {% if is_state('sun.sun', 'above_horizon') %}up{% else %}down{% endif %}!"
```
{% endraw %}
