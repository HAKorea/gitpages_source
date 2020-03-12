---
title: LIFX 웹 사이트에서 API 토큰을 만듭니다. 클라우드
description: Instructions on using native LIFX scenes with Home Assistant.
logo: lifx.png
ha_category:
  - Scene
ha_release: 0.43
---

`lifx_cloud` 장면(scene) 플랫폼을 사용하면 LIFX 클라우드에 LIFX 스마트폰 앱이 저장한 장면을 활성화 할 수 있습니다.

```yaml
# Example configuration.yaml entry
scene:
  - platform: lifx_cloud
    token: YOUR_LIFX_TOKEN
```

그런 다음 스마트폰 앱에서 각 장면의 이름을 활성화 할 수 있습니다.

```yaml
  - service: scene.turn_on
    entity_id: scene.goodnight
```

{% configuration %}
token:
  description: The API token for your LIFX Cloud account.
  required: true
  type: string
timeout:
  description: Network timeout in seconds.
  required: false
  default: 10
  type: integer
{% endconfiguration %}

### API 토큰 받기

LIFX 웹 사이트에서 API 토큰을 만듭니다. :
1. Sign in to the [LIFX Cloud](https://cloud.lifx.com/)
2. Click on your e-mail address and select _Personal Access Tokens_
3. Now click _Generate New Token_
4. Enter a meaningful label, such as 'Home Assistant'
5. Click _Generate_
6. Copy the token that now appears
7. Paste the token into the Home Assistant configuration file
