---
title: 차고문(Aladdin Connect)
description: Instructions how to integrate Genie Aladdin Connect garage door covers into Home Assistant.
logo: aladdin_connect.png
ha_category:
  - Cover
ha_release: 0.75
ha_iot_class: Cloud Polling
---

`aladdin_connect` 커버 플랫폼을 사용하면 Home Assistant를 통해 Genie Aladdin Connect 차고문을 제어 할 수 있습니다.

<div class='note'>
Aladdin Connect 계정이 소유한 문만 사용할 수 있습니다. 귀하의 계정에 공유 액세스 권한이 부여된 출입문은 아직 지원되지 않습니다.
</div>

<iframe width="690" height="437" src="https://www.youtube.com/embed/FSny-b9_D_U" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

## 설정

설치에서 Aladdin Connect 커버를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
cover:
  - platform: aladdin_connect
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Your Aladdin Connect account username.
  required: true
  type: string
password:
  description: Your Aladdin Connect account password.
  required: true
  type: string
{% endconfiguration %}
