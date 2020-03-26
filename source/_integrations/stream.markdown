---
title: 스트림(Stream)
description: Instructions on how to integrate live streams within Home Assistant.
logo: home-assistant.png
ha_category:
  - Other
ha_release: '0.90'
ha_iot_class: Local Push
ha_quality_scale: internal
ha_codeowners:
  - '@hunterjm'
---

`stream` 통합구성요소는 홈어시스턴트를 통해 프록시 실시간 스트림을 할 수 있는 방법을 제공합니다. 본 통합구성요소는 현재 H.264 소스 스트림을 HLS 형식으로 프록시하는 것만 지원하며 FFmpeg >= 3.2 이상이 필요합니다.

## 설정

이 컴포넌트를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
stream:
```

### 서비스

`stream` 플랫폼은 일단 로드되면 다양한 작업을 수행하기 위해 호출할 수있는 서비스를 노출합니다.

#### record 서비스

제공된 스트림에서 `.mp4` record를 만듭니다. 이 서비스는 직접 호출할 수 있지만 [`camera.record`](/integrations/camera#service-record) 서비스에서 내부적으로 사용됩니다. 

`duration`, `lookback` 옵션은 모두 제안사항이지만 스트림 별로 일치해야합니다. 실제 녹음 길이는 다를 수 있습니다. 필요에 따라 이러한 설정을 조정하는 것이 좋습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `stream_source`        |      no  | 스트림의 입력 소스 (예: `rtsp://my.stream.feed:554`). |
| `filename`             |      no  | 파일 이름 문자열 (예: `/tmp/my_stream.mp4`). |
| `duration`             |      yes | 대상 녹화 길이 (초) , 기본값: 30 |
| `lookback`             |      yes | duration과 함께 포함할 lookback 기간(초)입니다. 현재 `stream_source`에 대한 활성 HLS 스트림이 있는 경우에만 사용할 수 있습니다, 기본값: 0 |

`filename`의 경로 부분은 `configuration.yaml` 파일의 [`homeassistant:`](/docs/configuration/basic/)섹션에 있는 `whitelist_external_dirs`의 항목이어야합니다.

예를 들어, 자동화에서 다음 액션은 `rtsp://my.stream.feed:554`에서 기록을 작성하여 `/config/www`에 저장합니다.

```yaml
action:
  service: camera.record
  data:
    entity_id: camera.quintal
    filename: '/config/www/my_stream.mp4'
    duration: 30
```

## Lovelace에서 스트리밍

Homeassistant 버전 0.92부터는 이제 카메라 피드를 lovelace로 직접 라이브 스트리밍할 수 있습니다. 이렇게 하려면 [picture-entity](/lovelace/picture-entity/), [picture-glance](/lovelace/picture-glance/) 혹은 [picture-elements](/lovelace/picture-elements/)들 중 하나를 추가하고,  `camera_image`를 stream-ready 카메라 엔티티로 설정하고 `camera_view`를 lovelace view 중 하나에 `live`로 설정하십시오.

## 문제 해결

수동 설치의 일부 사용자는 다시시작한 후 로그에 다음 오류가 표시될 수 있습니다 :

```text
2019-03-12 08:49:59 ERROR (SyncWorker_5) [homeassistant.util.package] Unable to install package av==6.1.2: Command "/home/pi/home-assistant/bin/python3 -u -c "import setuptools, tokenize;__file__='/tmp/pip-install-udfl2b3t/av/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-record-ftn5zmh2/install-record.txt --single-version-externally-managed --compile --install-headers /home/pi/home-assistant/include/site/python3.6/av" failed with error code 1 in /tmp/pip-install-udfl2b3t/av/
2019-03-12 08:49:59 ERROR (MainThread) [homeassistant.requirements] Not initializing stream because could not install requirement av==6.1.2
2019-03-12 08:49:59 ERROR (MainThread) [homeassistant.setup] Setup failed for stream: Could not install all requirements.
```

이 오류가 표시되면 다음 명령을 실행하고 Home Assistant를 다시시작하여 이 오류를 해결할 수 있습니다 (명령은 `homeassistant` 사용자로 실행할 필요는 없습니다).

```text
sudo apt-get install -y python-dev pkg-config libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev libavfilter-dev
```
