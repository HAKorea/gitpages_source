---
title: 다운로더(downloader)
description: Instructions on how to setup the downloader integration with Home Assistant.
logo: home-assistant.png
ha_category:
  - Downloading
ha_release: pre 0.7
ha_quality_scale: internal
---

`downloader` 통합구성요소는 파일을 다운로드하는 서비스를 제공합니다. 다운로드 디렉토리가 존재하지 않으면 오류가 발생하고 자체적으로 설정되지 않습니다. 홈어시스턴트를 실행중인 사용자의 디렉토리는 쓰기 가능해야합니다.

이를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
downloader:
  download_dir: downloads
```

{% configuration %}
download_dir:
  description: "If the path is not absolute, it's assumed to be relative to the Home Assistant configuration directory (eg. `.homeassistant/downloads`)."
  required: true
  type: string
{% endconfiguration %}

### 서비스 사용

"개발자 도구"로 이동한 다음 "Call Service"로 이동하여 사용 가능한 서비스 목록에서 `downloader/download_file`을 선택하십시오. 아래 예에 표시된대로 "Service Data" 필드를 채우고 "CALL SERVICE"를 누르십시오.

```json
{"url":"http://domain.tld/path/to/file"}
```

주어진 URL에서 파일을 다운로드합니다. 

| Service data attribute | Optional | Description                                    |
| ---------------------- | -------- | ---------------------------------------------- |
| `url`                  |       no | The URL of the file to download.               |
| `subdir`               |      yes | Download into subdirectory of **download_dir** |
| `filename`             |      yes | Determine the filename.                        |
| `overwrite`            |      yes | Whether to overwrite the file or not, defaults to `false`. |

### Download 상태 이벤트

다운로드가 성공적으로 완료되면 Home Assistant는 자동화를 작성하는데 사용할 수 있는 'downloader_download_completed' 이벤트를 이벤트 버스로 보냅니다.
다운로드에 실패한 경우 다운로드가 성공적으로 완료되지 않았음을 나타내는 다른 이벤트 'downloader_download_failed'가 발생합니다.

이벤트와 함께 다음 페이로드 매개 변수를 사용할 수 있습니다.

| Parameter | Description                                                                                                                                                                                                                                                    |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `url`  | The `url` that was requested.|                                                                                                                                      
| `filename`    | The `name` of the file that was being downloaded.|

#### 자동화 사례 

```yaml
- alias: Download Failed Notification
  trigger:
    platform: event
    event_type: downloader_download_failed
  action:
    service: persistent_notification.create
    data_template:
      message: "{{trigger.event.data.filename}} download failed"
      title: "Download Failed"
 ```
