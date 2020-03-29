---
title: 오픈멀티룸오디오(Snapcast)
description: Instructions on how to integrate Snapcast into Home Assistant.
logo: snapcast.png
ha_category:
  - Media Player
ha_release: 0.13
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/oA0L4tSvPKk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`snapcast` 플랫폼을 사용하면 Home Assistant에서 [Snapcast](https://github.com/badaix/snapcast)를 제어할 수 있습니다.

Snapcast를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: snapcast
    host: YOUR_IP_ADDRESS
```

{% configuration %}
host:
  description: The IP address of the device, e.g., `192.168.0.10`.
  required: true
  type: string
port:
  description: The port number.
  required: false
  default: 1705
  type: integer
{% endconfiguration %}

## 서비스

snapcast 구성 요소는 media_player 구성 요소 아래에 등록된 몇 가지 서비스를 제공합니다.

### `snapcast.snapshot` 서비스

하나 이상의 스피커에서 현재 재생중인 내용의 스냅샷을 만듭니다. 이 서비스와 다음 서비스는 초인종 또는 알림음을 재생하고 나중에 재생을 재개하려는 경우에 유용합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | The speakers to snapshot.

### `snapcast.restore` 서비스

하나 이상의 스피커의 이전에 찍은 스냅샷을 복원합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s that should have their snapshot restored.

### `snapcast.join` 서비스

단일 그룹으로 플레이어를 그룹화하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `master` | no | Entity ID of the player to synchronize to.
| `entity_id` | yes | String or list of `entity_id`s to join to the master.

### `snapcast.unjoin` 서비스

스피커 그룹에서 하나 이상의 스피커를 제거하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | String or list of `entity_id`s to separate from their coordinator speaker.
