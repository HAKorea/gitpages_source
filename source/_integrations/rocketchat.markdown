---
title: 로켓챗(Rocket.Chat)
description: Instructions on how to add Rocket.Chat notifications to Home Assistant.
logo: rocketchat.png
ha_category:
  - Notifications
ha_release: 0.56
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/IzJ11kvM-P8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`rocketchat` 알림 플랫폼을 사용하면 Home Assistant에서 [Rocket.Chat](https://rocket.chat/) 인스턴스로 메시지를 보낼 수 있습니다.

## 설정

설치에 Rocket.Chat을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - platform: rocketchat
    name: NOTIFIER_NAME
    url: https://rocketchat.example.com
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    room: YOUR_ROOM_NAME
```

- **name** (*Optional*): Name displayed in the frontend. The notifier will bind to the service `notify.NOTIFIER_NAME`.
- **url** (*Required*): The URL of your Rocket.Chat instance.
- **username** (*Required*): The Rocket.Chat username.
- **password** (*Required*): The Rocker.Chat password.
- **room** (*Required*): The chat room name to send messages to.

### script.yaml 예시

```yaml
rocketchat_notification:
  sequence:
  - service: notify.NOTIFIER_NAME
    data:
      message: "Message to Rocket.Chat from Home Assistant!"
      data:
        emoji: ":smirk:"
```

#### 메시지 변수(Message variables)

- **message** (*Required*): 나타낼 메시지입니다.
- **data** (*Optional*): [Rocket.Chat docs](https://rocket.chat/docs/developer-guides/rest-api/chat/postmessage#message-object-example)에 정의 된 변수를 포함하는 사전(dictionary)

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.