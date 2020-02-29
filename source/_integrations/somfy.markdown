---
title: 솜피 Open API
description: Instructions on how to set up the Somfy hub within Home Assistant.
logo: somfy.png
ha_category:
  - Hub
ha_iot_class: Cloud Polling
ha_release: 0.95
ha_config_flow: true
ha_codeowners:
  - '@tetienne'
---

Somfy 통합구성요소를 통해 사용자는 [tahoma](/integrations/tahoma/) 구성 요소와 달리 [official API](https://developer.somfy.com/somfy-open-api/apis)를 사용하여 Somfy 장치를 Home Assistant에 연동 할 수 있습니다. 

## 설치

Somfy는 새로운 계정 연결 서비스를 활용하고 있습니다. 즉, Somfy를 설정하려면 통합구성요소 페이지로 이동하여 새 통합구성요소 추가를 클릭하기만 하면됩니다.

<div class='videoWrapper'>
<iframe width="560" height="315" src="https://www.youtube.com/embed/y0SECWUVR-M" frameborder="0" allowfullscreen></iframe>
</div>

## 자체 개발자 계정으로 설치

자신의 개발자 계정을 만들고 이를 통해 Somfy를 설정 할 수 있습니다.

### 개발자 계정 설정

1. Visit [https://developer.somfy.com](https://developer.somfy.com).
2. Log in using your Somfy credentials.
3. Open the _My Apps_ menu.
4. Add a new App:

- App Name: Home Assistant
- Callback URL: `<YOUR_HOME_ASSISTANT_URL>/auth/external/callback`
- Description: Home Assistant instance
- Product: Somfy Open API

5. Once Home Assistant restarted, go to Configuration>Integrations.
6. Select the Somfy integration.

### 설정

```yaml
# Example configuration.yaml entry
somfy:
  client_id: CONSUMER_KEY
  client_secret: CONSUMER_SECRET
```

{% configuration %}
client_id:
  description: Your Somfy consumer key.
  required: true
  type: string
client_secret:
  description: Your Somfy consumer secret.
  required: true
  type: string
{% endconfiguration %}

### TAHOMA 통합구성요소와 잠재적 중복 (Potential duplicate with the Tahoma integration)

[tahoma](/integrations/tahoma) 구성 요소를 사용하는 경우 이 구성 요소에 의해 추가된 Cover를 제외해야합니다. 그렇지 않으면 두 번 추가됩니다.

```yaml
# Example configuration.yaml entry
tahoma:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
  exclude:
    [
      "rts:RollerShutterRTSComponent",
      "rts:CurtainRTSComponent",
      "rts:BlindRTSComponent",
      "rts:VenetianBlindRTSComponent",
      "rts:DualCurtainRTSComponent",
      "rts:ExteriorVenetianBlindRTSComponent",
      "io:ExteriorVenetianBlindIOComponent",
      "io:RollerShutterUnoIOComponent",
      "io:RollerShutterWithLowSpeedManagementIOComponent",
      "io:RollerShutterVeluxIOComponent",
      "io:RollerShutterGenericIOComponent",
      "io:WindowOpenerVeluxIOComponent",
      "io:VerticalExteriorAwningIOComponent",
      "io:HorizontalAwningIOComponent",
    ]
```
