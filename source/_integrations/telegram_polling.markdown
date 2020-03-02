---
title: "텔레그램 polling"
description: "Telegram polling support"
logo: telegram.png
ha_category:
  - Notifications
ha_release: 0.42
---

텔레그램 Chatbot polling 구현. 

Telegram에서 지원하는 두 가지 봇 구현 중 하나입니다. 홈어시스턴트가 인터넷에 노출 될 필요는 없습니다.

## 설정

이를 홈어시스턴트로 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
telegram_bot:
  - platform: polling
    api_key: YOUR_API_KEY
    allowed_chat_ids:
      - 12345
      - 67890
```

{% configuration %}
allowed_chat_ids:
  description: 웹 후크와 상호 작용할 권한이 있는 `user_id` 텔레그램 형식의 사용자 목록.
  required: true
  type: list
api_key:
  description: 봇의 API 토큰.
  required: true
  type: string
parse_mode:
  description: 메시지 데이터에서 명시적이지 않은 경우 메시지의 기본 파서 (`html` 또는 `markdown`)
  required: false
  type: string
  default: "`markdown`"
proxy_url:
  description: 프록시 URL 뒤에서 작업하는 경우 (`socks5://proxy_ip:proxy_port`).
  required: false
  type: string
proxy_params:
  description: "프록시 뒤에서 작업할 경우 프록시 설정 매개 변수 (예: `username`, `password` 등)"
  required: false
  type: string
{% endconfiguration %}

`chat_id`와 `api_key`를 얻으려면 지침을 따르십시오. [here](/integrations/telegram).