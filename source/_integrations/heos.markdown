---
title: 데논 HEOS
description: Instructions on how to integrate Denon HEOS into Home Assistant.
logo: heos.png
ha_category:
  - Media Player
ha_release: 0.92
ha_iot_class: Local Push
ha_config_flow: true
ha_codeowners:
  - '@andrewsayre'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/ck6UGL8G7Cs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

HEOS 통합구성요소는 스피커, 앰프 및 수신기 (Denon 및 Marantz)와 같은 [HEOS](http://heosbydenon.denon.com) 가능 제품에 대한 지원을 Home Assistant에 추가합니다. 현재 기능은 다음과 같습니다.

- 각 장치는 미디어 플레이어 엔티티로 표시됩니다
- 현재 재생중인 미디어보기
- 재생 모드 (재생, 일시 정지, 중지, 다음 및 이전), 볼륨, 음소거 및 셔플 제어
- 재생 목록 지우기
- 장치 물리적 입력 및 HEOS 즐겨 찾기에서 소스 선택

## 설정

[discovery](/integrations/discovery) 통합구성요소가 활성화 되면 HEOS 장치가 자동으로 검색되고 설정됩니다 . 또는 프론트 엔드 제어판 통합 페이지를 통해 또는 `configuration.yaml` 파일에 다음을 추가하여 수동으로 연동을 설정할 수 있습니다 .

```yaml
# Example configuration.yaml entry
heos:
  host: IP_ADDRESS
```

{% configuration %}
host:
  description: "장치의 주소입니다. 예 : 192.168.1.32"
  required: true
  type: string
{% endconfiguration %}

<div class='note info'>
단일 장치에 연결하면 네트워크의 모든 장치를 제어할 수 있습니다. HEOS 장치가 여러 개인 경우 유선을 통해 LAN에 연결되거나 무선 신호가 가장 강한 호스트를 입력하십시오.
</div>

## 서비스

### `heos.sign_in` 서비스

로그인 서비스를 사용하여 HEOS 즐겨찾기 및 재생 목록을 검색하고 재생할 수 있도록 연결된 컨트롤러를 HEOS 계정에 서명하십시오. 로그인에 실패하면 오류 메시지가 기록됩니다. 서비스 데이터 페이로드 예 :

```json
{
  "username": "example@example.com",
  "password": "password"
}
```

| Attribute              | Description
| ---------------------- | ---------------------------------------------------------|
| `username`             | HEOS 계정의 사용자 이름 또는 이메일. [필수]
| `password`             | HEOS 계정의 비밀번호입니다. [필수]

### `heos.sign_out` 서비스

사인 아웃 서비스를 사용하여 HEOS 계정에서 연결된 컨트롤러에 사인 아웃하십시오. 로그 아웃에 실패하면 오류 메시지가 기록됩니다. 이 서비스에는 매개 변수가 없습니다.

### `media_player.play_media` 서비스

#### 즐겨찾기 재생

`media_player.play_media` 서비스를 통해 번호 또는 이름으로 HEOS 즐겨 찾기를 재생할 수 있습니다. 서비스 데이터 페이로드 예 :

```json
{
  "entity_id": "media_player.office",
  "media_content_type": "favorite",
  "media_content_id": "1"
}
```

| Attribute              | Description
| ---------------------- | ---------------------------------------------------------|
| `entity_id`            | `entity_id` of the player
| `media_content_type`   | Set to the value `favorite`
| `media_content_id`     | The nubmer (i.e. `1`) or name (i.e. `Thumbprint Radio`) of the HEOS favorite

#### 플레이 리스트 재생

`media_player.play_media` 서비스를 통해 HEOS 플레이 리스트를 재생할 수 있습니다 . 서비스 데이터 페이로드 예 :

```json
{
  "entity_id": "media_player.office",
  "media_content_type": "playlist",
  "media_content_id": "Awesome Music"
}
```

| Attribute              | Description
| ---------------------- | ---------------------------------------------------------|
| `entity_id`            | `entity_id` of the player
| `media_content_type`   | Set to the value `playlist`
| `media_content_id`     | The name of the HEOS playlist

#### 빠른 선택 재생

`media_player.play_media` 서비스를 통해 nubmer 또는 이름으로 HEOS Quick Select를 재생할 수 있습니다 . 서비스 데이터 페이로드 예 :

```json
{
  "entity_id": "media_player.office",
  "media_content_type": "quick_select",
  "media_content_id": "1"
}
```

| Attribute              | Description
| ---------------------- | ---------------------------------------------------------|
| `entity_id`            | `entity_id` of the player
| `media_content_type`   | Set to the value `quick_select`
| `media_content_id`     | The quick select number (i.e. `1`) or name (i.e. `Quick Select 1`)

#### Url 재생

`media_player.play_media` 서비스를 사용하여 HEOS 미디어 플레이어를 통해 URL을 재생할 수 있습니다. HEOS 플레이어는 URL에 도달할 수 있어야합니다. 서비스 데이터 페이로드 예 :

```json
{
  "entity_id": "media_player.office",
  "media_content_type": "url",
  "media_content_id": "http://path.to/stream.mp3"
}
```

| Attribute              | Description
| ---------------------- | ---------------------------------------------------------|
| `entity_id`            | `entity_id` of the player to play the URL
| `media_content_type`   | Set to the value `url`
| `media_content_id`     | The full URL to the stream

## Notes

- HEOS 그룹은 현재 지원되지 않습니다.
- 영역(zone)이 여러 개인 수신기는 단일 미디어 플레이어로 표시됩니다. 재생이 시작되면 켜지지만 현재 연동에선 끌 수 없습니다.

## 문제 해결

### 디버깅

HEOS 통합은 로그 레벨이 `debug`로 설정되면 명령, 이벤트 및 기타 메시지에 대한 추가 정보를 기록합니다. 디버그 로깅을 활성화하려면 아래의 관련 줄을 `configuration.yaml`에 추가하십시오. :

```yaml
logger:
  default: info
  logs:
    homeassistant.components.heos: debug
    pyheos: debug
```

### 즐겨찾기 누락

HEOS 컨트롤러가 HEOS 계정에 로그인하지 않으면 HEOS 즐겨찾기가 미디어 플레이어 소스 선택에 채워지지 않고 `favorite` 및 `playlist`에 대한 `media_player.play_media` 서비스가 실패합니다. 또한 시작시 다음 경고가 기록됩니다. :
> IP_ADDRESS가 HEOS 계정에 로그인되어 있지 않으며 HEOS 즐겨 찾기를 검색 할 수 없습니다. 'heos.sign_in' 서비스를 사용하여 HEOS 계정에 로그인하십시오.

이 문제를 해결하려면 `heos.sign_in` 서비스를 사용하여 위에서 설명한대로 계정에 컨트롤러에 서명하십시오. 계정 자격 증명이 유효한 동안 컨트롤러는 로그인 상태를 유지하므로이 작업은 한 번만 수행하면됩니다.