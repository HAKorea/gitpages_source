---
title: Home Assistant Cloud
description: Enable the Home Assistant Cloud integration.
logo: nabu-casa.svg
ha_release: '0.60'
ha_category:
  - Voice
ha_iot_class: Cloud Push
ha_codeowners:
  - '@home-assistant/cloud'
---

Home Assistant Cloud를 사용하면 로컬 Home Assistant를 Amazon Alexa 및 Google Assistant와 같은 다양한 클라우드 서비스와 빠르게 통합 할 수 있습니다. [Learn more.](/cloud)

## 설정

configuration에서 [`default_config:`](https://www.home-assistant.io/integrations/default_config/)를 비활성화하거나 제거하지 않은 경우이 통합구성요소는 기본적으로 활성화됩니다.  다음 예는 이 통합구성요소를 수동으로 활성화하는 방법입니다. :

```yaml
# Example configuration.yaml entry to enable the cloud component
cloud:
```

활성화되면, 홈 어시스턴트의 구성 패널로 이동하여 계정을 등록하고 로그인하십시오. **Configuration** 패널이 표시되지 않으면, `configuration.yaml` 파일 에서 다음 옵션이 사용 가능한지 확인하십시오.

```yaml
config:
```
