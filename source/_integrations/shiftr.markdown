---
title: IOT기기실시간연결도(shiftr.io)
description: Transfer events to Shiftr.io.
logo: shiftr.png
ha_category:
  - History
ha_release: 0.48
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="690" height="609" src="https://www.youtube.com/embed/hGicZsBHo9s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`shiftr` 통합구성요소로 홈어시스턴트로 수집한 세부 정보를 [Shiftr.io](https://shiftr.io)로 전송하고 정보의 흐름을 시각화 할 수 있습니다. 귀하의 세부 정보는 공개됩니다!

## 설정

새로운 [namespace](https://shiftr.io/new)를 생성하고 새로운 토큰을 생성하십시오. 컴포넌트를 설정하려면 `Key (Username)` 및 `Secret (Password)`를 사용해야합니다.

설치시 `shiftr` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
shiftr:
  username: YOUR_NAMESPACE_USERNAME
  password: YOUR_NAMESPACE_PASSWORD
```

{% configuration %}
username:
  description: Username for the Shiftr namespace.
  required: true
  type: string
password:
  description: Password for the Shiftr namespace.
  required: true
  type: string
{% endconfiguration %}
