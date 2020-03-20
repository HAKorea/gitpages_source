---
title: "텔레그램 Broadcast"
description: "Telegram support to send messages only"
logo: telegram.png
ha_category:
  - Notifications
ha_release: 0.48
---

**메시지 전송만** 지원하는 텔레 그램 구현. 홈어시스턴트 인스턴스는 인터넷에 노출 될 필요가 없으며 봇에게 전송된 메시지를 수신하기 위한 폴링이 없습니다.

## 설정

이를 홈어시스턴트로 통합하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
telegram_bot:
  - platform: broadcast
    api_key: YOUR_API_KEY
    allowed_chat_ids:
      - 12345
      - 67890
```

{% configuration %}
allowed_chat_ids:
  description: 웹 후크와 상호 작용할 수있는 권한이 부여된 `user_id` 텔레그램 형식의 사용자 목록
  required: true
  type: list
api_key:
  description: bot의 API 토큰..
  required: true
  type: string
parse_mode:
  description: "메시지 데이터에 명시적이지 않은 경우, 메시지의 기본 파서 (`html` 또는 `markdown`)"
  required: false
  type: string
  default: "`markdown`"
proxy_url:
  description: 프록시 URL 뒤에서 작업하는 경우 (`socks5://proxy_ip:proxy_port`).
  required: false
  type: string
proxy_params:
  description: "프록시 뒤에서 작업 할 경우 프록시 구성 매개 변수 (예: 사용자 이름, 비밀번호 등)"
  required: false
  type: string
{% endconfiguration %}

`chat_id` 와 `api_key`를 얻으려면 [here](/integrations/telegram)의 지시사항을 따르십시오.