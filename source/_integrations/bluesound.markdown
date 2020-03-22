---
title: 블루사운드(Bluesound)
description: Instructions on how to integrate Bluesound devices into Home Assistant.
logo: bluesound.png
ha_category:
  - Media Player
ha_release: 0.51
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/BcHIngIOlLo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`bluesound` 플랫폼을 사용하면 Home Assistant의 [Bluesound](https://www.bluesound.com/) HiFi 무선 스피커 및 오디오 통합구성요소를 제어할 수 있습니다.

새 장치를 자동으로 검색하려면 `configuration.yaml` 파일에서 `discovery:` 가 있는지 확인하십시오. Bluesound 장치를 수동으로 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml
media_player:
  - platform: bluesound
    hosts:
      - host: 192.168.1.100
```

{% configuration %}
hosts:
  description: Bluesound 장치 리스트.
  required: false
  type: list
  keys:
    host:
      description: 플레이어의 IP 주소 또는 호스트 이름.
      required: true
      type: string
    name:
      description: 프런트 엔드에 사용된 장치의 이름.
      required: false
      type: string
    port:
      description: 장치와 통신하기위한 포트.
      required: false
      default: 11000
      type: integer
{% endconfiguration %}

## 고급 설정 사례

```yaml
# Example configuration.yaml entry with manually specified addresses
media_player:
  - platform: bluesound
    hosts:
      - host: 192.168.1.100
        name: bluesound_kitchen
        port: 11000
      - host: 192.168.1.131
```

### `bluesound.join` 서비스

단일 마스터 스피커로 플레이어를 그룹화하십시오. 새 그룹을 만들거나 기존 그룹에 가입합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `master` | no | A single `entity_id` that will become/hold the master speaker.
| `entity_id` | no | String or list of a single `entity_id` that will group to master speaker.

### `bluesound.unjoin` 서비스

스피커 그룹에서 하나 이상의 스피커를 제거합니다. `entity_id`가 제공되지 않으면 모든 스피커가 연결 해제됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | String or list of `entity_id`s that will be separated from their master speaker.

### `bluesound.set_sleep_timer` 서비스

스피커를 끄는 타이머를 설정합니다. 이를 호출할 때마다 시간이 한 단계씩 증가합니다. 단계는 (분) : 15, 30, 45, 60, 90, 0입니다. 예를 들어 13 분의 진행 타이머를 늘리면 15로 증가합니다. 타이머가 90으로 설정되면 제거됩니다. 시간 (따라서 0).

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that will have their timers set.

### `bluesound.clear_sleep_timer` 서비스

스피커에서 슬립 타이머가 설정되어 있으면 삭제합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that will have their timers cleared.
