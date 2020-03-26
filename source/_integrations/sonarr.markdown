---
title: 컨텐츠리스트자동화(Sonarr)
description: Instructions on how to integrate Sonarr sensors with Home Assistant
logo: sonarr.png
ha_category:
  - Downloading
ha_release: 0.34
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/0Pm-qOSKvyo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 `sonarr` 센서 플랫폼은 주어진 [Sonarr](https://sonarr.tv/) 인스턴스에서 데이터를 가져옵니다.

## 설정

설치에서 Sonarr 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sonarr
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  required: true
  type: string
  description: "Your Sonarr API key, found in Settings > General in the Sonarr Web UI."
host:
  required: false
  type: string
  description: The host Sonarr is running on.
  default: "`localhost`"
port:
  required: false
  type: integer
  description: The port Sonarr is running on.
  default: 8989
monitored_conditions:
  type: list
  required: false
  description: Conditions to display on the frontend.
  default: "`upcoming`"
  keys:
    series:
      description: The number of series in Sonarr.
    upcoming:
      description: The number of upcoming episodes.
    wanted:
      description: The number of episodes still 'wanted'.
    queue:
      description: The number of episodes in the queue.
    commands:
      description: The number of commands being run.
    diskspace:
      description: Available disk space.
urlbase:
  required: false
  type: string
  description: The base URL Sonarr is running under.
  default: "`/`"
days:
  required: false
  type: integer
  description: How many days to look ahead for the upcoming sensor, 1 means today only.
  default: 1
include_paths:
  required: false
  type: list
  description: Array of file paths to include when calculating diskspace. Leave blank to include all.
unit:
  required: false
  type: string
  description: The unit to display disk space in.
  default: GB
ssl:
  required: false
  type: boolean
  description: Whether or not to use SSL for Sonarr.
  default: false
{% endconfiguration %}

## 사례

본 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 다음 2 일 동안 방송되는 에피소드를 가져오기

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sonarr
    api_key: YOUR_API_KEY
    host: 192.168.1.8
    monitored_conditions:
      - upcoming
    days: 2
```

### SSL 활성화

SSL은 기본값 (8989)과 다른 포트에서 실행될 수 있습니다. SSL 포트는 Sonarr의 모든 포트에 바인딩될 수 있으므로 별도로 설정되야합니다 (8989로 변경되지 않은 경우). Sonarr의 SSL에 대한 자세한 내용은 [Sonarr site](https://github.com/Sonarr/Sonarr/wiki/SSL)를 참조하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sonarr
    api_key: YOUR_API_KEY
    host: 192.168.1.8
    port: 9898
    monitored_conditions:
      - upcoming
    days: 2
    ssl: true
```

### 모든 저장 위치에 디스크 공간 확보

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sonarr
    api_key: YOUR_API_KEY
    host: 192.168.1.8
    monitored_conditions:
      - diskspace
```

### 리스트된 저장 위치에 디스크 공간 확보

Sonarr가 반환하는 저장 위치는 시스템 페이지에 있으며 하위 경로가 별도로 마운트된 경우 중복되게 나열될 수 있습니다. 포함할 경로를 나열하여 센서가 보고할 데이터를 선택할 수 있습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sonarr
    api_key: YOUR_API_KEY
    host: 192.168.1.8
    monitored_conditions:
      - diskspace
    include_paths:
      - /tank/plex
```

### 다른 단위로 디스크 공간 확보

Sonarr API는 사용 가능한 공간을 바이트 단위로 반환하지만 이 센서는 기본적으로 GB 단위로 보고하여 숫자를 보다 관리하기 쉽게 만듭니다. 스토리지에 다른 장치가 필요한 경우 이를 대체할 수 있습니다. 바이트(B)에서 요타 바이트(YB)까지 모든 단위가 지원됩니다.

*이 계산은 base 2 math을 사용하여 수행되며 base 10 math을 사용하여 계산하는 시스템과 다를 수 있습니다.*

```yaml
# Example configuration.yaml entry
sensor:
  - platform: sonarr
    api_key: YOUR_API_KEY
    host: 192.168.1.8
    monitored_conditions:
      - diskspace
    unit: TB
```
