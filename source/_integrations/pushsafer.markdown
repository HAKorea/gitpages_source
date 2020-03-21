---
title: 푸쉬세이퍼(Pushsafer)
description: Instructions on how to add Pushsafer notifications to Home Assistant.
logo: pushsafer.png
ha_category:
  - Notifications
ha_release: 0.39
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/VAl7sFK92tQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Pushsafer 서비스](https://www.pushsafer.com/)는 알림 구성 요소를 위한 플랫폼입니다. 이를 통해 Pushsafer를 사용하여 사용자에게 메시지를 보낼 수 있습니다.

개인(private) 또는 별칭(alias) 키를 얻으려면 [Pushsafer 웹 사이트](https://www.pushsafer.com)로 이동하여 등록해야합니다.

Pushsafer 알림을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: pushsafer
    private_key: YOUR_KEY
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
private_key:
  description: Your private or alias key. Private key = send the notification to all devices with standard params, alias key send the notification to the devices stored in the alias with predefined params.
  required: true
  type: string
{% endconfiguration %}

### 사례

텍스트 형식의 두 장치에게 메시지. 

```yaml
action:
  service: notify.notify
  data:
    title: "Test to 2 devices"
    message: "Attention [b]bold[/b] text[br][url=https://www.pushsafer.com]Link to Pushsafer[/url]"
    data:
      icon: "2"
      iconcolor: "#FF0000"
      sound: "2"
      vibration: "1"
      url: "https://www.home-assistant.io/"
      urltitle: "Open Home Assistant"
      time2live: "0"
```

외부 URL에서 형식화 된 텍스트 및 이미지가 있는 하나의 장치에게 메시지

```yaml
action:
  service: notify.notify
  data:
    title: "Test to 1 device with image from an url"
    message: "Attention [i]italic[/i] Text[br][url=https://www.home-assistant.io/]Testlink[/url]"
    data:
      icon: "14"
      iconcolor: "#FFFF00"
      sound: "22"
      vibration: "31"
      url: "https://www.home-assistant.io/"
      urltitle: "Open Home Assistant"
      time2live: "60"
      picture1:
        url: "https://www.home-assistant.io/images/integrations/alexa/alexa-512x512.png"
```

형식화된 텍스트 및 로컬 이미지가 있는 두 개의 장치 및 하나의 장치 그룹에 대한 메시지

```yaml
action:
  service: notify.notify
  data:
    title: "Test to 3 devices with local image"
    message: "Attention [i]italic[/i] Text[br][url=https://www.home-assistant.io/]Testlink[/url]"
    target: ["1111","2222","gs3333"],
    data:
      icon: "20"
      iconcolor: "#FF00FF"
      sound: "33"
      vibration: "0"
      url: "https://www.home-assistant.io/"
      urltitle: "Open Home Assistant"
      time2live: "10"
      priority: "2"
      retry: "60"
      expire: "600"
      answer: "1"
      picture1: {
        path: "C:\\Users\\Kevin\\AppData\\Roaming\\.homeassistant\\image-760-testimage.jpg"
```

푸시 알림을 사용자 정의하려면 [Pushsafer API 설명](https://www.pushsafer.com/en/pushapi)을 살펴보십시오.

응용 프로그램을 설정할 때 이 [icon](/images/favicon-192x192.png)를 사용할 수 있습니다.

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.