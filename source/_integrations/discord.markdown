---
title: 디스코드(Discord)
description: Instructions on how to add Discord notifications to Home Assistant.
logo: discord.png
ha_category:
  - Notifications
ha_release: 0.37
---

[Discord service](https://discordapp.com/)는 알림 구성 요소를 위한 플랫폼입니다. 이를 통해 통합구성요소는 Discord를 사용하여 사용자에게 메시지를 보낼 수 있습니다.

토큰을 얻으려면 [Discord My Apps page](https://discordapp.com/developers/applications/me)로 이동하여 새 응용 프로그램을 만들어야합니다. 응용 프로그램이 준비되면 [bot](https://discordapp.com/developers/docs/topics/oauth2#bots) 사용자(**Create a Bot User**)를 만듭니다.

정보 섹션에서 **Client ID**와 나중에 봇의 (숨겨진)**Token**을 검색합니다.


응용 프로그램을 설정할 때 이[icon](/images/favicon-192x192-full.png)을 사용할 수 있습니다.

Discord를 사용하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - platform: discord
    token: YOUR_DISCORD_BOT_TOKEN
```

{% configuration %}
name:
  description: 알리미는 `notify.NAME` 서비스에 바인딩합니다.
  required: false
  type: string
  default: notify
token:
  description: 봇의 토큰.
  required: true
  type: string
{% endconfiguration %}

### 봇 설정하기

봇은 서버로 메시지를 보내거나 사용 가능한 로컬 이미지를 첨부 할 수 있습니다. 봇을 관리자인 서버에 추가하려면 [Discord My Apps page](https://discordapp.com/developers/applications/me)에서 봇의 세부 정보를 얻습니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/discord-bot.png' />
</p>

이제 [bot](https://discordapp.com/developers/docs/topics/oauth2#bots)의 **Client ID**와 함께 Discord Authorization 페이지를 사용하십시오.

`https://discordapp.com/api/oauth2/authorize?client_id=[CLIENT_ID]&scope=bot&permissions=0`

<p class='img'>
  <img src='{{site_root}}/images/screenshots/discord-auth.png' />
</p>

"Authorized"라는 확인 메시지가 표시 될 때까지 기다립니다.

봇이 서버에 추가되면 봇을 작동시키려는 채널의 채널 ID를 얻습니다.   Discord 응용 프로그램에서 **Settings** > **Appearance** > **Check developer mode** 으로 이동하십시오.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/discord-api.png' />
</p>

채널 이름을 마우스 오른쪽 단추로 클릭하고 채널 ID를 복사하십시오. (**Copy ID**).

이 채널 ID는 알림 서비스를 호출 할 때 대상으로 사용해야합니다. 여러 서버에서 여러 채널 ID를 지정할 수 있습니다.

#### Service Call 사례 

```yaml
- service: notify.discord
  data:
    message: "A message from Home Assistant"
    target: ["1234567890", "0987654321"]
    data:
      images: 
      - "/tmp/garage_cam"
      - "/tmp/garage.jpg"
```

### Notes

메시지에 사용자 ID를 사용하여 채널 내부의 모든 사용자에게 태그를 지정할 수 있습니다. : `<@userid>`에서 `userid`를 복사한 ID로 바꾸는 방법으로. 사용자 ID를 얻으려면 사용자 이름을 마우스 오른쪽 버튼으로 클릭하여 위의 채널 ID와 마찬가지로 ID를 복사하십시오.

봇 생성 및 권한 부여에 대한 자세한 내용은 [OAuth2 information page](https://discordapp.com/developers/docs/topics/oauth2)를 방문하십시오.

알림을 효과적으로 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.

메시지가 전송될 때 이미지가 Discord에 업로드됩니다. 따라서 이미지에 대한 로컬 경로가 필요합니다 (예: `/local/garage.jpg`가 아닌 `/config/www/garage.jpg`). 메시지로 보낸 후 이미지를 업데이트해도 Discord의 메시지는 업데이트되지 않습니다.