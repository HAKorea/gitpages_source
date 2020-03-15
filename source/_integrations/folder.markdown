---
title: 폴더(Folder)
description: Sensor for monitoring the contents of a folder.
logo: file.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.64
---

폴더의 내용을 모니터링하기위한 센서. 폴더 경로는 [whitelist_external_dirs](/docs/configuration/basic/)에 추가해야합니다. 선택적으로 [wildcard filter](https://docs.python.org/3.6/library/fnmatch.html)를 폴더 내에서 특정 파일에 적용 할 수 있습니다. 센서 상태는 필터 기준을 충족하는 폴더 내의 파일 크기 (MB)입니다. 센서는 폴더에 있는 필터링된 파일 수, 해당 파일의 전체 크기 (바이트) 및 쉼표로 구분된 파일 경로 목록을 속성으로 표시합니다.

## 설정

설치에서 `folder`센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
sensor:
  - platform: folder
    folder: /config
```

{% configuration %}
folder:
  description: 폴더 경로
  required: true
  type: string
filter:
  description: 적용할 필터
  required: false
  default: "`*`"
  type: string
{% endconfiguration %}
