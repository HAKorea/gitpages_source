---
title: "컴맨드 라인 Notify"
description: "Instructions on how to add command line notifications to Home Assistant."
logo: command_line.png
ha_category:
  - Notifications
ha_release: 0.14
---

`command_line` 플랫폼을 사용하면 Home Assistant의 알림에 외부 도구를 사용할 수 있습니다. 메시지는 STDIN으로 전달됩니다.

설치시 이러한 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: command_line
    command: "espeak -vmb/mb-us1"
```

{% configuration %}
name:
  description: 선택적 매개 변수 `name`을 설정하면 여러 알리미를 만들 수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME`에 바인딩합니다.
  required: false
  default: notify
  type: string
command:
  description: 취할 액션.
  required: true
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.