---
title: 시스코 가상회의(Cisco Webex Teams)
description: Instructions on how to add Cisco Webex Teams notifications to Home Assistant.
logo: cisco_webex_teams.png
ha_category:
  - Notifications
ha_release: '0.40'
ha_codeowners:
  - '@fbradyirl'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/0O-k5Ku6P7o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`cisco_webex_teams` 알림 플랫폼을 사용하면 홈어시스턴트에서 [Cisco Webex Teams](https://www.webex.com/team-collaboration.html)(이전의 Cisco Spark)로 풍부한 알림을 전달할 수 있습니다.

이 알림 플랫폼을 사용하려면 앱(bot) 토큰이 필요합니다. 토큰을 얻으려면 [Cisco Webex for Developers](https://developer.webex.com/)를 방문하십시오.
* 자세한 지침은 [Webex Teams bot documentation](https://developer.webex.com/docs/bots)에서 **Creating a Webex Teams Bot** 섹션에서 찾을 수 있습니다.

메시지를 게시할 `room_id`도 지정해야합니다. `room_id`는 다음 두 가지 방법 중 하나로 찾을 수 있습니다.

1. Logging in at [Cisco Webex for Developers](https://developer.webex.com/) and navigate to `Documentation`>`API Reference`>`Messages` and select List Messages, or 
2. Log into the web client at [teams.webex.com](https://teams.webex.com/), 
 * select the room (or create a new room), 
 * then copying the room ID from the URL. 
 
<strong>**Note:** bot 이메일(`mybot@webex.bot` 형식)을 위에서 지정한 회의실에 참가자로 추가해야합니다.</strong>

설치에서 이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: cisco_webex_teams
    token: YOUR_BOT_TOKEN
    room_id: CISCO_WEBEX_TEAMS_ROOMID
```

## 서식있는 텍스트 형식만들기

Webex Teams 클라이언트는 허용된 html 태그 세트를 통해 서식있는 텍스트를 렌더링할 수 있습니다.

예를 들어 다음과 같이 읽기 쉬운 방식으로 세부 정보를 표시하도록 자동화를 설정할 수 있습니다. :

<p class='img'>
<img src='/images/integrations/cisco_webex_teams/rich_formatting.png' />
macOS 클라이언트에 표시되는 서식있는(Rich) 텍스트
</p>

위 스크린 샷의 자동화는 다음과 같습니다.

```yaml

# Rich Text Example 1.
# Show a one line message with a red banner
- alias: "Notify On Build Failing"
  trigger:
    - platform: webhook
      webhook_id: build_failed
  action:
    service: notify.cisco_webex_teams_notify
    data:
      message: "<blockquote class=danger>Build 0.89.5 compile failed."


# Rich Text Example 2.
# Show a title and multi-line message with a yellow banner, 
# with lists, a person mention and a link
- alias: "Notify On Build Unstable"
  trigger:
    - platform: webhook
      webhook_id: build_unstable
  action:
    service: notify.cisco_webex_teams_notify
    data:
      title: "<strong>Build 0.89.6 is unstable.</strong>"
      message: "<blockquote class=warning>Version 0.89.6 failed verifications.
      
      <ul>
        <li> test_osx
        <li> test_win_lint

        <li>... and 4 more.
      </ul>
      <p><@personEmail:sparkbotjeeves@sparkbot.io></p>
      <p><small><i>View <a href='https://demo/testReport/'>Test Report</a></i></small><br></p>
      "

# Rich Text Example 3.
# Show a title and multi-line message with a blue banner, 
# with lists, a person mention and a link
- alias: "Notify On Build Passing"
  trigger:
    - platform: webhook
      webhook_id: build_passed
  action:
    service: notify.cisco_webex_teams_notify
    data:
      title: "<strong>✅ Version 0.89.7 passed all tests and deployed to production!</strong>"
      message: "<blockquote class=info>Version 0.89.7 passed all verifications.
      
      <ul>
        <li> test_cov
        <li> test_osx
        <li> test_win
        <li> test_linux
        <li>... and 45 more.
      </ul>
      "
```

다음은 허용되는 html 태그 및 속성 목록입니다.

Tag | More Info
--- | --- 
`<@personEmail:email@examplecompany.com>` | Used to tag another Webex Team user by email address. 
`<a>`  | Defines a hyperlink. Allows attribute `href`.
`<blockquote>`  | Defines a section that is quoted from another source. Allows attribute `class` with allowed values `danger`, `warning`, `info`, `primary`, `secondary`.
`<b>` | Defines bold text.
`<strong>`  | Defines important text.
`<i>`  | Defines italic text.
`<em>` | Defines emphasized text.
`<pre>` | Defines preformatted text.
`<code>` | Defines a piece of computer code.
`<br>` | Defines a single line break.
`<p>` | Defines a paragraph.
`<ul>` | Defines an unordered list.
`<ol>` | Defines an ordered list.
`<li>` | Defines a list item.
`<h1>` to `<h3>` | Defines HTML headings.

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
token:
  description: Your app (bot) token.
  required: true
  type: string
room_id:
  description: The Room ID.
  required: true
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.