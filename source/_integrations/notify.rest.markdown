---
title: "REST"
description: "Instructions on how to add RESTful notifications to Home Assistant."
logo: restful.png
ha_category:
  - Notifications
ha_release: 0.13
---

`rest` 알림 플랫폼을 사용하면 [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer) 알림을 홈어시스턴트에서 다른 상대방에게 전달할 수 있습니다.

설치시 REST 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: rest
    resource: http://IP_ADDRESS/ENDPOINT
```

{% configuration %}
name:
  description: "`notify.NOTIFIER_NAME`. 선택적 매개 변수`name`을 설정하면 여러 알리미를 만들 수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME` 에 바인딩합니다."
  required: false
  default: notify
  type: string
resource:
  description: 값을 받을 자원 또는 엔드 포인트.
  required: true
  type: string
method:
  description: 요청 방법. 유효한 옵션은  `GET`, `POST` 혹은 `POST_JSON`.
  required: false
  default: GET
  type: string
verify_ssl:
  description: 엔드 포인트의 SSL 인증서를 확인.
  required: false
  type: boolean
  default: True
authentication:
  description:  HTTP 인증의 유형 `basic` 혹은 `digest`.
  required: false
  default: basic
  type: string
username:
  description: REST 엔드 포인트에 액세스하기위한 사용자 이름
  required: false
  type: string
password:
  description: REST 엔드 포인트에 액세스하기위한 비밀번호
  required: false
  type: string
headers:
  description: 요청에 대한 헤더.
  required: false
  type: string
message_param_name:
  description: 메시지의 매개 변수 이름.
  required: false
  default: message
  type: string
title_param_name:
  description: 제목의 매개 변수 이름.
  required: false
  type: string
target_param_name:
  description: 대상의 매개 변수 이름.
  required: false
  type: string
data:
  description: 자원으로 보낼 추가 매개 변수 사전(dictionary).
  required: false
  type: string
data_template:
  description: 자원으로 보낼 추가 매개 변수의 템플리트 사전.
  required: false
  type: template
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/) 를 참조하십시오 .