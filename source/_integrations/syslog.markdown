---
title: 시스로그(Syslog)
description: Instructions on how to add syslog notifications to Home Assistant.
logo: syslog.png
ha_category:
  - Notifications
ha_release: pre 0.7
ha_codeowners:
  - '@fabaff'
---

`syslog` 플랫폼을 사용하면 Home Assistant에서 로컬 syslog로 알림을 전달할 수 있습니다.

설치시 syslog 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: syslog
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
facility:
  description: Facility according to RFC 3164 (https://tools.ietf.org/html/rfc3164). Check the table below for entries.
  required: false
  default: syslog
  type: string
option:
  description: Log option. Check the table below for entries.
  required: false
  default: pid
  type: string
priority:
  description: Priority of the messages. Check the table below for entries.
  required: false
  default: info
  type: string
{% endconfiguration %}

이 테이블에는 `configuration.yaml` 파일에서 사용할 값이 들어 있습니다.

| facility  | option  | priority  |
| :-------- |:--------| :---------|
| kernel    | pid     | 5         |
| user      | cons    | 4         |
| mail      | ndelay  | 3         |
| daemon    | nowait  | 2         |
| auth      | perror  | 1         |
| LPR       |         | 0         |
| news      |         | -1        |
| uucp      |         | -2        |
| cron      |         |           |
| syslog    |         |           |
| local0    |         |           |
| local1    |         |           |
| local2    |         |           |
| local3    |         |           |
| local4    |         |           |
| local5    |         |           |
| local6    |         |           |
| local7    |         |           |

facility, option, priority 에 대한 자세한 내용은 [wikipedia article](https://en.wikipedia.org/wiki/Syslog) 및 [RFC 3164](https://tools.ietf.org/html/rfc3164)를 참조하십시오. 

알림을 사용하려면 [자동화 시작 페이지](/getting-started/automation/)를 참조하십시오.