---
title: 17트랙
description: Instructions on how to use 17track.net data within Home Assistant
logo: 17track.png
ha_category:
  - Postal Service
ha_release: 0.83
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@bachya'
---

`seventeentrack` 센서 플랫폼을 통해 사용자는 [17track.net](https://www.17track.net/en) 에 묶인 패키지 데이터를 얻을 수 있습니다. 플랫폼은 현재 상태 (예: "운송중")의 패키지 수와 계정 내의 각 패키지에 대한 개별 센서를 표시하는 요약 센서를 모두 생성합니다.

<div class='note warning'>

17track.net 웹사이트에 계정 비밀번호는 16자를 초과할 수 없다고 명시되어 있지만 사용자는 기술적으로 16자를 초과하는 비밀번호를 설정할 수 있습니다. 이 비밀번호는 사용된 API에서 작동하지 **않습니다.** 따라서 17track.net 비밀번호는 16자를 초과하지 않아야합니다.

</div>

## 설정

플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 : 

```yaml
sensor:
  - platform: seventeentrack
    username: EMAIL_ADDRESS
    password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: 17track.net 계정과 연결된 이메일 주소
  required: true
  type: string
password:
  description: 17track.net 계정과 관련된 비밀번호.
  required: true
  type: string
show_archived:
  description: 보관된 패키지에 센서를 만들어야하는지 여부.
  required: false
  type: boolean
  default: false
show_delivered:
  description: 배송된 패키지에 센서를 만들어야하는지 여부
  required: false
  type: boolean
  default: false
{% endconfiguration %}
