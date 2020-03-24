---
title: 푸시불릿(Pushbullet)
description: Instructions on how to read user pushes in Home Assistant
logo: pushbullet.png
ha_category:
  - Sensor
  - Notifications
ha_release: 0.44
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/WxvXQ8ShbEU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Sensor](#sensor)
- [Notifications](#notifications)

<div class='note'>

프리 티어는 한 달에 500 회의 푸시로 [limited](https://docs.pushbullet.com/#push-limit) 됩니다.

</div>

### Sensor

`pushbullet` 센서 플랫폼은 무료 서비스인 [Pushbullet](https://www.pushbullet.com/)에서 휴대전화, 브라우저 및 친구간에 정보를 보내는 메시지를 읽습니다. 이 센서 플랫폼은 최근에 수신된 Pushbullet 알림 미러의 속성을 보여주는 센서를 제공합니다.

### 셋업

알림 미러링을 사용하면 컴퓨터에서 Android 기기의 알림을 볼 수 있습니다. 앱에서 먼저 활성화해야 하며 현재 Android 플랫폼에서만 사용할 수 있습니다. 자세한 내용은 Pushbullet 블로그의 [this announcement](https://blog.pushbullet.com/2013/11/12/real-time-notification-mirroring-from-android-to-your-computer/)를 참조하십시오. .

API 키/액세스 토큰을 검색하려면 [https://www.pushbullet.com/#settings/account](https://www.pushbullet.com/#settings/account)로 이동하십시오.

### 설정

설치시 Pushbullet 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: pushbullet
    api_key: YOUR_API_KEY
    monitored_conditions:
      - body
```

{% configuration %}
api_key:
  description: Pushbullet API 키.
  required: true
  type: string
monitored_conditions:
  description: 모니터한 푸쉬의 속성.
  required: false
  default: "`body` and `title`"
  type: list
  keys:
    application_name:
      description: 푸시를 보내는 애플리케이션.
    body:
      description: 메시지 본문.
    notification_id:
      description: 알림의 ID.
    notification_tag:
      description: 태그 (응용 프로그램에서 지원하는 경우)
    package_name:
      description: 발신자의 패키지 이름.
    receiver_email:
      description: 푸시 대상의 이메일.
    sender_email:
      description: 푸시 발신자.
    source_device_iden:
      description: 발신자 기기의 ID.
    title:
      description: 푸시의 제목.
    type:
      description: Type of push.
{% endconfiguration %}

모든 properties가 attributes으로 표시됩니다. properties 배열은 여러 properties에 대한 센서 판독값을 기록하기 위한 것입니다.

## 알림 (Notifications)

`pushbullet` 알림 플랫폼은 [Pushbullet](https://www.pushbullet.com/)에 메시지를 보내며, 이 서비스는 휴대 전화, 브라우저 및 친구간에 정보를 무료로 제공합니다. 프리 티어는 [limited](https://docs.pushbullet.com/#push-limit)으로 매월 500 회의 푸시로 제한됩니다.

설치시 Pushbullet 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: pushbullet
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Pushbullet의 API 키를 입력하십시오. API 키/액세스 토큰을 검색하려면 [https://www.pushbullet.com/#settings/account](https://www.pushbullet.com/#settings/account)로 이동하십시오.
  required: true
  type: string
name:
  description: 선택적 매개 변수 `name`을 설정하면 여러 알리미(notifier)를 만들 수 있습니다. 기본값은 `notify` 입니다. 알리미(notifier)는 서비스 `notify.NOTIFIER_NAME`에 바인딩합니다.
  required: false
  default: notify
  type: string
{% endconfiguration %}

### 사용법

Pushbullet은 알림 플랫폼이므로 알림 서비스 [as described here](/integrations/notify/)를 호출하여 제어할 수 있습니다. Pushbullet 계정에 등록된 모든 장치에 알림을 보냅니다. 특정 계정의 장치, 연락처 또는 채널을 지정하기 위해 선택적인 **target** 매개 변수를 Pushbullet에 제공할 수 있습니다.

Type | Prefix | Suffix | Example
---- | ------ | ------ | -------
Device | `device/` | Device nickname | `device/iphone`
Channel | `channel/` | Channel tag | `channel/my_home`
Email | `email/` | Contact's email address | `email/email@example.com`

대상을 사용하는 경우 자신의 계정의 전자 메일 주소가 'send to all devices'로 작동합니다. 이메일을 제외한 모든 대상은 전송전에 확인됩니다 (있는 경우).

#### 서비스 페이로드의 예 

```json
{
  "message": "A message for many people",
  "target": [
    "device/telephone",
    "email/hello@example.com",
    "channel/my_home"
  ]
}
```

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.

### URL 지원

```yaml
action:
  service: notify.NOTIFIER_NAME
  data:
    title: Send URL
    message: This is an url
    data:
      url: google.com
```

- **url** (*Required*): Pushbullet과 함께 보낼 페이지 URL입니다

### File 지원

```yaml
action:
  service: notify.NOTIFIER_NAME
  data:
    title: Send file
    message: This is a file
    data:
      file: /path/to/my/file
```

- **file** (*Required*): Pushbullet과 함께 보낼 파일.

### File URL support

```yaml
action:
  service: notify.NOTIFIER_NAME
  data:
    title: Send file
    message: This is a file URL
    data:
      file_url:  https://cdn.pixabay.com/photo/2014/06/03/19/38/test-361512_960_720.jpg
```

- **file_url** (*Required*): Pushbullet과 함께 보낼 파일.

### 단일 대상 

```yaml
  action:
    service: notify.NOTIFIER_NAME
    data:
      title: "Send to one device"
      message: "This only goes to one specific device"
      target: device/DEVICE_NAME
```

- **target**: 알림을 수신할 Pushbullet 장치.

<div class='note'>

[whitelist external directories](/docs/configuration/basic/)을 잊지 마십시오. 그래야 홈어시스턴트가 액세스 할 수 있습니다.

</div>
