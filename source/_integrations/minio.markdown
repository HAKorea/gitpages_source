---
title: 미니오(Minio)
description: Integration for interacting with Minio object storage.
logo: minio.png
ha_category: Utility
ha_iot_class: Cloud Push
ha_release: 0.98
ha_codeowners:
  - '@tkislan'
---

이 통합구성요소는 [Minio](https://min.io)와의 상호 작용을 추가합니다. 버킷 알림을 들을 수도 있습니다: [watch docs](https://docs.min.io/docs/minio-client-complete-guide.html#watch)

파일을 다운로드하거나 업로드하려면 [whitelist_external_dirs](/docs/configuration/basic/)에 폴더를 추가해야합니다.

## 설정

설치에서 Minio 통합구성요소를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
minio:
  host: localhost
  port: 9000
  access_key: ACCESS_KEY
  secret_key: SECRET_KEY
  secure: false
```

{% configuration %}
host:
  description: Minio 서버 호스트
  required: true
  type: string
port:
  description: Minio 서버 포트
  required: true
  type: integer
access_key:
  description: Minio 서버 액세스 키
  required: true
  type: string
secret_key:
  description: Minio 서버 비밀 키
  required: true
  type: string
secure:
  description: http 또는 https 연결 사용 여부
  required: true
  type: boolean
  default: false
listen:
  description: 이벤트를 청취할 설정 목록
  required: false
  default: []
  type: list
  keys:
    bucket:
      description: Bucket to use
      required: true
      type: string
    prefix:
      description: What prefix to use to filter file events
      required: false
      type: string
      default: ""
    suffix:
      description: What file suffix to use to filter file events
      required: false
      type: string
      default: ".*"
    events:
      description: What file
      required: false
      type: string
      default: "s3:ObjectCreated:*"
{% endconfiguration %}

## 자동화

`data_template`을 사용하여 Minio 서버의 생성된 새 파일에서 자동화를 트리거 할 수 있습니다.

{% raw %}
```yaml
#Automatically upload new local files
automation:
- alias: Upload camera snapshot
  trigger:
    platform: event
    event_type: folder_watcher
    event_data:
      event_type: created
  action:
    - delay: '00:00:01'
    - service: minio.put
      data_template:
        file_path: "{{ trigger.event.data.path }}"
        bucket: "camera-image-object-detection"
        key: "input/{{ now().year }}/{{ (now().month | string).zfill(2) }}/{{ (now().day | string).zfill(2) }}/{{ trigger.event.data.file }}"
    - delay: '00:00:01'
    - service: shell_command.remove_file
      data_template:
        file: "{{ trigger.event.data.path }}"

- alias: Download new Minio file
  trigger:
  - platform: event
    event_type: minio
    
  condition: []
  action:
  - service: minio.get
    data_template:
      bucket: "{{trigger.event.data.bucket}}"
      key: "{{trigger.event.data.key}}"
      file_path: "/tmp/{{ trigger.event.data.file_name }}"
```
{% endraw %}

## 플랫폼 서비스

다음 서비스들이 제공됩니다. :

- `get`
- `put`
- `remove`

### `minio.get` 서비스

파일 다운로드.

| Service data attribute    | Required | Description                                       |
|---------------------------|----------|---------------------------------------------------|
| `bucket`                  |      yes | Bucket to use                                     |
| `key`                     |      yes | Object key of the file                            |
| `file_path`               |      yes | File path on the local file system                |

### `minio.put` 서비스

파일 업로드.

| Service data attribute    | Required | Description                                       |
|---------------------------|----------|---------------------------------------------------|
| `bucket`                  |      yes | Bucket to use                                     |
| `key`                     |      yes | Object key of the file                            |
| `file_path`               |      yes | File path on the local file system                |

### `minio.remove` 서비스

파일 삭제.

| Service data attribute    | Required | Description                                       |
|---------------------------|----------|---------------------------------------------------|
| `bucket`                  |      yes | Bucket to use                                     |
| `key`                     |      yes | Object key of the file                            |
