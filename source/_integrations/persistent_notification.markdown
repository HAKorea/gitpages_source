---
title: Persistent notifications
description: Instructions on how to integrate persistent notifications into Home Assistant.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.23
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

<iframe width="692" height="388" src="https://www.youtube.com/embed/SQOJwWQgUno" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`persistent_notification` 통합구성요소는 사용자에 의해 해제해야하는 프론트 엔드에 필수 알림을 표시하는 데 사용할 수 있습니다.

<p class='img'>
  <img src='/images/screenshots/persistent-notification.png' />
</p>

### 서비스

`persistent_notification.create` 서비스는 `message`, `title`, `notification_id`를 받습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `message`              |       no | 알림 본문.
| `title`                |      yes | 알림 제목.
| `notification_id`      |      yes | `notification_id`가 주어지면, 해당 ID를 가진 알림이 이미있는 경우 알림을 덮어 씁니다.

`persistent_notification` 통합구성요소는 `message`와 `title` 모두에 대해 [templates](/topics/templating/)에서 특정할 수 있도록 지원합니다. 이를 통해 알림에 현재 홈어시스턴트 상태를 사용할 수 있습니다.

[automation setup](/getting-started/automation/)의 [action](/getting-started/automation-action/)에서 Custom subject를 사용하면 다음과 같이 진행할 수 있습니다. 

```yaml
action:
  service: persistent_notification.create
  data:
    message: "Your message goes here"
    title: "Custom subject"
```

`persistent_notification.dismiss` 서비스는 `notification_id`가 필요합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `notification_id`      |      no  | `notification_id`는 제거해야 할 알림을 식별하는 데 필요합니다.

이 서비스를 사용하면 스크립트 또는 자동화로 알림을 제거 할 수 있습니다.

```yaml
action:
  service: persistent_notification.dismiss
  data:
    notification_id: "1234"
```

이 자동화 예제는 Z-Wave 네트워크가 시작될 때 알림을 표시하고 네트워크가 준비되면 알림을 제거합니다.

```yaml
- alias: 'Z-Wave network is starting'
  trigger:
    - platform: event
      event_type: zwave.network_start
  action:
    - service: persistent_notification.create
      data:
        title: "Z-Wave"
        message: "Z-Wave network is starting..."
        notification_id: zwave

- alias: 'Z-Wave network is ready'
  trigger:
    - platform: event
      event_type: zwave.network_ready
  action:
    - service: persistent_notification.dismiss
      data:
        notification_id: zwave
```

### Markdown 지원

message 속성은 [Markdown formatting syntax](https://daringfireball.net/projects/markdown/syntax)을 지원합니다. 샘플들은 다음과 같습니다. : 

| Type | Message |
| ---- | ------- |
| Headline 1 | `# Headline` |
| Headline 2 | `## Headline` |
| Newline | `\n` |
| Bold | `**My bold text**` |
| Cursive | `*My cursive text*` |
| Link | `[Link](https://home-assistant.io/)` |
| Image | `![image](/local/my_image.jpg)` |

<div class="note">

  `/local/` in this context refers to the `.homeassistant/www/` folder.

</div>

### persistent notification 만들기

**개발자 도구** 사이드 바 항목에서 **Services** 탭을 선택한 다음 "Services" 드롭 다운에서 `persistent_notification.create` 서비스를 선택하십시오. **Service Data** 필드에 아래 샘플과 같은 것을 입력하고 **CALL SERVICE** 버튼을 누릅니다.

```json
{
  "notification_id": "1234",
  "title": "Sample notification",
  "message": "This is a sample text"
}
```
위에 표시된 알림 항목이 생성됩니다.
