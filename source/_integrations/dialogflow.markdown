---
title: 대화흐름(Dialogflow)
description: Instructions on how integrate Dialogflow with Home Assistant.
logo: dialogflow.png
ha_category:
  - Voice
ha_release: 0.56
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/fcL4fPhlVVc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`dialogflow` 통합구성요소는 [Dialogflow](https://dialogflow.com/)의 [webhook](https://dialogflow.com/docs/fulfillment#webhook) 통합구성요소와 함께 사용되도록 설계되었습니다. 사용자와 대화가 끝나면 Dialogflow는 웹후크에 액션과 매개 변수를 보냅니다.

DialogFlow에서 메시지를 수신하려면 웹에서 홈어시스턴트 인스턴스에 액세스할 수 있어야하고 ([Hass.io instructions](/addons/duckdns/))으로 HTTP 연동([docs](/integrations/http/#base_url))을 위해 `base_url`을 설정해야합니다. 서버가 응답하지 않거나 너무 오래 걸리면(5 초 이상) Dialogflow가 대체 응답을 반환합니다.

Dialogflow는 많은 유명한 messaging, virtual assistant, IoT 플랫폼과 [연동](https://dialogflow.com/docs/integrations/)할 수 있습니다.

Dialogflow를 사용하면 다음과 같은 대화를 쉽게 만들 수 있습니다. :


_User: What is the temperature at home?_

_Bot: The temperature is 34 degrees_

_User: Turn on the light_

_Bot: In which room?_

_User: In the kitchen_

_Bot: Turning on kitchen light_

이 통합구성요소를 사용하려면 Dialogflow에서 대화(의도)를 정의하고 음성으로 홈어시스턴트를 설정하고 선택적으로 실행할 액션를 설정해야합니다.

### DIALOGFLOW 계정 설정 

웹후크 URL을 얻으려면 설정 화면의 통합 페이지로 이동하여 "Dialogflow"를 찾으십시오. “configure”를 클릭하십시오. 화면의 지시 사항을 따르십시오.

- [Login](https://console.dialogflow.com/) with your Google account
- Click on "Create Agent"
- Select name, language (if you are planning to use Google Actions check their [supported languages](https://support.google.com/assistant/answer/7108196?hl=en)) and time zone
- Click "Save"
- Now go to "Fulfillment" (in the left menu)
- Enable Webhook and set your Dialogflow webhook url as the endpoint, e.g., `https://myhome.duckdns.org/api/webhook/800b4cb4d27d078a8871656a90854a292651b20635685f8ea23ddb7a09e8b417`
- Click "Save"
- Create a new intent
- Below "User says" write one phrase that you, the user, will tell Dialogflow, e.g., `What is the temperature at home?`
- In "Action" set some key (this will be the bind with Home Assistant configuration), e.g.,: GetTemperature
- In "Response" set "Cannot connect to Home Assistant or it is taking to long" (fall back response)
- At the end of the page, click on "Fulfillment" and check "Use webhook"
- Click "Save"
- On the top right, where is written "Try it now...", write, or say, the phrase you have previously defined and hit enter
- Dialogflow has send a request to your Home Assistant server

<div class='note warning'>

  V1 API는 2019년 10월 23일부터 더 이상 사용되지 않습니다. V1 API를 계속 사용중인 경우 V2 API를 사용하도록 Dialogflow에서 설정을 변경하는 것이 좋습니다. V2 API로 업그레이드한 후 yaml 설정을 변경할 필요가 없습니다. [여기](https://console.dialogflow.com/)서 코그 단추를 클릭하여 V2 API로 변경한 후 V2 API 를 선택하십시오. 

</div>

왼쪽 메뉴에서 "Integrations"을 살펴보고 third parties를 설정하십시오.

### 홈어시스턴트 설정 

활성화되면 [`alexa` integration](/integrations/alexa/)에 홈어시스턴트의 native intent support가 incoming intents를 처리하게됩니다. intents를 기반으로 액션을 실행하려면 [`intent_script`](/integrations/intent_script) 통합구성요소를 사용하십시오.

## 사례

[이 파일](https://github.com/home-assistant/home-assistant.io/blob/next/source/assets/HomeAssistant_APIAI.zip)을 다운로드 하고 본 설정에 사용할 예제를 보려면 Dialogflow 에이전트(**Settings** -> **Export and Import**)에서 로드하십시오. :

{% raw %}
```yaml
# Example configuration.yaml entry
dialogflow:

intent_script:
  Temperature:
    speech:
      text: The temperature at home is {{ states('sensor.home_temp') }} degrees
  LocateIntent:
    speech:
      text: >
        {%- for state in states.device_tracker -%}
          {%- if state.name.lower() == User.lower() -%}
            {{ state.name }} is at {{ state.state }}
          {%- elif loop.last -%}
            I am sorry, I do not know where {{ User }} is.
          {%- endif -%}
        {%- else -%}
          Sorry, I don't have any trackers registered.
        {%- endfor -%}
  WhereAreWeIntent:
    speech:
      text: >
        {%- if is_state('device_tracker.adri', 'home') and
               is_state('device_tracker.bea', 'home') -%}
          You are both home, you silly
        {%- else -%}
          Bea is at {{ states("device_tracker.bea") }}
          and Adri is at {{ states("device_tracker.adri") }}
        {% endif %}
  TurnLights:
    speech:
      text: Turning {{ Room }} lights {{ OnOff }}
    action:
      - service: notify.pushbullet
        data_template:
          message: Someone asked via apiai to turn {{ Room }} lights {{ OnOff }}
      - service_template: >
          {%- if OnOff == "on" -%}
            switch.turn_on
          {%- else -%}
            switch.turn_off
          {%- endif -%}
        data_template:
          entity_id: "switch.light_{{ Room | replace(' ', '_') }}"
```
{% endraw %}
