---
title: 홈어시스턴트 모바일앱(HA Mobile App Support)
description: The Mobile App integration allows a generic platform for integrating with mobile apps.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.89
ha_config_flow: true
ha_quality_scale: internal
ha_codeowners:
  - '@robbiet480'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/EfUEyNXrMT8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

모바일 앱 통합구성요소를 통해 홈어시스턴트 모바일 앱은 홈어시스턴트와 쉽게 연동할 수 있습니다.

홈어시스턴트와 연동하여 모바일 응용 프로그램을 사용하려는 경우이 통합구성요소를 사용하는 것이 좋습니다..

모바일 앱 개발자인 경우 모바일 앱 구성 요소 위에 앱을 빌드하는 방법에 대한 지침은 [developer documentation](https://developers.home-assistant.io/docs/en/app_integration_index.html)를 참조하십시오. 

## 설정

 configuaration 에서 [`default_config:`](https://www.home-assistant.io/integrations/default_config/)를 비활성화하거나 제거하지 않은 경우이 본 통합구성요소는 기본적으로 활성화되어있습니다. 이 경우 다음 예는 이 통합구성요소를 수동으로 활성화하는 방법입니다. :

```yaml
# Example configuration.yaml entry
mobile_app:
```

## 모바일 앱을 사용하는 앱

- [Home Assistant for iOS](https://apps.apple.com/us/app/home-assistant/id1099568401?ls=1) (official)
- [Home Assistant for Android](https://play.google.com/store/apps/details?id=io.homeassistant.companion.android) (official)
