---
title: Zero-configuration 네트워킹 (zeroconf)
description: Exposes Home Assistant using the Zeroconf protocol.
ha_category:
  - Network
ha_release: 0.18
logo: home-assistant.png
ha_quality_scale: internal
ha_codeowners:
  - '@robbiet480'
  - '@Kane610'
---

`zeroconf` 통합구성요소는 네트워크에서 지원되는 장치 및 서비스를 검색합니다. 검색된 통합구성요소는 설정 패널의 통합구성요소 페이지에서 검색 섹션에 표시됩니다. 또한 네트워크의 다른 서비스에서 홈어시스턴트를 검색할 수 있습니다. Zeroconf는 Bonjour, Rendezvous 및 Avahi 라고도 합니다.

[a Zeroconf section](https://developers.home-assistant.io/docs/en/next/creating_integration_manifest.html#zeroconf) 또는 [a HomeKit section](https://developers.home-assistant.io/docs/en/next/creating_integration_manifest.html#homekit)을 확실한 json에 추가하여 통합구성요소를 찾을 수 있습니다.

## 설정

이 통합구성요소는 설정에서 [`default_config:`](https://www.home-assistant.io/integrations/default_config/) 행을 비활성화하거나 제거하지 않는 한 기본적으로 활성화됩니다. 이 경우 zeroconf 및 HomeKit을 사용하여 홈어시스턴트가 통힙구성요소를 스캔하도록 하려면 다음 예제는 이 통합을 수동으로 사용하는 방법을 보여줍니다.

```yaml
# Example configuration.yaml entry
zeroconf:
```
