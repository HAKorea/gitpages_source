---
title: 트랜스미션(Transmission)
description: Instructions on how to integrate Transmission within Home Assistant.
logo: transmission.png
ha_category:
  - Downloading
  - Switch
  - Sensor
ha_release: 0.87
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@engrbm87'
  - '@JPHutchins'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/2bBoHjqCEa8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`transmission` 연동을 통해 홈어시스턴트에서  [Transmission](https://www.transmissionbt.com/)을 통해 다운로드를 모니터링하고 정보를 기반으로 자동화를 설정할 수 있습니다.

## 셋업

모니터링을 사용하려면 전송 클라이언트가 원격 액세스를 허용해야합니다. 그래픽 전송 클라이언트 (transmission-gtk)를 실행중인 경우 **Edit** -> **Preferences** 으로 이동하여 **Remote** 탭을 선택하십시오. **Allow remote access***을 선택하고 사용자 이름과 비밀번호를 입력한 다음 필요에 따라 네트워크 제한을 해제하십시오.

<p class='img'>
  <img src='{{site_root}}/images/integrations/transmission/transmission_perf.png' />
</p>

모든 것이 올바르게 설정되면 세부 정보가 프론트 엔드에 나타납니다.

<p class='img'>
  <img src='{{site_root}}/images/integrations/transmission/transmission.png' />
</p>

## 설정

**설정** -> **통합구성요소**-> **Transmission**을 통해 연동을 설정하십시오. 레거시 지원을 위해 이전 전송 설정을 가져 와서 새로운 통합구성요소로 설정합니다. `monitored_condiditions` 는 이제 홈어시스턴트에 자동으로 추가되므로 제거하십시오

이 센서를 활성화하려면`configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
transmission:
  host: 192.168.1.1
```

{% configuration %}
host:
  description: "This is the IP address of your Transmission daemon, e.g., `192.168.1.1`."
  required: true
  type: string
port:
  description: The port your Transmission daemon uses.
  required: false
  type: integer
  default: 9091
name:
  description: The name to use when displaying this Transmission instance in the frontend.
  required: false
  type: string
username:
  description: Your Transmission username, if you use authentication.
  required: false
  type: string
password:
  description: Your Transmission password, if you use authentication.
  required: false
  type: string
scan_interval:
  description: How frequently to query for new data. Defaults to 120 seconds.
  required: false
  type: integer
{% endconfiguration %}
  
## 통합구성요소 엔티티들

Transmission 통합구성요소는 다음 센서 및 스위치를 추가합니다.

Sensors:
- transmission_current_status: The status of your Transmission daemon.
- transmission_download_speed: The current download speed [MB/s].
- transmission_upload_speed: The current upload speed [MB/s].
- transmission_active_torrents: The current number of active torrents.
- transmission_paused_torrents: The current number of paused torrents.
- transmission_total_torrents: The total number of torrents present in the client.
- transmission_started_torrents: The current number of started torrents (downloading).
- transmission_completed_torrents: The current number of completed torrents (seeding)

Switches:
- transmission_switch: A switch to start/stop all torrents
- transmission_turtle_mode: A switch to enable turtle mode.


## 이벤트 자동화

Transmission 통합구성요소는 대상 클라이언트의 토렌트 상태를 지속적으로 모니터링합니다. 토렌트가 시작되거나 완료되면 홈어시스턴트 버스에서 이벤트가 트리거되어 모든 종류의 자동화를 구현할 수 있습니다.

가능한 이벤트는 다음과 같습니다. : 

- transmission_downloaded_torrent
- transmission_started_torrent

이벤트 내부에는 전송 사용자 인터페이스에서 볼 수 있듯이 시작되거나 완료된 토렌트 이름이 있습니다.

토렌트가 완성된 자동화 설정의 예 :

{% raw %}
```yaml
- alias: Completed Torrent
  trigger:
    platform: event
    event_type: transmission_downloaded_torrent
  action:
    service: notify.telegram_notifier
    data_template:
      title: "Torrent completed!"
      message: "{{trigger.event.data.name}}"
```
{% endraw %}

## 서비스

### `add_torrent` 서비스

다운로드 할 새 토렌트를 추가합니다. URL (http, https 또는 ftp), magnet 링크 또는 로컬 파일일 수 있습니다 (경로가 [white listed](/docs/configuration/basic/#whitelist_external_dirs)인지 확인).

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `name`    | no | Name of the configured instance
| `torrent` | no | Torrent to download


## 템플레이팅(Templating)

### Sensor `started_torrents`

state 속성 `torrent_info`는 현재 다운로드중인 토렌트에 대한 정보를 포함합니다. **개발자 도구**-> **state** -> `sensor.transmission_started_torrents` -> **Attributes**에서 혹은 마크 다운 카드를 Lovelace에 추가하여 이 정보를 볼 수 있습니다.

{% raw %}
```yaml
content: >
  {% set payload = state_attr('sensor.transmission_started_torrents', 'torrent_info') %}

  {% for torrent in payload.items() %} {% set name = torrent[0] %} {% set data = torrent[1] %}
  
  {{ name|truncate(20) }} is {{ data.percent_done }}% complete, {{ data.eta }} remaining {% endfor %}
type: markdown
```
{% endraw %}
