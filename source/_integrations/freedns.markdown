---
title: 무료DNS(FreeDNS)
description: Keep your DNS record up to date with FreeDNS.
logo: afraid_freedns.png
ha_category:
  - Network
ha_release: 0.67
---

`freedns` 통합구성요소로 [FreeDNS](https://freedns.afraid.org) 기록을 최신 상태로 유지할 수 있습니다.

## 셋업

업데이트 URL 또는 액세스 토큰을 결정해야합니다.

1. Head over to the [FreeDNS](https://freedns.afraid.org) website and login to your account.
2. Select the menu "Dynamic DNS"
3. You should now see your update candiates in a table at the bottom of the page.
4. Copy the link target of the "Direct URL".
5. The access token is the part at the end of the link: `https://freedns.afraid.org/dynamic/update.php?YOUR_UPDATE_TOKEN`
6. Either put the token as `access_token` _or_ the whole URL into the `url` attribute.

## 설정

설치시 이 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
freedns:
  access_token: YOUR_TOKEN
```

{% configuration %}
  access_token:
    description: Your access token. This is exclusive to `url`.
    required: false
    type: string
  url:
    description: The full update URL. This is exclusive to `access_token`.
    required: false
    type: string
  scan_interval:
    description: How often to call the update service.
    required: false
    type: time
    default: 10 minutes
{% endconfiguration %}
