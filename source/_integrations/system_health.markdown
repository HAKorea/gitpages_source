---
title: 시스템 상태(System Health)
description: System Health integration will report system info and allow to run system diagnostics.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.87
ha_quality_scale: internal
---

System Health 통합구성요소는 시스템 및 해당 구성 요소에 대한 정보를 제공하는 API를 제공합니다. 또한 진단 도구를 실행하여 문제를 진단할 수 있습니다.

이 통합구성요소은 설정에서 [`default_config :`](https://www.home-assistant.io/integrations/default_config/) 행을 비활성화하거나 제거하지 않은 한 기본적으로 활성화되어 있습니다. 이 경우 다음 예는 이 통합구성요소를 수동으로 활성화하는 방법을 보여줍니다.

```yaml
# Example configuration.yaml entry
system_health:
```

시스템 상태 통합 데이터는 "정보"탭의 개발자 도구에서 볼 수 있습니다.