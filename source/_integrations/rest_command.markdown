---
title: RESTful 명령
description: Instructions on how to integrate REST commands into Home Assistant.
logo: restful.png
ha_category:
  - Automation
ha_release: 0.36
ha_iot_class: Local Push
---

이 통합구성요소는 정규 REST 명령을 서비스로 노출 할 수 있습니다. 서비스는 [script] 또는 [automation]에서 호출 할 수 있습니다.

[script]: /integrations/script/
[automation]: /getting-started/automation/

이 구성 요소를 사용하려면 configuration.yaml파일에 다음 행을 추가 하십시오. 

```yaml
# Example configuration.yaml entry
rest_command:
  example_request:
    url: 'http://example.com/'
```

{% configuration %}
service_name:
  description: 서비스를 공개하는 데 사용되는 이름입니다. 예를 들어 위 예에서 'rest_command.example_request'가 됩니다.
  required: true
  type: map
  keys:
    url:
      description: 요청을 보내기 위한 URL (템플릿 지원).
      required: true
      type: template
    method:
      description: 사용할 HTTP 메소드 (get, patch, post, put 또는 delete)
      required: false
      default: get
      type: string
    headers:
      description: 요청의 헤더입니다.
      required: false
      type: list
    payload:
      description: 요청과 함께 보낼 문자열 / 템플릿.
      required: false
      type: template
    username:
      description: HTTP 인증을위한 사용자 이름입니다.
      required: false
      type: string
    password:
      description: HTTP 인증을위한 비밀번호입니다.
      required: false
      type: string
    timeout:
      description: 요청 시간 (초)입니다.
      required: false
      type: string
      default: 10
    content_type:
      description: 요청의 컨텐츠 유형.
      required: false
      type: string
    verify_ssl:
      description: 엔드 포인트의 SSL 인증서를 확인하십시오.
      required: false
      type: boolean
      default: true
{% endconfiguration %}

## 사례 (Examples)

템플릿을 사용하여 다른 엔티티의 값을 삽입하는 명령은 동적일 수 있습니다. 템플릿으로 작업을 수행하기위한 서비스 콜(service call) 지원 변수.

{% raw %}
```yaml
# Example configuration.yaml entry
rest_command:
  my_request:
    url: https://slack.com/api/users.profile.set
    method: POST
    headers:
      authorization: !secret rest_headers_secret
      accept: 'application/json, text/html'
      user-agent: 'Mozilla/5.0 {{ useragent }}'
    payload: '{"profile":{"status_text": "{{ status }}","status_emoji": "{{ emoji }}"}}'
    content_type:  'application/json; charset=utf-8'
    verify_ssl: true
```
{% endraw %}

이 예제 항목에서는 동적 매개 변수에 사용되는 간단한 [templates](/docs/configuration/templating/)을 볼 수 있습니다.

사이드 바의 [developer tools](/docs/tools/dev-tools/)에서 다음과 같은 `data`를 사용하여 새로운 서비스를 호출하십시오.

```json
{
  "status":"My Status Goes Here",
  "emoji":":plex:"
}
```
Or in an example `automation`

```yaml
automation:
- alias: 'Arrive at Work'
  trigger:
    platform: zone
    entity_id: device_tracker.my_device
    zone: zone.work
    event: enter
  action:
    - service: rest_command.my_request
      data:
        status: "At Work"
        emoji: ":calendar:"
```
