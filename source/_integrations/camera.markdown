---
title: 카메라(Camera)
description: Instructions on how to integrate cameras within Home Assistant.
logo: home-assistant.png
ha_category:
  - Camera
ha_release: 0.7
ha_quality_scale: internal
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/GlaS24QQjTs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


카메라 연동을 통해 Home Assistant에서 IP 카메라를 사용할 수 있습니다.

### 스트리밍 비디오

카메라가 이를 지원하고, [`stream`](/integrations/stream) 연동이 설정된 경우, 카메라를 프런트 엔드 및 지원되는 미디어 플레이어에서 스트리밍할 수 있습니다.
 
이 옵션은 스트림을 활성 상태로 유지하고 Home Assistant 시작시 피드를 사전에 로드합니다. 이로 인해 프런트 엔드에서 스트림을 열 때 뿐만 아니라 `play_stream` 서비스 또는 Google Assistant 연동 사용시 대기 시간이 줄어 듭니다. 그러나 컴퓨터에서 더 많은 리소스를 사용하므로 이 기능을 사용하려는 경우 CPU 사용량을 확인하는 것이 좋습니다.

<p class='img'>
  <img src='/images/integrations/camera/preload-stream.png' alt='Screenshot showing Preload Stream option in Home Assistant front end.'>
  카메라 대화 상자의 Preload Stream 옵션을 보여주는 예입니다.
</p>


### 서비스

`camera` 플랫폼이 로드되면 다양한 작업을 수행하기 위해 호출할 수 있는 서비스가 나타납니다.

제공 서비스 : `enable_motion_detection`, `disable_motion_detection`, `play_stream`, `record`, `snapshot`, `turn_off` 과 `turn_on`.

#### `enable_motion_detection` 서비스

카메라에서 모션 감지를 활성화합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |     yes  | 모션 감지를 가능하게하는 엔티티의 이름 (예 : `camera.living_room_camera`.) |

#### `disable_motion_detection` 서비스

카메라에서 모션 감지를 비활성화합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |     yes  | 모션 감지를 비활성화 할 엔티티의 이름  (예 : `camera.living_room_camera`.) |

#### `play_stream` 서비스

카메라에서 선택한 미디어 플레이어로 라이브 스트림을 재생합니다. 사전에 [`stream`](/integrations/stream) 통합구성요소가 설정되어야 합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 스트림을 가져올 엔티티의 이름 (예:`camera.living_room_camera`.) |
| `media_player`         |      no  | 스트림을 재생할 미디어 플레이어의 이름 (예:`media_player.living_room_tv`.) |
| `format`               |      yes | 특정 `media_player`와 `stream` 통합구성요소에서 지원되는 스트림. Default: `hls` |

예를 들어 자동화에서 다음 작업을 수행하면 `hls` 라이브 스트림이 chromecast로 전송됩니다.

```yaml
action:
  service: camera.play_stream
  data:
    entity_id: camera.yourcamera
    media_player: media_player.chromecast
```

#### `record` 서비스

카메라 스트림에서 녹화를 `.mp4` 로 만듭니다. `stream` 통합구성요소가 사전에 설정되어야 합니다.

`duration` 과 `lookback` 두 옵션 모두 쓸 수 있지만, 해당 카메라마다 일치해야합니다. 실제 녹음 길이는 다를 수 있습니다. 필요에 따라 이러한 설정을 조정하는 것이 좋습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 예로서 스냅샷을 생성할 이름은 `camera.living_room_camera`로 정할 수 있습니다. |
| `filename`             |      no  | 파일 이름의 템플릿. 변수는 `entity_id`, 예: {% raw %}`/tmp/{{ entity_id }}.mp4`{% endraw %}. |
| `duration`             |      yes | 목표 녹화 길이 (초) 기본값: 30 |
| `lookback`             |      yes | 추가 지속 시간에 더해질 목표 전환 시간 (초)입니다. 현재 활성화된 HLS 스트림이 있는 경우에만 사용할 수 있습니다. Default: 0 |

`filename`의 경로는 `whitelist_external_dirs`에  `configuration.yaml` 파일에서 [`homeassistant:`](/docs/configuration/basic/) 섹션에 속한 항목이 되어야 합니다. 

예를 들어, 자동화에서 다음 작업을 수행하면 “yourcamera” 에서 녹화된 후 타임스탬프가 기록된 파일 이름으로 /tmp에 저장됩니다.

{% raw %}
```yaml
action:
  service: camera.record
  data:
    entity_id: camera.yourcamera
    filename: '/tmp/{{ entity_id }}_{{ now().strftime("%Y%m%d-%H%M%S") }}.mp4'
```
{% endraw %}

#### `snapshot` 서비스

카메라에서 스냅샷을 찍습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      no  | 예를 들어에서 스냅샷을 생성할 엔티티의 이름은 `camera.living_room_camera`입니다. |
| `filename`             |      no  | 파일 이름의 템플릿. 변수는 `entity_id`, 예: {% raw %}`/tmp/snapshot_{{ entity_id }}`{% endraw %}. |

`filename`의 경로는 `whitelist_external_dirs`에  `configuration.yaml` 파일에서 [`homeassistant:`](/docs/configuration/basic/) 섹션에 속한 항목이 되어야 합니다. 

예를 들어, 자동화에서 다음 작업을 수행하면 “yourcamera”에서 녹화된 후 타임스탬프가 기록된 파일 이름으로 /tmp에 저장됩니다.

{% raw %}
```yaml
action:
  service: camera.snapshot
  data:
    entity_id: camera.yourcamera
    filename: '/tmp/yourcamera_{{ now().strftime("%Y%m%d-%H%M%S") }}.jpg'
```
{% endraw %}

#### `turn_off` 서비스

카메라를 끕니다. 모든 카메라 모델이 이 서비스를 지원하는 것은 아닙니다. 개별 카메라 페이지를 참조하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |     yes  | 끄려는 엔티티 이름 (예:`camera.living_room_camera`). |

#### `turn_on` 서비스

카메라를 켭니다. 모든 카메라 모델이 이 서비스를 지원하는 것은 아닙니다. 개별 카메라 페이지를 참조하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |     yes  | 켜려는 엔티티 이름 (예:`camera.living_room_camera`).      |

### 작동 테스트

`camera` 플랫폼을 올바르게 설정했는지 테스트하는 간단한 방법은, **개발자 도구** 에서 <img src='/images/screenshots/developer-tool-services-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> **Services** 를 사용하는 것입니다. **Service** 드롭 다운 메뉴에서 선택하고, **Service Data** 필드에 다음과 같은 샘플을 입력 후 , **CALL SERVICE**를 눌러보세요.

```yaml
entity_id: camera.living_room_camera
```
