---
title: 파일 크기
description: Component for monitoring the size of a file.
logo: file.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.64
---

파일의 크기를 MB 단위로 표시하기위한 `filesize` 센서. 경로는 [whitelist_external_dirs](/docs/configuration/basic/)에 추가되어야합니다.

## 설정

`filesize` 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
sensor:
  - platform: filesize
    file_paths:
      - /config/home-assistant_v2.db
  ```

{% configuration %}
file_paths:
  description: 파일의 절대 경로
  required: true
  type: list
{% endconfiguration %}
