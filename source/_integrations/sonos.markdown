---
title: Sonos(소노스)
description: Instructions on how to integrate Sonos devices into Home Assistant.
logo: sonos.png
ha_category:
  - Media Player
featured: true
ha_release: 0.7.3
ha_iot_class: Local Push
ha_config_flow: true
---

`sonos` 통합구성요소를 통해 Home Assistant에서 [Sonos](https://www.sonos.com) 무선 스피커를 제어 할 수 있습니다. IKEA Symfonisk 스피커와도 작동합니다.

설정 패널 내부의 통합구성요소 페이지로 이동하여 Sonos 통합구성요소를 설정할 수 있습니다.

## 서비스

Sonos 통합은 다양한 맞춤형 서비스를 제공합니다.

### `sonos.snapshot` 서비스

하나 이상의 스피커에서 현재 재생중인 내용의 스냅샷을 만듭니다. 이 서비스와 다음 서비스는 초인종 또는 알림음을 재생하고 나중에 재생을 다시 시작하려는 경우에 유용합니다. `entity_id` 가 제공되지 않으면 모든 스피커가 스냅샷됩니다.

<div class='note'>

큐(queue)는 스냅샷되지 않으며 복원할 때까지 그대로 유지해야합니다. `media_player.play_media`를 사용하면 안전하며 [TTS](/integrations/tts/) 알림을 포함한 알림 사운드를 재생하는 데 사용할 수 있습니다.

</div>

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 스냅샷 할 스피커입니다..
| `with_group` | yes | 그룹 레이아웃과 그룹에 있는 다른 스피커의 상태도 스냅샷으로 설정하면 기본값은 true입니다.

### `sonos.restore` 서비스

하나 이상의 스피커의 이전에 찍은 스냅샷을 복원합니다. `entity_id`가 제공되지 않으면 모든 스피커가 복원됩니다.

<div class='note'>

재생 대기열(queue)이 스냅샷되지 않습니다. 대기열을 교체한 스피커에서 `sonos.restore`를 사용하면 재생 위치가 복원되지만 새 대기열에서 복원됩니다! 

</div>

<div class='note'>
클라우드 대기열을 다시 시작할 수 없습니다. 여기에는 Spotify 내에서 시작된 대기열과 Amazon Alexa가 제어하는 ​​대기열이 포함됩니다.
</div>

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | 스냅샷을 복원해야하는 문자열 또는 `entity_id` 목록.
| `with_group` | yes | 그룹 레이아웃과 그룹에 있는 다른 스피커의 상태도 복원하면 기본값은 true입니다.

### `sonos.join` 서비스

단일 코디네이터 아래에 플레이어를 그룹화하십시오. 새 그룹을 만들거나 기존 그룹에 가입합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `master` | no | A single `entity_id` that will become/stay the coordinator speaker. 
| `entity_id` | yes | String or list of `entity_id`s to join to the master.

### `sonos.unjoin` 서비스

스피커 그룹에서 하나 이상의 스피커를 제거하십시오. `entity_id`가 제공되지 않으면 모든 스피커가 연결 해제됩니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | yes | String or list of `entity_id`s to separate from their coordinator speaker.

### `sonos.set_sleep_timer` 서비스

일정 시간이 지나면 볼륨을 0으로 줄임으로써 스피커를 끄는 타이머를 설정합니다. 팁 : sleep_time 값을 0으로 설정하면 스피커가 즉시 볼륨을 낮추기 시작합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that will have their timers set.
| `sleep_time` | no | Integer number of seconds that the speaker should wait until it starts tapering. Cannot exceed 86399 (one day).

### `sonos.clear_sleep_timer` 서비스

스피커에서 슬립 타이머가 설정되어 있으면 지워버립니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that will have their timers cleared. Must be a coordinator speaker.

### `sonos.update_alarm` 서비스

기존 Sonos 알람을 업데이트하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that will have their timers cleared. Must be a coordinator speaker.
| `alarm_id` | no | Integer that is used in Sonos to refer to your alarm.
| `time` | yes | Time to set the alarm.
| `volume` | yes | Float for volume level.
| `enabled` | yes | Boolean for whether or not to enable this alarm.
| `include_linked_zones` | yes | Boolean that defines if the alarm also plays on grouped players.

### `sonos.set_option` 서비스

Sonos 스피커 옵션을 설정하십시오.

Night Sound 및 Speech Enhancement 모드는 Sonos Playbar 및 Sonos Beam과 같은 제품의 TV 소스에서 재생할 때만 지원됩니다. 다른 스피커 유형은 이 옵션을 무시합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that will have their options set.
| `night_sound` | yes | Boolean to control Night Sound mode.
| `speech_enhance` | yes | Boolean to control Speech Enhancement mode.

### `sonos.play_queue` 서비스

Sonos 대기열 재생을 시작합니다.

대기열 재생을 강제로 시작하면 다른 스트림 (예 : 라디오)에서 대기열 재생으로 전환 할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that will start playing. It must be the coordinator if targeting a group.
| `queue_position` | yes | Position of the song in the queue to start playing from, starts at 0.

## 고급 사용

고급 사용을 위해 사용 가능한 일부 수동 설정 옵션이 있습니다. 이들은 일반적으로 Home Assistant와 Sonos가 동일한 서브넷에 있지 않은 복잡한 네트워크 설정이있는 경우에만 필요합니다.

Sonos IP 주소를 지정하여 자동 검색을 비활성화 할 수 있습니다. :


```yaml
# Example configuration.yaml entry with manually specified Sonos IP addresses
sonos:
  media_player:
    hosts:
      - 192.0.2.25
      - 192.0.2.26
      - 192.0.2.27
```

Home Assistant 서버에 여러 IP 주소가 있는 경우 Sonos 자동 검색에 사용해야 하는 IP 주소를 제공 할 수 있습니다. 기본적으로 모든 주소를 시도해야 하므로 이는 거의 필요하지 않습니다.

```yaml
# Example configuration.yaml entry using Sonos discovery on a specific interface
sonos:
  media_player:
    interface_addr: 192.0.2.1
```

Sonos 스피커는 (TCP 포트 1400을 사용하여) 변경 이벤트를 전달하기 위해 홈어시스턴트에 다시 연결을 시도합니다. Docker 옵션 `--net=host`를 사용하는 _not_ 와 같은 NAT 시나리오에서 도움이 될 수 있습니다.

```yaml
# Example configuration.yaml entry modifying the advertised host address
sonos:
  media_player:
    advertise_addr: 192.0.2.1
```
