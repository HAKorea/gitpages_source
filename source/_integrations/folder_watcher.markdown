---
title: 폴더 감시
description: Component for monitoring changes within the filesystem.
logo: home-assistant.png
ha_category:
  - System Monitor
ha_iot_class: Local Polling
ha_release: 0.67
ha_quality_scale: internal
---

이 통합구성요소는 [Watchdog](https://pythonhosted.org/watchdog/) 파일 시스템 모니터링을 추가하고 설정된 폴더 내의 파일 작성/삭제/수정시 홈어시스턴트에 이벤트를 공개합니다. 모니터링되는 'event_type'은 다음과 같습니다. :

* `created`
* `deleted`
* `modified`
* `moved`

설정된 폴더는 [whitelist_external_dirs](/docs/configuration/basic/)에 추가해야합니다. 기본적으로 폴더 모니터링은 재귀적이므로 하위 폴더의 내용도 모니터링됩니다. 

## 설정

설치에서 Folder Watcher 통합을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

{% raw %}
```yaml
folder_watcher:
  - folder: /config
```
{% endraw %}

{% configuration %}
folder:
  description: 폴더 경로
  required: true
  type: string
patterns:
  description: 적용할 패턴 일치성
  required: false
  default: "*"
  type: string
{% endconfiguration %}

## 패턴 

[fnmatch](https://docs.python.org/3.6/library/fnmatch.html)를 사용한 패턴 일치를 사용하여 파일 시스템 모니터링을 설정된 패턴과 일치하는 파일로만 제한할 수 있습니다. 다음 예는 파일 형식 `.yaml` 및 `.txt` 만 모니터링하는 데 필요한 설정을 보여줍니다.

{% raw %}
```yaml
folder_watcher:
  - folder: /config
    patterns:
      - '*.yaml'
      - '*.txt'
```
{% endraw %}

## 자동화

`data_template`을 사용하여 파일 시스템 이벤트 데이터에서 자동화를 트리거 할 수 있습니다. 다음 자동화는 해당 폴더에 추가된 새 파일의 이름과 폴더와 함께 알림을 보냅니다.

{% raw %}
```yaml
#Send notification for new image (including the image itself)
automation:
  alias: New file alert
  trigger:
    platform: event
    event_type: folder_watcher
    event_data:
      event_type: created
  action:
    service: notify.notify
    data_template:
      title: New image captured!
      message: "Created {{ trigger.event.data.file }} in {{ trigger.event.data.folder }}"
      data:
        file: "{{ trigger.event.data.path }}"
```
{% endraw %}
