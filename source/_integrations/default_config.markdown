---
title: Default Config
description: The default config integration will initate a default configuration for Home Assistant.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.88
---

이 통합구성요소는 메타 구성 요소이며 Home Assistant가로드 할 기본 통합 세트를 구성합니다. 다음 통합 구성요소를 로그합니다. :

- [automation](/integrations/automation/)
- [cloud](/integrations/cloud/)
- [config](/integrations/config/)
- [frontend](/integrations/frontend/)
- [history](/integrations/history/)
- [logbook](/integrations/logbook/)
- [map](/integrations/map/)
- [mobile_app](/integrations/mobile_app/)
- [person](/integrations/person/)
- [script](/integrations/script/)
- [ssdp](/integrations/ssdp/)
- [sun](/integrations/sun/)
- [system_health](/integrations/system_health/)
- [updater](/integrations/updater/)
- [zeroconf](/integrations/zeroconf/)

## 설정

홈 어시스턴트로 통합하려면, `configuration.yaml` 파일에 다음 섹션을 추가 하십시오. :

```yaml
# Example configuration.yaml entry
default_config:
```
