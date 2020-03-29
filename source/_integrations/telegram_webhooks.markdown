---
title: "텔레그램 webhooks"
description: "Telegram webhooks support"
logo: telegram.png
ha_category:
  - Notifications
ha_release: 0.42
---

텔레그램 [documentation](https://core.telegram.org/bots/webhooks)에 설명된대로 텔레그램 챗봇 웹 후크 구현.

텔레그램 `setWebhook` 메소드를 사용한 봇의 webhook URL은 `https://<public_url>:<port>/api/telegram_webhooks`로 설정되어야합니다.

이는 텔레그램이 지원하는 두 가지 봇 구현 중 하나입니다. Telegram에서 선호하는 구현방법으로 설명하자면 Home Assistant 인스턴스가 인터넷에 노출되어 있어야합니다.

## 설정

이것을 홈어시스턴트로 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
http:
  base_url: <public_url> # the Home Assistant https url which is exposed to the internet.

telegram_bot:
  - platform: webhooks
    api_key: YOUR_API_KEY
    parse_mode: html
    allowed_chat_ids:
      - 12345
      - 67890
```

{% configuration %}
allowed_chat_ids:
  description: 웹 후크와 상호 작용할 권한이 있는 사용자 및 그룹 채팅을 나타내는 ID 목록입니다.
  required: true
  type: list
api_key:
  description: 봇의 API 토큰.
  required: true
  type: string
parse_mode:
  description: 메시지 데이터에서 명시적이지 않은 경우 메시지의 기본 파서 (`html` 또는 `markdown`)
  required: false
  default: markdown
  type: string
proxy_url:
  description: 프록시 URL 뒤에서 작업하는 경우 (`socks5://proxy_ip:proxy_port`).
  required: false
  type: string
proxy_params:
  description: "프록시 뒤에서 작업할 경우 프록시 설정 매개 변수 (예: `username`, `password` 등)"
  required: false
  type: string
url:
  description: 다른 설정들에 대해 [`http`](/integrations/http/) 통합구성요소에서 `base_url`을 덮어쓸 수 있도록 허용. (`https://<public_url>:<port>`)
  required: false
  type: string
trusted_networks:
  description: 텔레그램 서버에 접속할 수 있는 리스트. 
  required: false
  type: string
  default: 149.154.160.0/20, 91.108.4.0/22
{% endconfiguration %}

`chat_id` 와 `api_key`를 얻으려면 [여기](/integrations/telegram)의 지시 사항을 따르십시오. 채팅을 승인할 뿐만 아니라 봇을 그룹에 추가한 경우 웹 후크와 상호 작용할 모든 사용자에게 권한을 부여해야합니다. 권한이 없는 사용자가 webhook 홈어시스턴트와 상호작용하려고 하면 오류가 발생합니다 ("수신 메시지는 허용되지 않습니다"). 이 오류 메시지의 "보낸 사람(from)" 섹션에서 사용자 ID를 쉽게 얻을 수 있습니다.

## 전체 설정 샘플

아래 설정 샘플은 항목이 어떻게 표시되는지 보여줍니다.

```yaml
# Example configuration.yaml entry
http:
  base_url: <public_url>

telegram_bot:
  - platform: webhooks
    api_key: YOUR_API_KEY
    trusted_networks:
      - 149.154.160.0/20
      - 91.108.4.0/22
    allowed_chat_ids:
      - 12345
      - 67890
```
