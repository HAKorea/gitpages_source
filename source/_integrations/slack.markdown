---
title: 협업시스템(Slack)
description: Instructions on how to add Slack notifications to Home Assistant.
logo: slack.png
ha_category:
  - Notifications
ha_release: pre 0.7
---

<iframe width="692" height="388" src="https://www.youtube.com/embed/6c7_TpPUpL0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`slack` 플랫폼을 통해 Home Assistant에서 [Slack](https://slack.com/)으로 알림을 전달할 수 있습니다.

## 셋업

### Bot posting as you

1. Create a [new app](https://api.slack.com/apps) under your Slack.com account
2. Click the `OAuth & Permissions` link in the sidebar, under the Features heading
2. In the Scopes section, add the `chat:write:user` scope, `Send messages as user`
3. Scroll up to `OAuth Tokens & Redirect URLs` and click `Install App`
4. Copy your `OAuth Access Token` and put that key into your `configuration.yaml` file -- see below

<div class='note'>

앱의 기본 설정에 앱 자격 증명 확인 토큰(credential Verification Token)이 있습니다. 이는 여기에 필요한 API 키가 **아닙니다.**

</div>

### Bot posting as its own user
Slack bot을 사용자로 사용할 수도 있습니다. https://[YOUR_TEAM].slack.com/apps/build/custom-integration 에서 new bot을 생성하고 제공된 토큰을 사용하십시오. 홈어시스턴트의 프론트 엔드에서 아이콘을 추가하고 bot에게 의미있는 이름을 지정할 수 있습니다.

알림을 받으려는 방에 bot을 초대하는 것을 잊지 마십시오.

## 설정

설치시 slack 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: slack
    api_key: YOUR_API_KEY
    default_channel: '#general'
```

{% configuration %}
name: 
  description: Setting this parameter allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  type: string
  default: "notify"
api_key:
  description: The Slack API token to use for sending Slack messages.
  required: true
  type: string
default_channel:
  description: The default channel to post to if no channel is explicitly specified when sending the notification message.  A channel can be specified adding a target attribute to the JSON at the same level as "message".
  required: true
  type: string
username:
  description: Home Assistant will post to Slack using the username specified.
  required: false
  type: string
  default: The user account or botname that you generated the API key as.
icon:
  description: Use one of the Slack emojis as an Icon for the supplied username.  Slack uses the standard emoji sets used [here](https://www.webpagefx.com/tools/emoji-cheat-sheet/).
  required: false
  type: string
{% endconfiguration %}

### Slack 서비스 데이터

확장된 기능을 위해 다음 속성을 `data` 안에 배치할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `file`                 |      yes | Groups the attributes for file upload. If present, either `url` or `path` have to be provided.
| `path `                |      yes | Local path of file, photo etc to post to slack. Is placed inside `file`.
| `url`                  |      yes | URL of file, photo etc to post to slack. Is placed inside `file`.
| `username`             |      yes | Username if the url requires authentication. Is placed inside `file`.
| `password`             |      yes | Password if the url requires authentication. Is placed inside `file`.
| `auth`                 |      yes | If set to `digest` HTTP-Digest-Authentication is used. If missing HTTP-BASIC-Authentication is used. Is placed inside `file`.
| `attachments`          |      yes | Array of [Slack attachments](https://api.slack.com/docs/message-attachments). See [the attachment documentation](https://api.slack.com/docs/message-attachments) for how to format. *NOTE*: if using `attachments`, they are shown **in addition** to `message`

URL에서 파일을 게시하는 예 :

```json
{
  "message":"Message that will be added as a comment to the file.",
  "title":"Title of the file.",
  "target": ["#channelname"], 
  "data":{
    "file":{
      "url":"http://[url to file, photo, security camera etc]",
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
  "message":"Message that will be added as a comment to the file.",
  "title":"Title of the file.",
  "data":{
    "file":{
      "path":"/path/to/file.ext"
    }
  }
}
```

`path`는 `configuration.yaml`의 `whitelist_external_dirs`에 대해 검증된다는 걸 알아두십시오.

포맷이 지정된 첨부 파일을 게시하는 예 :

```json
{
  "message": "",
  "data": {
    "attachments": [
      {
        "title": "WHAT A HORRIBLE NIGHT TO HAVE A CURSE.",
        "image_url": "https://i.imgur.com/JEExnsI.gif"
      }
    ]
  }
}
```

`message`는 필수키이지만 항상 표시되므로 여분의 텍스트를 원하지 않으면 `message`에 빈 문자열 (`""`)을 사용하십시오.

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.