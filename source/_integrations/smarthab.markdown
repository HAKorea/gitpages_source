---
title: 스마트햅(SmartHab)
description: Instructions on how to integrate SmartHab devices into Home Assistant
logo: smarthab.png
ha_release: 0.94
ha_category:
  - Hub
  - Cover
  - Light
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@outadoc'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/w-OKm24If28" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

집에 [SmartHab](https://www.smarthab.fr/en/home/) 장치가 장착되어 있고 앱 기반 서비스에 액세스 할 수 있는 경우 Home Assistant 용 SmartHab 통합구성요소를 통해 조명 및 셔터를 제어 할 수 있습니다.

설정에 `smarthab` 항목을 추가하면 지원되는 장치가 자동으로 검색되어 대시 보드에서 사용할 수있게됩니다.

<div class='note warning'>
  SmartHab 모바일 앱에서 자동으로 로그아웃되는 것을 방지하기 위해 앱 설정에서 보조 사용자를 생성하고 집에 대한 액세스 권한을 부여할 수 있습니다. 그런 다음이 계정의 자격 증명을 사용하여 연동을 설정할 수 있습니다. 이 사용자는 권한이 적어야하므로 더 안전합니다.
</div>

```yaml
# Example configuration.yaml entry
smarthab:
  email: EMAIL_ADDRESS
  password: PASSWORD
```

{% configuration %}
email:
  description: The email address of your SmartHab account.
  required: true
  type: string
password:
  description: The SmartHab account's password.
  required: true
  type: string
{% endconfiguration %}
