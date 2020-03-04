---
title: 로컬 파일
description: Instructions how to use Local File as a Camera within Home Assistant.
logo: file.png
ha_category:
  - Camera
ha_iot_class: Local Polling
ha_release: 0.22
---

`local_file` 카메라 플랫폼을 사용하면 디스크의 이미지 파일을 카메라로 Home Assistant에 통합 할 수 있습니다. 파일 시스템에서 이미지가 업데이트되면 홈어시스턴트에 표시된 이미지도 업데이트됩니다. `local_file_update_file_path` 서비스는 자동화를 사용하여 이미지를 업데이트하는 데 사용할 수 있습니다.

`local_file` 카메라는 예를 들어 임시 이미지를 로컬에 저장하는 다양한 카메라 플랫폼과 함께 사용할 수 있습니다. 또한 주기적으로 렌더링 한 다음 홈어시스턴트에 표시되는 그래프를 표시하는 데 사용할 수 있습니다.

## 설정

설치시 이 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: local_file
    file_path: /tmp/image.jpg
```

{% configuration %}
file_path:
  description: "카메라에서 제공하는 하는 파일입니다. 전체 경로를 사용하십시오 (예 :`/config/www/images/image.jpg`."
  required: true
  type: string
name:
  description: 카메라 이름.
  required: false
  type: string
{% endconfiguration %}

### `local_file.update_file_path` 서비스

이 서비스를 사용하여 카메라에서 표시되는 파일을 변경하십시오.

| Service data attribute | Description |
| -----------------------| ----------- |
| `entity_id` | 업데이트 할 카메라의 `entity_id` 문자열. |
| `file_path` | 표시할 새 이미지 파일의 전체 경로입니다. |
