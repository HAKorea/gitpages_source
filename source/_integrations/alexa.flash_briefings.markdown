---
title: "아마존 알렉사 Flash Briefing"
description: "Instructions on how to create your Flash Briefing skills with Home Assistant."
logo: amazon-alexa.png
ha_category:
  - Voice
ha_release: "0.31"
---
<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/_uJeiYZubEA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Flash Briefing 기술

[0.31] 버전부터 홈어시스턴트는 새로운 [Alexa Flash Briefing Skills API][flash-briefing-api]를 지원합니다. Flash Briefing Skill은 Home Assistant에서 생성된 새로운 Flash Briefing 소스를 추가합니다.

### 요구 사항

Amazon의 이 skill의 endpoint는 SSL을 통해 호스팅되어야합니다. 자체 서명 인증서는 개발 모드에서만 실행되기 때문에 사용하는 데 문제가 없습니다. Home Assistant의 암호화를 설정하는 방법에 대한 [our blog][blog-lets-encrypt]에서 자세히 읽어보십시오. Hass.io를 실행할 때 [Let's Encrypt](/addons/lets_encrypt/) 및 [Duck DNS](/addons/duckdns/) add-on을 사용하는 것이 가장 쉬운 방법입니다.

또한 이 문서를 작성할 당시 Alexa skill endpoint는 포트 443 (Home Assistant 기본값은 8123)을 통한 요청을 *반드시* 수락해야합니다. 이를 처리 할 수 있는 두 가지 방법이 있습니다.

  1. 라우터에서 외부 443을 홈어시스턴트 포트로 전달하십시오 (기본값은 8123)
  혹은
  2. 홈어시스턴트 서비스 포트를 443으로 변경하십시오. 이는 `configuration.yaml` 파일의 `server_port` 항목과 함께 [`http`](/integrations/http/) 섹션에서 수행됩니다.

[blog-lets-encrypt]: /blog/2015/12/13/setup-encryption-using-lets-encrypt/

### Home Assistant에서 Flash Briefing skill 설정 

`title`, `audio`, `text` 및 `display_url` 설정 매개 변수에 [templates]를 사용할 수 있습니다.

다음은 집에 누가 있는지 알려주는 Flash Briefing skill의 설정 예시입니다.

```yaml
{% raw %}# Example configuration.yaml entry
alexa:
  flash_briefings:
    whoishome:
      - title: Who's at home?
        text: >
          {%- if is_state('device_tracker.paulus', 'home') and
                 is_state('device_tracker.anne_therese', 'home') -%}
            You are both home, you silly
          {%- else -%}
            Anne Therese is at {{ states("device_tracker.anne_therese") }}
            and Paulus is at {{ states("device_tracker.paulus") }}
          {% endif %}{% endraw %}
```

원하는 경우 피드에 여러 항목을 추가할 수 있습니다. Amazon 필수 UID 및 타임스탬프는 시작시 임의로 생성되며 Home Assistant를 다시 시작할 때마다 변경됩니다.

허용되는 설정 매개 변수 및 형식에 대한 자세한 내용은 [Amazon documentation][flash-briefing-api-docs]를 참조하십시오.

### 아마존 개발콘솔에서 Flash Briefing skill 설정하기

- Log in to [Amazon developer console][amazon-dev-console]
- Click the Alexa navigation tab at the top of the console
- Click on the "Get Started >" button under "Alexa Skills Kit"
- Click the yellow "Add a new skill" button in the top right
  - Skill Information
    - For Skill Type select "Flash Briefing Skill API"
    - You can enter whatever name you want
    - Hit "Next"
  - Interaction Model
    - Nothing to do here
  - Configuration
    - Add new feed
      - For URL, enter `https://YOUR_HOST/api/alexa/flash_briefings/BRIEFING_ID?api_password=YOUR_API_PASSWORD` where `BRIEFING_ID` is the key you entered in your configuration (such as `whoishome` in the above example). **NOTE:** Do not use a non-standard HTTP or HTTPS port, AWS will not connect to it.
      - You can use this [specially sized Home Assistant logo][large-icon] as the Feed Icon
      - All other settings are up to you
      - Hit "Next"
  - Test
    - Having passed all validations to reach this screen, you can now click on "< Back to All Skills" as your flash briefing is now available as in "Development" service.
- To invoke your flash briefing, open the Alexa app on your phone or go to the [Alexa Settings Site][alexa-settings-site], open the "Skills" configuration section, select "Your Skills", scroll to the bottom, tap on the Flash Briefing Skill you just created, enable it, then manage Flash Briefing and adjust ordering as necessary.  Finally ask your Echo for your "news","flash briefing", or "briefing".

[amazon-dev-console]: https://developer.amazon.com
[flash-briefing-api]: https://developer.amazon.com/docs/flashbriefing/understand-the-flash-briefing-skill-api.html
[flash-briefing-api-docs]: https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/flash-briefing-skill-api-feed-reference
[large-icon]: /images/integrations/alexa/alexa-512x512.png
[small-icon]: /images/integrations/alexa/alexa-108x108.png
[templates]: /topics/templating/
[zero-three-one]: /blog/2016/10/22/flash-briefing-updater-hacktoberfest/
[alexa-settings-site]: https://alexa.amazon.com/
[emulated-hue-component]: /integrations/emulated_hue/
