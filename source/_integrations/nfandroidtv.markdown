---
title: 안드로이드TV/FireTV 알림
description: Notifications for Android TV / FireTV
logo: nfandroidtv.png
ha_category:
  - Notifications
ha_release: 0.32
---

[Notifications for Android TV](https://play.google.com/store/apps/details?id=de.cyberdream.androidtv.notifications.google) 및 [Notifications for FireTV](https://play.google.com/store/apps/details?id=de.cyberdream.firenotifications.google) 알림 플랫폼. 이 플랫폼을 사용하여 Android TV 장치에 알림을 보낼 수 있습니다. 메시지 내용이 포함된 오버레이가 설정 가능한 시간 (초) 동안 나타난 다음 다시 사라집니다. 이미지 전송(예 : 보안 캠)도 지원됩니다.

알림은 Android TV 장치의 전체 범위에 있습니다. 실행중인 응용 프로그램에 관계없이 표시됩니다.

이를 설정하면 두 가지 앱이 있습니다. 하나는 스마트 폰에서 알림을 보내거나 (이 플랫폼에는 필요하지 않음) 하나는 Android TV 장치에서 알림을 받도록하는 것입니다. Android TV 앱스토어에서 사용 가능한 앱은 Home Assistant에서 보낸 알림을 표시하는 데 필요한 앱입니다. In-App 구매는 Android 스마트폰 클라이언트에만 적용되므로 Home Assistant에서 알림을 푸시 할 때 제한이 없습니다.

알림 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - platform: nfandroidtv
    name: Kitchen
    host: 192.168.1.12
```

{% configuration %}
name:
  description: 선택적 매개 변수 `name`을 설정하면 여러 알리미를 만들 수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME` 에 바인딩합니다.
  required: false
  default: notify
  type: string
host:
  description: Android TV/FireTV 장치의 IP 주소
  required: true
  type: string
duration:
  description: 알림이 표시되는 기간 (초)입니다.
  required: false
  default: 5
  type: integer
fontsize:
  description: "`small`, `medium`, `large`, `max` 중 하나 여야합니다."
  required: false
  default: medium
  type: string
position:
  description: "`bottom-right`, `bottom-left`, `top-right`, `top-left`, `center` 중 하나 여야합니다."
  required: false
  default: bottom-right
  type: string
color:
  description: "`grey`, `black`, `indigo`, `green`, `red`, `cyan`, `teal`, `amber`, `pink` 중 하나 여야합니다."
  required: false
  default: grey
  type: string
transparency:
  description: "`0%`, `25%`, `50%`, `75%`, `100%` 중 하나여야 합니다."
  required: false
  default: 25%
  type: string
timeout:
  description: 시간 초과.
  required: false
  default: 5
  type: integer
interrupt:
  description: "true로 설정된 경우, 알림은 대화식이며 자세한 내용을 표시하기 위해 해제하거나 선택할 수 있습니다. 실행중인 앱 (예 : Netflix)에 따라 재생이 중지 될 수 있습니다." 
  required: false
  default: false
  type: boolean
{% endconfiguration %}

설정은 IP로 지정된 호스트에 대한 알림의 기본값을 구성하는 데 사용됩니다. 그러나 서비스를 호출할 때 데이터 속성과 함께 전달하여 대부분의 설정을 무시할 수 있습니다. 
다음은 최종 알림의 모양을 테스트하는 데 사용할 수 있는 완전히 사용자 정의된 JSON입니다.

```json
{
"message": "Messagetext",
"title": "My Notification",
"data":{
    "fontsize": "large",
    "position":"center",
    "duration":2,
    "transparency":"0%",
    "color": "red",
    "interrupt": 1
    }
}
```

### 이미지 전송을위한 서비스 데이터

`data` 안에 이미지를 보내기 위해 다음 속성을 배치할 수 있습니다 .

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `file`                 |      yes | Groups the attributes for file upload. If present, either `url` or `path` have to be provided. 
| `path`                |      yes | Local path of an image file. Is placed inside `file`.
| `url`                  |      yes | URL of an image file. Is placed inside `file`.
| `username`             |      yes | Username if the url requires authentication. Is placed inside `file`.
| `password`             |      yes | Password if the url requires authentication. Is placed inside `file`.
| `auth`                 |      yes | If set to `digest` HTTP-Digest-Authentication is used. If missing, HTTP-BASIC-Authentication is used. Is placed inside `file`.

URL에서 파일을 게시하는 예 :

```json
{
  "message":"Messagetext",
  "title":"My Notification",
  "data":{
    "file":{
      "url":"http://[url to image file]",
      "username":"optional user, if necessary",
      "password":"optional password, if necessary",
      "auth":"digest"
    }
  }
}
```

로컬 경로에서 파일을 게시하는 예 :

```json
{
  "message":"Messagetext",
  "title":"My Notification",
  "data":{
    "file":{
      "path":"/path/to/file.ext"
    }
  }
}
```

`path`는 `configuration.yaml`의 `whitelist_external_dirs`에 대해 검증된다는 것을 확인하십시오.