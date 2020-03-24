---
title: 오픈소스소셜(Mastodon)
description: Instructions on how to add Instapush notifications to Home Assistant.
logo: mastodon.png
ha_category:
  - Notifications
ha_release: 0.67
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/IPSbNdBmWKE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`mastodon` 플랫폼은 [Mastodon](https://joinmastodon.org/)을 사용하여 Home Assistant에서 알림을 전달합니다.

### 셋업

Mastodon 웹 인터페이스에서 **Preferences**으로 이동 한 다음 **Development**으로 이동하여 새 애플리케이션을 작성하십시오.

### 설정

Mastodon을 설치시 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: mastodon
    access_token: !secret mastodon_access_token
    client_id: !secret mastodon_client_id
    client_secret: !secret mastodon_client_secret
```

{% configuration %}
access_token:
  description: Your Mastodon access token.
  required: true
  type: string
client_id:
  description: Your Mastodon client ID
  required: true
  type: string
client_secret:
  description: Your Mastodon client secret.
  required: true
  type: string
base_url:
  description: URL of the Mastodon instance to use.
  required: false
  type: string
  default: https://mastodon.social
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.