---
title: 브런트 Blind Engine
description: Instructions on how to set up Brunt Blind Engine within Home Assistant.
logo: brunt.png
ha_category:
  - Cover
ha_release: 0.75
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@eavanvalkenburg'
---

The `brunt` platform allows one to control Blind Engines by [Brunt](https://www.brunt.co). To use this sensor, you need a Brunt App Account. All Brunt Blind devices registered to your account are automatically added to your Home Assistant with the names given them through the Brunt app.
`brunt` 플랫폼은 [Brunt](https://www.brunt.co)에 의해 블라인드 엔진을 제어할 수 있습니다 . 이 센서를 사용하려면 Brunt 앱 계정이 필요합니다. 계정에 등록 된 모든 Brunt Blind 장치는 Brunt 앱을 통해 이름이 지정된 홈어시스턴트에 자동으로 추가됩니다.

## 설정

이 연동을 가능하게하려면 `configuration.yaml` 에 다음 행을 추가하십시오.

```yaml
cover:
  - platform: brunt
    username: BRUNT_USERNAME
    password: BRUNT_PASSWORD
```

{% configuration %}
name:
  description: Cover 이름
  required: false
  default: "brunt blind engine"
  type: string
username:
  description: Brunt 앱의 계정 사용자 이름
  required: true
  type: string
password:
  description: Brunt 앱의 계정 비밀번호
  required: true
  type: string
{% endconfiguration %}

<div class='note warning'>
이 통합구성요소는 Brunt와 관련이 없으며 모바일 애플리케이션의 엔드 포인트에서 데이터를 검색합니다. 자신의 책임하에 사용하십시오.
</div>
